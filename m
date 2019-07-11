Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4609C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:02:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB87C21019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB87C21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYiw-0003J5-1E
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33838)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hlYhR-0001he-UP
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hlYhP-0007cN-Lu
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:01:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1hlYhL-0007Yb-PF; Thu, 11 Jul 2019 09:01:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 531BA4E908;
 Thu, 11 Jul 2019 13:01:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5951760143;
 Thu, 11 Jul 2019 13:01:17 +0000 (UTC)
Date: Thu, 11 Jul 2019 14:01:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190711130115.GJ11930@redhat.com>
References: <20190710170349.1548-1-mlevitsk@redhat.com>
 <84232589-627a-8151-a3d5-84c053d9a257@redhat.com>
 <20190711092031.GB11930@redhat.com>
 <4af9b328-f74b-50db-f130-3ce551239e14@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4af9b328-f74b-50db-f130-3ce551239e14@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 11 Jul 2019 13:01:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] LUKS: support preallocation in qemu-img
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 11, 2019 at 02:23:55PM +0200, Max Reitz wrote:
> On 11.07.19 11:20, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Jul 10, 2019 at 11:24:46PM +0200, Max Reitz wrote:
> >> On 10.07.19 19:03, Maxim Levitsky wrote:
> >>> preallocation=3Doff and preallocation=3Dmetadata
> >>> both allocate luks header only, and preallocation=3Dfalloc/full
> >>> is passed to underlying file, with the given image size.
> >>>
> >>> Note that the actual preallocated size is a bit smaller due
> >>> to luks header.
> >>
> >> Couldn=E2=80=99t you just preallocate it after creating the crypto h=
eader so
> >> qcrypto_block_get_payload_offset(crypto->block) + size is the actual
> >> file size?
> >=20
> > Yeah that would be preferrable. If that's really not possible, we
> > could likely provide some API to query the expected hreader size for
> > a given set of creation options.=20
> >=20
> >>
> >>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534951
> >>>
> >>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> >>> ---
> >>>  block/crypto.c | 28 ++++++++++++++++++++++++++--
> >>>  1 file changed, 26 insertions(+), 2 deletions(-)
> >>
> >> Hm.  I would expect a preallocated image to read 0.  But if you just
> >> pass this through to the protocol layer, it won=E2=80=99t read 0.
> >=20
> > Yes, it will be zeros at the physical layer, but unintelligble
> > garbage from POV of the virtual disk.
> >=20
> > I don't think this is really a problem though - this is what you
> > get already if you create a LUKS volume on top of a block device
> > today.
>=20
> Which is why we have BlockDriver.bdrv_has_zero_init(), which the LUKS
> driver does not implement, hence it being treated as false.
>=20
> But if you are preallocating, you have a choice of what you write, and
> why not make that zeroes?
>=20
> > AFAIK, we've not documented that preallocation guarantees future
> > reads will return zeros. Preallocation simply ensures that all
> > required space is allocated upfront. We do mention that it might
> > be achieved by writing zeros to the underlying storage but never
> > said you'll get zeros back.
>=20
> But we have, as I wrote in my second reply.  PreallocMode's
> documentation says that at least =E2=80=9Cfull=E2=80=9D is writing zero=
es, and to say
> those zeroes can be anywhere in the stack is cheating, from my POV.

I guess it depends on your interpretation of the docs. In qemu-img
man page it says

  "falloc" mode preallocates space for image by calling posix_fallocate()=
.
  "full" mode preallocates space for image by writing zeros to underlying
  storage.

To me both those sentances are talking about the lowest level in the
stack, closest to the physical storage medium, though I can understand
if people have other interpretations.

> > IOW I think its at most a docs problem to more clearly explain
> > that preallocation !=3D guaranteed zeros for reads.
> >=20
> >> (In fact, I don=E2=80=99t even quite see the point of having LUKS as=
 an own
> >> format still.  It was useful when qcow2 didn=E2=80=99t have LUKS sup=
port, but
> >> now it does, so...  I suppose everyone using the LUKS format should
> >> actually be using qcow2 with LUKS?)
> >=20
> > Certainly not. LUKS on raw is going to be very common, not least beca=
use
> > that's directly compatible with what Linux kernel supports. If you do=
n't
> > want the features of qcow2 like snapshots, it just adds overhead and =
mgmt
> > complexity for no gain, especially if dealing with block device backe=
d
> > storage (iSCSI, RBD).
> >=20
> > OpenStack will use cryptsetup when initializing its block storage wit=
h
> > LUKS, then tell QEMU to run with the raw + LUKS driver.
>=20
> I see the compatibility with the Linux kernel, yes (as I wrote in my
> second reply), but I=E2=80=99m not sure whether =E2=80=9Coverhead=E2=80=
=9D really is that big of
> a point when using encryption.

Overhead is not purely about CPU burn. There's non-negligible memory
overhead for qcow2s data tables that doesn't exist at all with raw.
The mgmt complexity & interoperability is the real killer feature
benefit of raw + LUKS vs qcow + LUKS though.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

