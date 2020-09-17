Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7CAC35264
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD98206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbWhD1sc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD98206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ018-0002lD-Hi
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 15:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIzys-0001lh-D2
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 15:54:10 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:43923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIzyq-0005eK-CS
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 15:54:09 -0400
Received: by mail-ej1-x629.google.com with SMTP id o8so4930339ejb.10
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TrUelx2LGJWwLBAW27oUlQK9yqUhJhsGMU0O2aE0xgY=;
 b=vbWhD1sc/NFFvY/OqBX15MUDg8kkrOOfrygIY/gKUGCo8jo4Zmse2JFKmJLlUEhTwB
 pZSIv0MRwdF46nmjNCFYrZhxV9SUXt8EQEloQENpaThG7UgPSuZbURyKG/mS3B2k71p+
 gwoTgOAZndo7MCX1LeQJPeOClwydTMX2HLDpBTqAGBtDxlIPE6Lw/vbHmgEfETENaN5F
 Hlvr5BpFk7sblkgE9rtYPFSJApV9Z2ET1kP6Au/M5uWwn1Pd8SWlyEqn1zEiLhoqIV+Y
 8H1GKkSeEwdiVvZ50K5wJvOgruCNkf9IgK+Jlb5Epf914OQbusst85JBJpvofBeAvtF1
 PoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TrUelx2LGJWwLBAW27oUlQK9yqUhJhsGMU0O2aE0xgY=;
 b=kIEWia+Ttp6QJOiAZ2Iq/SOKW1Wf9NFkUYGw2N8ieAeBHsyVKWJ8f8PZ2fT3nIXQ1k
 kem9/2Fz6qyU8BU7iM7w4C3+Zth+9GEJFWyBiGzlLmUB2Ygqyg6B56FXYlmPs94sEBmG
 E43gSGnwBHNiVBwjizkmSlMt+deS7Gpvk6taKpbfQu33wZjuN8s/IEnrcSanZpm0GPP3
 vl4z1qeWWSqPqgOFkS/a5ugEEjkPCrGAAyjjLWTiJUujFFJqojwBrehCwr4+3o8NnX9I
 8kuF3Oyq4idsgNuBI+Rq2VgOAYy7FhxxEaW5ebZ7RnRGXETMoh3s0svx3jV9Jjd+NpYH
 Bw8Q==
X-Gm-Message-State: AOAM533bOE4nTF3WUntRa8uNmRn0tgD8FrTTlb25sSw6z2PbHnyfMv32
 z8lr4ZPuf3WG5YYCXew4DB96TcdSpbhG1eRFMRLUDg==
X-Google-Smtp-Source: ABdhPJyOXY5weurtqr90QI28wDxI9Cf7ANGYyz+j8mqTBmbXPqYWcJ9PaufWa0hwop2oC8/9HyCNIfpEFIc6ECkVa7Y=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr31000426ejb.382.1600372446630; 
 Thu, 17 Sep 2020 12:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <3FA3CCC0-72A3-42EB-A12B-7FA0A30E106F@panasonic.aero>
In-Reply-To: <3FA3CCC0-72A3-42EB-A12B-7FA0A30E106F@panasonic.aero>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Sep 2020 20:53:55 +0100
Message-ID: <CAFEAcA_PFGc2Ka-egqYqzMq0Nu_aRiNUPif0yntg4L56UTi7MQ@mail.gmail.com>
Subject: Re: [Qemu-arm] Assigning sd-card to specific SD-bus with Sabrelite
 Machine
To: David Aghaian <David.Aghaian@panasonic.aero>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Jean-Christophe DUBOIS <jcd@tribudubois.net>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Sep 2020 at 19:21, David Aghaian
<David.Aghaian@panasonic.aero> wrote:
> Having a real difficult time determining whether or not I can use qemu (a=
rm) with the Sabrelite machine type to be able to assign an sd-card to one =
of the 4 available sd-bus slots. Currently, no matter what combination of a=
rguments I provide, it will always fall on the first bus (see screenshot).

> Is there any way with QEMU to attach the card specifically to the last sd=
-bus slot? It should be noted I was able to achieve the expected behavior a=
fter patching QEMU itself with the following change but I=E2=80=99d prefer =
to not have to modify the tool itself.

This ought to work, but I think there is a bug in the QEMU model
of this board which means it does not.

> diff qemu-5.1.0.orig/hw/sd/sdhci.c qemu-5.1.0/hw/sd/sdhci.c
> 1311a1312,1314
> >     static int index=3D0;
> >     char name[64];
> >     sprintf(name, "sd-bus.%d", index++);
> 1313c1316
> <                         TYPE_SDHCI_BUS, DEVICE(s), "sd-bus");
> ---
> >                         TYPE_SDHCI_BUS, DEVICE(s), name);

Thanks for the suggested patch -- this was a big clue about
what the problem was.

sdhci.c isn't really the best place for this to be done -- this is
the model of the device itself, and the name of the bus as part
of the device should be 'sd-bus'. The right place to fix the
bug, I think, is in the hw/arm/fsl-imx*.c files, which are the
implementation of the SoC object. There we should be creating
aliases on the SoC for the various SD buses (there's an example
of this in hw/arm/xlnx-zynqmp.c), and the aliases can all have
different names so they're usable from the command line.

thanks
-- PMM

