Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AFFC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC72D21D91
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMkqbJf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC72D21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWmx-00040N-2i
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWdu-0005L7-Ke
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWds-0004dn-V8
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:10:58 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600974656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hHmqMQxfZbi331nK7t2+GBJb5sQnYkDrc+8VoKpFrQs=;
 b=PMkqbJf0OjP/D+PprGpfxuSKrwkjSNjKXbNCJoiDzgpyyEIG+lNbskb+vKXBiJikA6RyJ5
 gV75qSsGD61ooKMggc3LjkvlMdPY00AbMFfyRHtocNueIvJ9jvWX0ZQwQy8NZ+onV0fHJJ
 zKwqonwVsgIukLGEkyzqwYBNR13AQxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-mKrKzXQvOJ2RdQnoKUFF1g-1; Thu, 24 Sep 2020 15:10:51 -0400
X-MC-Unique: mKrKzXQvOJ2RdQnoKUFF1g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F22F1084C9D;
 Thu, 24 Sep 2020 19:10:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BFF39CBA;
 Thu, 24 Sep 2020 19:10:49 +0000 (UTC)
Date: Thu, 24 Sep 2020 15:10:47 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 36/38] qapi/visit.py: assert tag_member contains a
 QAPISchemaEnumType
Message-ID: <20200924191047.GH191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-37-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-37-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="796bG6sDp7z5YuPV"
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

--796bG6sDp7z5YuPV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:59PM -0400, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/visit.py | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index 4edaee33e3..180c140180 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -22,7 +22,10 @@
>      indent,
>  )
>  from .gen import QAPISchemaModularCVisitor, ifcontext
> -from .schema import QAPISchemaObjectType
> +from .schema import (
> +    QAPISchemaEnumType,
> +    QAPISchemaObjectType,
> +)
> =20
> =20
>  def gen_visit_decl(name, scalar=3DFalse):
> @@ -84,15 +87,17 @@ def gen_visit_object_members(name, base, members, var=
iants):
>          ret +=3D gen_endif(memb.ifcond)
> =20
>      if variants:
> +        tag_member =3D variants.tag_member
> +        assert isinstance(tag_member.type, QAPISchemaEnumType)
> +

I'd be interested in knowing why this wasn't left to be handled by the
type checking only.  Anyway,

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--796bG6sDp7z5YuPV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9s7zUACgkQZX6NM6Xy
CfMLCA//QurFS0HxA3j6rx2JHbQfHgsot8fkbF/LJFbdHaaFhUXmog+3NFzct19T
jri6WfXojlmYEJmbwlRyKS60CYtiDPPv2imVcKAQks31lVYXyMj/QgpsvGFDqa5r
N/Gr6aNDFBSQBFuLj4JNUSKOZOUimSJkalluETQp+3W3BFptDS/CyY4DlQZtmt7m
LTWBYtD2oBSu4pJvRnjrAc6YbIDU2NjGj03h/PJG3BYtfacZw4GuAoHANXkBTCh0
Y5i+ZV6PpzSj67l3IRK6W0E4n/Dotgul4By+L2OT/mUG7XC43UseckggaA3WfYNr
r1MHxRYDUZg5q1/HfWH9mzX/3VxVCGGJY2sIjN/v7juguStUnlAaRwP8GSLnaX3X
HqusMA+LR8sQTZxU/faw3k95QXrPSI3yVp/Dt7Het85cYKEAFk8jwFR2tlPnsMe6
sjaGrZixQQVOzEbOtXxfVehmSOqst58edbzEbzXG5Qqfnfoler31/r+lOeCTprGi
RrOZr4oGjE6zk9Jn+55fGwRDLIfNyGlLj/mKYFaI1OZCYac/mk/IeRvooRJzlCvE
ea2y67xV6pVRg4nZdlklbpXCi9Go3zewy02f98NvkYtdbENFByGEE7mtYB3AtlBU
ig/yPrjE5VzWazKYz9W+4dMAo9jpC/V2oY84W37Tt2j+p4L9YiQ=
=09En
-----END PGP SIGNATURE-----

--796bG6sDp7z5YuPV--


