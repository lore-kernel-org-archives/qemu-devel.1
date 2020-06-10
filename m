Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147D8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A8A2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbdKPsL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A8A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj7n9-0005nP-4g
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj7m8-00050f-SV; Wed, 10 Jun 2020 16:56:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33894)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj7m7-0002uS-My; Wed, 10 Jun 2020 16:56:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id r7so3892541wro.1;
 Wed, 10 Jun 2020 13:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZR2bnJR/HapCFNBpf3uilKNOhwhTOCFsp2GKeX72c6A=;
 b=cbdKPsL4Md1lOvLguwb1F/tH7do9dMhuixG55lg+BupLuUeLLdGzw/mVaIVxahIEEZ
 c1vgBqzpcqoojNHe2jG8lpDjoQ0VkySxeMil11rzwD++O3UX0t5WzOenpsLxpigRy2Fh
 3v51mmM8efZQHE+4gauts0TZ4bIPkPFWDTrliwj2HxNiBd7ZbRoIi8pyYauC7juJWzzH
 55+4CHnS0+zeB0k81mnJ/qHg2+NGNc3h0M7Pgx0hv4mgjralu52ppZa5576HhTH3BQT2
 rvMRBbkzGIYTqOJPUkCT+kMlLh39S1zfKv32A5MXF5eQqxhyJ1Kt1MfVEu5AbMnpK5O1
 dITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZR2bnJR/HapCFNBpf3uilKNOhwhTOCFsp2GKeX72c6A=;
 b=QaFx1x6oVFbndTYfSHJVX+XDKz7A1X3eA9Xpy4hk57YHkWG6pEMMkN649Xg7x/fPEb
 q7OFIJxo2d7YYOXjYHFk6nHNv/das5D1No8nqNFC6ohIbOOrPWICONACYl+sxj5cZ3Ia
 0NsfHx5PeBwMRavwOVMyNsbYb86M4NrYxLsp/4HNnM13ipMeJISFbbnAy8kbZYrb+Fo2
 W+oY/PItAPSZifT2dnBbYLWmqerYyWoipSaqbMH6TigejcxW+LpcILFyJOBRfNGZD7x9
 iwI+JhFpmT3XrwMV7YaYrl1voD2edCYjye+06ROpIl6b486xcQlgluipFLZSVnZA8nIh
 7Q7g==
X-Gm-Message-State: AOAM532Mtij4t3HNF9jhHQX5pAiV3IwJPpyDl38sTsDOWAHhykcwm8w/
 lhBIMxwRLrmjPtK3qmvOZBQ=
X-Google-Smtp-Source: ABdhPJzMMQqjJaFmREIybuBSeT4DII3vxrVihq+8jivmnL1mHfu0jMu8os1OiOPhXi34YrZKXDB6LQ==
X-Received: by 2002:adf:fac2:: with SMTP id a2mr5653733wrs.304.1591822589545; 
 Wed, 10 Jun 2020 13:56:29 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id b8sm1476370wrs.36.2020.06.10.13.56.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2020 13:56:28 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] MAINTAINERS: Mark SH4 hardware orphan
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200608090142.6793-1-f4bug@amsat.org>
 <20200608090142.6793-2-f4bug@amsat.org>
 <CAHiYmc5UUaSKB6Ee0ds_hj0FBTzt0iLxzNWySt0mcZ9dvtZNyA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <377d3dfd-fa04-24b9-04fd-f2ed431820c5@amsat.org>
