Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760D8C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 23:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB80212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 23:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTxEUWrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB80212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLEYv-0006My-5W
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 19:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLEXr-0005Vb-Tu
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 19:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLEXq-000497-26
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 19:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600905088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zsgkTIojpFBvyqkfM6cpIwxNdonYzKVZ789P4w5uR3g=;
 b=DTxEUWrKgDIdkGqE91aVaIirqDda7ielz3sdJ5SGfml0LLEkWlnaC7FFKx/fswLn2Zj9Gj
 0zMF9ZLj1+ItipsJJcWA1NNxQqFMEyXdCU3MP0yWCKy3hygE04veTnAq5WeFNF8JvcFLfm
 BMCpm3al5OK6latfz8MV3WHQdZt+ajM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-tB7W-LnkOBCbIXPcZHEzUA-1; Wed, 23 Sep 2020 19:51:26 -0400
X-MC-Unique: tB7W-LnkOBCbIXPcZHEzUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD2EC1DE06;
 Wed, 23 Sep 2020 23:51:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D43B12C31E;
 Wed, 23 Sep 2020 23:51:23 +0000 (UTC)
Date: Wed, 23 Sep 2020 19:51:22 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 25/38] qapi/gen.py: add type hint annotations
Message-ID: <20200923235122.GZ191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-26-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-26-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Tg5qL4DubmxJEzuM"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
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

