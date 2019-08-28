Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52DBC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 10:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A4B217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 10:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A4B217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2uzB-0007n8-Iy
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 06:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i2uxz-0007FB-9q
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 06:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i2uxx-0005cJ-92
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 06:14:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34566)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1i2uxx-0005bO-1N
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 06:14:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B67F63DE31;
 Wed, 28 Aug 2019 10:14:11 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2954C5D6B0;
 Wed, 28 Aug 2019 10:14:05 +0000 (UTC)
Message-ID: <6a1f7b1dc372abfbbf8efaa7d0ce9c7db1881849.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Zolt=C3=A1n_K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
Date: Wed, 28 Aug 2019 13:14:03 +0300
In-Reply-To: <20190828095308.GE2991@redhat.com>
References: <cover.1566847960.git.DirtY.iCE.hu@gmail.com>
 <43076a2afeb0439b607b0631e0bfff77d55bc0cc.1566847960.git.DirtY.iCE.hu@gmail.com>
 <20190827054223.nuiz7fz27tld3hpt@sirius.home.kraxel.org>
 <2fdc616c-0690-a898-0247-765f90153903@gmail.com>
 <20190828095308.GE2991@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 28 Aug 2019 10:14:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 4/4] audio: paaudio: ability to specify
 stream name
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-08-28 at 10:53 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Aug 28, 2019 at 12:43:49AM +0200, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=
=B3 wrote:
> > On 2019-08-27 07:42, Gerd Hoffmann wrote:
> > > On Mon, Aug 26, 2019 at 09:59:04PM +0200, K=C5=91v=C3=A1g=C3=B3, Zo=
lt=C3=A1n wrote:
> > > > This can be used to identify stream in tools like pavucontrol whe=
n one
> > > > creates multiple -audiodevs or runs multiple qemu instances.
> > >=20
> > > Hmm, can we create an useful name automatically, without yet anothe=
r
> > > config option?
> > >=20
> > > Useful choices could be the device name (usb-audio, ...) or the dev=
ice
> > > id (whatever -device id=3Dxxx was specified on the command line).
> >=20
> > I'm afraid this is not going to work with the current architecture: d=
ue
> > to mixeng even if you have multiple devices, they'll be mixed to a
> > single stream and the audio backend will only see this one mixed stre=
am.
> >  As a workaround we could do something like concat all device names o=
r
> > ids, but I don't like that idea.
> >=20
> > Alternatively we could use the id of the audiodev instead, and no mor=
e
> > problems with mixeng.  However, with mixeng off (implemented in my ne=
xt
> > patch series) suddenly soundcards will have suddenly end up as differ=
ent
> > streams.  (This can be worked around by creating multiple audiodevs,
> > like what you have to use now to get multiple streams from pa, so thi=
s
> > is probably a smaller problem.)
> >=20
> > Currently I'm leaning for the audiodev's id option, unless someone
> > proposes something better.
>=20
> Using the audiodev id is not a good idea. If you have multiple QEMU's
> on your host, it is highly likely that libvirt will have assigned
> the same audiodev id to all of them.  Using the vm name would be ok,
> but only if you assume that each gust only has a single audio device.
>=20
> Using a combination of vm name + audidev id is going to be unique
> per host, but not especially friendly as a user visible name. It
> would be ok as a default, but I'd think we should let the mgmt app
> specify stream name explicitly, so that something user friendly
> can be set.
No, no!
It seems that pulseaudio has a name for each connection, and a name for e=
ach
steam within that connection.

The suggestion is that we use the VM name for the connection,
(which will be unique per VM usually, at least the user can make it be so=
)
and then use the audiodev id for each stream. Of course for multiple VMs,
the audiodev ids will be the same, but this is all right since you can
always distinguish them that the streams come from different VMs.

Also note that this thing is cosmetic from the correctness point of view,
that is pulse-audio internally has no problem with duplicate IDs.

The thing is useful mostly for tweaking the output streams in the pavucon=
trol,
where the names will allow you to easily know which steam is which.

Speaking of this, there is another minor feature missing, which is volume=
 level
feedback from pavucontrol to the guest. That means that if you change the=
 volume of the
stream in pavucontrol, the guest will not be aware of this, and still thi=
nk that the
volume is the same.
But for 'tweaking' I was mostly thinking about assigning the input/output=
 streams to
different sound devices, which pavucontrol can do and does work very well=
.

Best regards,
	Maxim Levitsky