Date: Wed, 10 Jun 2020 22:56:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc5UUaSKB6Ee0ds_hj0FBTzt0iLxzNWySt0mcZ9dvtZNyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 1:08 PM, Aleksandar Markovic wrote:
> пон, 8. јун 2020. у 11:05 Philippe Mathieu-Daudé <f4bug@amsat.org> је
> написао/ла:
>>
>> Aurelien Jarno expressed his desire to orphan the SH4 hardware [*]:
>>
>>   I don't mind being [...] removed from there.
>>   I do not really have time to work on that.
>>
>> Mark the SH4 emulated hardware orphan.
>>
>> Many thanks to Aurelien for his substantial contributions to QEMU,
>> and for maintaining the SH4 hardware for various years!
>>
>> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg708400.html
>>
>> Message-Id: <20200601214125.GA1924990@aurel32.net>
>> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
> 
> The basic idea of the patch (as read from the title and the commit
> message) is good and positive.
> 
> The problem is that the patch does something different than the commit
> message says - pretending that it just orphans something. Which is not
> good. Actually, very clumsy and bad.
> 
> It creates a whole new subsection in MAINTAINERS file (not said in the
> commit message), without any consistency with the current organization
> in the file. That new subsection looks completely misplaced, living
> with "TCG CPUs" neighbours.

I guess you misread the patch context, pasting it again:

-->8--
diff --git a/MAINTAINERS b/MAINTAINERS
index 6e7890ce82..49d90c70de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -299,9 +299,7 @@ SH4 TCG CPUs
 M: Aurelien Jarno <aurelien@aurel32.net>
 S: Odd Fixes
 F: target/sh4/
-F: hw/sh4/
 F: disas/sh4.c
-F: include/hw/sh4/

 SPARC TCG CPUs
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
@@ -1948,6 +1946,14 @@ F: hw/*/*xive*
 F: include/hw/*/*xive*
 F: docs/*/*xive*

+SH4 Hardware
+S: Orphan
+F: hw/sh4/
+F: hw/char/sh_serial.c
+F: hw/intc/sh_intc.c
+F: hw/timer/sh_timer.c
+F: include/hw/sh4/
+
 Subsystems
 ----------
 Audio
---

Pasting with more context and lines numbered:

 283 RENESAS RX CPUs
 284 M: Yoshinori Sato <ysato@users.sourceforge.jp>
 285 S: Maintained
 286 F: target/rx/
 287
 288 S390 TCG CPUs
 289 M: Richard Henderson <rth@twiddle.net>
 290 M: David Hildenbrand <david@redhat.com>
 291 S: Maintained
 292 F: target/s390x/
 293 F: hw/s390x/
 294 F: disas/s390.c
 295 F: tests/tcg/s390x/
 296 L: qemu-s390x@nongnu.org
 297
 298 SH4 TCG CPUs
 299 M: Aurelien Jarno <aurelien@aurel32.net>
 300 S: Odd Fixes
 301 F: target/sh4/
 302 F: disas/sh4.c

^ This part is the TCG frontend.

 303
 304 SPARC TCG CPUs
 305 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 306 M: Artyom Tarasenko <atar4qemu@gmail.com>
 307 S: Maintained
 308 F: target/sparc/
 309 F: hw/sparc/
 310 F: hw/sparc64/
 311 F: include/hw/sparc/sparc64.h
 312 F: disas/sparc.c
 313
 314 UniCore32 TCG CPUs
 315 M: Guan Xuetao <gxt@mprc.pku.edu.cn>
 316 S: Maintained
 317 F: target/unicore32/
 318 F: hw/unicore32/
 319 F: include/hw/unicore32/
 ...

1240 RISC-V Machines
1241 ---------------
1242 OpenTitan
1243 M: Alistair Francis <Alistair.Francis@wdc.com>
1244 L: qemu-riscv@nongnu.org
1245 S: Supported
1246 F: hw/riscv/opentitan.c
1247 F: include/hw/riscv/opentitan.h
1248
1249 SH4 Machines
1250 ------------
1251 R2D
1252 M: Magnus Damm <magnus.damm@gmail.com>
1253 S: Maintained
1254 F: hw/sh4/r2d.c
1255 F: hw/intc/sh_intc.c
1256 F: hw/timer/sh_timer.c

^ a SH4-based machine

1257
1258 Shix
1259 M: Magnus Damm <magnus.damm@gmail.com>
1260 S: Odd Fixes
1261 F: hw/sh4/shix.c
1262
1263 SPARC Machines
1264 --------------
1265 Sun4m
1266 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
1267 S: Maintained
1268 F: hw/sparc/sun4m.c
1269 F: hw/sparc/sun4m_iommu.c
....

1455 Devices
1456 -------
1457 EDU
1458 M: Jiri Slaby <jslaby@suse.cz>
1459 S: Maintained
1460 F: hw/misc/edu.c
1461
1462 IDE
1463 M: John Snow <jsnow@redhat.com>
1464 L: qemu-block@nongnu.org
1465 S: Supported
1466 F: include/hw/ide.h
1467 F: include/hw/ide/
1468 F: hw/ide/
....

1919 PIIX4 South Bridge (i82371AB)
1920 M: Hervé Poussineau <hpoussin@reactos.org>
1921 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
1922 S: Maintained
1923 F: hw/isa/piix4.c
1924 F: include/hw/southbridge/piix.h
1925
1926 Firmware configuration (fw_cfg)
1927 M: Philippe Mathieu-Daudé <philmd@redhat.com>
1928 R: Laszlo Ersek <lersek@redhat.com>
1929 R: Gerd Hoffmann <kraxel@redhat.com>
1930 S: Supported
1931 F: docs/specs/fw_cfg.txt
1932 F: hw/nvram/fw_cfg.c
1933 F: stubs/fw_cfg.c
1934 F: include/hw/nvram/fw_cfg.h
1935 F: include/standard-headers/linux/qemu_fw_cfg.h
1936 F: tests/qtest/libqos/fw_cfg.c
1937 F: tests/qtest/fw_cfg-test.c
1938 T: git https://github.com/philmd/qemu.git fw_cfg-next
1939
1940 XIVE
1941 M: David Gibson <david@gibson.dropbear.id.au>
1942 M: Cédric Le Goater <clg@kaod.org>
1943 L: qemu-ppc@nongnu.org
1944 S: Supported
1945 F: hw/*/*xive*
1946 F: include/hw/*/*xive*
1947 F: docs/*/*xive*
1948
1949 SH4 Hardware
1950 S: Orphan
1951 F: hw/sh4/
1952 F: hw/char/sh_serial.c
1953 F: hw/intc/sh_intc.c
1954 F: hw/timer/sh_timer.c
1955 F: include/hw/sh4/

