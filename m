Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701C9C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3604208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcRcU1j5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3604208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNKLY-0004EF-RY
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 14:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNKJw-00035E-RB
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 14:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNKJv-0004RA-2h
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 14:25:48 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601403946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmM4krDyGvanpoAaAqLDnTDLnK6BSk4w1VQYyA5jMDU=;
 b=RcRcU1j5XESxOzl/Hz4vr4fneLcG09b6upNn0gLK5hvFADAtG8CJDvtDa0GNGqgmMylW6N
 HtJHtuJ0xLIkXC671YRrnFFIiXofqybkTSUjW8GpiUyzH/VIbwWSH9y/cl0HnozEgUjt/9
 ELUNZF0+Cp9G0AgkSpVFcvmZXLp7FL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-boJzqqQNMTWhiP0gAYEuqw-1; Tue, 29 Sep 2020 14:25:44 -0400
X-MC-Unique: boJzqqQNMTWhiP0gAYEuqw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B4ED106B494
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 18:25:43 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF4EE5C1D7;
 Tue, 29 Sep 2020 18:25:37 +0000 (UTC)
Subject: Re: [PATCH v3 05/47] qapi/doc.py: Change code templates from function
 to string
To: Cleber Rosa <crosa@redhat.com>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-6-jsnow@redhat.com>
 <20200929035113.GF700868@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <9f22e424-f514-efc6-4719-f3396453f858@redhat.com>
Date: Tue, 29 Sep 2020 14:25:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929035113.GF700868@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 11:51 PM, Cleber Rosa wrote:
> On Thu, Sep 24, 2020 at 08:28:18PM -0400, John Snow wrote:
>> For whatever reason, when these are stored as functions instead of
>> strings, it confuses sphinx-autodoc into believing them to be
>> docstrings, and it chokes on the syntax.
>>
> 
> Interesting...
> 
>> Keeping them as dumb strings instead avoids the problem.
>>
> 
> I actually think it's a more honest approach, and easier to read.
> 
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/doc.py | 40 ++++++++++++++++++++--------------------
>>   1 file changed, 20 insertions(+), 20 deletions(-)
>>
>> diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
>> index c41e9d29f5..d12eda9e1e 100644
>> --- a/scripts/qapi/doc.py
>> +++ b/scripts/qapi/doc.py
>> @@ -8,26 +8,26 @@
>>   from qapi.gen import QAPIGenDoc, QAPISchemaVisitor
>>   
>>   
>> -MSG_FMT = """
>> +_MSG = '''
>>   @deftypefn {type} {{}} {name}
>>   
>>   {body}{members}{features}{sections}
>>   @end deftypefn
>>   
>> -""".format
>> +'''
>>
> 
> I know it doesn't make syntactic difference, but is there a reson for
> also changing the quote style?
> 
> - Cleber.
> 

Was just trying to differentiate it from docstrings to see if it helped. 
It didn't, but it also didn't hurt, so I left it.

Luckily, this patch won't matter after Peter Maydell's series goes in, 
so whatever!


