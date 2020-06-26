Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E68C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BECA320775
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjmiTKHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECA320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joljT-0001pJ-W3
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1joldt-0002BM-SU
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:31:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45894
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jolds-0003IC-9E
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593167491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ft8Z4dX6ZzqcvPBujF9qwjPG+Yt/DkxFH7/lzR9S8hE=;
 b=WjmiTKHqnbb6TLo/8HlH4t8D/+0mDcYmdItHgSeeofj3HMVtUHywRHH1Lmpg+lNJVupFun
 ym76nP+4eL4HGV8ATOmWJ/XeIPLpcvaAMW+TjIZQ8Ln5/MxIsYAR27TK8+NyskvTqCW6uV
 X8tazhq60SV76G7Afesk+ORi2AbfhUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-Plu1kwG-NqiJNWDaWksJFw-1; Fri, 26 Jun 2020 06:31:28 -0400
X-MC-Unique: Plu1kwG-NqiJNWDaWksJFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07A4D10059A1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 10:31:28 +0000 (UTC)
Received: from localhost (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3AE680882;
 Fri, 26 Jun 2020 10:31:24 +0000 (UTC)
Date: Fri, 26 Jun 2020 11:31:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/3] virtiofsd: Terminate capability list
Message-ID: <20200626103122.GF281902@stefanha-x1.localdomain>
References: <20200625162929.46672-1-dgilbert@redhat.com>
 <20200625162929.46672-2-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625162929.46672-2-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 05:29:27PM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> capng_updatev is a varargs function that needs a -1 to terminate it,
> but it was missing.
>=20
> In practice what seems to have been happening is that it's added the
> capabilities we asked for, then runs into junk on the stack, so if
> we're unlucky it might be adding some more, but in reality it's
> failing - but after adding the capabilities we asked for.
>=20
> Fixes: a59feb483b8 ("virtiofsd: only retain file system capabilities")
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl71znoACgkQnKSrs4Gr
c8hFwgf+KpmNHkGjRfZRdBpqgYqmm6P8GwGbZQHUIRJWvgwrKVZy1QG68IYMD34P
o8/LC4nbhjNFD+zHNdiPDZlSY3x32OgmifFJN5wvcJZdL4+UMoqULFusgv2ORZ8j
76qnUsJpFX/VZu3tM8l5S/ABByMvJc0fVRIRwMME3u5M9F3us7vjgBzSTGS3I0b9
hEIO7VTSgaxfxX7dlzli7iNhVxKH9wpIcP3jzT4IpxHnABay8XpG8KJPHmZ8Epy6
pfhKkkXHiHe8ijVH6haSMy43QYqWAAp1p5/WtklfttXqbAxXvIdeWXMckCBgoZ14
VkRbGmuJpZS7/yM1hDtmoQZpv+woLg==
=U6FJ
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--


