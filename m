Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0848FC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E02F21D91
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crDiTJRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E02F21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWm4-0002w0-Db
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWiR-0000OY-Rs
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:15:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWiP-0005Gk-06
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:15:39 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600974935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sFQ5yngiEp/yI+ad11W7jfTwFjVnYeu43dTS0RMq/8M=;
 b=crDiTJRoXzixsuuuRXipFo31OrsbyvL8RaISjPBFN1lT2qIkrCYsmMxreh2JF48MfJVgpe
 iTSB7iHu8XPepp1HOHVHwGeH5v78KfIyJQ76A1KUjIfhuPa2x+ZEfO0dftN9BmvW7qZShS
 /bpumtvTKzCGriCsEYsTlsT2aovDheA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-A7PwVUGeO6Od9iZvDh2BkQ-1; Thu, 24 Sep 2020 15:15:33 -0400
X-MC-Unique: A7PwVUGeO6Od9iZvDh2BkQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 257C1802EA5;
 Thu, 24 Sep 2020 19:15:32 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92EF55D9D2;
 Thu, 24 Sep 2020 19:15:28 +0000 (UTC)
Date: Thu, 24 Sep 2020 15:15:26 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 38/38] qapi/visit.py: add type hint annotations
Message-ID: <20200924191526.GC346482@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-39-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-39-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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

--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:01:01PM -0400, John Snow wrote:
> Annotations do not change runtime behavior.
> This commit *only* adds annotations.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9s8E4ACgkQZX6NM6Xy
CfM2ng//WN32IQWCJcdUti3CmN86i0r9UBVtIquC3FxlvZQbiUPwEIkP7GE8Ta0R
6C8WWxzmaXrquR7psHffZ4FQ+xZYa6OtDUYsaAfXcHqoP3qAAG09NyuZ5BAH1Sjh
Sft5ylstTNyRoBeUd4ATWiHFEupmMmw/jBuDEXEN/uBD9QKkFPHU+5YhlASBWi6Z
1jdodMwZyycpql4m33sK/MpxsIESapFeQCRwERtAowuLd7fGuiFcrciN5l9l5+Hg
G7/A0/hN7S+6bfNYFQwfIlPl1tN6ES4Ge+WpPRmLt0uzfMprYWo7r8YPSW3QoSWh
Q56dEUOE40wIEWph7omMB4bxcpKWbyClKS6pEBY0OXPGp7D5OCRN7XefeLGIk8ZA
sBB6mOuWlrL40RaKdJhxDBX3L4Y1Ia2pMls41Qbe/04LI7wqAei4A4WFFxuzSctq
mxbgB5okeD7YoZJt+lwL29Yu3Xvj/ESm0XG4RTILAxphyMvSaElXtTUfi8Em8JtG
BwWNXc4JojHLESmTfGr2plOWZ3195wXBw1CrqlQ6GsY4lOeRm/PDco5tubjkBSob
Tc3cDAxpWfw6sxw5M6znItMDohEVsLutlt8LFQyDAenhchrEeapjWtx5DQSkdKqV
fuphfq7L2jl8tl+KnH+p1RHVGpKTojs832crB9Di1YjqfyJYxQo=
=8mbu
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--


