Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74EBC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FBD22400
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7OvRWa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FBD22400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX4tH-0006su-63
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 11:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX4qL-0003nd-Mu
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX4qH-0004iD-W1
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603727724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jn9ArxiDxlQI8PA/H6fuobDqYuJm7LNsvrLlxOgd8jQ=;
 b=i7OvRWa854wab9+BEdQ7ZfAK6W1rHxYfuxBlmCEZ8j8RJPEdMcH58MHXYx8gFF9yjS5wGn
 NvriTlK24EB1zRWtaykq7XCm14g+xslZtJHvBcD2pFxkNvKQTA2FQkPsnEwRKukM0rU3OQ
 Jlcx8aewQRxYRqAL/P1hyHHjV/NTOeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-bxRwYQdVM7CrLn--Xqdrtg-1; Mon, 26 Oct 2020 11:55:22 -0400
X-MC-Unique: bxRwYQdVM7CrLn--Xqdrtg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B509107B26E
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 15:55:20 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA8F560BF3;
 Mon, 26 Oct 2020 15:55:13 +0000 (UTC)
Date: Mon, 26 Oct 2020 15:55:07 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v4 0/5] virtiofsd xattr name mappings
Message-ID: <20201026155507.GH52035@stefanha-x1.localdomain>
References: <20201023165812.36028-1-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201023165812.36028-1-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
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

--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2020 at 05:58:07PM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> This is the 4th cut of an xattr name mapping option for virtiofsd.
> It allows the user of virtiofsd to define a fairly flexible mapping
> from the view of the xattr names the host fs has and the ones that the
> guest sees.
>=20
>   The hope is this allows things like:
>     a) Different selinux attributes on host/guest
>     b) separation of trusted. attributes that clash on overlayfs
>     c) support for privileged xattr's in guests running with an
>        unprivileged virtiofsd.
>=20
> There's no apparent standard for this kind of mapping, so I made
> it flexible by specifying a mapping rule in the option.
>=20
> Prefix's can be added (selectively or globally), xattr's can be
> dropped in either direction or passed through.
>=20
> v4
>   cleanups from Stefan and Vivek's reviews
>=20
> Dave
>=20
>=20
> Dr. David Alan Gilbert (5):
>   tools/virtiofsd: xattr name mappings: Add option
>   tools/virtiofsd: xattr name mappings: Map client xattr names
>   tools/virtiofsd: xattr name mappings: Map server xattr names
>   tools/virtiofsd: xattr name mapping examples
>   tools/virtiofsd: xattr name mappings: Simple 'map'
>=20
>  docs/tools/virtiofsd.rst         | 161 +++++++++++
>  tools/virtiofsd/passthrough_ll.c | 474 ++++++++++++++++++++++++++++++-
>  2 files changed, 632 insertions(+), 3 deletions(-)
>=20
> --=20
> 2.28.0
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+W8VsACgkQnKSrs4Gr
c8gSDQgAvoLJAzqUAZWE3ZAPKZQ4CxxMbubcbZmw7ayb4k77FlxwYxJNcxJ1Z3as
ngcZY3KVCxcm9ra7fpxttaegIhdAb3p6r5lliABfltlIMlopjqRnEg5QhgVmmGoP
wfn+OvL06ST886JUSAUcnSRHz4WFG8JEF6vL6rwQySx0HFhNnP+CVcJDb/AQ/go5
CmEOoeTn18eZKty29q2EsIp+EgQuO1tWI4IXZzYeF9xMOTJkml4T5DTcbY4n+x6u
fqSLTGZa+pQlhl7gWBCUYWKfi2Xk2fxsetAIQuqYg7I8sIvIry6130mzerXfnF0H
Gh+TXTddfBABSWlftNTGvZCmQ74nEQ==
=+dAG
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--


