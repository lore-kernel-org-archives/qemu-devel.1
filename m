Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93634C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E34720724
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dC1xNDEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E34720724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sWr-00074N-Hy
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j1sW4-0005ln-GI
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:57:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j1sW3-00085g-7u
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:57:24 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j1sW2-00084k-Vj
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:57:23 -0500
Received: by mail-wr1-x444.google.com with SMTP id z7so2439056wrl.13
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 05:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yAjuGTrUzLaSLstCGgSeS/+v1tAOAo7YPsCrfgS10/k=;
 b=dC1xNDEkBmq46s6SixW2OK2qE1nzWKsKbiplgtnG6BqTnZ9vYt5YgWclBIf8yzGms5
 uVr57TTvHsDptxqx+V4KSiqQkNKnLOAAeYC32C6BDrhGspBexbf8Y8ImDjRGtu1sksU+
 1dJys+op2Zk1t/Kpq0US7uO2ETF0ccix/svRaigg3UOU29iMPplnAb0Asq2G/EeQJj+x
 nOODt/BNbfAttq7Nu2iB0ZmijNXmYiOBaJQeOyqtOV2mFt12Ls2b52yLaD+szSKqj3GB
 q8lZLaNdvEEsy08by0tD4XyrKQrZzxmk8Tm5aFfkdMkXQ7Eq2yHDa3uVy3+fzYAQdffl
 Pouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yAjuGTrUzLaSLstCGgSeS/+v1tAOAo7YPsCrfgS10/k=;
 b=EP86rGmDc1foplqv+gVa9xhy0cqKwFij6m3GbYMsUyiXgzaZ+Xb/LQYiUUFEQ/yUFj
 uK/p4jjvkf4xjKplUv95EHOJEWMp7XFCBfWI8VZbQ70tym+Dglv4BdxqaOXuBFs+hbKZ
 TnQ8rtoD400qtXKFrtwfZT8vRICKEY3JzxXXtQTDE88e/JKqHjGDobATr2olXnvP+ZCk
 xwHCEGqTPMHHweEyfrTRGXABpGCDljZldN53EUFlENlUI13CCgetbQIjOFGVrXNZJUSO
 y2iClfEea52z3N32ZYhQV1FMJJ3+wnxuPNuFViof+wKHUlIE0R4/55OoFkwai7CyOtXQ
 IwUQ==
X-Gm-Message-State: APjAAAWTRja2mrIrM9QKz3HWLy8KwgixqYNsMXiM3uYRywmTd517VNpb
 VnZVco6HoGCJGD4uSXXzUgY=
X-Google-Smtp-Source: APXvYqxXaDwah9t+7npfYSk3wL3F9BzWn3o3rs+My4QMXALIJLZg4LQPueFUMBlaSEfJ/lkEMoBkjg==
X-Received: by 2002:a5d:610c:: with SMTP id v12mr14678588wrt.88.1581515841855; 
 Wed, 12 Feb 2020 05:57:21 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v5sm685993wrv.86.2020.02.12.05.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 05:57:17 -0800 (PST)
Date: Wed, 12 Feb 2020 13:57:15 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Igor =?utf-8?Q?Kotrasi=C5=84ski?= <i.kotrasinsk@partner.samsung.com>
Subject: Re: [RFC 0/9] Add an interVM memory sharing device
Message-ID: <20200212135715.GC432724@stefanha-x1.localdomain>
References: <CGME20200204113102eucas1p172cfb883c70cfc8d7c2832682df3df2a@eucas1p1.samsung.com>
 <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <20200205143911.GG58062@stefanha-x1.localdomain>
 <1e872eb3-a21b-0f9b-e6a4-54843a028bed@siemens.com>
 <91d3f574-3a4f-8291-040e-520c5c58e77e@partner.samsung.com>
 <20200207110403.08a8a7cc@redhat.com>
 <20200207163349.GI168381@stefanha-x1.localdomain>
 <91525902-952f-7f84-c1b0-a4e5c35e0363@partner.samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <91525902-952f-7f84-c1b0-a4e5c35e0363@partner.samsung.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: peter.maydell@linaro.org, Igor Mammedov <imammedo@redhat.com>,
 pbonzini@redhat.com, qemu-devel@nongnu.org,
 Jan Kiszka <jan.kiszka@siemens.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2020 at 02:01:48PM +0100, Igor Kotrasi=C5=84ski wrote:
