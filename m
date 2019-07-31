Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1395C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 11:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76ED02089E
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 11:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76ED02089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsmPx-0008EQ-Nn
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 07:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38970)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hsmP3-00072F-50
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hsmP1-0007AU-Es
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:04:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hsmP1-0007A0-7p
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:04:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so69165721wre.12
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 04:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=0d2UQVZRCYZD0Qgx8QF07Wkx9k7Hz+/z4T89nwdVSgk=;
 b=sIuZu7PCaOpDFEMZyyvBsdJLy6HIY/VvMsaHxugfVuEuPhUOHlVDocP5p3luqVd8kg
 sBiwwBHCENrJrrj7I/fM3/K1g9DokPwUlVzrLO3OLm7Jx5odXyKiZchv4HAPU6nLOenj
 FZ3aYzP9SkGRrlxmL80Gj2xPBwmROOqg83xAujB+3YcKLwon1m3ivAO05LsYh47kAdvi
 OyD2K8vk/9I3zkxMjQ+fWm1YplICh/JgySDI88MLqUq6GRX1MnaKSGSkAk7noPNgiqxs
 8gaphIwCs/dXUyPrUhH9V1Eg97dhhHrgBJ4yza360Jei7w4CB2L7CIYP57AwL4/JDSD1
 PPtQ==
X-Gm-Message-State: APjAAAWGyQWDYgigtnxnYgZKpQrXbw9CLuQr8qhw/9RSYb9gY3HPXS30
 dZDu1LMOQCexKYqTNEb0UHn3vf8XEdk=
X-Google-Smtp-Source: APXvYqwLkGt0Exm0QzrDlFEdbIRvSJkxoYiqo1MiijSpnb3Sq5DpPNqKcoenJTgTD2nOiFVpHUthjg==
X-Received: by 2002:adf:eb0f:: with SMTP id s15mr57377293wrn.324.1564571053767; 
 Wed, 31 Jul 2019 04:04:13 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id y7sm50152663wmm.19.2019.07.31.04.04.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 04:04:13 -0700 (PDT)
References: <20190729125755.45008-1-slp@redhat.com>
 <a43acc8541c7ae811d65eb4d08e1a08333781282.camel@redhat.com>
 <20190730133546.056f8b19.cohuck@redhat.com>
 <09e5ceb5e7c03f74f05307a3b9f9a4df035ff74f.camel@redhat.com>
 <20190730151400.20686a5b.cohuck@redhat.com>
 <20190730160605-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
In-reply-to: <20190730160605-mutt-send-email-mst@kernel.org>
Date: Wed, 31 Jul 2019 13:04:11 +0200
Message-ID: <87h872wjmc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [RFC] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: peter.maydell@linaro.org, Cornelia Huck <cohuck@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Michael S. Tsirkin <mst@redhat.com> writes:

> On Tue, Jul 30, 2019 at 03:14:00PM +0200, Cornelia Huck wrote:
>> On Tue, 30 Jul 2019 14:17:48 +0200
>> Andrea Bolognani <abologna@redhat.com> wrote:
>>=20
>> > On Tue, 2019-07-30 at 13:35 +0200, Cornelia Huck wrote:
>> > > On Tue, 30 Jul 2019 12:25:30 +0200
>> > > Andrea Bolognani <abologna@redhat.com> wrote:=20=20
>> > > > Can you please make sure virtio-mmio uses the existing interface
>> > > > instead of introducing a new one?=20=20
>> > >=20
>> > > FWIW, I really hate virtio-pci's disable-modern/disable-legacy... fo=
r a
>> > > starter, what is 'modern'? Will we have 'ultra-modern' in the future=
?=20=20
>> >=20
>> > AIUI the modern/legacy terminology is part of the VirtIO spec, so
>> > while I agree that it's not necessarily the least prone to ambiguity
>> > at least it's well defined.
>>=20
>> Legacy is, modern isn't :) Devices/drivers are conforming to the
>> standard, I don't think there's a special term for that.
>
> Right, if we followed the spec, disable-modern would have been
> force-legacy.
>
> I'm fine with adding force-legacy for everyone and asking tools to
> transition if there. Document it's same as disable-modern for pci.
> Cornelia?

FWIW, for this patch, I'm perfectly fine with changing the "modern"
property to "force-legacy", with "true" as the default value.

