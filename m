Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09D1C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 15:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14FA206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 15:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXpo+0fD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14FA206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY9ru-0000ZX-Q5
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 11:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kY9rI-00007G-2p
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 11:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kY9rG-00060M-AG
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 11:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603985337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x5/EgEz9059a155iAtMhsuUg2WuGK2vuSfR+p8Dz5UA=;
 b=HXpo+0fDzZVPOlf4MoSbxdr6AwD3/7n/PW/5cxRpXn/jrARKCR7YZBgTzHagNyZFcYxAYX
 n9hzTCW3uSdWUGIoJXsQjw8Xjg8WXlUs8mFqZpxQ74+u1ic9beidiHsq1SOOegd1qwzdlW
 7LHCJka6+tsYVIX2FRh86gGfL0XLrds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-boriIJZrOCu1TMtUact5KQ-1; Thu, 29 Oct 2020 11:28:55 -0400
X-MC-Unique: boriIJZrOCu1TMtUact5KQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43AC0195CC40;
 Thu, 29 Oct 2020 15:28:54 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-114.ams2.redhat.com [10.36.113.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 663FC60C17;
 Thu, 29 Oct 2020 15:28:49 +0000 (UTC)
Subject: Re: [PATCH v2 8/8] configure: add [lm32|unicore32]-softmmu to
 deprecation logic
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200915134317.11110-1-alex.bennee@linaro.org>
 <20200915134317.11110-9-alex.bennee@linaro.org>
 <599acb88-ab14-c8c7-5ba6-6526b6e7c629@redhat.com> <874kmdm6v7.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5ca6d5d0-968b-8e3f-a265-c632d74d31d8@redhat.com>
Date: Thu, 29 Oct 2020 16:28:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <874kmdm6v7.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/10/2020 15.42, Alex Bennée wrote:
> 
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 15/09/2020 15.43, Alex Bennée wrote:
>>> While we are at it move the few places where they are into the
>>> deprecation build bucket.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  configure      | 2 +-
>>>  .gitlab-ci.yml | 9 +++++----
>>>  .shippable.yml | 2 +-
>>>  3 files changed, 7 insertions(+), 6 deletions(-)
>>
>>  Hi Alex,
>>
>> I noticed that these deprecated targets do not show up in the
>> output of "configure --help" at all anymore:
>>
>>  --target-list=LIST       set target list (default: build everything)
>>                            Available targets: aarch64-softmmu alpha-softmmu 
>>                            arm-softmmu avr-softmmu cris-softmmu hppa-softmmu 
>>                            i386-softmmu m68k-softmmu microblazeel-softmmu 
>>                            microblaze-softmmu mips64el-softmmu mips64-softmmu 
>>                            mipsel-softmmu mips-softmmu moxie-softmmu 
>>                            nios2-softmmu or1k-softmmu ppc64-softmmu ppc-softmmu 
>>                            riscv32-softmmu riscv64-softmmu rx-softmmu 
>>                            s390x-softmmu sh4eb-softmmu sh4-softmmu 
>>                            sparc64-softmmu sparc-softmmu tricore-softmmu 
>>                            x86_64-softmmu xtensaeb-softmmu xtensa-softmmu 
>>                            aarch64_be-linux-user aarch64-linux-user 
>>                            alpha-linux-user armeb-linux-user arm-linux-user 
>>                            cris-linux-user hppa-linux-user i386-linux-user 
>>                            m68k-linux-user microblazeel-linux-user 
>>                            microblaze-linux-user mips64el-linux-user 
>>                            mips64-linux-user mipsel-linux-user mips-linux-user 
>>                            mipsn32el-linux-user mipsn32-linux-user 
>>                            nios2-linux-user or1k-linux-user ppc64le-linux-user 
>>                            ppc64-linux-user ppc-linux-user riscv32-linux-user 
>>                            riscv64-linux-user s390x-linux-user sh4eb-linux-user 
>>                            sh4-linux-user sparc32plus-linux-user 
>>                            sparc64-linux-user sparc-linux-user 
>>                            x86_64-linux-user xtensaeb-linux-user 
>>                            xtensa-linux-user
>>
>> The text "default: build everything" is now also not accurate anymore.
>> How is a user who is still interested in these targets supposed to find
>> the right --target-list parameters now?
> 
> How about:
> 
> --8<---------------cut here---------------start------------->8---
> modified   configure
> @@ -1644,9 +1644,11 @@ Standard options:
>    --prefix=PREFIX          install in PREFIX [$prefix]
>    --interp-prefix=PREFIX   where to find shared libraries, etc.
>                             use %M for cpu name [$interp_prefix]
> -  --target-list=LIST       set target list (default: build everything)
> +  --target-list=LIST       set target list (default: build all non-deprcated)
>  $(echo Available targets: $default_target_list | \
>    fold -s -w 53 | sed -e 's/^/                           /')
> +$(echo Deprecated targets: $deprecated_targets_list | \
> +  fold -s -w 53 | sed -e 's/^/                           /')
>    --target-list-exclude=LIST exclude a set of targets from the default target-list
>  
>  Advanced options (experts only):
> --8<---------------cut here---------------end--------------->8---
> 
> Which would give:
> 
> 
>   --target-list=LIST       set target list (default: build all non-deprcated)
>                            Available targets: aarch64-softmmu alpha-softmmu 
>                            arm-softmmu avr-softmmu cris-softmmu hppa-softmmu 
>                            i386-softmmu m68k-softmmu microblaze-softmmu 
>                            microblazeel-softmmu mips-softmmu mips64-softmmu 
>                            mips64el-softmmu mipsel-softmmu moxie-softmmu 
>                            nios2-softmmu or1k-softmmu ppc-softmmu ppc64-softmmu 
>                            riscv32-softmmu riscv64-softmmu rx-softmmu 
>                            s390x-softmmu sh4-softmmu sh4eb-softmmu 
>                            sparc-softmmu sparc64-softmmu tricore-softmmu 
>                            x86_64-softmmu xtensa-softmmu xtensaeb-softmmu 
>                            aarch64-linux-user aarch64_be-linux-user 
>                            alpha-linux-user arm-linux-user armeb-linux-user 
>                            cris-linux-user hppa-linux-user i386-linux-user 
>                            m68k-linux-user microblaze-linux-user 
>                            microblazeel-linux-user mips-linux-user 
>                            mips64-linux-user mips64el-linux-user 
>                            mipsel-linux-user mipsn32-linux-user 
>                            mipsn32el-linux-user nios2-linux-user 
>                            or1k-linux-user ppc-linux-user ppc64-linux-user 
>                            ppc64le-linux-user riscv32-linux-user 
>                            riscv64-linux-user s390x-linux-user sh4-linux-user 
>                            sh4eb-linux-user sparc-linux-user 
>                            sparc32plus-linux-user sparc64-linux-user 
>                            x86_64-linux-user xtensa-linux-user 
>                            xtensaeb-linux-user
>                            Deprecated targets: 
>                            ppc64abi32-linux-user,tilegx-linux-user,lm32-softmmu,
>                            unicore32-softmmu
>   --target-list-exclude=LIST exclude a set of targets from the default target-list

Sounds good!

 Thomas



