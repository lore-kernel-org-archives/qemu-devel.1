Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A74C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F622184D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vq30TD1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F622184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5g0-0001fJ-2w
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 12:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jX5cD-0004gU-5z
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:12:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54968
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jX5cA-0002EW-KJ
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588954361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZyv5rx/E9/BAfTRG5gFWFzRN8AyQLrLXzppU17ZMro=;
 b=Vq30TD1UgVFST7N2C2qWiDGUU67VrHw89W1VoSycsnMwPKk2az4XNSLtUcvtg87sYRslDF
 3zvl7MVtVa8H8YnczHSaVJue0mES/UYb8bzYmg3LVBMSv37/78gKwZvWjzGF8lc6ESQ5fC
 e+E4Y3pMLbN/4mdc6IdvEs8aS9k+Xis=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-GKHlttkjPwmielLc63fBcg-1; Fri, 08 May 2020 12:12:38 -0400
X-MC-Unique: GKHlttkjPwmielLc63fBcg-1
Received: by mail-wm1-f70.google.com with SMTP id d134so5533744wmd.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 09:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pZyv5rx/E9/BAfTRG5gFWFzRN8AyQLrLXzppU17ZMro=;
 b=gR4TqhU7L43FfxFMDLtk6F3L9+jzpgFEg23ack9jJz+x6fO47jvxyaxp6wtp1Rdn8a
 Xs19gA8Fd9TNNZvyTLtCCz2qZuk9/3ydEHeGU8V9SgSdz1+K73D+mEpFFGNGhDAUOtpU
 1fk4M2STs5VfSeVEO6jBMo159Dp+21byzhsoTN74nv4Nycvaxe8EE3SGeOFCqFl2INlT
 9VASgntID7d5K+MZcg/SQFd2orXav+AnntD/HyaCNt1nIuxJIiKssPFCvJVd+pJdIsuE
 QZCE20Y9fTlXE0dqlmfLUpjyJilO/K1+LP+lHpQCm2g3V9qgBOSHwA4vDb2UjfQsa9aQ
 N+og==
X-Gm-Message-State: AGi0Pub22yQp6jDblZrFa8SP3/sZaeaOFuJn5uo0nxPPq05O9srAxHVX
 CtKIlrnKGL/77YSsMyAw32pHwUfxAFytIeoXHah5T/8WIb/2IuVCgPGCToiOWqe5ig03AduT6jH
 3pWfptud6IcHkubM=
X-Received: by 2002:adf:afdb:: with SMTP id y27mr3562786wrd.323.1588954357002; 
 Fri, 08 May 2020 09:12:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypISir3fWeW5ELncrsbWF+mfvfl4OVsQh+su9SHqfN/m1IyMe8uWjGMp04P3rFA63RHt9+glgw==
X-Received: by 2002:adf:afdb:: with SMTP id y27mr3562765wrd.323.1588954356810; 
 Fri, 08 May 2020 09:12:36 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a187sm13903904wmh.40.2020.05.08.09.12.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 09:12:36 -0700 (PDT)
Subject: Re: [PATCH] cpus: Fix botched configure_icount() error API violation
 fix
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
References: <20200508104933.19051-1-armbru@redhat.com>
 <85ab3d39-0916-3637-6568-70166436e7f8@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6f13227c-3575-319a-6722-c48584c2c516@redhat.com>
Date: Fri, 8 May 2020 18:12:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <85ab3d39-0916-3637-6568-70166436e7f8@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 08:00:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/20 3:45 PM, Eric Blake wrote:
> On 5/8/20 5:49 AM, Markus Armbruster wrote:
>> Fixes: abc9bf69a66a11499a801ff545b8fe7adbb3a04c
>> Fixes: Coverity CID 1428754
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   cpus.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
>>
>> diff --git a/cpus.c b/cpus.c
>> index 5670c96bcf..b9275c672d 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -813,7 +813,7 @@ void configure_icount(QemuOpts *opts, Error **errp)
>>           return;
>>       }
>> -    if (strcmp(option, "auto") != 0) {
>> +    if (option && !strcmp(option, "auto")) {
> 
> Another alternative would be using g_strcmp0, but this form is fine.

"Leading by example is the fastest way to train a team." ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
>>           if (qemu_strtol(option, NULL, 0, &time_shift) < 0
>>               || time_shift < 0 || time_shift > MAX_ICOUNT_SHIFT) {
>>               error_setg(errp, "icount: Invalid shift value");
>>
> 


