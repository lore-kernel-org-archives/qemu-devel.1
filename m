Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496AEC4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 17:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E0A4206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 17:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q4jCrsGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0A4206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP859-00021U-Et
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 13:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kP83V-0001Pj-FH
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 13:44:17 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kP83S-000633-8v
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 13:44:17 -0400
Received: by mail-wr1-x441.google.com with SMTP id w5so7051827wrp.8
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 10:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=plDwaILzrD45jJ0mNASBfq25jRcEi6jigUzDZ4edR8k=;
 b=q4jCrsGT8DMa32WcWZX3RwRsKFNJ8zVEdO6kzEGGFKSJx8gSqLSbBapzZk6nZbNcXR
 CKV2P8TgZ4AyQS++LC0Wu5wuup5xKapTxVTvfhis82CPKK6ngj9tJaimZTj0zBVXH2VE
 XLxBshbnL9LagmDyWicPYNJRxyPuR5E31qiQi1faMB9YeQ++CBW/vjsdly9nMIaf3Z2c
 hjQNTM0WvZW6npkz/EIJGbJ/VrwNxAxdS02gK0nFcybgLbhLM2tVqKWvszv+dlk8PBD4
 9gwlaCpWychM+17p57icL0Q7vtcncWj9O0wXnEl2j8mVNpFI0nt0oU33foT14/rVkbms
 xWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=plDwaILzrD45jJ0mNASBfq25jRcEi6jigUzDZ4edR8k=;
 b=KgGTrTJ5vGCALJ0LWps8GIWIbQZNgZzE4cNHAP33xerjPy4O6ZLmDkSuvnRPrat/+z
 v6JDh8HoaRzR9ZiM6HaRmObFx6u+PhqU0eBFLlYC72bP0YaW51NVb/+Mq56K9mM7J10/
 aZJsTLr1N2J08kZuLWwIMMeET8QjnfwRkfXdzp5awA0QNkHHCwJ2h9mNZhM+RG5LTz95
 mU1qQsppf+ASk9K49kpYkKC2huewTBNoT944W6r3CAAm5RA3dDFeMTvs3G0UBFFV5lEE
 oyBzZ2KFmtBGbUk4wQuYAeQywQHRRk9jxE1P/YkhCCR5NKLvOuznui6ebThE+m5GgKG4
 wI9A==
X-Gm-Message-State: AOAM530+30TFVmLFLIovdGIxWAw7wq3HmT2RwRr0WK69ly4NuypcuaNb
 Fxo+o8fhxnaz4tSPC/MljDBP3w==
X-Google-Smtp-Source: ABdhPJwrWSupyjkMG/bdTn+JE1+WoNktUL7v0kmqBj1TYIMhZ+va7zVjlHBcdj/kFNGiRLOC0QdW0g==
X-Received: by 2002:adf:d18c:: with SMTP id v12mr7322421wrc.131.1601833452054; 
 Sun, 04 Oct 2020 10:44:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t124sm9900983wmg.31.2020.10.04.10.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 10:44:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1598F1FF7E;
 Sun,  4 Oct 2020 18:44:10 +0100 (BST)
References: <47dbcad4-3121-b1c3-06fa-abec7c353fb6@gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas <74cmonty@gmail.com>
Subject: Re: Emulate Rpi with QEMU fails
In-reply-to: <47dbcad4-3121-b1c3-06fa-abec7c353fb6@gmail.com>
Date: Sun, 04 Oct 2020 18:44:09 +0100
Message-ID: <87sgatanti.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas <74cmonty@gmail.com> writes:

> Hi,
>
> I'm trying to emulate Rpi with QEMU.
> I found
> [url=3D1]this[/url]
> arcticle in Raspberry Pi Geek documenting the steps including persistent
> storage on host.
>
> However when starting the emulation with command
> qemu-system-arm -M versatilepb -cpu arm1176 -m 256 -serial stdio -hda
> 2020-08-20-raspios-buster-armhf-lite.img -net
> "user,hostfwd=3Dtcp::5022-:22" -dtb versatile-pb-buster.dtb -kernel
> kernel-qemu-5.4.51-buster -append "root=3D/dev/sda2 rootfstype=3Dext4 rw
> panic=3D1" -no-reboot

Let's start with the fact you are using a versatilepb machine type with
a versatilepb dtb and not the rasppi model. The manual goes into more
details about why you can't generally share kernels built for one ARM
system on another:

  https://qemu.readthedocs.io/en/latest/system/target-arm.html

Since that article was written we have added models for the -M raspi2
and -M raspi3 which might work better with a kernel written for it
although the emulation isn't complete.

> I get this error:
> VFS: Cannot open root device "sda2" or unknown-block(0,0): error -6
> Please append a correct "root=3D" boot option; here are the available
> partitions:
> 0100            4096 ram0
>  (driver?)
> 0101            4096 ram1
>  (driver?)
> 0102            4096 ram2
>  (driver?)
> 0103            4096 ram3
>  (driver?)
> 0104            4096 ram4
>  (driver?)
> 0105            4096 ram5
>  (driver?)
> 0106            4096 ram6
>  (driver?)
> 0107            4096 ram7
>  (driver?)
> 0108            4096 ram8
>  (driver?)
> 0109            4096 ram9
>  (driver?)
> 010a            4096 ram10
>  (driver?)
> 010b            4096 ram11
>  (driver?)
> 010c            4096 ram12
>  (driver?)
> 010d            4096 ram13
>  (driver?)
> 010e            4096 ram14
>  (driver?)
> 010f            4096 ram15
>  (driver?)
> 1f00           65536 mtdblock0
>  (driver?)
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,0)
>
> I assume this is related to the content in fstab of RaspiOS:
> proc            /proc           proc    defaults          0       0
> PARTUUID=3D907af7d0-01  /boot           vfat    defaults          0      =
 2
> PARTUUID=3D907af7d0-02  /               ext4    defaults,noatime  0      =
 1
>
> Can you please advise how to fix this error?
>
> THX


--=20
Alex Benn=C3=A9e

