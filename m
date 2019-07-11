Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73320C74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4781A21019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4781A21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlVGG-0007OC-Ft
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 05:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41921)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hlVFn-0006v7-Il
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hlVFm-0003ao-Ee
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:20:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1hlVFj-0003Vi-Ha; Thu, 11 Jul 2019 05:20:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 368AA3084242;
 Thu, 11 Jul 2019 09:20:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40A3B1001B2B;
 Thu, 11 Jul 2019 09:20:33 +0000 (UTC)
Date: Thu, 11 Jul 2019 10:20:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190711092031.GB11930@redhat.com>
References: <20190710170349.1548-1-mlevitsk@redhat.com>
 <84232589-627a-8151-a3d5-84c053d9a257@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84232589-627a-8151-a3d5-84c053d9a257@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 11 Jul 2019 09:20:34 +0000 (UTC)
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

On Wed, Jul 10, 2019 at 11:24:46PM +0200, Max Reitz wrote:
> On 10.07.19 19:03, Maxim Levitsky wrote:
> > preallocation=3Doff and preallocation=3Dmetadata
> > both allocate luks header only, and preallocation=3Dfalloc/full
> > is passed to underlying file, with the given image size.
> >=20
> > Note that the actual preallocated size is a bit smaller due
> > to luks header.
>=20
> Couldn=E2=80=99t you just preallocate it after creating the crypto head=
er so
> qcrypto_block_get_payload_offset(crypto->block) + size is the actual
> file size?

Yeah that would be preferrable. If that's really not possible, we
could likely provide some API to query the expected hreader size for
a given set of creation options.=20

>=20
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534951
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/crypto.c | 28 ++++++++++++++++++++++++++--
> >  1 file changed, 26 insertions(+), 2 deletions(-)
>=20
> Hm.  I would expect a preallocated image to read 0.  But if you just
> pass this through to the protocol layer, it won=E2=80=99t read 0.

Yes, it will be zeros at the physical layer, but unintelligble
garbage from POV of the virtual disk.

I don't think this is really a problem though - this is what you
get already if you create a LUKS volume on top of a block device
today.

AFAIK, we've not documented that preallocation guarantees future
reads will return zeros. Preallocation simply ensures that all
required space is allocated upfront. We do mention that it might
be achieved by writing zeros to the underlying storage but never
said you'll get zeros back.

IOW I think its at most a docs problem to more clearly explain
that preallocation !=3D guaranteed zeros for reads.

> (In fact, I don=E2=80=99t even quite see the point of having LUKS as an=
 own
> format still.  It was useful when qcow2 didn=E2=80=99t have LUKS suppor=
t, but
> now it does, so...  I suppose everyone using the LUKS format should
> actually be using qcow2 with LUKS?)

Certainly not. LUKS on raw is going to be very common, not least because
that's directly compatible with what Linux kernel supports. If you don't
want the features of qcow2 like snapshots, it just adds overhead and mgmt
complexity for no gain, especially if dealing with block device backed
storage (iSCSI, RBD).

OpenStack will use cryptsetup when initializing its block storage with
LUKS, then tell QEMU to run with the raw + LUKS driver.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

