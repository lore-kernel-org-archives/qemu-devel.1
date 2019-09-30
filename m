Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0245C4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 09:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C9A21721
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 09:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C9A21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iErxN-0007n8-M1
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 05:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iErwH-0006ft-EA
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 05:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iErwG-0001c5-2S
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 05:25:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34130)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1iErwB-0001Zy-Ew; Mon, 30 Sep 2019 05:25:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4B85818CB8F9;
 Mon, 30 Sep 2019 09:25:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C73D01001B33;
 Mon, 30 Sep 2019 09:25:44 +0000 (UTC)
Date: Mon, 30 Sep 2019 10:25:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH] configure: deprecate 32 bit build hosts
Message-ID: <20190930092519.GB11996@redhat.com>
References: <20190925233013.6449-1-alex.bennee@linaro.org>
 <CAFEAcA9vb5_Mi_axWpu7269Zg0xMLbiiV80ofLeyDpfws3G4nQ@mail.gmail.com>
 <4512b61a-ed82-e628-88e5-f44ef87c2b50@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4512b61a-ed82-e628-88e5-f44ef87c2b50@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Mon, 30 Sep 2019 09:25:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 qemu-discuss <qemu-discuss@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, qemu-ppc@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 10:11:05AM -0700, Richard Henderson wrote:
> On 9/26/19 12:50 AM, Peter Maydell wrote:
> > On Thu, 26 Sep 2019 at 00:31, Alex Benn=C3=A9e <alex.bennee@linaro.or=
g> wrote:
> >>
> >> The 32 bit hosts are already a second class citizen especially with
> >> support for running 64 bit guests under TCG. We are also limited by
> >> testing as actual working 32 bit machines are getting quite rare in
> >> developers personal menageries. For TCG supporting newer types like
> >> Int128 is a lot harder with 32 bit calling conventions compared to
> >> their larger bit sized cousins. Fundamentally address space is the
> >> most useful thing for the translator to have even for a 32 bit guest=
 a
> >> 32 bit host is quite constrained.
> >>
> >> As far as I'm aware 32 bit KVM users are even less numerous. Even
> >> ILP32 doesn't make much sense given the address space QEMU needs to
> >> manage.
> >=20
> > For KVM we should wait until the kernel chooses to drop support,
> > I think.
>=20
> Agreed.  I think this discussion should be more about TCG.
>=20
> >> @@ -745,19 +744,22 @@ case "$cpu" in
> >>    ;;
> >>    armv*b|armv*l|arm)
> >>      cpu=3D"arm"
> >> -    supported_cpu=3D"yes"
> >>    ;;
> >=20
> > I'll leave others to voice opinions about their architectures,
> > but I still have 32-bit arm in my test set for builds, and
> > I'm pretty sure we have users (raspi users, for a start).
>=20
> I'd really like to know what raspi users might be using qemu for.  Depe=
nding on
> that answer, perhaps it would be sufficient for arm32 tcg to only suppo=
rt
> 32-bit guests.

I asked on the Fedora development lists for feedback on the idea of
dropping QEMU 32-bit host support

  https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject=
.org/thread/TPAVIC6YANGP2NK4RUOP7OCIOIFIOV3A/

The response was rather underwhealming to say the least, with only one
person explicitly expressing a desire for QEMU to keep 32-bit host
support for armv7l.

The main interesting thing I learnt was that even with 64-bit Raspberry
Pi hardware, it can be desirable to run 32-bit Raspberry Pi supporting
distro, supposedly for performance benefits.

> For context, the discussion that Alex and I were having was about int12=
8_t, and
> how to support that directly in tcg (especially to/from helpers), and h=
ow that
> might be vastly easier if we didn't have to consider 32-bit hosts.

I know nothing about TCG internals, but Is it viable to implement int128_=
t
support only in 64-bit host, leaving 32-bit hosts without it ? Or is this
really a blocking item that is holding back 64-bit host features.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

