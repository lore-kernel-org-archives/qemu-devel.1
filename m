Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28351C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 10:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06FB2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 10:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06FB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2vAb-0002IK-3n
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 06:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i2v9X-0001QX-Ax
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 06:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i2v9V-0001Zf-R0
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 06:26:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49834)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i2v9V-0001ZA-JG
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 06:26:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8B778980E7;
 Wed, 28 Aug 2019 10:26:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81DB919D7A;
 Wed, 28 Aug 2019 10:26:05 +0000 (UTC)
Date: Wed, 28 Aug 2019 11:26:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190828102603.GG2991@redhat.com>
References: <cover.1566847960.git.DirtY.iCE.hu@gmail.com>
 <43076a2afeb0439b607b0631e0bfff77d55bc0cc.1566847960.git.DirtY.iCE.hu@gmail.com>
 <20190827054223.nuiz7fz27tld3hpt@sirius.home.kraxel.org>
 <2fdc616c-0690-a898-0247-765f90153903@gmail.com>
 <20190828095308.GE2991@redhat.com>
 <6a1f7b1dc372abfbbf8efaa7d0ce9c7db1881849.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a1f7b1dc372abfbbf8efaa7d0ce9c7db1881849.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Wed, 28 Aug 2019 10:26:08 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 28, 2019 at 01:14:03PM +0300, Maxim Levitsky wrote:
> On Wed, 2019-08-28 at 10:53 +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Aug 28, 2019 at 12:43:49AM +0200, Zolt=C3=A1n K=C5=91v=C3=A1g=
=C3=B3 wrote:
> > > On 2019-08-27 07:42, Gerd Hoffmann wrote:
> > > > On Mon, Aug 26, 2019 at 09:59:04PM +0200, K=C5=91v=C3=A1g=C3=B3, =
Zolt=C3=A1n wrote:
> > > > > This can be used to identify stream in tools like pavucontrol w=
hen one
> > > > > creates multiple -audiodevs or runs multiple qemu instances.
> > > >=20
> > > > Hmm, can we create an useful name automatically, without yet anot=
her
> > > > config option?
> > > >=20
> > > > Useful choices could be the device name (usb-audio, ...) or the d=
evice
> > > > id (whatever -device id=3Dxxx was specified on the command line).
> > >=20
> > > I'm afraid this is not going to work with the current architecture:=
 due
> > > to mixeng even if you have multiple devices, they'll be mixed to a
> > > single stream and the audio backend will only see this one mixed st=
ream.
> > >  As a workaround we could do something like concat all device names=
 or
> > > ids, but I don't like that idea.
> > >=20
> > > Alternatively we could use the id of the audiodev instead, and no m=
ore
> > > problems with mixeng.  However, with mixeng off (implemented in my =
next
> > > patch series) suddenly soundcards will have suddenly end up as diff=
erent
> > > streams.  (This can be worked around by creating multiple audiodevs=
,
> > > like what you have to use now to get multiple streams from pa, so t=
his
> > > is probably a smaller problem.)
> > >=20
> > > Currently I'm leaning for the audiodev's id option, unless someone
> > > proposes something better.
> >=20
> > Using the audiodev id is not a good idea. If you have multiple QEMU's
> > on your host, it is highly likely that libvirt will have assigned
> > the same audiodev id to all of them.  Using the vm name would be ok,
> > but only if you assume that each gust only has a single audio device.
> >=20
> > Using a combination of vm name + audidev id is going to be unique
> > per host, but not especially friendly as a user visible name. It
> > would be ok as a default, but I'd think we should let the mgmt app
> > specify stream name explicitly, so that something user friendly
> > can be set.
> No, no!
> It seems that pulseaudio has a name for each connection, and a name for=
 each
> steam within that connection.
>=20
> The suggestion is that we use the VM name for the connection,
> (which will be unique per VM usually, at least the user can make it be =
so)
> and then use the audiodev id for each stream. Of course for multiple VM=
s,
> the audiodev ids will be the same, but this is all right since you can
> always distinguish them that the streams come from different VMs.

Ok, if I'm reading the code correctly, it seems we do take care to
re-use a single connection to PA for all audiodevs we create. So a
VMname is fine for the connection.

> Also note that this thing is cosmetic from the correctness point of vie=
w,
> that is pulse-audio internally has no problem with duplicate IDs.
>=20
> The thing is useful mostly for tweaking the output streams in the pavuc=
ontrol,
> where the names will allow you to easily know which steam is which.

Yep, I wasn't really concerned about internals - from the user POV being
able to accurately distinguish streams in pavucontrol is very important
though, so we should ensure that's possible. If we use 'id'  for the
stream as a default though, we should still allow an override, as 'id'
values are not really intended as end user visible data. If a guest
has multiple devices I'd expect to be able to give them names that are
meaningful to me as a user, not something libvirt auto-generates for
its own machine oriented use.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

