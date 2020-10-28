Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41963C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 22:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CE820731
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 22:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRNm8rK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CE820731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXuFD-00089t-47
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 18:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXuD3-0006fP-UA
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 18:46:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXuD2-0003Lz-Gk
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 18:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603925183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r6u+VkZ1H+kbLOnjVLZvY5kA3dx2p2dRohTCu8RAEjM=;
 b=eRNm8rK9ZYC0sTqjMMVIBwj/yxhGwaFs9VxxpJgu6ZEz3Nkxg5LsXSJ0vi3x6JPPG4yZl6
 n18xva3i9eJxuaoWFBzVhHSfD+gOfV/3S6KmtTC2IsHjQYl5AuDdrYjrFydIugJYlHM469
 KHnztGDu4bkA/UoU7mClKH3yyA0Gr+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-mNIyoc6HP_CzzLSKvp7Z7g-1; Wed, 28 Oct 2020 18:46:19 -0400
X-MC-Unique: mNIyoc6HP_CzzLSKvp7Z7g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C96011019624;
 Wed, 28 Oct 2020 22:46:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 711B15D9EF;
 Wed, 28 Oct 2020 22:46:13 +0000 (UTC)
Date: Wed, 28 Oct 2020 18:46:11 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 14/15] python/qemu: add isort to pipenv
Message-ID: <20201028224611.GG2549351@localhost.localdomain>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-15-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020193555.1493936-15-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="S5HS5MvDw4DmbRmb"
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

--S5HS5MvDw4DmbRmb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 03:35:54PM -0400, John Snow wrote:
> isort 5.0.0 through 5.0.4 has a bug that causes it to misinterpret
> certain "from ..." clauses that are not related to imports.
>=20
> Require 5.0.5 or greater.
>=20
> isort can be run with 'isort -c qemu' from the python root.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--S5HS5MvDw4DmbRmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+Z9LMACgkQZX6NM6Xy
CfPXbg/+MghIxWG5+ceiuPJ7MQW9XMwdB+8maJvZdSnzbnRsSe941YvA3pLOrIh2
Pd6EiJ351aQuq9pL7MrjefdGTnwqjGjHKBrxm020Lm9EcCPw10axoxiJHWyaOBKp
snVRp5tPsriZA6NswyObMLRqoAoYYhBQqCoaCSO/TSBo/jJ1QD6skl+WdgiBtPCW
uKxcm3hsqd4ApaZjvaoDc7DbKhp0WlfT6nd68RkXiEqC/tKUjqDeoTEDDfu0dnfE
6MiTi4/WGOWbAt0rtKbrV+b2VTYleZeT3sJAmDi8p3hw5+tMxAhMl4BNw1GLAVPd
2PW7nKImvDKLv++nEBZPIHbWsCUw0HaxEU+DIbOXfoNjzeVcE/39g1g9tryFDo2F
GWHmF06g89htNGt6BM4IvT3d8OPY+iIROaO6pvfRG+1NaqlNSoc3AJYX/KBu9IxQ
aVe5hgrpN3QaVhRT9OZQ/90qdXmpEhbHFGYC2qFKxJQ93zkcYAMW+C018yW/ng+Y
IX6oeMfbdHsQYgR1a38+Vac9ilrZoWJ5DyphGiVlxXGJEwZe/mcPdZyckdClsj3h
2t7oem6A137+gmkORkn4qXRoM+StD9VH3c8BIONyqXo1b3fwMoAH5UoI91pU47Vq
Fss6PwuhEWa5jV57f3Q7GicTk55Da6T4fDKLM+G44ieJ9QgQptc=
=6mfl
-----END PGP SIGNATURE-----

--S5HS5MvDw4DmbRmb--


