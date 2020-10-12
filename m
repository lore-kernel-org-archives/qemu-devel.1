Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D56EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 03:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A124E20757
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 03:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUZHWqT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A124E20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRoKB-00050g-Jp
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 23:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kRoJQ-0004Zs-EA
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 23:15:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kRoJN-0003Lo-6Y
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 23:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602472543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dim6xNlcCui+hczfnszbSDA/YsuVqy9D1hcYi8TvWjQ=;
 b=HUZHWqT//FH7we4Js1dWilfsbR9D9jZWq+4DHzafyBWz/TdhmFTid7sZBYZ7EGa/zB7vB0
 bH7PQOJgGchO/rGda5II6gfSb9QdowSKX4NF3XZDvZIsxwiNqIA8wevnVZE1mveiEoRjt6
 1EIR8N6I1JJu0e8irEERu0A/f8ycA+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-VZyKEl1oP6aFhPyABdoxkA-1; Sun, 11 Oct 2020 23:15:40 -0400
X-MC-Unique: VZyKEl1oP6aFhPyABdoxkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4F0418C5200
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 03:15:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37AF76EF7B;
 Mon, 12 Oct 2020 03:15:36 +0000 (UTC)
Date: Sun, 11 Oct 2020 23:15:34 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] docs/devel/testing.rst: Update outdated Avocado URLs
Message-ID: <20201012031534.GB887538@localhost.localdomain>
References: <20201010080741.2932406-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201010080741.2932406-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 21:16:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: avocado-devel@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2020 at 10:07:41AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Avocado documentation referred returns 404 error.
> Update the broken links.
>

Thanks!

> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+DylQACgkQZX6NM6Xy
CfNWcw/9EJxencU6gfeDizBjKmmFu4AeLZ9HQMagRT4doVJYbi5Ul6e2+gh3UxY6
UM3KphSqJT9PDGje+k1pj9JLJ9b1dx+QEBHVsxFxvdPIrREDeBd/fUCXgCIq/8CC
xBvemhHuA13xmgrVqHHYLNRB6YFepL9pw4G3oB8W62CWiUJzQvXd0qQWYGCmHNE0
itCP7U8zRj5z1hdzZ6pI/I2ZBjHocwFLAXcCsKJoMuwLFCCrjXoAOpOCnLwdzp/v
HmzoRMweucfSiYCqsVp6WZ6KyGqnB02axrT2kYetXymgu4q0skEp6aADW0gZCdDe
Jl8K+ZVHyj7T5uySqzO/2apxBwD1EC9jHKN6wlTjAtrEuIcHQharCq8uxeS4+OgM
lo+7+SCA9z5Ek7HTVZ5qVqGLlwOuAkieJHPNvR6EPcKIzvucjQORMLZjl/K0zYmf
fsdZ40XLzvicBhWhiXXBX6JdSqCyHwWKZ3yOawcKpT7N45h84O73NEOaWH0ihIWl
mmBRj7Fd5E7xTu9lDPMFBF0fmIiUvr7GB/PtxMD+A4nk7mYlZTdglqBVplFfQg9i
q3GMOH4Tl9YBfeb/f4X5velfjNJrdZ2OrLG7U9Gcg1k8ib6llk1aOKibpMwTbLxM
fMGXxgBIm0vXHcV3quq6nmSQVmEtwVIHreJ9/P6HWWpmBtjcpPM=
=Cg2Q
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--


