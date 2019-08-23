Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A87C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 10:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAAB221726
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 10:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAB221726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i16h0-0005HS-0J
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 06:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i16XG-0002e9-4N
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i16XF-0001rq-0E
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:11:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i16XE-0001qI-QR
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:11:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BE0251801590;
 Fri, 23 Aug 2019 10:11:07 +0000 (UTC)
Received: from localhost (ovpn-117-204.ams2.redhat.com [10.36.117.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD8F918677;
 Fri, 23 Aug 2019 10:11:06 +0000 (UTC)
Date: Fri, 23 Aug 2019 11:11:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Message-ID: <20190823101105.GE12092@stefanha-x1.localdomain>
References: <20190822115433.12070-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Content-Disposition: inline
In-Reply-To: <20190822115433.12070-1-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 23 Aug 2019 10:11:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: register_savevm_live doesn't
 need dev
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
Cc: quintela@redhat.com, jasowang@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2019 at 12:54:33PM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Commit 78dd48df3 removed the last caller of register_savevm_live for an
> instantiable device (rather than a single system wide device);
> so trim out the parameter.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  docs/devel/migration.rst       |  3 +--
>  hw/ppc/spapr.c                 |  2 +-
>  hw/s390x/s390-skeys.c          |  2 +-
>  hw/s390x/s390-stattrib.c       |  2 +-
>  hw/s390x/tod.c                 |  2 +-
>  include/migration/register.h   |  3 +--
>  migration/block-dirty-bitmap.c |  2 +-
>  migration/block.c              |  2 +-
>  migration/ram.c                |  2 +-
>  migration/savevm.c             | 23 +----------------------
>  net/slirp.c                    |  2 +-
>  11 files changed, 11 insertions(+), 34 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1fu7kACgkQnKSrs4Gr
c8hkHAf/YDVH5kanaqICh0QogEBjaYOBOxPf0Pi2VO2oriR+Jr9LLLHm9G+uQPSt
zpAVRusTnNh8uuZPrMWhqQTq7qmhcnjHflxX+cx/vd66Zsqbv7i9Ik8FQwrq7tFu
Ntvgc6nzJXAlzPoThSvGCm4BhfrMzU2VeoNmsHz87tOTwdWveBEpV7ZjYO2rXzUw
oGi3/BRFdBvWtvHVNo2z/yhaEFE3eZfeQNAqsNo3v8M/TwmNI/l4geREL4uY7oKh
q5d7lP0Pb0naIwQcTH8OlrUF722RQjFnzfN5FOX7lLBdYFWfY7n4rh7e1wRS12lJ
ko17zxk0qv636fAXZsXrkymD21LnZQ==
=2iri
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--

