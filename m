Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B78C35257
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 20:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D16E321BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 20:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YptOac9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16E321BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKSdP-0000T0-Oe
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 16:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kKScI-0008QG-Id
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 16:40:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kKScG-0007xY-Vx
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 16:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600720852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aBZrZBdxy0uRDbgQbHOPII2mOycn6EjLnbI2yDCIqeY=;
 b=YptOac9MqpgD9wJvHlihhTSMv9MvPonxBjPBEO2QaMlIaKppo9R9/7bO8ROgpge/n6GYgo
 QwiHpvnzmlayiidIO0Fq0FS/+XJopIUY8ZZxWXIegIXwFQ3yMbXOES55ytlFZ2XgQRjdfS
 t5nfxgwsNdRoNCwOxs+5vn38y6zYwi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-VnxwiDjxOC-C2ZeNrolVPw-1; Mon, 21 Sep 2020 16:40:48 -0400
X-MC-Unique: VnxwiDjxOC-C2ZeNrolVPw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD8D481CAF8;
 Mon, 21 Sep 2020 20:40:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3698C10013DB;
 Mon, 21 Sep 2020 20:40:46 +0000 (UTC)
Date: Mon, 21 Sep 2020 16:40:44 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 4/6] travis.yml: Drop the default softmmu builds
Message-ID: <20200921204044.GB15763@localhost.localdomain>
References: <20200918103430.297167-1-thuth@redhat.com>
 <20200918103430.297167-5-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918103430.297167-5-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 12:34:28PM +0200, Thomas Huth wrote:
> The total runtime of all Travis jobs is very long and we are testing
> all softmmu targets in the gitlab-CI already - so we can speed up the
> Travis testing a little bit by not testing the softmmu targets here
> anymore.
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Acked-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Acked-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .travis.yml | 14 --------------
>  1 file changed, 14 deletions(-)
>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9pD8wACgkQZX6NM6Xy
CfOWAg/+ODbTORndxznCxNU8OXB1Xw1fJXjbDGA7tnJFbqrn8ZlRlypulKchLtSm
65vbajHPfvypaqI+EDO6tBzkB5/EPoHZMJmO0ZjuRe2OYEKRUmUDW6EUWpRTmNPT
b10uZMC7y43WIKhMAT1zezLSZvTdXkz/Eanv4YSkKlp70GsILkKLVBSR5N3glrTA
EYY0664NHsGY/EC8o/p6NJ6P4jdVVanBetQtmC8JnuN4OcCiJu0HPcGxzOU09jWN
iT+FquR6KfP4bcyOFDqWpRybuBzBwKbslfyZuTr/8L4MqqqJNY9IAZMOh3Do006C
zTX69LzJmMlLSwoawxCZsKXekzWFdb36miUUxZVW7aE7HU0/iDC2h2KZJKnbspwS
C43jZbT/AVt/PWC9K9T4fQrEu45FgjhKVpmJ/+R6qoiJtmI8vUL4xiHGHg1NdI/u
Y6UUwRi+o6VmxIazwBBzYX1ZOA6ApHbPkUVtlySvhJJXgOKEyaR+Y+epS+nPDWMq
I8oEXd6IZtFIKbHvlCh8XRSP/etuoYVkW0nyzLta84fvwMfm95KzoOylxWX+58u8
6NmJbxOgYqWgOb8zS+M8CxMFvtEz+wU5aSBJ3LJJmaDnHQfVNgamYT2EjmAoIOgv
x/ASgulR8GIv4BnzckOKr758VGAThMGKqK6aLNw/jDGe46UHLL0=
=uqDe
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--