--Tg5qL4DubmxJEzuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:48PM -0400, John Snow wrote:
> Annotations do not change runtime behavior.
> This commit *only* adds annotations.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/gen.py | 102 +++++++++++++++++++++++---------------------
>  1 file changed, 53 insertions(+), 49 deletions(-)
>=20
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index cb2b2655c3..df8cf8271c 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -17,7 +17,7 @@
>  import errno
>  import os
>  import re
> -from typing import Optional
> +from typing import Dict, Generator, List, Optional, Tuple
> =20
>  from .common import (
>      c_fname,
> @@ -32,31 +32,31 @@
>      QAPISchemaObjectType,
>      QAPISchemaVisitor,
>  )
> +from .source import QAPISourceInfo
> =20
> =20
>  class QAPIGen:
> -
> -    def __init__(self, fname):
> +    def __init__(self, fname: Optional[str]):
>          self.fname =3D fname
>          self._preamble =3D ''
>          self._body =3D ''
> =20
> -    def preamble_add(self, text):
> +    def preamble_add(self, text: str) -> None:
>          self._preamble +=3D text
> =20
> -    def add(self, text):
> +    def add(self, text: str) -> None:
>          self._body +=3D text
> =20
> -    def get_content(self):
> +    def get_content(self) -> str:
>          return self._top() + self._preamble + self._body + self._bottom(=
)
> =20
> -    def _top(self):
> +    def _top(self) -> str:
>          return ''
> =20
> -    def _bottom(self):
> +    def _bottom(self) -> str:
>          return ''
> =20
> -    def write(self, output_dir):
> +    def write(self, output_dir: str) -> None:
>          # Include paths starting with ../ are used to reuse modules of t=
he main
>          # schema in specialised schemas. Don't overwrite the files that =
are
>          # already generated for the main schema.
> @@ -81,7 +81,7 @@ def write(self, output_dir):
>          f.close()
> =20
> =20
> -def _wrap_ifcond(ifcond, before, after):
> +def _wrap_ifcond(ifcond: List[str], before: str, after: str) -> str:
>      if before =3D=3D after:
>          return after   # suppress empty #if ... #endif
> =20
> @@ -121,40 +121,38 @@ def build_params(arg_type: Optional[QAPISchemaObjec=
tType],
> =20
> =20
>  class QAPIGenCCode(QAPIGen):
> -
> -    def __init__(self, fname):
> +    def __init__(self, fname: Optional[str]):
>          super().__init__(fname)
> -        self._start_if =3D None
> +        self._start_if: Optional[Tuple[List[str], str, str]] =3D None
> =20
> -    def start_if(self, ifcond):
> +    def start_if(self, ifcond: List[str]) -> None:
>          assert self._start_if is None
>          self._start_if =3D (ifcond, self._body, self._preamble)
> =20
> -    def end_if(self):
> +    def end_if(self) -> None:
>          assert self._start_if
>          self._wrap_ifcond()
>          self._start_if =3D None
> =20
> -    def _wrap_ifcond(self):
> +    def _wrap_ifcond(self) -> None:
>          self._body =3D _wrap_ifcond(self._start_if[0],
>                                    self._start_if[1], self._body)
>          self._preamble =3D _wrap_ifcond(self._start_if[0],
>                                        self._start_if[2], self._preamble)
> =20
> -    def get_content(self):
> +    def get_content(self) -> str:
>          assert self._start_if is None
>          return super().get_content()
> =20
> =20
>  class QAPIGenC(QAPIGenCCode):
> -
> -    def __init__(self, fname, blurb, pydoc):
> +    def __init__(self, fname: str, blurb: str, pydoc: str):
>          super().__init__(fname)
>          self._blurb =3D blurb
>          self._copyright =3D '\n * '.join(re.findall(r'^Copyright .*', py=
doc,
>                                                    re.MULTILINE))
> =20
> -    def _top(self):
> +    def _top(self) -> str:
>          return mcgen('''
>  /* AUTOMATICALLY GENERATED, DO NOT MODIFY */
> =20
> @@ -170,7 +168,7 @@ def _top(self):
>  ''',
>                       blurb=3Dself._blurb, copyright=3Dself._copyright)
> =20
> -    def _bottom(self):
> +    def _bottom(self) -> str:
>          return mcgen('''
> =20
>  /* Dummy declaration to prevent empty .o file */
> @@ -180,16 +178,16 @@ def _bottom(self):
> =20
> =20
>  class QAPIGenH(QAPIGenC):
> -
> -    def _top(self):
> +    def _top(self) -> str:
>          return super()._top() + guardstart(self.fname)
> =20
> -    def _bottom(self):
> +    def _bottom(self) -> str:
>          return guardend(self.fname)
> =20
> =20
>  @contextmanager
> -def ifcontext(ifcond, *args):
> +def ifcontext(ifcond: List[str],
> +              *args: QAPIGenCCode) -> Generator[None, None, None]:

IIUC, this could simply be "Iterator[None]" instead of
"Generator[None, None, None]".

Anyway,

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--Tg5qL4DubmxJEzuM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9r33cACgkQZX6NM6Xy
CfMldw/+JPF+gErKk6sRk80kTrj5UaKWsKje6FmwjSemP49eiz9qkj//w2CD0CHf
dn5EFIq88dZ+W8aiXV+IA11sSBU1p4yG4ne7qq2G7yHlzv33pe3TMb7ATAB/URH7
tGAfXn5slPyTufKA6xHjrM9L9ptebTV23u5hyISTlanjeQCBmciph8w591wE43eT
yomt7t1ZEPJNluZvGIvcM40erxBE6RE0r5BRPYMFiMuRqp4KhmJgxw8XwkHMIyab
K6Dr4lFBsA6ntY9xtLTIRpgUdqyxtZxMM2CWWDWieafClXA/m1TTmNrCySRRnXtQ
7EfiE2upkx5JjD6ehAMyCutx7MvZZ9dEgjctUsjMPl9aCwUhH+Xnq/YdXA9Cx1Bl
G18DtILGm6HXvDg1qjEE/j+YUF+ojhnW8aZ0RpFiuYZDR7PyZOyVAIqBGqYTgy3K
zPZ2k9HBJMLWA4gIfS2XCRsNFguh3wkEDQyb+MGQZApgOsJaq9ZJU0MAjj6q0sAS
6oxJ0psACpv8sONPpfR0HUDH95fWXSsGcKjugQmfkVNmnToivPtYJnWBaFp+kXvp
wni9d18mR+ftii2rtjGtYP42YU4FbWwjZxULmvcgKeg7h0ZzaGMI48odR32idlHd
2IAbjRHsUQYUYRGWlm9HxmqSl69Gjc7Efx3keLcS6SDM+eS6aKY=
=+s4k
-----END PGP SIGNATURE-----

--Tg5qL4DubmxJEzuM--


