Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9FEC2D0A8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 02:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FDAF208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 02:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEntmzpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDAF208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN5i8-0000f3-MS
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 22:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN5gk-00075e-Ij
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 22:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN5gi-0003tK-RD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 22:48:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601347700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PhwEuQcVxO9XxmWfKSzxhAM07aFaou7oJRsIpmtd58M=;
 b=XEntmzpxpeKpHrC7jD6xlJ1aLRfXmMGr8mjshe3oKYNhpY3jbMquqzHiaD2byEM8dbwi1K
 FEd4Pb4jqqgY8P50FTRcUenw1n/VmJeygAQaqevR1jCYsw2DozyejnPVNkyUf4c6JEiBZn
 k8Lo6RYRVphX4o3tCmF/i1+PFqTohF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-zL_OPeB3OGeRWMEtQqdy8g-1; Mon, 28 Sep 2020 22:48:17 -0400
X-MC-Unique: zL_OPeB3OGeRWMEtQqdy8g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB143107464E
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 02:48:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40E3310013BD;
 Tue, 29 Sep 2020 02:48:16 +0000 (UTC)
Date: Mon, 28 Sep 2020 22:48:14 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 02/47] [DO-NOT-MERGE] docs: repair broken references
Message-ID: <20200929024814.GB700868@localhost.localdomain>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-3-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200925002900.465855-3-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 24, 2020 at 08:28:15PM -0400, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9yoG4ACgkQZX6NM6Xy
CfNvxhAAsPmJuvoTfEVt6IvHzv86zOUB1RR4W0mmF4Szgvf+KRtllq941EE1AzEz
29jRhin7csz8SivPQtHYRhEuK/RjCcQ6+Kk0MNJaWhxmQUFZCb474FVwtIWz22wn
Sb7PNox7ancpFT26vIyGL1Uzy9b8/FdiUGubglGnpGVQfzO8/UEDmG0kt+l/aKD3
OZ9YceScV/Dg2NbHs9VWeXBGSLtlFpea7+nSbasoJC81WjHMrPMYSE1rki7xXaOy
M0789iWw2CKW+X/QLLGNXdxhj0/9SwFWqDsn2dcHhHmlhtsKRIiOmHQ/Nb4ofDxB
ORbmGvnTGXqxzsxjkqeWG+I0FRdeafqPHQrbHZhblPCQDUGyWJSftB1wCIUGMZnc
8Cg4THSBiJkeOneJ4W/VtbQtOFYGCfnwv0ue++ZLYGZ2rYXXwXEXE5PSEvC+4D0H
vOOR2ACgHK1ACn3GxMru0PP3/7lDmzuMy/pvofPjJNH2d2KrmeC04JlDUfop2UXy
MG7er6EGWH7Xvu7nLrMGHYDFOefnve8LUFH/EGFOYx3QVGDsnka5oxmy0YpM4nqH
bEgGbb53F1oz+issjcDWVdYVhGCiXhLFiZs1Ka5Zeb6aes2NhlCzA2NBEc9vvBbr
eS450DsPnd2ZgIABW28WrzlivDECmMIfNC1gUyy4cDrwT6I9zlA=
=Lmnm
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--


