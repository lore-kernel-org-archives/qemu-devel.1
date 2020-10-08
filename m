Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C723C04EBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C192145D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJtBqJtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C192145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQT1C-0000OT-B5
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQT0O-0008Jv-5Z
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQT0L-0003XE-9I
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602152311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dTsAr4L86S0toDmX0b/7rWXFq99GSpHLg1+rR/o5ino=;
 b=hJtBqJtGXhs12qXHdVbAlvjr+sXlOiXi2vXfnomvJk4dIQXAf1kuDE6SrTdiklRV5FUSuR
 JTU1REH6KFkfmTbqVD9WEx+FNIfnkX9DUBrK9LEoKowEMaYMwrFG4h9TWSTUJOZ4XkoOOP
 u2Vn63Ro4r9q1xwCHxWaAf5hIrCzFsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-f1-XfL1OMtmIbNi7UxwPkQ-1; Thu, 08 Oct 2020 06:18:28 -0400
X-MC-Unique: f1-XfL1OMtmIbNi7UxwPkQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFC49106C0D9;
 Thu,  8 Oct 2020 10:18:07 +0000 (UTC)
Received: from localhost (ovpn-115-14.ams2.redhat.com [10.36.115.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54F535D9D5;
 Thu,  8 Oct 2020 10:18:07 +0000 (UTC)
Date: Thu, 8 Oct 2020 11:18:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] block/nvme: Add driver statistics for access
 alignment and hw errors
Message-ID: <20201008101806.GB17253@stefanha-x1.localdomain>
References: <20201001162939.1567915-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201001162939.1567915-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2020 at 06:29:39PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Keep statistics of some hardware errors, and number of
> aligned/unaligned I/O accesses.
>=20
> QMP example booting a full RHEL 8.3 aarch64 guest:
>=20
> { "execute": "query-blockstats" }
> {
>     "return": [
>         {
>             "device": "",
>             "node-name": "drive0",
>             "stats": {
>                 "flush_total_time_ns": 6026948,
>                 "wr_highest_offset": 3383991230464,
>                 "wr_total_time_ns": 807450995,
>                 "failed_wr_operations": 0,
>                 "failed_rd_operations": 0,
>                 "wr_merged": 3,
>                 "wr_bytes": 50133504,
>                 "failed_unmap_operations": 0,
>                 "failed_flush_operations": 0,
>                 "account_invalid": false,
>                 "rd_total_time_ns": 1846979900,
>                 "flush_operations": 130,
>                 "wr_operations": 659,
>                 "rd_merged": 1192,
>                 "rd_bytes": 218244096,
>                 "account_failed": false,
>                 "idle_time_ns": 2678641497,
>                 "rd_operations": 7406,
>             },
>             "driver-specific": {
>                 "driver": "nvme",
>                 "completion-errors": 0,
>                 "unaligned-accesses": 2959,
>                 "aligned-accesses": 4477
>             },
>             "qdev": "/machine/peripheral-anon/device[0]/virtio-backend"
>         }
>     ]
> }
>=20
> Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
> v2: 'access-nb' -> 'accesses' (Stefan)
> ---
>  qapi/block-core.json | 24 +++++++++++++++++++++++-
>  block/nvme.c         | 27 +++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9+514ACgkQnKSrs4Gr
c8iQPwf/dYaRHZ1WgY5/Et+Ohq75oZT+Q+DAZjrBz5r8E4cTEG67XFD2svOQtJt5
11GCAX3i1qNLNad2Z74FbgToGAadn4YeFwj3XceT3Q4tYlBmJgUO3AsGtk1D7L5q
/AfaTOAs95LZFwbixQndFXoANFkjqZF7RY34vaPfLcix5dK8sh8qC9I8nVWkgCd3
j52GbgfEMm+P3yauTKENGFpvi5AO/gl9XZtSKUhe5kFZjLAWAolBTeRdjUD9MzRD
wAoX2H6H5y7JExNMiiCSNi2+ORQml7lrk9qYp27SUfIhGuyafLK9cmFw2grV4qdP
2n3IXWvumRs2oKDf9GKs+hSwUqQUmw==
=5Y+x
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--


