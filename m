Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C348AC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9EC21743
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9EC21743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvoei-0000Kw-OZ
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 16:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34247)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vmaffione@freebsd.org>) id 1hvmCC-0000gy-2Z
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vmaffione@freebsd.org>) id 1hvmCA-0003z0-Kg
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:27:24 -0400
Received: from mx2.freebsd.org ([96.47.72.81]:61840)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vmaffione@freebsd.org>)
 id 1hvmCA-0003wu-GE
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:27:22 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client CN "mx1.freebsd.org",
 Issuer "Let's Encrypt Authority X3" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id A3E27705A0
 for <qemu-devel@nongnu.org>; Thu,  8 Aug 2019 17:27:20 +0000 (UTC)
 (envelope-from vmaffione@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org",
 Issuer "Let's Encrypt Authority X3" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 464FgD33PDz4bLm
 for <qemu-devel@nongnu.org>; Thu,  8 Aug 2019 17:27:20 +0000 (UTC)
 (envelope-from vmaffione@freebsd.org)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "GTS CA 1O1" (verified OK))
 (Authenticated sender: vmaffione)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 3A9C6119D
 for <qemu-devel@nongnu.org>; Thu,  8 Aug 2019 17:27:20 +0000 (UTC)
 (envelope-from vmaffione@freebsd.org)
Received: by mail-qt1-f181.google.com with SMTP id d17so14041450qtj.8
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 10:27:20 -0700 (PDT)
X-Gm-Message-State: APjAAAUdAXHfd3KRyxxk882JoOEBiZF8w6HbEsjXgELKNixvplA1FZAn
 t2Fecu7TL9E0xr+WyjCuxkS09KzMQD+2J1eheFI=
X-Google-Smtp-Source: APXvYqyChC6XC0l9I7/cfwmt/6dFbnRes+snRwrHtbuX8lTnAOS5WsTWVtbcJ4Nv5UItZpvinOl4SqRsI6Ow+f/kdCs=
X-Received: by 2002:ac8:4413:: with SMTP id j19mr14169190qtn.281.1565285239786; 
 Thu, 08 Aug 2019 10:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
 <87a7ckrat7.fsf@dusky.pond.sub.org>
 <ee3709c9-f351-081a-3aeb-53b7b6036b0a@redhat.com>
 <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
 <12dbfcd1-8d9d-f564-fb90-767943eca874@redhat.com>
 <2e660c06-8efe-5158-2ba6-ecd9563e879f@redhat.com>
In-Reply-To: <2e660c06-8efe-5158-2ba6-ecd9563e879f@redhat.com>
From: Vincenzo Maffione <vmaffione@freebsd.org>
Date: Thu, 8 Aug 2019 19:27:41 +0200
X-Gmail-Original-Message-ID: <CA+_eA9iVw0H+J01z_REn5xL7a88skZLCw1qCq9vY8o3XkibSwQ@mail.gmail.com>
Message-ID: <CA+_eA9iVw0H+J01z_REn5xL7a88skZLCw1qCq9vY8o3XkibSwQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 96.47.72.81
X-Mailman-Approved-At: Thu, 08 Aug 2019 16:04:11 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] Is network backend netmap worth keeping?
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yes, indeed.
Netmap is actively maintained on FreeBSD, and QEMU is packaged on FreeBSD
with netmap support enabled.
Also keep in mind that, differently from Linux, the (current) tap driver on
FreeBSD does not support offloads (e.g. IFF_VNET_HDR, TUNSETVNETHDRSIZE and
so on). On the contrary, netmap (VALE) supports the same offloads as tap
does on Linux. This makes inter-VM networking with VALE more appealing on
FreeBSD.

Cheers,
  Vincenzo

Il giorno gio 8 ago 2019 alle ore 15:36 Philippe Mathieu-Daud=C3=A9 <
philmd@redhat.com> ha scritto:

> On 8/8/19 7:38 AM, Jason Wang wrote:
> >
> > On 2019/8/8 =E4=B8=8B=E5=8D=8812:48, Markus Armbruster wrote:
> >> Please excuse the attention-grabbing subject.
> >>
> >> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
> >>
> >>> On 8/7/19 10:16 PM, Markus Armbruster wrote:
> >> [...]
> >>>> Can you tell me offhand what I have to install so configure enables
> >>>> CONFIG_NETMAP?
> >>> The steps are listed in tests/docker/dockerfiles/debian-amd64.docker,
> >>> but you can get to this point running:
> >>>
> >>>    $ make docker-image-debian-amd64 V=3D1 DEBUG=3D1
> >>>
> >>> This will build the docker image with netmap (so you don't have to me=
ss
> >>> with your workstation setup), then build QEMU within the image.
> >> So, to make use of QEMU's netmap backend (CONFIG_NETMAP), you have to
> >> build and install netmap software from sources.  Which pretty much
> >> ensures nobody uses it.  It was added in commit 58952137b0b (Nov 2013)=
.
> >> The commit message points to <http://info.iet.unipi.it/~luigi/netmap/>=
,
> >> which gives me "connection timed out" right now.
> >>
> >> On the other hand, it's covered in MAINTAINERS, and has seen
> >> non-janitorial activity as late as Dec 2018 (commit c693fc748a).
> >>
> >> Luigi, Giuseppe, Vincenzo, what's the status of the netmap project?
> >>
> >> Why is the QEMU netmap backend worth keeping?
> >>
> >> Who is using the netmap backend?
> >
> >
> > Netmap was supported by freebsd:
> > https://www.freebsd.org/cgi/man.cgi?query=3Dnetmap&sektion=3D4. So I gu=
ess
> > there should be real users.
> >
> >
> >>
> >> How do they obtain a netmap-enabled QEMU?  Compile it from sources
> >> themselves?
> >
> >
> > Yes.
>
> Hmm at least on the FreeBSD setup by vmtest (12.0-RELEASE r341666) we
> don't need to build it from source:
>
> $ make vm-build-freebsd V=3D1 DEBUG=3D1
> [...]
> netmap support    yes
> [...]
>
> $ fgrep -r CONFIG_NETMAP .
> ./config-host.mak:CONFIG_NETMAP=3Dy
>
