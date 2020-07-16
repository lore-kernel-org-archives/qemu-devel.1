Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDB9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 20:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0627A20656
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 20:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S3MXJtmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0627A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwAwo-0001XC-8O
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 16:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jwAvw-00011V-HZ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 16:56:48 -0400
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44]:45961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jwAvu-0000Ln-OT
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 16:56:48 -0400
Received: by mail-vk1-xa44.google.com with SMTP id h1so1637084vkn.12
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 13:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KaTxWEFwh8YfXI8KSxg7J1l0+flvZY2xPiPzQG9QEM8=;
 b=S3MXJtmCJIVmtNXryZSm7wuf5r5YkFHxZHttHyYYzH3MeJh3WtokxPap+d9wFrUFgZ
 mdp293ouPSm7y30wW3sV6IDAa8+OKXaobmMGm/49WrU4+oOpiqNETeQomAXnCmPMHGhl
 AT/sqhEodfo7trB56LXS5f+pdgsyIq4gdQyEqAMLTCYOcIm+T12qzl/zHLeueYrPlZ3t
 7r9AvVIlf0svxJQZU+xkp7646ERHoxgjLBDY4D8VPWg3Y/3YiYzWAIQ+EusmpFIRVvwT
 SYsJVfrQXKZmWGsG4T0jRHFQCt17CrvmCqWfVlf+qcg5FYKLkBL3u1AHkjMcNsYPK+QO
 Qsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KaTxWEFwh8YfXI8KSxg7J1l0+flvZY2xPiPzQG9QEM8=;
 b=KoXcBQwioUb9Umd8XgaSE4ol4oTdEbWYnGSGg2zowolRf0cBF2s5jlwVui7VKjBYkt
 GDX14TF/P2UdbnZzaZKVSW+HFR28i9CQnYxaRa3ikW5EkerxPEhMigqK+c25TcUB3rVM
 6Ur0Z+dfQ2sLmLwZm6Ld6wa5osDTaNa27rzgQxGn/FACQmQe0XuKcLpZkfM3jedoFT2o
 5FCBLRPfUvuDCNYzCeQQdBKij6maOQj4vjKRptVl7JB/OFrXDW//2p6b5xYPmoHpojAm
 Tnv3Y3o15Gpfju/hpW0dKUV10HyTMMD3B3pqBe5hY6GrYObrQHz7fr88XAN0+w3v1cZ6
 pNwQ==
X-Gm-Message-State: AOAM530XwXPhb1DTf/6T5dFgxtyMJG9rrg7aoD5gTgtsQNA5uKDEmRJy
 v/Lh90okkQkgk2fceb3fc+gun4TFPikDi2dp63Rubg==
X-Google-Smtp-Source: ABdhPJwNqNeMc2gH4+ohsZe215PQh3Ryt9NZMj/ad7WOwpfhCbBr5xwUtYCP2vnQcUncViMi67mNJ6w2jdoXzI5ZKak=
X-Received: by 2002:a1f:38d2:: with SMTP id f201mr4830349vka.91.1594933004141; 
 Thu, 16 Jul 2020 13:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-11-hskinnemoen@google.com>
 <109d52ed-65bf-0fcc-98f1-47b7a6671d0b@kaod.org>
 <CAFQmdRZcygskP3iwss01-Jz67yjAP_JENXjWM2Bp8U=DRzxR0Q@mail.gmail.com>
 <875zaq78xq.fsf@dusky.pond.sub.org>
 <19733456-a672-595d-e721-e0ef26d7f665@amsat.org>
 <87v9iq2hkv.fsf@dusky.pond.sub.org>
 <e87663cf-7cb2-ca6c-a751-e5c1cebc5440@amsat.org>
 <87pn8xywz2.fsf@dusky.pond.sub.org>
 <b3bc658f-a865-8e6b-c904-01c7724e89cc@amsat.org>
 <CAFQmdRa9FiP6yX=XDrJy5KpjifQyVkQiY6DXtSoJSvfoq7Vm6w@mail.gmail.com>
In-Reply-To: <CAFQmdRa9FiP6yX=XDrJy5KpjifQyVkQiY6DXtSoJSvfoq7Vm6w@mail.gmail.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Thu, 16 Jul 2020 13:56:31 -0700
Message-ID: <CAFQmdRac6tsZafN3PsnLhPA_Ny032ZAjOFuXkmYvJ-ubjcpPPw@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Qemu-block <qemu-block@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>, CS20 KFTing <kfting@nuvoton.com>, 
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
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
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, Jul 15, 2020 at 1:54 PM Havard Skinnemoen
<hskinnemoen@google.com> wrote:
>
> On Wed, Jul 15, 2020 at 3:57 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> >
> > On 7/15/20 11:00 AM, Markus Armbruster wrote:
> > > Now my point.  Why first make up user configuration, then use that to
> > > create a BlockBackend, when you could just go ahead and create the
> > > BlockBackend?
> >
> > CLI issue mostly.
> >
> > We can solve it similarly to the recent "sdcard: Do not allow invalid S=
D
> > card sizes" patch:
> >
> >  if (!dinfo) {
> >      error_setg(errp, "Missing SPI flash drive");
> >      error_append_hint(errp, "You can use a dummy drive using:\n");
> >      error_append_hint(errp, "-drive if=3Dmtd,driver=3Dnull-co,"
> >                              "read-ones=3Don,size=3D64M\n);
> >      return;
> >  }
> >
> > having npcm7xx_connect_flash() taking an Error* argument,
> > and MachineClass::init() call it with &error_fatal.
>
> Erroring out if the user specifies a configuration that can't possibly
> boot sounds good to me. Better than trying to come up with defaults
> that are still not going to result in a bootable system.
>
> For testing recovery paths, I think it makes sense to explicitly
> specify a null device as you suggest.

Hmm, one problem. qom-test fails with

qemu-system-aarch64: Missing SPI flash drive
You can add a dummy drive using:
-drive if=3Dmtd,driver=3Dnull-co,read-zeroes=3Don,size=3D32M
Broken pipe
/usr/local/google/home/hskinnemoen/qemu/for-upstream/tests/qtest/libqtest.c=
:166:
kill_qemu() tried to terminate QEMU process but encountered exit
status 1 (expected 0)
ERROR qom-test - too few tests run (expected 68, got 7)

So it looks like we might need a different solution to this, unless we
want to make generic tests more machine-aware...

