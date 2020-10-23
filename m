Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BBBC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 02:04:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7B720E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 02:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNUjm50o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7B720E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVmQx-00007S-4K
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 22:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kVmPr-00081w-7n; Thu, 22 Oct 2020 22:02:51 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:39862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kVmPp-0005m9-7d; Thu, 22 Oct 2020 22:02:50 -0400
Received: by mail-yb1-xb42.google.com with SMTP id 67so3325750ybt.6;
 Thu, 22 Oct 2020 19:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MdNjEe8qDgX/ZT7aExW7njszeWmLIpE6Qcuh8bI/ozg=;
 b=DNUjm50oKO1bcRFeCe5lMIVZ5hmxitiyeDB5n2t5TEZuN/7aSFq0OEDP7F36jBwiCm
 wyFJJ85BdSMTt+wx1r8EpD7Ew6ogytxv+O3fIGTfroyBRg1z1rAtB58Fg+A74/ObE8uj
 ZFZxx4M5ualnL1aYu5LzSKjs6gtk8Uwve0BRX7wNaFdOPZ+pZWCLovZNHVocLPtIkBxT
 uoFnHUsk7UcUzYda9ewczBNzZhe2E+YQFJHx1p52EFBxbWYnTRwZm6H3hfgQWwgssS7y
 uA5lPM7NjgfNXGMgbRt5NQrdXzSTA7MMO8wAKojV3P8Pq4sKMPET9Comhh4fmYVyfk5y
 IzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MdNjEe8qDgX/ZT7aExW7njszeWmLIpE6Qcuh8bI/ozg=;
 b=ITLELoO7+qtAwiMG7hXHt+XzvAcoSfaDTxCSkITTTct2ngT54XyPKdb0SjEQjKOwxx
 +CmzgHUWGksr/2oZf7zGP9HBlghvRO8YP667gu0U7sZEapvmnL5EF2DKuOKoH3/skusS
 3+phzsw+FZpQHby7HpL5Y/emuY3lqpgkEEPXdeaoGBu97lw2sKnk54pGivA0If2T0Ud4
 6+5ho17AqCULCHFWIUuILJKer+y/MeRkPFobMUDTxoI/GFEFatjNaVQxNHf52CN9kvuw
 hZ5vLcvbot3ZycGPcfQk11wy433G6ANCa6pMrhcEwqFNMQRLtZiTAU8PVGrI7IiY+rB6
 zzoA==
X-Gm-Message-State: AOAM533q/6nmY6JcKvhVW+2eA5PA3WZDF/nrGJHH6xTDKiiTVtJUhDKV
 ZXivfVWAiGJourpLp+fDsQ3aLRf28lb38dH1dZc=
X-Google-Smtp-Source: ABdhPJwva9psuI6eBE8IXjnI5x+Y0RFfLsZXCQLjngHa1uTCkWDXtMP7NVwa6FUUFkVGszEvt1/7tC1fHwVGzIlY4NE=
X-Received: by 2002:a25:386:: with SMTP id 128mr310909ybd.122.1603418566061;
 Thu, 22 Oct 2020 19:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200821172916.1260954-1-f4bug@amsat.org>
 <20200821172916.1260954-23-f4bug@amsat.org>
 <e378932a-1de3-83c1-834f-ae6526604cb7@amsat.org>
 <CAEUhbmVFZ8aWdv48D8acdfFRp6WMYL6n=ENeo4hBZfmqE9TrDA@mail.gmail.com>
 <a0ac3805-ec48-2a0e-6511-b142bfc6f214@amsat.org>
 <CAEUhbmVLFJWND=KHexD12mrCMJSO3mcE6k7_tRE+v8pNZjhN_A@mail.gmail.com>
 <CAPan3Wqx-psi6zgz3NyM1Hu_PHaGq4Nn3_RJf_zueqwXFNKuWg@mail.gmail.com>
In-Reply-To: <CAPan3Wqx-psi6zgz3NyM1Hu_PHaGq4Nn3_RJf_zueqwXFNKuWg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 23 Oct 2020 10:02:34 +0800
Message-ID: <CAEUhbmXGbNNXkJYt8-sX_+nT_ReXoyerYaf+KROxx55-89wbHA@mail.gmail.com>
Subject: Re: [PULL 22/23] hw/sd: Fix incorrect populated function switch
 status data structure
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Niek,

On Thu, Oct 22, 2020 at 11:20 PM Niek Linnenbank
<nieklinnenbank@gmail.com> wrote:
>
> Hi Bin, Philippe,
>
> If im correct the acceptance tests for orange pi need to be run with a fl=
ag ARMBIAN_ARTIFACTS_CACHED set that explicitly allows them to be run using=
 the armbian mirror. So if you pass that flag on the same command that Phil=
ippe gave, the rests should run.

Thank you for the hints. Actually I noticed the environment variable
ARMBIAN_ARTIFACTS_CACHED when looking at the test codes, but after I
turned on the flag it still could not download the test asset from the
apt.armbian.com website.

> I have a follow up question and Im interested to hear your opinion on tha=
t Philippe. Should we perhaps update the orange pi tests (and maybe others)=
 so they use a reliable mirror that we can control, for example a github re=
po? I would be happy to create a repo for that, at least for the orange pi =
tests. But maybe there is already something planned as a more general solut=
ion for artifacts of other machines as well?
>

Regards,
Bin

