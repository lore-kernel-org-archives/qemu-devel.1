Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66316C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 328D32064C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zu+5/KDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328D32064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxsdA-0008Ve-GM
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 09:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxscT-0007Zn-Ka
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:47:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27517
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxscR-0006Ra-KG
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595339262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iWhzcSbW9El81og4hP+zMbi9USsPc6xITJmKjVFqEhQ=;
 b=Zu+5/KDCi/MgyCsd8abxzOGWdjWxaIodgqlTEo9Uc2ds58RtnD+Pdcj7NmALy5/+goHfvu
 Djg5rLjTQrwpnPkLktn2Ay11FZg48dtp4MKJJLZdh7uJTFkW0e2ZnYbfz5pzLePY04l4RJ
 Cs+aK3J4u78tejyTwJAHJCHt4Otd1G0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-LSh3V5INPLuFcAmVa_H7zQ-1; Tue, 21 Jul 2020 09:47:37 -0400
X-MC-Unique: LSh3V5INPLuFcAmVa_H7zQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBA6480046B;
 Tue, 21 Jul 2020 13:47:35 +0000 (UTC)
Received: from localhost (ovpn-114-133.ams2.redhat.com [10.36.114.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBB0010023A7;
 Tue, 21 Jul 2020 13:47:29 +0000 (UTC)
Date: Tue, 21 Jul 2020 14:47:29 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [RFC v2 3/3] libvhost-user: fence legacy virtio devices
Message-ID: <20200721134729.GA186372@stefanha-x1.localdomain>
References: <20200717092929.19453-1-mhartmay@linux.ibm.com>
 <20200717092929.19453-4-mhartmay@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200717092929.19453-4-mhartmay@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:46:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 11:29:29AM +0200, Marc Hartmayer wrote:
> libvhost-user has no support for legacy virtio devices therefore
> let's fence them.
>=20
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>  contrib/libvhost-user/libvhost-access.h | 10 ++++++++++
>  contrib/libvhost-user/libvhost-user.c   |  6 ++++++
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/contrib/libvhost-user/libvhost-access.h b/contrib/libvhost-u=
ser/libvhost-access.h
> index 868ba3e7bfb8..aa505ea1ec02 100644
> --- a/contrib/libvhost-user/libvhost-access.h
> +++ b/contrib/libvhost-user/libvhost-access.h
> @@ -1,11 +1,21 @@
>  #ifndef LIBVHOST_ACCESS_H
> =20
> +#include <assert.h>
> +
>  #include "qemu/bswap.h"
> =20
>  #include "libvhost-user.h"
> =20
> +static inline bool vu_has_feature(VuDev *dev, unsigned int fbit);
> +
>  static inline bool vu_access_is_big_endian(VuDev *dev)
>  {
> +    /*
> +     * TODO: can probably be removed as the fencing is already done in
> +     * `vu_set_features_exec`
> +     */
> +    assert(vu_has_feature(dev, VIRTIO_F_VERSION_1));

Great, please drop it since the memory accesses are called from
performance-critical code paths.

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8W8fAACgkQnKSrs4Gr
c8iLvwf/eeG6JH1j0+NvPbud0pUW6MvNy/tUc9XTUDKgmuzEyszRgmmEwxTdJ38G
p0r8pISDhL1G2hQOa4lrCoRGEnyvTizKLRp5EDTZ1K/EDjwkXlnD5dACFBtUKZ4r
qiEDBfAp6CWxGAFRusQb+gSTkSDbm8fnxuxMWD4th7K20+tY+Iaarza/JGYTOvwU
NKx/wwrj+nSetsXxfI4Y/SHku3RiqLoY1S9piMUPs+kvH8zLcXfSi3KdJvXxbvPo
96dJIeeIJ1hDPARtoCQpwPlhDRGjA7BQ6XQsj+R4tkaPgyLa19uZYRMUtPam7sdo
k08YtvIh8iYVBDfvYSrlASsXvnGmCw==
=MCCj
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--


