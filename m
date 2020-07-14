Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF0AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 923B320773
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxfZsBze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923B320773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvCR8-0005Oc-TD
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 00:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvCQP-0004SI-L4
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 00:20:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49721
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvCQO-0007dq-2B
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 00:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594700410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p6i250nFGdu2A20Ms2PLEnT1nrV7PGv9PirpChT/iL8=;
 b=TxfZsBzeVfQ4H1Q/DIIhZVc4D/j5ju4iJZJN4bQ1hR3BZo7WDhHYGS0wN27lKEAlCVQUQX
 8O9dFsvypzvqMWpyNe504JdqrvBfMq+zZ8LOqjW9Hno1IA5q3vRv82Lky7hbqAtwyh0luN
 34HQ7PlHH/Nrq26h6N/Isx6Ryz2a1Fc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-saOGRP5dNW-KdElSI82hEA-1; Tue, 14 Jul 2020 00:20:08 -0400
X-MC-Unique: saOGRP5dNW-KdElSI82hEA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 188631080;
 Tue, 14 Jul 2020 04:20:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F41215C6DD;
 Tue, 14 Jul 2020 04:20:01 +0000 (UTC)
Date: Tue, 14 Jul 2020 00:20:00 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 12/12] python/machine.py: change default wait timeout
 to 3 seconds
Message-ID: <20200714042000.GJ2983508@localhost.localdomain>
References: <20200710050649.32434-1-jsnow@redhat.com>
 <20200710050649.32434-13-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200710050649.32434-13-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UlxN1C6awaFNesUv"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:30:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--UlxN1C6awaFNesUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 01:06:49AM -0400, John Snow wrote:
> Machine.wait() does not appear to be used except in the acceptance tests,
> and an infinite timeout by default in a test suite is not the most helpfu=
l.
>=20
> Change it to 3 seconds, like the default shutdown timeout.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20

Well, for the acceptance tests, there's usually a test wide timeout,
but this is indeed a good idea!

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--UlxN1C6awaFNesUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8NMm0ACgkQZX6NM6Xy
CfP3Hg/8CU/AUQkvmH3xV7saG/csyI6Kxnw954y2z0HmcqM4reN1xCzLyR5XlBaK
SSs6A3KXzrzUqU3ZXbbDJQqF6FrphuO1X1XhiHbn7XSVf3UAeq8b+ttCcS5JzOt3
U165dbZrGFzmgs0h2skNalP0LpMTLvoRkb+r/lZ5XMUW1suvG2xzVcWX6ta0Lbcq
8CzV5v9KpA1bWzg0yuEVSspX2KviC7/EiRsOOwZz5mlxutmh2gqZJGgUme4pUbYE
JKHCjZg4IJNrEbTAhJb4bAqsE8JuQa8Glht2J9GlnBB2KV2ke7aYL6iX6U9Uq/9A
EdlUElYRbpXJDJG5SRiyZ5WEmNXeRYdwfzw3Tq7fvC8hWB9zr2ha4H8TB+3Qx5+B
gGQtNUYbrL8sUIlkknmKscepRjAdLhqntv0cuqCCMDfIf3CpQPCj+7bQJigO4/wz
OQrCMWjDjhGj40h28vyBH4TPcy8EsQNcx9f85rRBl0fIdkLjpoEoH0atfOntVTrU
NoBNpCDzAWrRPEW58QKq9YbmAiJCEmreTeytcVbMIiIO9Knaa4ePI2fHxV1R5b4x
lbbU+if1jxIHHawN5C4BHkIBPKz1oTv0BeU2jwN5nrP0yneDFKFbn+W13XlFj9gs
vK2VvKZnKYfCcnN1eDStVryWZZTbD0VXZv1dglU9p4zTEZe6Cxo=
=ROhS
-----END PGP SIGNATURE-----

--UlxN1C6awaFNesUv--


