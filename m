Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838C3C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 22:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DE420735
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 22:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOJRxqqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DE420735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXuEl-0007og-7l
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 18:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXu9g-0004Pr-VJ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 18:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXu9e-0002uK-VQ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 18:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603924974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cL6G8HGDdpQHsSJ49c60LwepBpbuI6T5XWQ2T0NjuA0=;
 b=gOJRxqqhSOnMsiIHRt+49MWSH4YaLxC2dEjVrlGRG5SIuZfFZ6BiqwYRl8SFLX1fk2aqHs
 1895s/5tTMqgczP16UUm6lqouocOLQXAU6TMBc4++WcE1Lzn+ZHyvIHWcrvaB7tB6857TU
 dYS108Kxr1XsrmUZ5kOFHuynzZhNfbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-fMrBg3qtOZyxO6fiy0G5lQ-1; Wed, 28 Oct 2020 18:42:50 -0400
X-MC-Unique: fMrBg3qtOZyxO6fiy0G5lQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98D83804B8F;
 Wed, 28 Oct 2020 22:42:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31FCD5B4B2;
 Wed, 28 Oct 2020 22:42:44 +0000 (UTC)
Date: Wed, 28 Oct 2020 18:42:42 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 11/15] python: move mypy.ini into setup.cfg
Message-ID: <20201028224242.GD2549351@localhost.localdomain>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-12-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020193555.1493936-12-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ben Widawsky <ben@bwidawsk.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Rohit Shinde <rohit.shinde12194@gmail.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 03:35:51PM -0400, John Snow wrote:
> mypy supports reading its configuration values from a central project
> configuration file; do so.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+Z8+IACgkQZX6NM6Xy
CfNivA/+OdLVuf86kOL0upsRce9xq1Y38cL6cdliGpPkzwmOjDOXw5jkWAtQEj60
prbFbNOp/gpdOREfvbnL8fxlf828zrTy9L+LmdBZvEw1LZMAZlpJw6BG8Wu2sDf2
SrMi81ISRwY6g/8fFT7DtwzoN/cWxzUowGvoNfsflXTrDL0lVIhb+I4x+wPJit5v
8LMv/ZpNQSB7TiDtifPQwfycMCCOC6Hv8VuVxS1MruGkUIB8JO/ESV540n8+FsI+
zeqwkySbHpTP4gEBWsCuX6IEWTD3SGw0P1LACK94P8dCQatbN+KDNdgCbwYuzojA
fah9xv8xrDzNgLsINnZvFBZyuF8YgX9PT7eDqeU4JhTf1wmXEnZ1E6j9iNr+1rmW
0GddBv0t62b2h8uszsgM4ANiXD0RoJ7mEM19pgoq89BVeTw4iiBsPfy8FvMeBqyd
xqdVOugBTTdEFS+SgamEs288miDPVja4u2iwk+zhqA68ufdnfeDyjXvJziFKVuU4
SjYs3EG6yi153C+Pd2wMphEbQRJ1R8N7OJl5d5GJqYsVJSLDOPsa8jMuXpN0+fr3
eEyAXNF4Sv9la65TJbo/Nl2U1DTJzvlRnhz1JjLqKUBvAXk7fAsRJmm7zn1mdhjD
AFuX3sTos/0Ru4Z4JN/MDhp2bjxTQC3mEwVTrc9r+wxTKN7DXq4=
=sf75
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--


