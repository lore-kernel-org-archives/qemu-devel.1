Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A841C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43D5206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+vAlF8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43D5206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBDxo-0003mE-Vq
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBDve-0000Cj-O5
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:10:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25660
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBDvd-0001of-02
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598519439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xn5RMJreF8zU3L+NcAJXY9m/TKiflBqtg2h7oBhQrLo=;
 b=O+vAlF8DpkCNVVKzd/z7jFPbeOkqST4pTEGZufa9G4ZfQHy9A6agsckNnzIIcvoQ2HoqNo
 wte8gsj0Dq4OSeXHyPiAfxqGDhJGFhKu+t3EZkw32GlApzZHC7bCFr/7aOSKja7E5jVzL6
 pQSjNusI4GDRFRYgtxdk3ddrdBVCs+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-s63SDqxPOMqlkeJ9vO8lnA-1; Thu, 27 Aug 2020 05:10:38 -0400
X-MC-Unique: s63SDqxPOMqlkeJ9vO8lnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 802978015DB;
 Thu, 27 Aug 2020 09:10:36 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00B116111F;
 Thu, 27 Aug 2020 09:10:33 +0000 (UTC)
Subject: Re: [PATCH for-5.2 v2 3/9] pc-bios/s390-ccw: Introduce ENODEV define
 and remove guards of others
To: Janosch Frank <frankja@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20200806105349.632-1-thuth@redhat.com>
 <20200806105349.632-4-thuth@redhat.com>
 <e279b0f7-daf7-8a9e-3009-a1677637ce90@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bffa0294-211d-23ea-b80c-0fbbfe0be6a8@redhat.com>
Date: Thu, 27 Aug 2020 11:10:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e279b0f7-daf7-8a9e-3009-a1677637ce90@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, qemu-block@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/08/2020 15.27, Janosch Frank wrote:
> On 8/6/20 12:53 PM, Thomas Huth wrote:
>> Remove the "#ifndef E..." guards from the defines here - the header
>> guard S390_CCW_H at the top of the file should avoid double definition,
>> and if the error code is defined in a different file already, we're in
>> trouble anyway, then it's better to see the error at compile time instead
>> of hunting weird behavior during runtime later.
>> Also define ENODEV - we will use this in a later patch.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Would it make sense to use the errno.h numbers for the defines?

Which one? From Linux? From Windows? From BSD? ... I think it's likely
best if we keep them separate to avoid confusion.

 Thomas


> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> 
>> ---
>>  pc-bios/s390-ccw/s390-ccw.h | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>> index 36b884cced..dbc4c64851 100644
>> --- a/pc-bios/s390-ccw/s390-ccw.h
>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>> @@ -27,12 +27,10 @@ typedef unsigned long long __u64;
>>  #define false 0
>>  #define PAGE_SIZE 4096
>>  
>> -#ifndef EIO
>>  #define EIO     1
>> -#endif
>> -#ifndef EBUSY
>>  #define EBUSY   2
>> -#endif
>> +#define ENODEV  3
>> +
>>  #ifndef NULL
>>  #define NULL    0
>>  #endif
>>
> 
> 


