Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADC6C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1FD3208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVVsXuFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FD3208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN73t-0005q3-R1
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 00:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN73J-0005Lb-Ps
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:15:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN73I-0007qF-9N
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:15:45 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601352943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zqfc7pEYcrycIJ+3SLi9v8SZpATga4YRGBj5/+dXTQo=;
 b=BVVsXuFS0gMGdjNMLTM+2k8a53jHlp0pw0N6oE3BeRDYShcs2LChwZjlZyQJOUJ7ekLAG3
 VfH+DVrebDFbSNg82T0cos6r8wTb4t8hnD1evTW0WoLlOFxHh767BQEevkpr7ffYCjGEoF
 bYAIF5QubmMT05li+K+awqWHsL2Etfs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-H9zi6hEXN1WC8PBw9xKAOw-1; Tue, 29 Sep 2020 00:15:40 -0400
X-MC-Unique: H9zi6hEXN1WC8PBw9xKAOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAD10107464E
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:15:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F495277D0;
 Tue, 29 Sep 2020 04:15:39 +0000 (UTC)
Date: Tue, 29 Sep 2020 00:15:37 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 12/47] qapi: enforce import order/styling with isort
Message-ID: <20200929041537.GJ700868@localhost.localdomain>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-13-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200925002900.465855-13-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GlnCQLZWzqLRJED8"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 23:30:14
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

--GlnCQLZWzqLRJED8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 08:28:25PM -0400, John Snow wrote:
> While we're mucking around with imports, we might as well formalize the
> style we use. Let's use isort to do it for us.
>=20
> force_sort_within_sections: Intermingles "from x" and "import x" style
> statements, such that sorting is always performed strictly on the module
> name itself.
>=20
> force_grid_wrap=3D4: Four or more imports from a single module will force
> the one-per-line style that's more git-friendly. This will generally
> happen for 'typing' imports.
>=20
> multi_line_output=3D3: Uses the one-per-line indented style for long
> imports.
>=20
> include_trailing_comma: Adds a comma to the last import in a group,
> which makes git conflicts nicer to deal with, generally.
>=20
> Suggested-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--GlnCQLZWzqLRJED8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9ytOkACgkQZX6NM6Xy
CfN3AQ/8CDCZ+N9Qbm3ewlcjuTi8JsNz64EDRhCcfpg13pas8ssEFWWOOJ/NHEH0
wN9GjpWMyYF/DS3X0tbiRmMfNS6NWdqLLve9njx0YWU6kmm3ma8BXwQlC/oheMM7
xC3g9u+6nP1SZLqtM0s1HU+yzgIjVYeJDN6fa30mQMzFdEQtpyDOhsrLzgbCeqCd
m4tHcIdRLiaQoeM1cUprQCyNdgd8D1r04Hf+Ekp1NwxHfLQo08Cb47TunQ/hu3VQ
bbSfR9OtB0QxWpGWsgZVy5TpU+MDIEX9dOE/uFLcqYTjj2MVIoIuE/yu8VmGT7MN
+srehfhlwD6HUO7qAFbkBHLeqL1gQBqoMesQEbhB+r2M7cSH9hWxMuVXG8IyRbsQ
YjLCPpLomn/kyOiwayphFNT11hT36dJ9Su4mzT/cZq6ibYtu6MxfDwFl0BBntsYd
eJKNvWD3FL4LzaBZEax58574G3VO6gLZ/VAjFKx96f1FbFivNvs+UKzq/77FaR3b
++CtKlbolJ/m+bPOXOER+8WqJL4ymAzwbWVQzz3kvICwKy3oSN6rI8Iec+THPAC7
nCUzIZE/AGxZl0K6tVshOW5wnRNinmKTzrjLeNVWjoJidCMdPB1VEauReHCagP0L
79FXGUbQ7KB1ICu6C/ZTbzkB0RswBQtONI3utqri6xLqyvVCQ3U=
=NE1O
-----END PGP SIGNATURE-----

--GlnCQLZWzqLRJED8--


