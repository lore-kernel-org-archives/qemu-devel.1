Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C873C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 068BE2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068BE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIqzl-000689-HS
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iIqwP-0002fs-6S
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iIqwN-0005kl-Rt
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:10:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43564)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iIqwN-0005jv-LH
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:10:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CFC8C18CB8E0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 09:10:26 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-204-231.brq.redhat.com [10.40.204.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10C695D6C8;
 Fri, 11 Oct 2019 09:10:24 +0000 (UTC)
Date: Fri, 11 Oct 2019 11:10:21 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 0/4] qapi: Add detection for the 'savevm' fix for
 blockdev
Message-ID: <20191011091021.GC1979@andariel.pipo.sk>
References: <20191011085027.28606-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <20191011085027.28606-1-armbru@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 11 Oct 2019 09:10:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2019 at 10:50:23 +0200, Markus Armbruster wrote:
> Add 'features' field in the schema for commands and add a feature flag
> to advertise that the fix for savevm [1] is present.
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03487.html
>=20
> Based-on: <20191001191514.11208-1-armbru@redhat.com>
>=20
> v4:
>  - PATCH 1: New
>  - PATCH 2: Factor out check_features()
>  - PATCH 3: Factor out _print_features(), drop duplicated test
>  - PATCH 4: Shorten savevm-blockdev-monitor-nodes to just
>             savevm-monitor-nodes; tweak commit message and
> 	    documentation

Thanks for fixing the problems in 2-4, they all look good to me. Adding
a reviewed-by in this case would not be appropriate.

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAl2gRv0ACgkQHGwCByjY
1Gr7ohAAmXqbc9TaxV87ELX4ep5PPIqGrNQJ9E1wWrSatuTPMUKuJLaF4cQld7Mz
p/4eoykEDDz6DUs9/OeyTel2PykBsy4FyjTsvsVE8Tlz8pP/kbllDnRdEYAqth0/
xefgYdJPL5fj9vz6Sr+wv9emdtrBhNYPhcuQStf5Npo225Njs3N46LNbuIAUQb19
Tn7IrtJN0zYMJkbbOylNPmDWxSxIdf3GYo7/Ik7EmJGx5Wllt8rmNnT9h+AePvoo
KeYEavMVmNImK+pDyLwnBaD/sA57IXzUV1hfcxrWhaDceJQxHp2bNN5uw6Hwz0K+
WMD5/a2xTJnzoqeWWUqYOJUBd+QCAGhKzY5OYdvNZo7bYvrb3clWl0RYQUqXAlaN
5wzKGwX4zoHLvFqxyCSip4t2KYXIymZ/zj52pfA4Em382KBU5vaBTzvOQX4tJ3UE
G3hwPOrEXpYSKD2GNQ3bl1t7n/gqKfVka4WFgBvbjWXB+N/oGoSZjk631iTzSW7O
wylEq5Uq4Mx46hUmiCz/9YWDQO5VtQrb5nnHIE/g5yea3seQZjpjTLYMptVOckUY
/84U2ytApQ6LiR1IxSYt2w6JKV7MFeAqRkhBkVgpFh4797DIeQvMIxzhxkd/6gXg
eKUbcRPlsZUuuHMXyzvJ6zvubcIi9wW2d7/adtrMR23GtaitmAQ=
=HOB8
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--

