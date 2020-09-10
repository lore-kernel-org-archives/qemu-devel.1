Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC9CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 11:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D90420C09
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 11:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="coqVH2fJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D90420C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGKTy-0003z7-61
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 07:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1kGKG9-00076R-1m
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:56:57 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529]:35224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1kGKG6-0006IO-Qu
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:56:56 -0400
Received: by mail-ed1-x529.google.com with SMTP id i1so5865698edv.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 03:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=XHD8+o9rBKTBEWiboce4LpdiiKgt5drAfpuf/AnQXBI=;
 b=coqVH2fJkTlHmkbSMi6pvkm2rovvmoTdihqkYP6QTitmBjDxN88sd866ML2peFCrpD
 JfZ9h5EG4E1LQRyMv9x7dZA8l32y1IK23pjKpy93jzl64NQdMB4J7vduiGTVuidr9ZEB
 0ut1U7B4iubUFn6FSdI3BDOo75mAvFLXBHIgN6UVDbqkzZfTvVmD+zR9hvndcnakDZHB
 nk25/c6vRSeWvUrI3w/uRA11zsZYZ6k4nrWA99RyFMyvNDKDqpNjgWzWlcaJOkT7Wxms
 DRxPWEhQL6w0Ja4kAL+EpAbczDGBx6pV6oJiX1glGj0FVixh/PNcvcrX6x6m3+qqsVpS
 VCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=XHD8+o9rBKTBEWiboce4LpdiiKgt5drAfpuf/AnQXBI=;
 b=oxZXDEN/wGtnLSk5eEAnKic3mZHQOKYFgfgw7EPyFHmcyMa/TFGDKzFh4Gss287WIa
 eFqg3BJdCzbo4ErwLjlyN7596stUzx3j7vcbN+OVAH/VKDuhKOcX7DCKR9bG3MDVBeqg
 2e4vNVIGSvkhDffdBQOn2qk6uRMi5ky9WmbjhLpgT74IFyYHL/1KR0vj209yGoOC5KZb
 th27JRcPBf3UjlNhrAkyDAbYDNBrtrLoIMvvftL1hwhh1ZtuB33X/NkRhhN0dhYTc4xz
 cj16LIm8cctjCba2dmKXYvnnaDpKyiifaima4/scVqj0u46m8pkvDTQujZ/r9gb8GwMX
 NwWw==
X-Gm-Message-State: AOAM533kKtNcfrQwyqFvEotr1PABX2fRSXIG3Fo4nbyeXIUPNoR4ky2F
 O40/cJqvc45zzV/cSLzVAzIpzA==
X-Google-Smtp-Source: ABdhPJytqjRZo7fAiypMhCKrPH244swRMyNrWr+76nKgWFNXEO/6jlNZgZPaCYjBDMcR7WHQw9A8ew==
X-Received: by 2002:a50:fd83:: with SMTP id o3mr8461124edt.176.1599735413195; 
 Thu, 10 Sep 2020 03:56:53 -0700 (PDT)
Received: from wks.local ([86.120.181.246])
 by smtp.gmail.com with ESMTPSA id m16sm6480082ejl.69.2020.09.10.03.56.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Sep 2020 03:56:52 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [RFC] QEMU as Xcode project on macOS
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <20200910104552.GH1083348@redhat.com>
Date: Thu, 10 Sep 2020 13:56:51 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <E3A8F45F-689E-4F11-BCF4-A36D042F9698@livius.net>
References: <2764135.D4k31Gy3CM@silver> <2421928.3WNMogbLRJ@silver>
 <20200910093910.GG1083348@redhat.com> <4878996.4JzhbN1UZ4@silver>
 <CAFEAcA_CPNppKwwJSu4O6U6qF-rfHR2NtG=hWBFatZmD4aiMdg@mail.gmail.com>
 <20200910104552.GH1083348@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Received-SPF: none client-ip=2a00:1450:4864:20::529;
 envelope-from=ilg@livius.net; helo=mail-ed1-x529.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>, G 3 <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 10 Sep 2020, at 13:45, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> AFAICT both MacPorts and HomeBrew can be installed into custom =
locations,
> at least if you do a "from source" install of them, rather than using =
the
> pre-built packages.

Yes, I use this for HomeBrew, but generally you cannot select the =
individual versions for libraries and tools, the Ruby code used to build =
packages is in a Git, you can checkout a moment in time, but you get the =
selection of versions at that moment.

If you try using individual Ruby files for different packages, you =
generally run into dependency issues.


Regards,

Liviu



