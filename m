Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1128BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D2C20884
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpjOlT0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D2C20884
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrSkW-0008PH-3N
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jrSjZ-0007o0-QU
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 16:56:33 -0400
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44]:36456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jrSjY-0002Gl-Aj
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 16:56:33 -0400
Received: by mail-vk1-xa44.google.com with SMTP id s192so7360924vkh.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=URtNUD6GSTAQ7SAD3xbfDjQDrrOchuNcrcx+xI4NSVE=;
 b=LpjOlT0UFhP+SidGvZSXO+FB7vrfIlT9OCWkrGyCza0bwCdS1lSrEhpanXfpdxHuyb
 E7sbXs3Xaif6cp7Ri/ywqjfzxqLFYmsc6fm5joK6Ub9eUR2oExeIJU3M/syRMS+XT0uI
 4DBt3w48SykIUP4RcFYNfYvmcABVqzMwTTn3V4Up48Gqdmr6n21gEDegdIGM4IAxQXbi
 tyN3eAsz4H5gFfm3wkw0vyKbxLs2tmpdOfFTtomVE+MwwV3ygOOF3B5VMna02o7orsjQ
 kMFXQLvraOJS2Gr3o01wAMPaS4c9uTAolXQYoYn/Av3zMAwBoY1+a0tqaQvyWD49NMkc
 WRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=URtNUD6GSTAQ7SAD3xbfDjQDrrOchuNcrcx+xI4NSVE=;
 b=Ix7pQeQPV6qBnC9s1eDz7nqFICdmja1jLGhT0k/9U2L/r5dY4bwqSlM5vRWDMdY6iX
 RsnDuHr0n3T7bdEb7T+ik1hdz60UL23cRHxrbIGbUK9npbJpa/+9OON3j7FQEVPXVsiz
 AdT5fRIDrlleARtrFocvpeCfNAcRfxVkrwi7Zd3iWqhpC54oIikkpx/FLnQyYojVmgDe
 4Q2V3VPODdIX5GiXdWpTngfoPW/qdgTwyR1fI+qhZe0p7BLX3qQZRJc5BVPp9lvxwpNW
 IXYtY7JAjhkz+SfZa2AoS27dDLVmonV8QL9GeC/o7dcOvPLWVXaVSGcglAs2vt9xC7Sl
 sdFA==
X-Gm-Message-State: AOAM533ShgUDABY1GGImAPe+Y1CaIdnYbYpa3wg3GbguCnY6Ksb2EuZ2
 TxWW3xVwc2oPyK5/ot3A3llSvvYKtwJ4WW195IYcew==
X-Google-Smtp-Source: ABdhPJwm33N5yPnBIXG5z1amad3dreXS7niLMQG2asMrmf3TDID+AhfweT7T57ZYyqXh9bg9Y/90YdD4hK2o6YNvF64=
X-Received: by 2002:a05:6122:130b:: with SMTP id
 e11mr29630373vkp.20.1593809790964; 
 Fri, 03 Jul 2020 13:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200626235519.591734-1-hskinnemoen@google.com>
 <20200626235519.591734-6-hskinnemoen@google.com>
 <001d2d27-dfe2-b03b-9996-ca69ba81a542@amsat.org>
In-Reply-To: <001d2d27-dfe2-b03b-9996-ca69ba81a542@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Fri, 3 Jul 2020 13:56:19 -0700
Message-ID: <CAFQmdRZ4o9hs57kGU6WWHuBw4X+F55WyEsrhqiDTnSb3iftxTA@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] hw/arm: Add NPCM730 and NPCM750 SoC models
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a44;
 envelope-from=hskinnemoen@google.com; helo=mail-vk1-xa44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 3, 2020 at 6:32 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> On 6/27/20 1:55 AM, Havard Skinnemoen wrote:
> > +/*
> > + * This covers the whole MMIO space. We'll use this to catch any MMIO =
accesses
> > + * that aren't handled by any device.
> > + */
> > +#define NPCM7XX_MMIO_BA         (0x80000000)
> > +#define NPCM7XX_MMIO_SZ         (0x7FFD0000)
>
> Could be 0x80000000 since UNIMP_DEVICE is created with low
> priority.

Good point, I'll do that.

> > +    /* I/O space -- unimplemented unless overridden below. */
> > +    create_unimplemented_device("npcm7xx.io", NPCM7XX_MMIO_BA, NPCM7XX=
_MMIO_SZ);
>
> Note by doing that you won't get transaction failures when accessing
> unassigned regions. This not incorrect, but a bit overkill (this covers
> almost 2GiB...).

A lot of that 2GiB space is used by six 128 MiB flash memory
apertures. But there are some holes that probably should generate
transaction failures instead of a default response.

Would it be OK if I send a patch to tighten up the unimplemented space
once a few more of the peripherals have been implemented?

Havard

