Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9597C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:01:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 879482053B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrCJdW/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879482053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqmk-0001Kg-FZ
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joql6-0000Ed-Bi; Fri, 26 Jun 2020 11:59:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joql4-00043J-IJ; Fri, 26 Jun 2020 11:59:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id h15so9981165wrq.8;
 Fri, 26 Jun 2020 08:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xk4kffrXUCfO4tB7wnRoSXPKdFEE/9oDmgTUl7kwiew=;
 b=XrCJdW/lJePsb3hSHLOc9jcVWsZZlLDrW4me2rg65Av8+WMhd3jbycpdgvr2IPkwqV
 daLG0yM0f1zA6JbZv993CCdI7kt7nvoZUl+b0zSyf5fSPVsWxKLApsH16Q+s+fR4+FwA
 Ts83J4YgMIdCGMKGQzYQFRMrdT51Onhfw6Dqc0vAEB1Pj1sEOKL/vvAFV0nmuYHVzOfV
 3ftQAGNWUVmRMwnyWQDAAlVQP999NyNp4CEXERqLdIWW+ImT+Cdkg7TRHbFjWw0pFicW
 ldNRGQgNMAORh5fFu2PWsXuslr0RteoClv4l/THQJTPHcdzOGEL4lXsdpi9MG2/lrqPz
 zvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xk4kffrXUCfO4tB7wnRoSXPKdFEE/9oDmgTUl7kwiew=;
 b=P1wElkXtrWF+lZWvrvq6pO+APB6OcaF4sltd17aBlmMOmJqZJ+3HQb3d0dO9yngGMH
 t21hIzz1b7sMsv77HSaIYg7SRx18a1lUlGy/TjGKEXcOxgpd02bjjBs0DOFLHrQjRnuA
 utJw/1n07VAKvPHvl5Qr3bs3dlvmlewdO5Uii4EYHwq0Ohhg2PgqpvvhV8XCAX11NvDH
 NgjBtWe247tJF6VoKkOMr9UAN/z639k8+GWE1KB6BAMOQAKcfgD2aAOtsfYB75JW5RC9
 lYmH4Ul46rvLAA++qNqiR7KgaZHHH+9zSJ8updki31UdJ1LeTmJfi9H9o6XzeM/QerYX
 zhFw==
X-Gm-Message-State: AOAM531Ct7WGEe1DTyrvYGilG6qIhpUvihzISX+JkvSFrXm0ssTGy7DY
 33jdFqLuIWi3SSKxr11Ilekyave2Q8u780373gI=
X-Google-Smtp-Source: ABdhPJwqmdBBYDqooVwi9ysWfldfiWX9hS7JuQ4g1zzzj7eFBZlUpbdMoIQW1Ygw9tTmIBl2fm6QhRgmdq+nvBrchFI=
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr4390534wrv.162.1593187155772; 
 Fri, 26 Jun 2020 08:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200626102744.15053-1-f4bug@amsat.org>
In-Reply-To: <20200626102744.15053-1-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 26 Jun 2020 17:59:02 +0200
Message-ID: <CAHiYmc6DNCaDzLautfL26Rv_hAjZ-M582nr-hj6t=JwB7zWcyg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Use object_get_canonical_path_component to get
 child description
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=B5=D1=82, 26. =D1=98=D1=83=D0=BD 2020. =D1=83 12:27 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> This RFC is simply a proof-of-concept to see if I correctly
> understood Markus' suggestion, see the thread around:
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg08652.html
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   hw/i2c/smbus_eeprom: Set QOM parent
>   hw/i2c/smbus_eeprom: Add description based on child name
>   hw/i2c/smbus_eeprom: Trace reset() event
>
>  include/hw/i2c/smbus_eeprom.h |  9 ++++++---
>  hw/i2c/smbus_eeprom.c         | 18 +++++++++++++++---
>  hw/mips/fuloong2e.c           |  2 +-
>  hw/ppc/sam460ex.c             |  2 +-
>  hw/i2c/trace-events           |  3 +++
>  5 files changed, 26 insertions(+), 8 deletions(-)
>
> --

Is there any documentation related to this interface? If yes, provide
the link, and describe what is not clear to you. If not, then this
series should provide appropriate documentation.

In times we desperately need working "Continuous Integration", it
looks we instead spend our time on "Continuous Interface Guessing" -
for years.

Thanks,
Aleksandar



> 2.21.3
>

