Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6E4C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E8A2082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E8A2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55754 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdCLr-00088e-W1
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 07:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45721)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hdCKq-0007S4-V7
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hdCKq-0006OA-0M
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:31:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hdCKp-0006N5-Qj
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:31:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id c66so2854712wmf.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 04:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sWAUzTVZTd1N0vgARBpJ2iBRKFKmWFK8xlcTWblFbF4=;
 b=mrJyXcwITvmMAsS42zNF4PQcyyD2YpiSl1QeNOTBFnxFCld3TCehx2EUGoDc/DcrUl
 I/muWWC6FrIq8MeYMe7YEB8WSNOV+kvW69QKV/YxgSah2w4N3+xcpzAJB7Kn9PWdd/0S
 7a/EAOYPG2HSsScfFgqGa16ztn6L3KCIalM+b6KUC9VbnlmsBym0HLNYj3Tsp82w98au
 DgzOGYdULeh8VSc0jTiAL3uMjtXkfPMHLg3rt2xCpWBW+/u7B5KCZVprEjDHTp6H3RCB
 QBXWsqdO1b/YIVaSSR/B/oRa+LCCkXGacRdLgpdnx8cEiTNAolb6bVTeDuzuNgliF9fQ
 umMg==
X-Gm-Message-State: APjAAAWAwcPm6BulyjM6q4wMJK2zUAZX0ANtFYmik6o4M8EbvGsSV7dN
 srbROlvvrL57c6vyQWjbphhi77CFVdk=
X-Google-Smtp-Source: APXvYqxCkxr+jo9Ms+5ximXz6ukYxWJCwje2l+VFilB0wntLLi2mYwm7pBrTeixqwcm1POkzL4OxrA==
X-Received: by 2002:a1c:ef0c:: with SMTP id n12mr3039033wmh.132.1560857490353; 
 Tue, 18 Jun 2019 04:31:30 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id n3sm9987742wro.59.2019.06.18.04.31.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Jun 2019 04:31:29 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>
References: <20190618083442.10407-1-drjones@redhat.com>
 <CAFEAcA9bwbev3efZ=LJPGgObBCbW-WX19fySMusLyMNC5ZExvA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <61cad4d2-61bc-00f1-d86a-d88b9e926ad2@redhat.com>
Date: Tue, 18 Jun 2019 13:31:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9bwbev3efZ=LJPGgObBCbW-WX19fySMusLyMNC5ZExvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] hw/arm/boot: fix direct kernel boot setup
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/19 1:02 PM, Peter Maydell wrote:
> On Tue, 18 Jun 2019 at 09:34, Andrew Jones <drjones@redhat.com> wrote:
>>
>> We need to check ram_end, not ram_size.
>>
>> Fixes: 852dc64d665f ("hw/arm/boot: Diagnose layouts that put initrd or
>> DTB off the end of RAM")
>> Signed-off-by: Andrew Jones <drjones@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>> ---
>>  hw/arm/boot.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>> index b2f93f6beff6..8a280ab3ed49 100644
>> --- a/hw/arm/boot.c
>> +++ b/hw/arm/boot.c
>> @@ -1109,7 +1109,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
>>                               info->initrd_filename);
>>                  exit(1);
>>              }
>> -            if (info->initrd_start + initrd_size > info->ram_size) {
>> +            if (info->initrd_start + initrd_size > ram_end) {
>>                  error_report("could not load initrd '%s': "
>>                               "too big to fit into RAM after the kernel",
>>                               info->initrd_filename);
>> --
>> 2.20.1
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> I think I missed this because my test case doesn't have an
> initrd -- direct kernel boot works fine if all you're
> passing to QEMU is the kernel... I think we could clarify
> the commit message a little:
> 
> hw/arm/boot: fix direct kernel boot with initrd
> 
> Fix the condition used to check whether the initrd fits
> into RAM; this meant we were spuriously refusing to do
> a direct boot of a kernel in some cases if an initrd
> was also passed on the command line.
> 
> ?
> 
> (if you agree I can just fix up the commit message when I apply it.)
> 
> thanks
> -- PMM
> 

