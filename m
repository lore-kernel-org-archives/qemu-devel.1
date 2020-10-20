Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A2BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE86122242
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0Pinoyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE86122242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUoPJ-0003ct-Hh
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 05:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kUoO6-0002ic-9n
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kUoO4-0005Dr-7J
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603187819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Xw9GMqaWQKFNzrfwP3BjrWOgzWexwEhjMQKUYNqtS0=;
 b=G0PinoyvqOVQLdmLHDKZAmKrGQSnv1B8GGtm9vRku1R2G4D7UVRmrIDn4daHtTUJjje+WX
 wcV1mNu97Pj9c0TQNnxYID9AH+EpZrzPNkwpv20G36wIiocWWopWNY2/UwrH1uLHZYkDl5
 3fuaAbo0LoXxwdFbt7qXB0yXxmMFLeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-6R-AAlhTNvWGxoBSB-g0zQ-1; Tue, 20 Oct 2020 05:56:56 -0400
X-MC-Unique: 6R-AAlhTNvWGxoBSB-g0zQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEB26185B384
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 09:56:55 +0000 (UTC)
Received: from localhost (ovpn-115-35.ams2.redhat.com [10.36.115.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99AAE10027A5;
 Tue, 20 Oct 2020 09:56:49 +0000 (UTC)
Date: Tue, 20 Oct 2020 10:56:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 4/5] tools/virtiofsd: xattr name mapping examples
Message-ID: <20201020095648.GE140014@stefanha-x1.localdomain>
References: <20201014180209.49299-1-dgilbert@redhat.com>
 <20201014180209.49299-5-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201014180209.49299-5-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: dinechin@redhat.com, virtio-fs@redhat.com, qemu-devel@nongnu.org,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2020 at 07:02:08PM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Add a few examples of xattrmaps to the documentation.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  docs/tools/virtiofsd.rst | 50 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+OtGAACgkQnKSrs4Gr
c8htDwf/YGHHmPe3DtThJiExnFnADbQqRo9XIjltlLuqGklmBHNuccQQpBJyGTPc
UIDEeRoARRRDkNP4n2+blbUQ8EhBdZcG8GdUhVWJVKrvHUbazAKK6IzSgCi//Je0
Otcg4jVMkicZPawUDLQmTOYZEwyAob06Ie0nN43CS8kLD9zAxptZeq2XssSh36Zj
vDqDdNqrmrTTHUu5jP1m0IgeUYhml9hi2Zc5UowTup5nUi3J22V/LO6rsegPfTmk
3/qqad6wChpduKY2nfAClOMEZZ+9JuOTV055dku44T3dZ2B/jXqUYsPJzP0IKiOM
qbd7jd7BWeb0NZuXrDX8k307rRl7ig==
=k8kN
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--


