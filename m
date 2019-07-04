Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87772C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A64C218A6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A64C218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj2qO-00038e-V7
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 10:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59142)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hj2ny-0001Nm-LH
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hj2nn-0006kZ-Ql
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:33:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hj2nj-0006cE-Qe
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:33:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4D2B4368E3
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2019 14:33:09 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D8BB7D502;
 Thu,  4 Jul 2019 14:33:08 +0000 (UTC)
Date: Thu, 4 Jul 2019 16:33:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Message-ID: <20190704163303.329b034b@redhat.com>
In-Reply-To: <20190612114125.22060-1-berrange@redhat.com>
References: <20190612114125.22060-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 04 Jul 2019 14:33:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] qapi: report the default CPU type for
 each machine
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Jun 2019 13:41:25 +0200
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> When user doesn't request any explicit CPU model with libvirt or QEMU,
> a machine type specific CPU model is picked. Currently there is no way
> to determine what this QEMU built-in default is, so libvirt cannot
> report this back to the user in the XML config.
>=20
> This extends the "query-machines" QMP command so that it reports the
> default CPU model typename for each machine.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>


we probably need to allow feed it back to QEMU -cpu directly
for all machines (currently it will work only with a handfull of them)
something like:

diff --git a/exec.c b/exec.c
index e7622d1956..ea4d2d74a6 100644
--- a/exec.c
+++ b/exec.c
@@ -999,11 +999,14 @@ const char *parse_cpu_option(const char *cpu_option)
         exit(1);
     }
=20
-    oc =3D cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
-    if (oc =3D=3D NULL) {
-        error_report("unable to find CPU model '%s'", model_pieces[0]);
-        g_strfreev(model_pieces);
-        exit(EXIT_FAILURE);
+    oc =3D object_class_by_name(model_pieces[0]);
+    if (!oc) {
+        oc =3D cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
+        if (oc =3D=3D NULL) {
+            error_report("unable to find CPU model '%s'", model_pieces[0]);
+            g_strfreev(model_pieces);
+            exit(EXIT_FAILURE);
+        }
     }
=20
     cpu_type =3D object_class_get_name(oc);

> ---
>=20
> Changed in v2:
>=20
>  - Fix qapi docs version tag
>=20
>  qapi/misc.json | 6 +++++-
>  vl.c           | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 8b3ca4fdd3..9e2dedd938 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2018,12 +2018,16 @@
>  #
>  # @hotpluggable-cpus: cpu hotplug via -device is supported (since 2.7.0)
>  #
> +# @default-cpu-type: default CPU model typename if none is requested via
> +#                    the -cpu argument. (since 4.1)
> +#
>  # Since: 1.2.0
>  ##
>  { 'struct': 'MachineInfo',
>    'data': { 'name': 'str', '*alias': 'str',
>              '*is-default': 'bool', 'cpu-max': 'int',
> -            'hotpluggable-cpus': 'bool'} }
> +            'hotpluggable-cpus': 'bool',
> +            '*default-cpu-type': 'str'} }
> =20
>  ##
>  # @query-machines:
> diff --git a/vl.c b/vl.c
> index 201144b162..b2de329bd2 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1519,6 +1519,10 @@ MachineInfoList *qmp_query_machines(Error **errp)
>          info->name =3D g_strdup(mc->name);
>          info->cpu_max =3D !mc->max_cpus ? 1 : mc->max_cpus;
>          info->hotpluggable_cpus =3D mc->has_hotpluggable_cpus;
> +        if (mc->default_cpu_type) {
> +            info->default_cpu_type =3D g_strdup(mc->default_cpu_type);
> +            info->has_default_cpu_type =3D true;
> +        }
> =20
>          entry =3D g_malloc0(sizeof(*entry));
>          entry->value =3D info;


