Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD95FC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B225A2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B225A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2ueO-0003To-Tn
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 05:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i2udg-000326-V3
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i2udf-0000N3-8B
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:53:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60116)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i2udf-0000MX-30
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:53:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6B3042A09A5;
 Wed, 28 Aug 2019 09:53:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3655E600D1;
 Wed, 28 Aug 2019 09:53:10 +0000 (UTC)
Date: Wed, 28 Aug 2019 10:53:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Message-ID: <20190828095308.GE2991@redhat.com>
References: <cover.1566847960.git.DirtY.iCE.hu@gmail.com>
 <43076a2afeb0439b607b0631e0bfff77d55bc0cc.1566847960.git.DirtY.iCE.hu@gmail.com>
 <20190827054223.nuiz7fz27tld3hpt@sirius.home.kraxel.org>
 <2fdc616c-0690-a898-0247-765f90153903@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2fdc616c-0690-a898-0247-765f90153903@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 28 Aug 2019 09:53:13 +0000 (UTC)
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
Cc: qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 28, 2019 at 12:43:49AM +0200, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3=
 wrote:
> On 2019-08-27 07:42, Gerd Hoffmann wrote:
> > On Mon, Aug 26, 2019 at 09:59:04PM +0200, K=C5=91v=C3=A1g=C3=B3, Zolt=
=C3=A1n wrote:
> >> This can be used to identify stream in tools like pavucontrol when o=
ne
> >> creates multiple -audiodevs or runs multiple qemu instances.
> >=20
> > Hmm, can we create an useful name automatically, without yet another
> > config option?
> >=20
> > Useful choices could be the device name (usb-audio, ...) or the devic=
e
> > id (whatever -device id=3Dxxx was specified on the command line).
>=20
> I'm afraid this is not going to work with the current architecture: due
> to mixeng even if you have multiple devices, they'll be mixed to a
> single stream and the audio backend will only see this one mixed stream=
.
>  As a workaround we could do something like concat all device names or
> ids, but I don't like that idea.
>=20
> Alternatively we could use the id of the audiodev instead, and no more
> problems with mixeng.  However, with mixeng off (implemented in my next
> patch series) suddenly soundcards will have suddenly end up as differen=
t
> streams.  (This can be worked around by creating multiple audiodevs,
> like what you have to use now to get multiple streams from pa, so this
> is probably a smaller problem.)
>=20
> Currently I'm leaning for the audiodev's id option, unless someone
> proposes something better.

Using the audiodev id is not a good idea. If you have multiple QEMU's
on your host, it is highly likely that libvirt will have assigned
the same audiodev id to all of them.  Using the vm name would be ok,
but only if you assume that each gust only has a single audio device.

Using a combination of vm name + audidev id is going to be unique
per host, but not especially friendly as a user visible name. It
would be ok as a default, but I'd think we should let the mgmt app
specify stream name explicitly, so that something user friendly
can be set.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

