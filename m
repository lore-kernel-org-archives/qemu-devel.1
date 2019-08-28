Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6A3C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 10:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5032F2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 10:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5032F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2vNG-000533-GT
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 06:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i2vM8-0004b8-Ta
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 06:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i2vM6-0001ss-PO
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 06:39:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1i2vM6-0001rW-Hc
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 06:39:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C51746;
 Wed, 28 Aug 2019 10:39:09 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4608C60A35;
 Wed, 28 Aug 2019 10:39:05 +0000 (UTC)
Message-ID: <ae12796c51767489970f1040d3d86230f01ec79d.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Wed, 28 Aug 2019 13:39:04 +0300
In-Reply-To: <20190828102603.GG2991@redhat.com>
References: <cover.1566847960.git.DirtY.iCE.hu@gmail.com>
 <43076a2afeb0439b607b0631e0bfff77d55bc0cc.1566847960.git.DirtY.iCE.hu@gmail.com>
 <20190827054223.nuiz7fz27tld3hpt@sirius.home.kraxel.org>
 <2fdc616c-0690-a898-0247-765f90153903@gmail.com>
 <20190828095308.GE2991@redhat.com>
 <6a1f7b1dc372abfbbf8efaa7d0ce9c7db1881849.camel@redhat.com>
 <20190828102603.GG2991@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Wed, 28 Aug 2019 10:39:09 +0000 (UTC)
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Zolt=C3=A1n_K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-08-28 at 11:26 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Aug 28, 2019 at 01:14:03PM +0300, Maxim Levitsky wrote:
> > On Wed, 2019-08-28 at 10:53 +0100, Daniel P. Berrang=C3=A9 wrote:
> > > On Wed, Aug 28, 2019 at 12:43:49AM +0200, Zolt=C3=A1n K=C5=91v=C3=A1=
g=C3=B3 wrote:
> > > > On 2019-08-27 07:42, Gerd Hoffmann wrote:
> > > > > On Mon, Aug 26, 2019 at 09:59:04PM +0200, K=C5=91v=C3=A1g=C3=B3=
, Zolt=C3=A1n wrote:
> > > > > > This can be used to identify stream in tools like pavucontrol=
 when one
> > > > > > creates multiple -audiodevs or runs multiple qemu instances.
> > > > >=20
> > > > > Hmm, can we create an useful name automatically, without yet an=
other
> > > > > config option?
> > > > >=20
> > > > > Useful choices could be the device name (usb-audio, ...) or the=
 device
> > > > > id (whatever -device id=3Dxxx was specified on the command line=
).
> > > >=20
> > > > I'm afraid this is not going to work with the current architectur=
e: due
> > > > to mixeng even if you have multiple devices, they'll be mixed to =
a
> > > > single stream and the audio backend will only see this one mixed =
stream.
> > > >  As a workaround we could do something like concat all device nam=
es or
> > > > ids, but I don't like that idea.
> > > >=20
> > > > Alternatively we could use the id of the audiodev instead, and no=
 more
> > > > problems with mixeng.  However, with mixeng off (implemented in m=
y next
> > > > patch series) suddenly soundcards will have suddenly end up as di=
fferent
> > > > streams.  (This can be worked around by creating multiple audiode=
vs,
> > > > like what you have to use now to get multiple streams from pa, so=
 this
> > > > is probably a smaller problem.)
> > > >=20
> > > > Currently I'm leaning for the audiodev's id option, unless someon=
e
> > > > proposes something better.
> > >=20
> > > Using the audiodev id is not a good idea. If you have multiple QEMU=
's
> > > on your host, it is highly likely that libvirt will have assigned
> > > the same audiodev id to all of them.  Using the vm name would be ok=
,
> > > but only if you assume that each gust only has a single audio devic=
e.
> > >=20
> > > Using a combination of vm name + audidev id is going to be unique
> > > per host, but not especially friendly as a user visible name. It
> > > would be ok as a default, but I'd think we should let the mgmt app
> > > specify stream name explicitly, so that something user friendly
> > > can be set.
> >=20
> > No, no!
> > It seems that pulseaudio has a name for each connection, and a name f=
or each
> > steam within that connection.
> >=20
> > The suggestion is that we use the VM name for the connection,
> > (which will be unique per VM usually, at least the user can make it b=
e so)
> > and then use the audiodev id for each stream. Of course for multiple =
VMs,
> > the audiodev ids will be the same, but this is all right since you ca=
n
> > always distinguish them that the streams come from different VMs.
>=20
> Ok, if I'm reading the code correctly, it seems we do take care to
> re-use a single connection to PA for all audiodevs we create. So a
> VMname is fine for the connection.
>=20
> > Also note that this thing is cosmetic from the correctness point of v=
iew,
> > that is pulse-audio internally has no problem with duplicate IDs.
> >=20
> > The thing is useful mostly for tweaking the output streams in the pav=
ucontrol,
> > where the names will allow you to easily know which steam is which.
>=20
> Yep, I wasn't really concerned about internals - from the user POV bein=
g
> able to accurately distinguish streams in pavucontrol is very important
> though, so we should ensure that's possible. If we use 'id'  for the
> stream as a default though, we should still allow an override, as 'id'
> values are not really intended as end user visible data. If a guest
> has multiple devices I'd expect to be able to give them names that are
> meaningful to me as a user, not something libvirt auto-generates for
> its own machine oriented use.

I have absolutely nothing against user specified override!
Just that if the idea is shot down, lets at least have device id instead.


For the reference this is how currently the sound streams are shown,
without any patches applied
https://imgur.com/a/I8HZhgx

Gnome sound panel only shows application names,
but pavucontrol shows both the application name and stream name.

Best regards,
	Maxim Levitsky


