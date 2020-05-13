Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6137CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50B6204EA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LW+1h80v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50B6204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYsIN-0007pj-VR
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 10:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jYsHm-0007GC-9b
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:23:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47151
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jYsHl-0008GJ-Ey
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589379780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9x9TkzH8Dgz+/crwUdJg5lEphBmRSN3yhYChYSmeAgI=;
 b=LW+1h80vTZ+da/oWF1Y0y+GNX5GUBBXDR4E+OBRlUDmDvd2e4GN6Czv/QXefq8/vAWovbT
 uNaIHhUC1zljiB8sgy7XVtdwE8giTgcvXITjRmSpWb/an8Vs1RvrSGq9FWlQ1uLuCVZ2Jp
 HhTXrYiwys6VGlf0E6ks+JNU5KFaFw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-c48pkinhMN-OxMSRvNzfNA-1; Wed, 13 May 2020 10:22:57 -0400
X-MC-Unique: c48pkinhMN-OxMSRvNzfNA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86FC98730B3;
 Wed, 13 May 2020 14:22:56 +0000 (UTC)
Received: from localhost (ovpn-112-208.phx2.redhat.com [10.3.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D3D46B8C5;
 Wed, 13 May 2020 14:22:55 +0000 (UTC)
Date: Wed, 13 May 2020 10:22:55 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/1] machine queue, 2020-05-13
Message-ID: <20200513142255.GA577771@habkost.net>
References: <20200513140057.576234-1-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200513140057.576234-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Peter, note that my PGP key had expired 2 weeks ago, so you'll
probably see a few signature check warnings.

On Wed, May 13, 2020 at 10:00:56AM -0400, Eduardo Habkost wrote:
> The following changes since commit de2f658b6bb422ec0e0fa94a49e476018602ee=
ea:
>=20
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
00511' into staging (2020-05-11 14:34:27 +0100)
>=20
> are available in the Git repository at:
>=20
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>=20
> for you to fetch changes up to 70b6d525dfb51d5e523d568d1139fc051bc223c5:
>=20
>   hostmem: don't use mbind() if host-nodes is empty (2020-05-12 12:48:57 =
-0400)
>=20
> ----------------------------------------------------------------
> machine queue, 2020-05-13
>=20
> Bug fixes:
> * hostmem: don't use mbind() if host-nodes is empty (Igor Mammedov)
>=20
> ----------------------------------------------------------------
>=20
> Igor Mammedov (1):
>   hostmem: don't use mbind() if host-nodes is empty
>=20
>  backends/hostmem.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.26.2
>=20

--=20
Eduardo

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEWjIv1avE09usz9GqKAeTb5hNxaYFAl68ArsACgkQKAeTb5hN
xaaeZQ//Vp6uDxlci+1JAkgMYIvjHJD+y67xtPZyDqiE15MLel1kFfqFPD1mCKPW
xghYAndXwGMm5df562Vs0XE6pAedKWijmYo7ZJGBJguaqaZlPm9M0tj4l1Ug7fik
a+Ylwliami3Rn60c4Y4XhZC8X+duboys8S4WMWsMVIaXAiK5g9ffck9VvuyNAGo6
GLKfkYeKRd9Sd91omsSyegEtP3/ffmQC5WKidSyiCRJrjnEeSKyl7aG5Ux8lsTDa
gXQv10wXdAE3HfyAQFdreqLH20Jxwk4IgOoiRpwlKXPo8q2z5mGQ5GqPVjP3ueZE
3Y8HOq0TniSDi/HYzBxNVY3bfyaUQnv00jYm3hht0qxtfPtlOdtqN+v3Ij/Ahsrb
gmytT5UWkxI+JKWFKCRdNlm4+ogYlnE961Gs7CgLBhNfesaSSYgEJOaLixHflE1a
J14ZbHjfnmfizy49a8SVLfNosF/rPdQVOGTdwWf8/FKomowjLsrbtj5EFdGCblwD
jiUJ8NGN5RTlJu/UO10kCnKMxvMLAaOpZxS4e8DJDpARe8CYEehCKaeNDCbND4Pv
pRUIuab4KVnRRdmP/COFs8FfwOfKGGeIQNXcXTSD0fahBfcyBq/qSwiLBNvOX+t+
aOyBd4QXRNRjig/e2PmqgPC4P2szXIqPRPjcs4UobS/6HUv5oCo=
=dhgX
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--


