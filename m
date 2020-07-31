Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5406EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 07:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F54520829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 07:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWz2ascC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F54520829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1PqV-0003Cd-Er
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 03:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k1Ppo-0002lp-CI
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 03:52:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51075
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k1Ppm-0000pp-Fc
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 03:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596181925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=s+QnI68YqBKqFylR7G/MFs8rxzhqAWK9M0SHd6+x0C0=;
 b=aWz2ascCtY3X2svMpHHx13uuLtXY2MnjiUsZor7nqtZcX6oNj19Kx7/ttDJrQQi+ZSaBnG
 s3qXOkJc4g3+EsIY98UQqQs887pUebbZ98Kpwq1aSvs9sATSJFtiFhoagRT+dJ5JPbjxkK
 /QPyfrPoeCPYSLeHEfnp+GN3buenBDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-AQ8aS-grOOimahGbJaMm3A-1; Fri, 31 Jul 2020 03:52:02 -0400
X-MC-Unique: AQ8aS-grOOimahGbJaMm3A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F23968017FB;
 Fri, 31 Jul 2020 07:52:00 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-153.ams2.redhat.com [10.36.112.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF88A10013C4;
 Fri, 31 Jul 2020 07:51:58 +0000 (UTC)
Subject: Re: [PATCH for-5.2 1/6] pc-bios/s390-ccw/Makefile: Compile with
 -std=gnu99, -fwrapv and -fno-common
To: Janosch Frank <frankja@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20200728183734.7838-1-thuth@redhat.com>
 <20200728183734.7838-2-thuth@redhat.com>
 <cd6b0a45-deeb-bf36-1763-c79b1759e892@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7a7e9ea0-1630-e24e-c6ae-3026c07ed9a9@redhat.com>
Date: Fri, 31 Jul 2020 09:51:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cd6b0a45-deeb-bf36-1763-c79b1759e892@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 02:46:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/07/2020 09.46, Janosch Frank wrote:
> On 7/28/20 8:37 PM, Thomas Huth wrote:
>> The main QEMU code is compiled with -std=gnu99, -fwrapv and -fno-common.
>> We should use the same flags for the s390-ccw bios, too, to avoid that
>> we get different behavior with different compiler versions that changed
>> their default settings in the course of time (it happened at least with
>> -std=... and -fno-common in the past already).
>>
>> While we're at it, also group the other flags here in a little bit nicer
>> fashion: Move the two "-m" flags out of the "-f" area and specify them on
>> a separate line.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> What was the argument for z900 again? TCG?

Yes. As long as you can still select "-cpu z900" as parameter, the bios
should of course support that CPU level, too.

 Thomas