^ The section is placed under the "Devices" category.

1956
1957 Subsystems
1958 ----------
1959 Audio
1960 M: Gerd Hoffmann <kraxel@redhat.com>
1961 S: Maintained
1962 F: audio/
....

Where do you think this entry should be placed?

> On top of that, it creates a new
> precedent, leaving many unanswered questions, like: Should other
> targets follow the same pattern?
> 
> I personally think that creating a new subsection is just a code
> churn, waste of everybody's time on unimportant things.
> 
> Wouldn't it be simpler that you just changed statuses of all Aurelien
> sh4 sections to "Orphaned", as he already said he approves, and leave
> sh4 sections reorganization to a future maintainer?
> 
> If you really want to reorganize sh4 sections, these changes should be
> in a separate patch. "Orphaning" patch should contain only changes of
> statuses.
> 
> Regards,
> Aleksandar
> 
>>  MAINTAINERS | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6e7890ce82..49d90c70de 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -299,9 +299,7 @@ SH4 TCG CPUs
>>  M: Aurelien Jarno <aurelien@aurel32.net>
>>  S: Odd Fixes
>>  F: target/sh4/
>> -F: hw/sh4/
>>  F: disas/sh4.c
>> -F: include/hw/sh4/
>>
>>  SPARC TCG CPUs
>>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> @@ -1948,6 +1946,14 @@ F: hw/*/*xive*
>>  F: include/hw/*/*xive*
>>  F: docs/*/*xive*
>>
>> +SH4 Hardware
>> +S: Orphan
>> +F: hw/sh4/
>> +F: hw/char/sh_serial.c
>> +F: hw/intc/sh_intc.c
>> +F: hw/timer/sh_timer.c
>> +F: include/hw/sh4/
>> +
>>  Subsystems
>>  ----------
>>  Audio
>> --
>> 2.21.3
>>
>>
> 

