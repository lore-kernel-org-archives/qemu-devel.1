Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209F1ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0DF222BF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0DF222BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wke-0001uT-Bj
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i7wYh-0005zu-7w
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i7wYg-0008G1-1L
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:56:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47404)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i7wYf-0008FR-OM
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:56:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DDCB618C427B;
 Wed, 11 Sep 2019 06:56:52 +0000 (UTC)
Received: from localhost (ovpn-116-185.ams2.redhat.com [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52F6119C4F;
 Wed, 11 Sep 2019 06:56:45 +0000 (UTC)
Date: Wed, 11 Sep 2019 08:56:39 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190911065639.GA4181@stefanha-x1.localdomain>
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190902121233.13382-2-johannes@sipsolutions.net>
 <fe517ef6c6a8e2df9675388be9454b5863c7fc55.camel@sipsolutions.net>
 <20190909160039.GC20875@stefanha-x1.localdomain>
 <d095bafedcd4bcc5d76279785e5bd523aef62b58.camel@sipsolutions.net>
 <20190910150319.GB31674@stefanha-x1.localdomain>
 <e114b68dffecd9b4c4666327b15a28098c83f7ec.camel@sipsolutions.net>
 <20190910112937-mutt-send-email-mst@kernel.org>
 <f4d1a66f6ff407f9aaec77f1125effe5cf10467b.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <f4d1a66f6ff407f9aaec77f1125effe5cf10467b.camel@sipsolutions.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Wed, 11 Sep 2019 06:56:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] docs: vhost-user: add in-band kick/call
 messages
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2019 at 05:34:57PM +0200, Johannes Berg wrote:
> On Tue, 2019-09-10 at 11:33 -0400, Michael S. Tsirkin wrote:
> > On Tue, Sep 10, 2019 at 05:14:36PM +0200, Johannes Berg wrote:
> > > Is any of you familiar with the process of getting a virtio device ID
> > > assigned, and if so, do you think it'd be feasible? Without that, it'd
> > > probably be difficult to upstream the patch to support this protocol =
to
> > > user-mode Linux.
> >=20
> > Sure, subscribe then send a patch to virtio-comment@lists.oasis-open.org
>=20
> Ok, great.
>=20
> > We do expect people to eventually get around to documenting the device
> > and upstreaming it though. If there's no plan to do it at all, you might
> > still be able to reuse the virtio code, in that case let's talk.
>=20
> Right, no, I do want to and am working on the code now, but it's a bit
> of a chicken & egg - without an ID I can't really send any code upstream
> :-)
>=20
> I can accompany the request for a new ID with working patches.
>=20
> What kind of documentation beyond the header file should be added, and
> where?

You can reserve the device ID without any header files or documentation.
Just a patch like this one will suffice:

  https://github.com/oasis-tcs/virtio-spec/commit/9454b568c29baab7f3e4b1a38=
4627d0061f71eba

I have checked that device ID 29 appears to be free so you could use it.

For the actual VIRTIO device specification, please follow the same
format as the other devices.  Here is the virtio-net section in the
VIRTIO spec:

  https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html=
#x1-1940001

It documents the virtqueues, configuration space layout, theory of
operation, and also includes normative statements that compliant drivers
and devices are expected to follow.

The goal of the spec is to provide all the information needed by driver
and device emulation authors to create an implementation from scratch
(without studying existing code in Linux, QEMU, etc).

The VIRTIO spec contains pseudo-C struct and constant definitions, but
not a real header file.  The header file for a Linux driver would live
in include/uapi/linux/virtio_foo.h (see existing devices for examples).
This would be part of your Linux patches and separate from the virtio
spec.

Stefan

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl14mqcACgkQnKSrs4Gr
c8hHyQgAtpFcm+238TskSyYaSv6jvpfyWx+DOidJ8yKMViGdPGqteCn/9UuJZRYn
MFSHuj0qaDLivoFRySX7LncdPbUTLIdUvmZIVFdtBJM0UUlII01xgVwGuqQ1Xxup
zOpcjIJBOmtPvB9zIQsSm+a0oYBbD+YKlPAOQ7DYfVnw6HyC+utKeg4cKs46Li45
5M6oW+BZhws1wy+Mnc+2NI+RJQKAdNI5/BIIrGOlwEbRpIocaGKdsruNxyc15cYp
A0bCejDo171c08O5jsBuTeo1rDmM1OBPb2DF7LyaoJDGpRRwaBEgrWhfq45z7Z2w
rQJLf2HTC1nhfsHtczzPDJ0PRf+4uw==
=BaWp
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