> On 2/7/20 5:33 PM, Stefan Hajnoczi wrote:
> > On Fri, Feb 07, 2020 at 11:04:03AM +0100, Igor Mammedov wrote:
> >> On Fri, 7 Feb 2020 10:00:50 +0100
> >> Igor Kotrasi=C5=84ski <i.kotrasinsk@partner.samsung.com> wrote:
> >>
> >>> On 2/5/20 3:49 PM, Jan Kiszka wrote:
> >>>> On 05.02.20 15:39, Stefan Hajnoczi wrote:
> >>>>> On Tue, Feb 04, 2020 at 12:30:42PM +0100,
> >>>>> i.kotrasinsk@partner.samsung.com wrote:
> >>>>>> From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
> >>>>>>
> >>>>>> This patchset adds a "memory exposing" device that allows two QEMU
> >>>>>> instances to share arbitrary memory regions. Unlike ivshmem, it do=
es not
> >>>>>> create a new region of memory that's shared between VMs, but inste=
ad
> >>>>>> allows one VM to access any memory region of the other VM we choos=
e to
> >>>>>> share.
> >>>>>>
> >>>>>> The motivation for this device is a sort of ARM Trustzone "emulati=
on",
> >>>>>> where a rich system running on one machine (e.g. x86_64 linux) is =
able
> >>>>>> to perform SMCs to a trusted system running on another (e.g. OpTEE=
 on
> >>>>>> ARM). With a device that allows sharing arbitrary memory between V=
Ms,
> >>>>>> this can be achieved with minimal changes to the trusted system an=
d its
> >>>>>> linux driver while allowing the rich system to run on a speedier x=
86
> >>>>>> emulator. I prepared additional patches for linux, OpTEE OS and Op=
TEE
> >>>>>> build system as a PoC that such emulation works and passes OpTEE t=
ests;
> >>>>>> I'm not sure what would be the best way to share them.
> >>>>>>
> >>>>>> This patchset is my first foray into QEMU source code and I'm cert=
ain
> >>>>>> it's not yet ready to be merged in. I'm not sure whether memory sh=
aring
> >>>>>> code has any race conditions or breaks rules of working with memory
> >>>>>> regions, or if having VMs communicate synchronously via chardevs i=
s the
> >>>>>> right way to do it. I do believe the basic idea for sharing memory
> >>>>>> regions is sound and that it could be useful for inter-VM communic=
ation.
> >>>>>
> >>>>> Hi,
> >>>>> Without having looked into the patches yet, I'm already wondering i=
f you
> >>>>> can use the existing -object
> >>>>> memory-backend-file,size=3D512M,mem-path=3D/my/shared/mem feature f=
or your
> >>>>> use case?
> >>>>>
> >>>>> That's the existing mechanism for fully sharing guest RAM and if you
> >>>>> want to share all of memory then maybe a device is not necessary - =
just
> >>>>> share the memory.
> >>>
> >>> That option adds memory in addition to the memory allocated with the
> >>> '-m' flag, doesn't it? I looked into that option, and it seemed to me
> >>> you can't back all memory this way.
> >> with current QEMU you play with memory sharing using numa workaround
> >>
> >> -m 512 \
> >> -object memory-backend-file,id=3Dmem,size=3D512M,mem-path=3D/my/shared=
/mem feature,share=3Don \
> >> -numa node,memdev=3Dmem
> >>
> >> also on the list there is series that allows to share main ram
> >> without numa workaround, see
> >>    "[PATCH v4 00/80] refactor main RAM allocation to use hostmem backe=
nd"
> >>
> >> with it applied you can share main RAM with following CLI:
> >>
> >> -object memory-backend-file,id=3Dmem,size=3D512M,mem-path=3D/my/shared=
/mem feature,share=3Don \
> >> -m 512 \
> >> -M virt,memory-backend=3Dmem
> >=20
> > Nice!  That takes care of memory.
>=20
> After a bit of hacking to map the shared RAM instead of communicating=20
> via socket I can confirm - I can run OpTEE this way, and it passes=20
> tests. My solution is *technically* more accurate since it is aware of=20
> memory subregions and completely independent from memory backend setup,=
=20
> but with my use case satisfied already, I don't think it's of use to anyo=
ne.

Great!

Stefan

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5EBDsACgkQnKSrs4Gr
c8iIpgf7Bt9GrWA25TH/5eT26OK8BZv/xUJSNUYpluf1QYH9WAezM9DNRCceHmtf
EoMjGVB0VJDuJZ+udv/FtGUrKWazWzkSvsUYLo1MuR7IASVe6h0Nvpd3ReykBNbp
nOArd2MUp8qr+HxOz3tTqL3xGoh+92MoqJMbswGutfr2htjGvHcf6/7to+IESbC2
ITRFwIRvsgscO+EOC/s8hLauMuy/L+T+k2nfuhoDt/7sRUQi9GRI7y3CvyYjqmM2
UHABKBzvnUxBgveluGxSaK2SnwNeU2tVZBNDyIq0muuEDntEIWM1LHhFl3uAv9NG
0D14+YjIWgSQVURJqeAD532bteWKAw==
=2nWC
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--

