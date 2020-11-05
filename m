Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD0CC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274442071A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpjPrYPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274442071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kadfu-0002Zg-VR
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 06:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kadfC-00029D-PA
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:42:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kadfA-0004uR-Ts
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604576562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lC48rY3G8FprNaK8G1jsVkp+PmmXMxlNaUnrRISox9g=;
 b=SpjPrYPs2rP4OWsjl4sOdVh1rtkzCxMeF6F4D+nIS+r0/ZU+PnAAZ4+CtAe/sO6VBLYT+b
 O6Xv6XHLgJ7Fbfl7Lsrvwe2rcw35oEOmGUv4tS3AE7eI3zb5sifhKKmVCTwlU1PWnINlyz
 HkHeuaeI7z5dQqxmj3T6YWJYcz64/cE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-dP58eRpwPdmP_gpji0-diA-1; Thu, 05 Nov 2020 06:42:27 -0500
X-MC-Unique: dP58eRpwPdmP_gpji0-diA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A64FA57207;
 Thu,  5 Nov 2020 11:42:26 +0000 (UTC)
Received: from localhost (ovpn-114-186.ams2.redhat.com [10.36.114.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74BA821E98;
 Thu,  5 Nov 2020 11:42:18 +0000 (UTC)
Date: Thu, 5 Nov 2020 11:42:17 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201105114217.GD462479@stefanha-x1.localdomain>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <20201102132844.332f680c.cohuck@redhat.com>
 <20201102145626.GA186617@stefanha-x1.localdomain>
 <20201104080745.qvpofinyni2wprq2@sirius.home.kraxel.org>
 <20201104164010.GB425016@stefanha-x1.localdomain>
 <20201105064724.qd55txohwbfpvdsg@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20201105064724.qd55txohwbfpvdsg@sirius.home.kraxel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
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
Cc: John G Johnson <john.g.johnson@oracle.com>, mtsirkin@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2020 at 07:47:24AM +0100, Gerd Hoffmann wrote:
> > > > Yes. If you are creating a custom device that no one else needs to
> > > > emulate then you can simply pick a unique URL:
> > > >=20
> > > >   https://vendor.com/my-dev
> > > >=20
> > > > There doesn't need to be anything at the URL. It's just a unique st=
ring
> > > > that no one else will use and therefore web URLs are handy because =
no
> > > > one else will accidentally pick your string.
> > >=20
> > > If this is just a string I think it would be better to use the revers=
e
> > > domain name scheme (as used by virtio-serial too), i.e.
> > >=20
> > >  - org.qemu.devices.e1000e
> > >  - com.vendor.my-dev
> >=20
> > This is the Java syntax.
>=20
> I think both android and ios use that too, for app naming (but maybe that
> comes from java).
>=20
> > Go uses gitlab.com/my-user/foo and I think it's
> > nicer but I think I'm bikeshedding.
> >=20
> > Is there any particular reason why you prefer the reverse domain name
> > approach?
>=20
> Having "https://" at the start is odd, especially if we don't require
> that the given URL returns something useful.  Other that that I don't
> mind that much whenever we use go-style or java-style strings, with a
> slight preference for the latter for consistency with virtio-serial.

Thanks for explaining. We can discuss the exact format in the next
revision if there are opinions.

Stefan

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+j5RkACgkQnKSrs4Gr
c8gDBQf/f25a5nzNbNrhmTjHjGc4qz0hledCJ3Th3BuQqZHkRypjbNtQmvw3nh5c
vkhFI/+80GaIsdXIZENOlgVb9I2reJT1WWujyCa4UnJ0sariGY6ZPqivFTrNSotI
cZoXjeN9fxGI00NxQhMPfNmUeTKiKo5BHU0thImwMPGUIwJZPFMHWr0ndA/AnFEt
k6E82m+N785mpiQu8wn8dpr9IpiayxxcrGreXHy3dblsVeGBxsMKWmHsUFyf61Iv
zc7Lv/e73QokGZwyPooBnWZm0Urkm0tgthIjAGjg9yXKmM76L7OllTGU3WfoBnj6
3J4Z3lbgKsYpNbMTUiEPKzgrz02qzA==
=QGC9
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--


