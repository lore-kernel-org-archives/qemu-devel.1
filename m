Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75712C4727D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A412193E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIejmBxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A412193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL9g5-0006Ws-Fk
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 14:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL9UA-0002SN-3V
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL9U8-0000WR-5X
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600885639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HUThgk63yrTEEbCNncbfoZ01l5yhDqO7ELDtAeOJw60=;
 b=MIejmBxE5JsJnsQVdBaXgC71WIwwiH1JX+WTAf++P83cr3VUyl9e+ClvFx6Rzis/RWWNGA
 ZK3/3hXRak6YEzfDBu2lO1kwMVD5gWaw+0z3N/ySC3QtF/SoeOGnJurdOsS9zhwDZFxZxf
 fqR0qWFfeKnp6fO6DxHe0mf3ZtvAPFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-spbyGzNWMRyxQC_NZd6yVg-1; Wed, 23 Sep 2020 14:27:16 -0400
X-MC-Unique: spbyGzNWMRyxQC_NZd6yVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8CE381F03F
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 18:27:15 +0000 (UTC)
Received: from localhost (ovpn-112-110.ams2.redhat.com [10.36.112.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73CDF55778;
 Wed, 23 Sep 2020 18:27:15 +0000 (UTC)
Date: Wed, 23 Sep 2020 19:27:14 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 1/2] qemu/atomic: Update coding style to make
 checkpatch.pl happier
Message-ID: <20200923182714.GA70694@stefanha-x1.localdomain>
References: <20200923151901.745277-1-philmd@redhat.com>
 <20200923151901.745277-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200923151901.745277-2-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2020 at 05:19:00PM +0200, Philippe Mathieu-Daud=E9 wrote:
> To limit the number of checkpatch errors in the next commit,
> clean coding style issues first.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
> False positive:
>=20
>  ERROR: Use of volatile is usually wrong, please add a comment
>  #11: FILE: include/qemu/atomic.h:328:
>  +#define atomic_read__nocheck(p)   (*(__typeof__(*(p)) volatile *) (p))
>=20
>  ERROR: Use of volatile is usually wrong, please add a comment
>  #12: FILE: include/qemu/atomic.h:329:
>  +#define atomic_set__nocheck(p, i) ((*(__typeof__(*(p)) volatile *) (p))=
 =3D (i))
> ---
>  include/qemu/atomic.h | 9 +++++----
>  util/bitmap.c         | 3 ++-
>  util/rcu.c            | 6 ++++--
>  3 files changed, 11 insertions(+), 7 deletions(-)

I already sent a pull request with the patch that renames atomic.h, but
this patch can be rebased on top:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9rk4IACgkQnKSrs4Gr
c8jFywf/TQBmzCf2sW7QC1ZKOmn9TBIdAsn9l6l+XD3k2NJY53KKg/anAkCJ1sUl
SPdgSgJ3DW6aPkor5oGilk8IOoePdgNS8eR4UMXLcs6TM/abMXSNgrcjNyOXMYvb
emPjsikjiEpjgSmYwCrhf8Nku4m1f1dEc70wLsRdBWkfBz/2mSDzLo+1pv8BumrZ
5j0xozAR7iHN8CjvO/bWyu6ClcnDwxUjMUAWbdTHWRivu1fNqXZsGsW5i6X7TIPw
qKN+4/RM1q26GK8ugX6a2XFIVUqRaf4U5EC2cy/noPrT3IUA4Wa9BlPqpE+VXtg3
Ng46jFZiDhYX8s2s7nVMYy0l/xkVkw==
=be15
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--


