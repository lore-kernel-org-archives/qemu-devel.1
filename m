Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E22C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F4220866
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MyunkfZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F4220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8sOp-000859-5Q
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 16:14:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1j8sLK-0006ye-C4
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:11:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1j8sLJ-0000Ua-7b
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:11:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:58775)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1j8sLI-0000Rv-Uz
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1583183462;
 bh=qZXe2B+402l3kQShwKwEPmJMA2r3HmJ4JbuDGPRFqiU=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=MyunkfZ0EeRjeOpxYvgd09OaoQStXmZLJQDayZ/UIClL7e7a6EIlZjG8nG425WaJ0
 AKlJdylcKiIpcgFHemF7DYW14kgOLRKy0Us63VzaNYEv8/iTJuZhyABKsH8+Xo7GTV
 ikItjMSwwlkEG/EcNGOf0cFFTWpue9gYEXEh7Qqo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MatVh-1jgIHd0YGZ-00cTZv; Mon, 02
 Mar 2020 22:11:02 +0100
To: Paolo Bonzini <pbonzini@redhat.com>, Maxime Villard <max@m00nbsd.net>
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com> <20200128140945.929-3-n54@gmx.com>
 <e3279b9d-e6f9-43f3-3ebb-b31ba8ff5f7e@redhat.com>
 <4e29b732-ce95-02f1-ec9c-31f1ce33cda0@gmx.com>
 <4ece50db-33c7-4630-6b0f-52197b2ae845@redhat.com>
 <5b289981-1e54-2301-af36-86361415bf6b@gmx.com>
 <bd4bb6d3-be33-2f97-8ee5-695b41b5eff1@m00nbsd.net>
 <CABgObfZ5AdBmU7R8ycFwTLxEHXQw_GrXwJ0BMvDWgJEvKevcGg@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Subject: Re: [PATCH v2 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
Message-ID: <8413a29d-3983-4176-5c6c-735a87ab7701@gmx.com>
Date: Mon, 2 Mar 2020 22:10:01 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CABgObfZ5AdBmU7R8ycFwTLxEHXQw_GrXwJ0BMvDWgJEvKevcGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k9XhB/L94D0XXJsU/uxzZC7JwUJazDXGF8NylWAVmIcDf1gtuXv
 2VjUrNd8pGXX0VMJcSIs+3PsvQmwgUriI5UsCFswVclYQbr/lQ2lKFF1/UEQlwyiGSndaRm
 LUOaeHZBmZ5YXKVQGqoD5pQK9i1075Xvp/ivbbljR98+VxcIzic/Wfvh/+t3RvKZ5k2YJ7M
 z7dkArvzZWyfKwU2A7KHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ocDD93A6hBU=:gxW6BHCssBkFm5nquFuMHS
 lPue8E2ghuJpolRhv8oZuMKxQKaFkFIiFc+vWD29eBUQOTdHhPXwYC1My//AIu3+pxN31lHLa
 D9D5n/ojs+kywOg5p/KXZ1N0ZTXXLFLrLOkX+TzrTrFb4V6QlYDg6FjJAZySdaISR58YZn6JK
 YEq3d1DUsaACjS2Xv04I7RmI27B9xd/aG9IDbn8vwrwLJpYzSbuUAYeRkdtO1QDXnmaky0+Ta
 fqtBRbaKT1PMYq1X6BfY312GagB7spLJMEOudIm5XmQjPdzsquL81itQ2woMTWYcxwGR8Zz8t
 H+Hs/3LF08NrTEVUyWRTfxZpRJ4hDu89yQyzukTPBGSIoXtBEZ3mz455FeSro/7kYrbl5m2z+
 zRSA+YOFGEVqjj4oCjYm2Yg7KePsRZ6SzbdcQQBaBZJ889I0w3HIhu+mRCPoJSW4N1Wan0CzZ
 H9FUe2iLzrnRyJ4nD4eEqgJG1Oc0wznLbJkx08JtBP87jxTu+remmCis0sSLf4oxRkmtZ0pcx
 KqCmlNTAZVZ94PoERE/6lAmgpKnH99IOSztJv7W835kJ1iaJbC/O/rOLCqri05AJeUGJmCYKN
 SOP+fS8WQWdODIhWiNAohGuI0WKm4c51JU97YhAqeO+Jfjc8WYoKkhWziVU0fkv4QoAqdUINV
 JFp94l+xlN26/yJTRzk56ZEVIXry2qquX/s7QunaQEEM7Y280cNOADsdV/C3+EmgtVPH68RWT
 P4detV1uvzHaaGJ3Y0k+Nu4LXZsa4mpfN4wa6UX0F88dhDhHERlwdv+i7O08r1QW8GkwToaSE
 XSjB7Z2RpoqyOWJOpk9dnNFAl4o9eR9UrCcJ0l70dryAARrQZrVxYz2/FvjjvS1OCfm+rcnps
 hmmul3W89v4wzLcjeSa4xbczz71WMfTpNvrJMaZC8bo6Dd11dKFj56fWjpwKgV9EdNxse3V5O
 OO3UHsjnt2s5YN6Yac+e5Wp5b2oGiUMwS0spMedgZdmuYwbcxSyHCkEpGhQ0vFTgbs7y3c6jg
 Re9eTsKeY78ncfRKfYVQpuiOBZt6PCI2TTqp6FfT6NWQ20LCqrUDrJvmIIAfkFSJ2bTnw04Qq
 4xH4HNBgjV0i0JkRupFlQsjX0+xQ+E7+11fVDWVXvDitxWLkmqc8L0QEqOC7exlaD/cQFyzw7
 3Qc8OJcFmD27LGWP4qgTqf4zKERQ8x+gK1ChrmYeN5H+ujt7pKeTdva27GInTUozCkGJ4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.15
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02.03.2020 20:40, Paolo Bonzini wrote:
>
>
> Il lun 2 mar 2020, 20:14 Maxime Villard <max@m00nbsd.net
> <mailto:max@m00nbsd.net>> ha scritto:
>
>     Le 02/03/2020 =C3=A0 19:05, Kamil Rytarowski a =C3=A9crit=C2=A0:
>     > On 02.03.2020 18:12, Paolo Bonzini wrote:
>     >> On 03/02/20 12:56, Kamil Rytarowski wrote:
>     >>> On 03.02.2020 12:41, Philippe Mathieu-Daud=C3=A9 wrote:
>     >>>>> @@ -1768,6 +1785,7 @@ disabled with --disable-FEATURE, default=
 is
>     >>>>> enabled if available:
>     >>>>> =C2=A0=C2=A0=C2=A0 hax=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HAX acceleration support
>     >>>>> =C2=A0=C2=A0=C2=A0 hvf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hypervisor.framework acceleration suppor=
t
>     >>>>> =C2=A0=C2=A0=C2=A0 whpx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Windows Hypervisor Platform acceleration
>     support
>     >>>>> +=C2=A0 nvmm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 NetBSD Virtual Machine Monitor acceleration
>     support
>     >>>>> =C2=A0=C2=A0=C2=A0 rdma=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enable RDMA-based migration
>     >>>>> =C2=A0=C2=A0=C2=A0 pvrdma=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Enable PVRDMA support
>     >>>>> =C2=A0=C2=A0=C2=A0 vde=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 support for vde network
>     >>>>> @@ -2757,6 +2775,20 @@ if test "$whpx" !=3D "no" ; then
>     >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>     >>>>> =C2=A0 fi
>     >>>>>
>     >>>>
>     >>>> Maybe you can add something like:
>     >>>>
>     >>>> if test "$targetos" =3D "NetBSD"; then
>     >>>> =C2=A0=C2=A0=C2=A0 nvmm=3D"check"
>     >>>> fi
>     >>>>
>     >>>> to build by default with NVMM if available.
>     >>>
>     >>> I will add nvmm=3Dyes to the NetBSD) targetos check section.
>     >>
>     >> No, nvmm=3Dyes instead should fail the build if nvmm.h is not
>     available.
>     >> That is not a good default.
>     >>
>     >> Paolo
>     >>
>     >>
>     >
>     > Most users will get nvmm.h in place now and this is still a tunabl=
e.
>     >
>     > I have got no opinion what to put there, nvmm=3Dcheck still works.
>
>     I would keep "yes", for consistency with the other entries. Changing=
 all
>     entries to "check" should be done in a separate commit, unrelated to
>     NVMM.
>
>
> The difference is that KVM for example does not need external includes
> or libraries.
>
> Paolo
>

We don't support this scenario and after a year there might be no
supported release without NVMM.

The only concern is about using qemu on !amd64, but we have there not
many users of qemu for understandable reasons.

For AArch64 we plan to implement a dedicated NVMM backend.

>
>     > diff --git a/configure b/configure
>     > index d4a837cf9d..b3560d88bb 100755
>     > --- a/configure
>     > +++ b/configure
>     > @@ -836,7 +836,7 @@ DragonFly)
>     >=C2=A0 NetBSD)
>     >=C2=A0 =C2=A0 bsd=3D"yes"
>     >=C2=A0 =C2=A0 hax=3D"yes"
>     > -=C2=A0 nvmm=3D"yes"
>     > +=C2=A0 nvmm=3D"check"
>     >=C2=A0 =C2=A0 make=3D"${MAKE-gmake}"
>     >=C2=A0 =C2=A0 audio_drv_list=3D"oss try-sdl"
>     >=C2=A0 =C2=A0 audio_possible_drivers=3D"oss sdl"
>     >
>


