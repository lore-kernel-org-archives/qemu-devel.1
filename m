Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BBEC4727D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF3320BED
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4odo7CB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF3320BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLASZ-0001Vb-3Y
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 15:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLARZ-00012Z-0y
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 15:28:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLARX-0007li-HP
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 15:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600889319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LnjZ5EhywDhKOv3dcaCOoyu7NX3AoWe08F/aQR+SLKI=;
 b=h4odo7CBnkmGMMBiR6VyaT49Ig24t/TJDnH97gul+t2rbmFr02S1d2kpbGUcIoboaccGQz
 CKOtZqYL5IJo+9MbNINebc6qkJBysUjIZ3qqx4ZnTCVOhFwuj3Fi/jB7DXly0j/UgxuIFr
 q0JAAI31b6cvc7vIyVzW4boK2KyndgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-B_PmSAvQMlq5jDXNXtvN7w-1; Wed, 23 Sep 2020 15:28:37 -0400
X-MC-Unique: B_PmSAvQMlq5jDXNXtvN7w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A13A1074652;
 Wed, 23 Sep 2020 19:28:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E98919D6C;
 Wed, 23 Sep 2020 19:28:35 +0000 (UTC)
Date: Wed, 23 Sep 2020 15:28:33 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 13/38] qapi/common.py: add type hint annotations
Message-ID: <20200923192833.GM191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-14-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-14-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lRF4gxo9Z9M++D0O"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--lRF4gxo9Z9M++D0O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:36PM -0400, John Snow wrote:
> Annotations do not change runtime behavior.
> This commit *only* adds annotations.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--lRF4gxo9Z9M++D0O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9rod4ACgkQZX6NM6Xy
CfOTRA/9FLt65sGMV6db0fDY948LGtCKCkvJj7KjAiN4Ct96BWTWFSEjII2ODbUZ
mAxdo0hRZETJpAr50kIlGFw4aY/9aqQwWjHvrDQDT7Qfec+VIf5lYRtRGf7ekj6E
KpL5e4XPJLQCp66ihJoO2E3f8Qf5uQz0QKf6DATasmvISvcOO1vxQDdEr7yfYWCS
CJGOfCNH2IXWPMhDX453t4gaXstW8PBYCID+D0Hmey5r4NiW0A2t2U0Cl+uNT8L9
8MTfzQMJOG23Z/rH8psFNh6XpVtgHDUaqqVoecjMdBhO4VbEpQl6F5VOCiI0XHFx
3fpw9TOUROF1uG/BtFvDls/oRRzDTvP6vvMMTY4DExWTx12Ydw7LfEd3X92S23XR
t6CONUjOYJpiG5Cfg+c323m0xbaeY5JISIKhN1fITUB80BKfIkjF3yFfbNKsXlkr
PNoBmEfbx5aMAz05+J0V1Q8IlH9C9/NwtN11CcrLF84ArjbdDoRGYerHPtqzjNcv
7RLl8PEgmfCr1LsglbZb+RcSL5Mzm0PzuG1knqd5hjBq4Ql3wEoVpAtdBxZMB+ES
SwJ5un8JGd4xqonMf6b1/zot3bTarJ4uqxd9aIJ9KHrsJJnzQCz6gd3Dz91GlUTI
8YpmDI9w+xXdkdAxbuBhWTOhk2ev87F2gyHT+mIc4lz2xE5sBwo=
=CgNs
-----END PGP SIGNATURE-----

--lRF4gxo9Z9M++D0O--