>> >=20
>> > > It is also quite backwards with the 'disable' terminology.=20=20
>> >=20
>> > That's also true. I never claimed the way virtio-pci does it is
>> > perfect!
>> >=20
>> > > We also have a different mechanism for virtio-ccw ('max_revision',
>> > > which covers a bit more than virtio-1; it doesn't have a 'min_revisi=
on',
>> > > as negotiating the revision down is fine), so I don't see why
>> > > virtio-mmio should replicate the virtio-pci mechanism.
>> > >=20
>> > > Also, IIUC, virtio-mmio does not have transitional devices, but eith=
er
>> > > version 1 (legacy) or version 2 (virtio-1). It probably makes more
>> > > sense to expose the device version instead; either as an exact versi=
on
>> > > (especially if it isn't supposed to go up without incompatible
>> > > changes), or with some min/max concept (where version 1 would stand a
>> > > bit alone, so that would probably be a bit awkward.)=20=20
>> >=20
>> > I think that if reinventing the wheel is generally agreed not to be
>> > a good idea, then it stands to reason that reinventing it twice can
>> > only be described as absolute madness :)
>> >=20
>> > We should have a single way to control the VirtIO protocol version
>> > that works for all VirtIO devices, regardless of transport. We might
>> > even want to have virtio-*-{device,ccw}-non-transitional to mirror
>> > the existing virtio-*-pci-non-transitional.
>> >=20
>> > FWIW, libvirt already implements support for (non)-transitional
>> > virtio-pci devices using either the dedicated devices or the base
>> > virtio-pci plus the disable-{modern,legacy} attributes.
>>=20
>> One problem (besides my dislike of the existing virtio-pci
>> interfaces :) is that pci, ccw, and mmio all have slightly different
>> semantics.
>>=20
>> - pci: If we need to keep legacy support around, we cannot enable some
>>   features (IIRC, pci-e, maybe others as well.) That means transitional
>>   devices are in some ways inferior to virtio-1 only devices, so it
>>   makes a lot of sense to be able to configure devices without legacy
>>   support. The differences between legacy and virtio-1 are quite large.
>> - ccw: Has revisions negotiated between device and driver; virtio-1
>>   requires revision 1 or higher. (Legacy drivers that don't know the
>>   concept of revisions automatically get revision 0.) Differences
>>   between legacy and virtio-1 are mostly virtqueue endianness and some
>>   control structures.
>> - mmio: Has device versions offered by the device, the driver can take
>>   it or leave it. No transitional devices. Differences don't look as
>>   large as the ones for pci, either.
>>=20
>> So, if we were to duplicate the same scheme as for pci for ccw and mmio
>> as well, we'd get
>>=20
>> - ccw: devices that support revision 0 only (disable-modern), that act
>>   as today, or that support at least revision 1 (disable-legacy). We
>>   still need to keep max_revision around for backwards compatibility.
>>   Legacy only makes sense for compat machines (although this is
>>   equivalent to max_revision 0); I don't see a reason why you would
>>   want virtio-1 only devices, unless you'd want to rip out legacy
>>   support in QEMU completely.
>
> Reduce security attack surface slightly. Save some cycles
> (down the road) on branches in the endian-ness handling.
> Make sure your guests
> are all up to date in preparation to the day when legacy will go away.
>
> Not a huge win, for sure, but hey - it's something.
>
>> - mmio: devices that support version 1 (disable-modern), or version 2
>>   (disable-legacy). You cannot have both at the same time. Whether this
>>   makes sense depends on whether there will be a version 3 in the
>>   future.
>>=20
>> So, this might make some sense for mmio; for ccw, I don't see any
>> advantages other than confusing people further...


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl1BdasACgkQ9GknjS8M
AjUqmg/9Gpfm04ur+10Y649SssqfrBFS7X0W64AUjgybEZfBy4tRqnfd/vgns9W1
X5ySxq5dtswchEuRSINwWRF5/qoGMXsWTL5zh1eR0M+gbbV4g4fnVTxuD+MXmF5v
h78D9hb+QwAL+jgd1cCBu3doXGN4lIMLBOMWfHW3U/lGNyztTc2exn/3jWbu25s8
lQCPSU/MbLHviKm+cMqB05OrDtBxo6Mq35itNYHEhWJsQ8inwqZCXcq1kShupeFI
fup/4cehnabpFWCDFJS6yBtbZEHIz5fhmMys7IClAFv4hVd9oB4NcM1J4lt5JLGk
wVSbxZ0jnltXFnX5frHqdkSCgJN56bLwGWNVzj2WnsiAFqZ0I64qSaA/Oe2vggr0
E49osQK0U4afN5nu3NZeBziurYYBvXWnDFss8DdLhbYNCgYSg8vtHTWLyXi+C0y7
MBp2krAu2PaNDN53vuvAfQOxf+NNMq7AJf9YEjjZn9s6ry4aQ7D5pNzxqljv6VCo
4in4nrVdNNCqIyCmOLEukiKVVFuq/FfekAduoRR58H0sU7i8g7H+Ms65AN4+X8tL
UMfk8g6t8FPW+94nbSmJ7Y30JY5gRdGHG3aECPnBiFXdWQH/aBk9/tzCfjgx2Gf1
i1zwBxVxlc3uO53B3K0Oa7i+JqnYgG5cFIOOpPyHQKF/aMbUyps=
=/g7q
-----END PGP SIGNATURE-----
--=-=-=--

