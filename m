Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACD6C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B73A2311E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECU4Gfon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B73A2311E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWG0-00057D-3V
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 14:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWEO-0004Hn-KF
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 14:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWEL-00013T-Qf
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 14:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600973072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NN5IFaAIoRrQwehRNtOqwtJ2RJ+BGO49lPhrvp4w8ko=;
 b=ECU4GfontqudsQGRtXgOLEhYjqPmiJ+k+de9nobRFsrXItEZHup5Nl7CfJglgdCoCMcd+C
 vTM12fXneq7Zv37OsulSalsT1piX7CTB0GkYUr5MBpuulK1Ob4r/QMWZlWb22LM7e5Vz/B
 TBNY8z94uudHrQ2xXf/lpU1ojkda8mM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-QhVDj2AXOpu08j7VV6eOug-1; Thu, 24 Sep 2020 14:44:27 -0400
X-MC-Unique: QhVDj2AXOpu08j7VV6eOug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9EE2801001;
 Thu, 24 Sep 2020 18:44:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C22675D9D2;
 Thu, 24 Sep 2020 18:44:24 +0000 (UTC)
Date: Thu, 24 Sep 2020 14:44:23 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 29/38] qapi/gen.py: delint with pylint
Message-ID: <20200924184423.GE191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-30-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-30-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hNrJFWHEm0TKGkuH"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
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

--hNrJFWHEm0TKGkuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:52PM -0400, John Snow wrote:
> 'fp' and 'fd' are self-evident in context, add them to the list of OK
> names.
>=20
> _top and _bottom also need to stay class methods because some users
> override the method and need to use `self`. Tell pylint to shush.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

With the commit message change caught by Eduardo:

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--hNrJFWHEm0TKGkuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9s6QQACgkQZX6NM6Xy
CfMPVQ/9Gc/U52/HC4lBD8N0SyM2fHNVIb8VRoAoBm1dBx54D5OF7uj/jBCGRSEi
v7fQ6AWHue/VlT1pbepHHJL8dp2UEviVYoG3X+5sgipdvKEHHZ/OvorA55gZkfKO
6QKh0B8fs2HbxNDam8IEErEjQz7V87DgtPYmN43NHGuXFBR4vUaTTccH10z1HUkX
QSVTprTtrL2xTuj6yOL2IIsn/ve2+xVTEjIErCNdSyB2XEPSh9ND2tJuf2poCRfc
fLgXsisJGv1JD2BeAt5WiY0I5Qh+qmfPK+11TUGaPM3Lgq33c4YckWrkl7lvEyaQ
5GsGhyKprdhN9gIfA78sq0qd4OIt6nK1t23ZY+ljJKSuO2oHx56elww+3l6bTMYa
dSJEZSWtt72Yrusyx3o5ONddZgweJ+mvRfIMG3Kr7k5bRCnK54IgZQOwfA1X1Qz+
2SFce611HIyr0jqn6g/ml3IgHx8szegItTiq/mc1AyrlmVNomAN/m4T8I0LWtN3l
smd/b7DWwsHd7trWw6In9RPE2AOk3E4AI8NK3iJN2No0317ordakl4XIXYy9t45K
oluIcRM1j6Fefd4N+xCtRjcszX5ECDnborwZRV2xOSmzmW15sggSzkkZg+SA8GAj
tAOmOI98Fu3IOB7Mzmr0CnqBCoEM8H++O/KQ1NKxEgDQzSZ8ihY=
=7fh9
-----END PGP SIGNATURE-----

--hNrJFWHEm0TKGkuH--


