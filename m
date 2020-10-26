Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B26DC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F1520878
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fSa7pqWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F1520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3Tc-0001Nh-Jr
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX3T2-0000pg-0l
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:27:24 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530]:38874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX3T0-0007OC-6z
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:27:23 -0400
Received: by mail-ed1-x530.google.com with SMTP id bc23so9553177edb.5
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 07:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OvbtfY6lkD6VEoZogwJ9TbS0WlCK3sjxtuzPyp+H5ro=;
 b=fSa7pqWXWZ9sPFh4Gi++zbJSsM6GZaCpenk+9Kl8FSF1gotAJce7T3g3h4q4YTO2FP
 lSVEImggFasMynK0r6hyM8uc5ZSVnldoMpyFXQzIw8GfkeKE/QlK4mcFXAdkQ4/kT1DD
 GOVJ8B6PqYGAODBTmHJNsao3fX/7Fq8tq6n92lH6HBnqVAhhFHlWlbMz72b+IZs4JNDw
 GDhANuby7+lHGZBl/nZB83KcPDlfZ3lDgJWNfWUCUMvg1NjKdZJWU2S/PQDThV///Aik
 NJmNItmHf4MlETEzViZ4YmvDWKfFZ5iwkjCjGcj9+1nY5+TAPBjqFDhVWeKRXBWpYk5T
 3rAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OvbtfY6lkD6VEoZogwJ9TbS0WlCK3sjxtuzPyp+H5ro=;
 b=sUU5bE4EbfxtHfcL6WEo4g7m/WTdtVNyBwRWnYpetki/DDlO5mqNAnthzT6cc1HSoe
 2gacqx5euh01am/g7hgbfTyH+yk7H2C9JWP8PND+6hGCAAqjL7ds7q9oAT7FjkjoCHz4
 UyX4GVl8ueqDmNik/EIJyyKVTiTBZYcXI+ceUGP5KVvqmWA1eLI+p1dAb9462YR8sDQD
 lHMD4iRa8Y+Flh+P4+5Q0ufFx3mOLISU/lncg7i1FOhRZBUTNt2VMpj8/5uM5RALoKPO
 VUAlTFi0wioyQfrm1FursRsHjOYWC0wHV4ezovrBE/329GYCUhKa6TkjzpZ4eeutAU6h
 zRKQ==
X-Gm-Message-State: AOAM533J+Ogw4LbcGwkLexMAcufJB4jFV2k0tWEzLkbB5te7F8Qp9bw9
 L61icXD/4L6ErEdNobxqwQHeMclBayY45pZskAd0NA==
X-Google-Smtp-Source: ABdhPJzDcraFiXeGbaaeiglb1htFAj5QVZ4RDINBtUihUSWe7nIjzhJIvD/vi2pfz5SDES9UWWE3s6QGdo/0C1FzBiQ=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr15723476edq.146.1603722440357; 
 Mon, 26 Oct 2020 07:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200228163840.23585-1-peter.maydell@linaro.org>
 <20200228163840.23585-26-peter.maydell@linaro.org>
 <a049110f-b7cb-52bd-de77-6e1193b5b6de@amsat.org>
 <6ce6a790-c68e-e3ed-962e-ba6f49244315@redhat.com>
 <f02d74fb-af6e-6e04-7ce7-48ab09a20e4f@amsat.org>
 <f2f276a9-a6ad-a2f8-2fbc-f1aca5423f79@amsat.org>
 <20201023174351.31838a86@redhat.com>
 <c80350d2-3591-6541-abf3-960b69cedf7d@amsat.org>
 <20201023210445.2fa72562@redhat.com>
 <CAFEAcA_wP1t1+o_PnCOotHvs54qSxJQSyuhtbSCSg4oewD43ng@mail.gmail.com>
 <20201026143657.68147517@redhat.com>
In-Reply-To: <20201026143657.68147517@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 14:26:59 +0000
Message-ID: <CAFEAcA_=_x=xH5jHiS6WyUSjyZwH2sy6xsMxgm6c-c+rcRAPzA@mail.gmail.com>
Subject: Re: [PULL 25/33] tests/acceptance: Add a test for the N800 and N810
 arm machines
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 13:37, Igor Mammedov <imammedo@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > Hmm, maybe, maybe not. The original design idea here was that
> > the boot loader code took a structure defining only the things
> > that the bootloader needed to know. It doesn't really need to
> > know about all the stuff that's in MachineState, which is
> > the state structure for the machine.
>
> Yep It doesn't need all data the MachineState contains, but then we end up
> with this kind of bugs which could be avoided if duplication were not there.
> And some of the fields in  MachineState are pure bootloader data.

I notice we already have arm_load_kernel() take a MachineState*
and fill in the info->kernel_filename etc from the MachineState
fields. I suppose we could do the same for a few more fields.
I'm not very fond of the way that function takes the MachineState*,
though. I think it would be nicer if the MachineState had a
separate sub-struct which was "this is the stuff that's just
data for the bootloader" and passed that, rather than throwing
the entire state struct pointer around.

thanks
-- PMM

