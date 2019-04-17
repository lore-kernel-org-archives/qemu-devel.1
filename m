Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA3FC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30932206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30932206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57027 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGoGN-00067I-7h
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 13:22:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGoFT-0005oa-SB
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGoFP-0008Gb-3B
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:21:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hGoFJ-0008AM-K1; Wed, 17 Apr 2019 13:21:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CECE33099FC5;
	Wed, 17 Apr 2019 17:21:15 +0000 (UTC)
Received: from redhat.com (ovpn-112-35.ams2.redhat.com [10.36.112.35])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 794CB1001DCC;
	Wed, 17 Apr 2019 17:21:12 +0000 (UTC)
Date: Wed, 17 Apr 2019 18:21:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190417172109.GW7535@redhat.com>
References: <20190401145741.28322-1-eblake@redhat.com>
	<d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
	<39599f7c-c3c6-73c9-7f74-0e70270c49de@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <39599f7c-c3c6-73c9-7f74-0e70270c49de@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Wed, 17 Apr 2019 17:21:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2] qemu-img: Saner printing of
 large file sizes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417172109.pJaM8jNJp5KfwtOI83xgIK1J2Waok92t5ZaGhUE-yWQ@z>

On Wed, Apr 17, 2019 at 11:58:57AM -0500, Eric Blake wrote:
> On 4/10/19 2:28 PM, Max Reitz wrote:
> > On 01.04.19 16:57, Eric Blake wrote:
> >> Disk sizes close to INT64_MAX cause overflow, for some pretty
> >> ridiculous output:
> >>
> >>   $ ./nbdkit -U - memory size=3D$((2**63 - 512)) --run 'qemu-img inf=
o $nbd'
> >>   image: nbd+unix://?socket=3D/tmp/nbdkitHSAzNz/socket
> >>   file format: raw
> >>   virtual size: -8388607T (9223372036854775296 bytes)
> >>   disk size: unavailable
> >>
>=20
> >=20
> > There are more iotests this breaks.  First, there is 059 for vmdk, wh=
ich
> > looks just like the rest.
>=20
> Easy enough; I was able to reproduce.
>=20
> >=20
> > But for -m32, it gets a bit more difficult.  Every size above 999 GB
> > (1000 GB gets rounded to 1 TB, which is 2^31 * 512) gets printed as
> > "inf [unit]":
>=20
> Ouch - pre-existing bug in size_to_str(); I'll have to fix that, then
> send a v3.
>=20
> Kevin, do you want to unqueue this from block-next until then?
>=20
> >=20
> > But regardless of the iotests, we shouldn=E2=80=99t show the size as =
infinite
> > just because of -m32.
>=20
> Is there an easy docker setup for building -m32?

QEMU has a "fedora-i386-cross" image you can at least do builds in
Hopefully its good enough for make check too

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

