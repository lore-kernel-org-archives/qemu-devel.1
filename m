Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF64C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 22:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8835E20848
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 22:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMZCYT05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8835E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Ff0-00086H-Pd
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 17:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j9Fdu-0007df-5l
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 17:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j9Fdr-0001ud-V6
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 17:03:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31493
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j9Fdn-0001n8-KI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 17:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583273021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sp6YvkJSSaudtBjuyIVA/eHRNunav+tgYRyj2BL+RXg=;
 b=IMZCYT057VDOFz5UPUfgtiV2YUEa8ZCsHiPfw9LlRYxJUGfXq31yiWG4Xl9IISxDNH/I5V
 exRXpqiLdkAh3WL+1Cs6sP5xdWQFP3FyHfpjT8h7guq2OkuDJEEw5GP/TD7qvnwWeIWy9X
 csSgfrYt70XhJp41s9Y/ujZaNiub3NA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-GA1B0yE6NZGK0jsdjNgc5A-1; Tue, 03 Mar 2020 17:03:30 -0500
X-MC-Unique: GA1B0yE6NZGK0jsdjNgc5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E1F3107ACC4;
 Tue,  3 Mar 2020 22:03:29 +0000 (UTC)
Received: from [10.10.120.212] (ovpn-120-212.rdu2.redhat.com [10.10.120.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0ADA15D9C9;
 Tue,  3 Mar 2020 22:03:27 +0000 (UTC)
Subject: Re: [PATCH 4/4] qapi: Brush off some (py)lint
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200227144531.24309-1-armbru@redhat.com>
 <20200227144531.24309-5-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6b7e0d73-6840-3a6a-9d33-0adcec0d4c84@redhat.com>
Date: Tue, 3 Mar 2020 17:03:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227144531.24309-5-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: mdroth@linux.vnet.ibm.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/27/20 9:45 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

I wrote some pylint cleanup for iotests recently, too. Are you targeting
a subset of pylint errors to clean here?

(Do any files pass 100%?)

Consider checking in a pylintrc file that lets others run the same
subset of pylint tests as you are doing so that we can prevent future
regressions.

Take a peek at [PATCH v6 0/9] iotests: use python logging=E2=80=8B

Thanks for this series. I had a very similar series sitting waiting to
go out, but this goes further in a few places.

--js

> ---
>  scripts/qapi/commands.py   | 2 +-
>  scripts/qapi/expr.py       | 3 +--
>  scripts/qapi/gen.py        | 9 ++++++---
>  scripts/qapi/introspect.py | 2 --
>  scripts/qapi/parser.py     | 6 ++----
>  scripts/qapi/schema.py     | 9 ++++-----
>  6 files changed, 14 insertions(+), 17 deletions(-)
>=20
> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> index 8bb6316061..0e13e82989 100644
> --- a/scripts/qapi/commands.py
> +++ b/scripts/qapi/commands.py
> @@ -274,7 +274,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularCV=
isitor):
> =20
>  void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
>  ''',
> -                       c_prefix=3Dc_name(self._prefix, protect=3DFalse))=
)
> +                             c_prefix=3Dc_name(self._prefix, protect=3DF=
alse)))
>          self._genc.preamble_add(mcgen('''
>  #include "qemu/osdep.h"
>  #include "%(prefix)sqapi-commands.h"
> diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
> index d7a289eded..fecf466fa7 100644
> --- a/scripts/qapi/expr.py
> +++ b/scripts/qapi/expr.py
> @@ -35,7 +35,6 @@ def check_name_is_str(name, info, source):
>  def check_name_str(name, info, source,
>                     allow_optional=3DFalse, enum_member=3DFalse,
>                     permit_upper=3DFalse):
> -    global valid_name
>      membername =3D name
> =20
>      if allow_optional and name.startswith('*'):
> @@ -249,7 +248,7 @@ def check_union(expr, info):
>  def check_alternate(expr, info):
>      members =3D expr['data']
> =20
> -    if len(members) =3D=3D 0:
> +    if not members:
>          raise QAPISemError(info, "'data' must not be empty")
>      for (key, value) in members.items():
>          source =3D "'data' member '%s'" % key
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index e17354392b..33690bfa3b 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -45,10 +45,10 @@ class QAPIGen:
> =20
>      def write(self, output_dir):
>          pathname =3D os.path.join(output_dir, self.fname)
> -        dir =3D os.path.dirname(pathname)
> -        if dir:
> +        odir =3D os.path.dirname(pathname)
> +        if odir:
>              try:
> -                os.makedirs(dir)
> +                os.makedirs(odir)
>              except os.error as e:
>                  if e.errno !=3D errno.EEXIST:
>                      raise
> @@ -261,6 +261,9 @@ class QAPISchemaModularCVisitor(QAPISchemaVisitor):
>              genc.write(output_dir)
>              genh.write(output_dir)
> =20
> +    def _begin_system_module(self, name):
> +        pass
> +
>      def _begin_user_module(self, name):
>          pass
> =20
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index 0cc655fd9f..b5537eddc0 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -10,8 +10,6 @@ This work is licensed under the terms of the GNU GPL, v=
ersion 2.
>  See the COPYING file in the top-level directory.
>  """
> =20
> -import string
> -
>  from qapi.common import *
>  from qapi.gen import QAPISchemaMonolithicCVisitor
>  from qapi.schema import (QAPISchemaArrayType, QAPISchemaBuiltinType,
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 340f7c4633..abadacbb0e 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -282,8 +282,7 @@ class QAPISchemaParser:
>                  doc.end_comment()
>                  self.accept()
>                  return doc
> -            else:
> -                doc.append(self.val)
> +            doc.append(self.val)
>              self.accept(False)
> =20
>          raise QAPIParseError(self, "documentation comment must end with =
'##'")
> @@ -492,7 +491,7 @@ class QAPIDoc:
>              raise QAPIParseError(self._parser,
>                                   "'%s' can't follow '%s' section"
>                                   % (name, self.sections[0].name))
> -        elif self._is_section_tag(name):
> +        if self._is_section_tag(name):
>              line =3D line[len(name)+1:]
>              self._start_section(name[:-1])
> =20
> @@ -556,7 +555,6 @@ class QAPIDoc:
>              raise QAPISemError(feature.info,
>                                 "feature '%s' lacks documentation"
>                                 % feature.name)
> -            self.features[feature.name] =3D QAPIDoc.ArgSection(feature.n=
ame)
>          self.features[feature.name].connect(feature)
> =20
>      def check_expr(self, expr):
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index e132442c04..cfbb9758c4 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -19,7 +19,7 @@ import re
>  from collections import OrderedDict
> =20
>  from qapi.common import c_name, pointer_suffix
> -from qapi.error import QAPIError, QAPIParseError, QAPISemError
> +from qapi.error import QAPIError, QAPISemError
>  from qapi.expr import check_exprs
>  from qapi.parser import QAPISchemaParser
> =20
> @@ -96,14 +96,14 @@ class QAPISchemaVisitor:
>      def visit_end(self):
>          pass
> =20
> -    def visit_module(self, fname):
> +    def visit_module(self, name):
>          pass
> =20
>      def visit_needed(self, entity):
>          # Default to visiting everything
>          return True
> =20
> -    def visit_include(self, fname, info):
> +    def visit_include(self, name, info):
>          pass
> =20
>      def visit_builtin_type(self, name, info, json_type):
> @@ -576,7 +576,7 @@ class QAPISchemaObjectTypeVariants:
>              assert self.tag_member.ifcond =3D=3D []
>          if self._tag_name:    # flat union
>              # branches that are not explicitly covered get an empty type
> -            cases =3D set([v.name for v in self.variants])
> +            cases =3D {v.name for v in self.variants}
>              for m in self.tag_member.type.members:
>                  if m.name not in cases:
>                      v =3D QAPISchemaObjectTypeVariant(m.name, self.info,
> @@ -1098,7 +1098,6 @@ class QAPISchema:
> =20
>      def visit(self, visitor):
>          visitor.visit_begin(self)
> -        module =3D None
>          for mod in self._module_dict.values():
>              mod.visit(visitor)
>          visitor.visit_end()
>=20

--=20
=E2=80=94js


