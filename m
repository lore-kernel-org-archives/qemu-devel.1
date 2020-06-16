Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C918C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5182B20882
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikhiztV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5182B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDxr-0007pc-LJ
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jlDx9-0006mQ-Hs
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:56:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55018
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jlDx7-0002Xv-0n
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592323003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=JIyg3EBxGYmTPSXBLsOxceR7zhjqF6+5bfR9qsn8RZg=;
 b=ikhiztV0bek5CKIqHmR9TYPH19bINXHSobckA7jvczOadqfMQQ9NWts5S441ASJ6reMT6Q
 lyD/rJicebLYfpyu7NMr8gg+yCoiO8Mf84oga4g+v8ox0JEx05Qk3qYFvxm6uJIKIr2wOI
 j9RRgCD/Z/aceKvizTAN1qhgQDltif4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-g-mnKC7-NueKcgZ5o-SiuA-1; Tue, 16 Jun 2020 11:56:42 -0400
X-MC-Unique: g-mnKC7-NueKcgZ5o-SiuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EE91100A8F1;
 Tue, 16 Jun 2020 15:56:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-128.ams2.redhat.com [10.36.114.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A62E2768AE;
 Tue, 16 Jun 2020 15:56:31 +0000 (UTC)
Subject: Re: [PATCH v4 1/7] MAINTAINERS: Cover 'hw/sh4/sh_intc.h' with the R2D
 machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200611114317.13044-1-f4bug@amsat.org>
 <20200611114317.13044-2-f4bug@amsat.org>
 <bb388c24-092c-28f5-2a78-daee14ed5731@redhat.com>
 <94575412-81ae-25e1-b9ad-b12317da815b@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <bd8d3086-8fe7-958f-a54e-95d69f399627@redhat.com>
Date: Tue, 16 Jun 2020 17:56:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <94575412-81ae-25e1-b9ad-b12317da815b@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/06/2020 16.49, Philippe Mathieu-Daudé wrote:
> On 6/16/20 3:34 PM, Thomas Huth wrote:
>> On 11/06/2020 13.43, Philippe Mathieu-Daudé wrote:
>>> Commit 81527b94ad added hw/intc/sh_intc.c, complete by
>>> adding its corresponding header.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  MAINTAINERS | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 13711aafe8..87ceca7ff1 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1257,6 +1257,7 @@ S: Maintained
>>>  F: hw/sh4/r2d.c
>>>  F: hw/intc/sh_intc.c
>>>  F: hw/timer/sh_timer.c
>>> +F: include/hw/sh4/sh_intc.h
>>>  
>>>  Shix
>>>  M: Yoshinori Sato <ysato@users.sourceforge.jp>
>>
>> Hmm, sh_intc.h is used by sh7750_init() in sh7750.c ... and that
>> function is used by both, r2d and shix machines ... so should that maybe
>> rather be part of both machines or a generic entry?
> 
> I'll add it to both machines. The maintainers can reorder
> the sections later.
> 
> Thanks for the review!

Ok, with that change:
Reviewed-by: Thomas Huth <thuth@redhat.com>


