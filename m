Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80BEC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2A421927
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2A421927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtvW-0003hL-MC
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iAtt2-0001cy-9T
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iAtt1-0000sA-8N
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:42:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39684)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iAtt1-0000rj-1r
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:42:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4D46A10DCC82;
 Thu, 19 Sep 2019 10:42:06 +0000 (UTC)
Received: from localhost (unknown [10.36.118.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CC345D9CC;
 Thu, 19 Sep 2019 10:42:03 +0000 (UTC)
Date: Thu, 19 Sep 2019 11:42:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190919104202.GP3606@stefanha-x1.localdomain>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-15-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eAnxKwVhzStH6fSc"
Content-Disposition: inline
In-Reply-To: <20190918231846.22538-15-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Thu, 19 Sep 2019 10:42:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 14/22] libqtest: add in-process qtest.c
 tx/rx handlers
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
Cc: Thomas Huth <thuth@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--eAnxKwVhzStH6fSc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 11:19:41PM +0000, Oleinik, Alexander wrote:
> @@ -830,6 +832,9 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
> =20
>  const char *qtest_get_arch(void)

Maybe this should be per QTestState just like big_endian, but the global
qtest_arch variable is okay for now.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--eAnxKwVhzStH6fSc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2DW3oACgkQnKSrs4Gr
c8i35AgAiA6pKrmgTet/BoWn+A2KFwuD3mVV4uYSKVYhrI+vVO6LN5bEj0mvSEhc
UkVEONf5HJKmin2kzkmXhOdPRI8XobHUgZZLYonCd5xot20G3SGDpaI2S5DQ34IT
oGv8MkyJafEIakKgpmABrb0Y84OGLK6HXnA+BTe6Q3KHcAL23DtznzokyRoTBagk
Yk8oCgYHZZ4VM4IAWzHY19zomgAIC7QcasrXL7OyyR9IAA84vZXRh8eZnCRIO4W1
GHp7jmMeo0j2QK3OST43YJzdaMsyAfjoTZnNLGiSBTuynbD3A7MAiU0hVnh3PTZ+
voTEpr0xVRA1kvD471XZ69NXNytomw==
=F4oS
-----END PGP SIGNATURE-----

--eAnxKwVhzStH6fSc--

