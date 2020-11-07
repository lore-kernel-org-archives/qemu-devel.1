Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB833C388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 04:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0540E206D5
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 04:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVXLksI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0540E206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbFm1-0005Z9-5k
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 23:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kbFlT-0005A6-Ud
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 23:23:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kbFlR-0003A2-G9
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 23:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604723023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FE/2adVCk+nAF63DFa9Jp3NIb6DTQg8UJdiCPchNwvs=;
 b=YVXLksI+rcdKkZ3BMNP9d24YAGxBIjjIuNCS/8BLfkEOMXpA/l5xn4LCTwCDrXitColN34
 JdjXnpjjyT6J6B7/DfQCrkO07PNCvbLs0oJ9mTSL/0hbwgTdAR7itoryWbt911YEgJNIe9
 YHUyaLOp/m6EoiZidyH5jGPjbc+AHQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-59yTEdnZNHasQmAT2r8vXg-1; Fri, 06 Nov 2020 23:23:40 -0500
X-MC-Unique: 59yTEdnZNHasQmAT2r8vXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC3A742380
 for <qemu-devel@nongnu.org>; Sat,  7 Nov 2020 04:23:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-47.rdu2.redhat.com
 [10.10.112.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 05AA35C1BD;
 Sat,  7 Nov 2020 04:23:38 +0000 (UTC)
Date: Fri, 6 Nov 2020 23:23:37 -0500
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 06/11] qapi/introspect.py: add _gen_features helper
Message-ID: <20201107042337.GB2208@localhost.localdomain>
References: <20201026194251.11075-1-jsnow@redhat.com>
 <20201026194251.11075-7-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201026194251.11075-7-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 22:10:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 03:42:46PM -0400, John Snow wrote:
> _make_tree might receive a dict or some other type. Adding features
> information should arguably be performed by the caller at such a time
> when we know the type of the object and don't have to re-interrogate it.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+mIUYACgkQZX6NM6Xy
CfObSA/6AiVUW/FOGE84LJMKiu4MTxIRk0GUZZLtQcYyun275o41vbtWAjtMj7/Q
B99MmyOa3VYJE2i0oxdKltnWD85N9pXYDQD8FnSiLNH/SRzIr9S9kYLACvAVkiG3
PZP0FsnOY3W+n0yYcSpaZ6Lpgda+b188k9c5xq3w6l1YvvcI052PTMDBqUzX5b8x
kvdJtXKtOL8/6A2B6FEWbptvUYENMncTcik7OGEpPETICyfALekQATr75Vv07bzr
SjShOAMKdWcnSvtevcX/NP7l/CwvGhMwMQbYDXP6MsXvO1hEvebRQE4C8hAA/ZrA
9cN6CzVbs8eXwkUallvvwJDNliR4rn1NvH0aKXVcoq+EM6zo7HMTWhOBg4ig0j+S
1gAOykDnRdFHTLsZbGZ7OH/xH8DfyQcrDwMEame9cPqy/Afi5VlleqwKW8Qs17aa
UYCNz8aOYD8k5QgouvVa9+7DbXuSg2+aPeg2HDA1joi7/f4pumfQHhNFY3g0WVPL
2m6puqW1mXIKQTXXXSYQx8VpJsvtaAmPUPl6Zpbr0SLvJyklMV8kNNFAnkj8jBYN
K8ErJqYMUqux9QugM7ATRrznWwXyz1Wat4aXi8cWmnEv6f6B9/6kGBM/Q4tdl0SP
8t2u+uPgLyrjCuGJAs4Fii73oDOibl2y410dGyb1ImkJI+XWw50=
=JE+R
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--


