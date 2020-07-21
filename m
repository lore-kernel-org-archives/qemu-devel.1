Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0112C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC0C20684
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IzEG8Gxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC0C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxseB-00016k-QZ
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 09:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxscl-00083B-De
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:48:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47530
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxscj-0006TB-IY
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595339280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=le0uRquTl/Fr9x8i/kta/jkFdE5PbS3wb/9B/eyXOIY=;
 b=IzEG8GxlKPzio9tbKYxwcYujmPZLpgYXOWu+9k0DU17iS4NC/ulFs2HV7AUwP9Lg17gOeL
 tKbxwym6FwqePhEvkhyeIP3HMwaatS3ZiRbWlRvC/S59b2fdiB1g/UNFULLtp9S4TiIEB9
 3YW+eVA/ffOcxf+U3S2nKXf4QTU4gk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-A1ZQ6172MTyzNRCS6Z750w-1; Tue, 21 Jul 2020 09:47:54 -0400
X-MC-Unique: A1ZQ6172MTyzNRCS6Z750w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2042189CEE3;
 Tue, 21 Jul 2020 13:47:53 +0000 (UTC)
Received: from localhost (ovpn-114-133.ams2.redhat.com [10.36.114.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0791372682;
 Tue, 21 Jul 2020 13:47:47 +0000 (UTC)
Date: Tue, 21 Jul 2020 14:47:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [RFC v2 1/3] virtio: add vhost-user-fs-ccw device
Message-ID: <20200721134746.GB186372@stefanha-x1.localdomain>
References: <20200717092929.19453-1-mhartmay@linux.ibm.com>
 <20200717092929.19453-2-mhartmay@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200717092929.19453-2-mhartmay@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
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

--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 11:29:27AM +0200, Marc Hartmayer wrote:
> From: Halil Pasic <pasic@linux.ibm.com>
>=20
> Wire up the CCW device for vhost-user-fs.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  hw/s390x/Makefile.objs       |  1 +
>  hw/s390x/vhost-user-fs-ccw.c | 73 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+)
>  create mode 100644 hw/s390x/vhost-user-fs-ccw.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8W8gIACgkQnKSrs4Gr
c8jL2gf+PmQ2jBYlD9USTtEbRh69VQFVAFJ30j6fo8qzI0nSuu1WWCYyUMv2af9l
Zrx43LomYZwIdMcbjltZ6nbfrZ8mq5UV1EHjtQeOBbKCSQaHgFYZ6JGv9jAaBlAt
pL5yzx5ZvbrwQvNqzuUk+FwjXTbd0OM7YPxoNDTFRW9ZllNu+RZXg8Sx8ZlW42Bx
Ga62Rp0oQUKW8Pz1PHfQihMyovFWsgxc06b26De7dzUIDrdQ4xYlLG0J2tKBWnvI
+nhqW8UouA5UEf5VV0lLFB8klNgqPNqoR+vVoFMoI0M2oyAFRw8bWudQrC+ryb2W
4pUf17A7oZiXiQd3ImNFbirpkGVpjw==
=fjbC
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--


