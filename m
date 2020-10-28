Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADFEC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 22:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A414B20731
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 22:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbptPhGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A414B20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXuF9-00082v-Jf
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 18:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXuAW-0004zc-Ps
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 18:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXuAU-0002zH-54
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 18:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603925022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NeHFsJpg4GqKD/sIf/C4nx4owDvCn+JmqQiRZPxTWeA=;
 b=HbptPhGeYVe6ZIZVZikf79HTgC0ux84OCqEBRACZEAyTJhuaAlgwA/sc/qHCMJH4nPnxuD
 RMbtikozvjozpzytKpR1fQeVfVBNuxueWk6Xu/urTXT5abTZ/buy6yoFLZW3I/I3KJok01
 TToz5xrPQYbyuC5pAE7WcuUTt/BGZy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-a9hZTgqmMmWZpM8K-ZhJXQ-1; Wed, 28 Oct 2020 18:43:40 -0400
X-MC-Unique: a9hZTgqmMmWZpM8K-ZhJXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF485186DD37;
 Wed, 28 Oct 2020 22:43:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B459D76642;
 Wed, 28 Oct 2020 22:43:31 +0000 (UTC)
Date: Wed, 28 Oct 2020 18:43:29 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 12/15] python: add mypy to pipenv
Message-ID: <20201028224329.GE2549351@localhost.localdomain>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-13-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020193555.1493936-13-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 03:35:52PM -0400, John Snow wrote:
> 0.730 appears to be about the oldest version that works with the
> features we want, including nice human readable output (to make sure
> iotest 297 passes), and type-parameterized Popen generics.
>=20
> 0.770, however, supports adding 'strict' to the config file, so require
> at least 0.770.
>=20
> Now that we are checking a namespace package, we need to tell mypy to
> allow PEP420 namespaces, so modify the mypy config as part of the move.
>=20
> mypy can now be run from the python root by typing 'mypy qemu'.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+Z9BEACgkQZX6NM6Xy
CfOvKA/9Eng89eGC4+rJlFfwz1InXlj6h6EdaCubvo4NaL6xWWrmvelGgHBwFZGf
RgYKWQdYdWLIT7B8J/pTKPFBwg/qM6Sm+bNrc2jHbC6ftIzEeMh3ifI+dDtPN3PJ
jiqkuXWbK3PybPlus6jWbQQWgRUwj70G6LFJUI7MbwbMZMAxWhWFwL1PR8Jzc018
97AVMACNajl+l1TcxSYnJ8O5PfxTZ0mHwAVO7MNJLR1iOcciz9OvIZnAzybkaxYM
JAo2ZVUuJVNXOxH+s10m/vCu5wUcRJODn70f3OIFiUaeKHrmnlB2FlRBhhTu5vlI
nI1CSWWtJjw4t18gz4JBz7t/NH9tQfwAB/1EilXK2HcqYsq1untzMMvfVOquJ4U2
lOcYdc+VLwldTdxSSTMIStZPYrd6Xk5dxwxS/7K6O4lCgy522/Dic8LxscttFh+b
3HwFfcJKubZx9/yJYnbHHnlhRvJBoywq8uMyIHMznLULfIB0KaJpk0FriHMjVpMF
QupUZLR+/xnGL8spzdZoQux03k5xe4gkiX+xQAyLdEci5B6Daz0LFanPqYIhHhyj
qcNYyARy0On/DilRqE+YiFRErR9TfOV5Vw2LzbKTthLJYhO5LmTWRl4eYJYWyqJG
CVgO37R2x9xwafl63TSEnueML5RfxIASJE5t7oCTuPRoKREbaz4=
=bBib
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--


