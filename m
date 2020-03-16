Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEB2C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA3520658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7bLA4Ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA3520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDurw-0004xi-Bx
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDtmS-0006YN-Qa
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDtmQ-00030F-Id
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:44:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDtmQ-0002xZ-B5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:43:58 -0400
Received: by mail-wm1-x341.google.com with SMTP id m3so19061924wmi.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gnrEwKmph2O8Xa5Sk8h8RucKLWSdRoTBZXZXHqiZGYA=;
 b=a7bLA4Htaul4fAExMJB2CEOA8v6TZEHMiFIlRmL6LrTg5uPuaBVx0Ow45CnqRRRVuw
 pjv0U5SuXmDXCYNj48jCt5PpiR1s8pPgcGz/5Qi0Lz2JVSLA0VVw++QX31ZGs0OPYEnu
 wlucVjDUHM2AiY+ZfxGGV59roudongLKzhmGaiP3FgyQfVy1XAg6NbsEXem3KdCXk0Bf
 3P8AlExkjR35XvvHB1BMKZSo1ffd0Zi2fVw/cwtTlRCwAmDKMPlLlTbxat2JOnh2QKTT
 3aJvuoGoRQGa9YSFyfY948bX3ctv/2jwzGVqnQNT3Ol+Ku11G3haBVmbEByAIldugfGG
 I/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gnrEwKmph2O8Xa5Sk8h8RucKLWSdRoTBZXZXHqiZGYA=;
 b=t/fG0yvxU0Y/sHEDOV5eiL/4qGfZigkfMtn05jq621v8LJty4Pecfp6SjRsOQxspk9
 dDGLqK+A3IgEBmNBXbziwyrUd2+m/zebXakeiMEAM0jdLBP+UO+AbQrhnN+DcgHdb1eS
 tS6Rq0NTFr7Fr/st7T7uX57RwX3iJAr1JNlYzUtMzRAlFcQ5LQ+xpeppvrkvSp1LtmID
 koZoLigPUPadfEWQehFNK4KqhfoMlOar5V2P8HfT1U/oQLWMmvaw45i3H9oziXs8R8T+
 WwLhcqjSTQlemXzmWSFj/g5rGxn1NzdhSzNsE90U04BxbUqGGor/x+r87Qg//IniPKFF
 7upA==
X-Gm-Message-State: ANhLgQ21J+kcpQXZ+uWLysup5Pi9V2gppQ+Q1m1KHWcoBCU4QFUO8PYP
 VRt2bR4BzLru+i6FKBRDgXRhzk3/jo6jd23Nm7Y=
X-Google-Smtp-Source: ADFU+vvOieXnM/bejz5Lw7QnKYvaoW053C+5U3a/Wfv1ixLZeFbK3yhHJFVbZIX4B4/XDpNuKGdnzcYrZur/FydlfQo=
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr283121wma.26.1584380636925;
 Mon, 16 Mar 2020 10:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-28-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-28-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 18:43:45 +0100
Message-ID: <CAJ+F1CJa_LKpnadL80ah4r+RGztKCKbQ7Hs=3AusM4adJOi_8g@mail.gmail.com>
Subject: Re: [PATCH v3 27/34] qemu-options: New -compat to set policy for
 deprecated interfaces
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Sun, Mar 15, 2020 at 4:46 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Policy is separate for input and output.
>
> Input policy can be "accept" (accept silently), or "reject" (reject
> the request with an error).
>
> Output policy can be "accept" (pass on unchanged), or "hide" (filter
> out the deprecated parts).
>
> Default is "accept".  Policies other than "accept" are implemented
> later in this series.
>
> For now, -compat covers only syntactic aspects of QMP, i.e. stuff
> tagged with feature 'deprecated'.  We may want to extend it to cover
> semantic aspects, CLI, and experimental features.
>
> The option is experimental.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/compat.json             | 51 ++++++++++++++++++++++++++++++++++++
>  qapi/qapi-schema.json        |  1 +
>  include/qapi/compat-policy.h | 20 ++++++++++++++
>  qapi/qmp-dispatch.c          |  3 +++
>  softmmu/vl.c                 | 17 ++++++++++++
>  qapi/Makefile.objs           |  8 +++---
>  qemu-options.hx              | 20 ++++++++++++++
>  7 files changed, 116 insertions(+), 4 deletions(-)
>  create mode 100644 qapi/compat.json
>  create mode 100644 include/qapi/compat-policy.h
>
> diff --git a/qapi/compat.json b/qapi/compat.json
> new file mode 100644
> index 0000000000..fd6f8e932c
> --- /dev/null
> +++ b/qapi/compat.json
> @@ -0,0 +1,51 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# =3D Compatibility policy
> +##
> +
> +##
> +# @CompatPolicyInput:
> +#
> +# Policy for handling "funny" input.
> +#
> +# @accept: Accept silently
> +# @reject: Reject with an error
> +#
> +# Since: 5.0
> +##
> +{ 'enum': 'CompatPolicyInput',
> +  'data': [ 'accept', 'reject' ] }
> +
> +##
> +# @CompatPolicyOutput:
> +#
> +# Policy for handling "funny" output.
> +#
> +# @accept: Pass on unchanged
> +# @hide: Filter out
> +#
> +# Since: 5.0
> +##
> +{ 'enum': 'CompatPolicyOutput',
> +  'data': [ 'accept', 'hide' ] }
> +
> +##
> +# @CompatPolicy:
> +#
> +# Policy for handling deprecated management interfaces.
> +#
> +# This is intended for testing users of the management interfaces.
> +#
> +# Limitation: covers only syntactic aspects of QMP, i.e. stuff tagged
> +# with feature 'deprecated'.  We may want to extend it to cover
> +# semantic aspects, CLI, and experimental features.
> +#
> +# @deprecated-input: how to handle deprecated input (default 'accept')
> +# @deprecated-output: how to handle deprecated output (default 'accept')

If this is going to cover something else than qmp, then perhaps it
should use a "qmp" prefix.

If not, then the CLI should probably be -qmp-compat.


> +#
> +# Since: 5.0
> +##
> +{ 'struct': 'CompatPolicy',
> +  'data': { '*deprecated-input': 'CompatPolicyInput',
> +            '*deprecated-output': 'CompatPolicyOutput' } }
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 43b0ba0dea..f575b76d81 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -75,6 +75,7 @@
>  { 'include': 'migration.json' }
>  { 'include': 'transaction.json' }
>  { 'include': 'trace.json' }
> +{ 'include': 'compat.json' }
>  { 'include': 'control.json' }
>  { 'include': 'introspect.json' }
>  { 'include': 'qom.json' }
> diff --git a/include/qapi/compat-policy.h b/include/qapi/compat-policy.h
> new file mode 100644
> index 0000000000..8efb2c58aa
> --- /dev/null
> +++ b/include/qapi/compat-policy.h
> @@ -0,0 +1,20 @@
> +/*
> + * Policy for handling "funny" management interfaces
> + *
> + * Copyright (C) 2019 Red Hat, Inc.
> + *
> + * Authors:
> + *  Markus Armbruster <armbru@redhat.com>,
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QAPI_COMPAT_POLICY_H
> +#define QAPI_COMPAT_POLICY_H
> +
> +#include "qapi/qapi-types-compat.h"
> +
> +extern CompatPolicy compat_policy;
> +
> +#endif
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index fb53687ce9..80beab517f 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -12,6 +12,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qapi/compat-policy.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/dispatch.h"
>  #include "qapi/qmp/qdict.h"
> @@ -19,6 +20,8 @@
>  #include "sysemu/runstate.h"
>  #include "qapi/qmp/qbool.h"
>
> +CompatPolicy compat_policy;
> +
>  static QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_=
oob,
>                                       QObject **id, Error **errp)
>  {
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index ff2685dff8..74eb43d114 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -27,6 +27,7 @@
>  #include "qemu/units.h"
>  #include "hw/boards.h"
>  #include "hw/qdev-properties.h"
> +#include "qapi/compat-policy.h"
>  #include "qapi/error.h"
>  #include "qemu-version.h"
>  #include "qemu/cutils.h"
> @@ -105,6 +106,7 @@
>  #include "sysemu/replay.h"
>  #include "qapi/qapi-events-run-state.h"
>  #include "qapi/qapi-visit-block-core.h"
> +#include "qapi/qapi-visit-compat.h"
>  #include "qapi/qapi-visit-ui.h"
>  #include "qapi/qapi-commands-block-core.h"
>  #include "qapi/qapi-commands-run-state.h"
> @@ -3749,6 +3751,21 @@ void qemu_init(int argc, char **argv, char **envp)
>                      qemu_opt_get_bool(opts, "mem-lock", false);
>                  enable_cpu_pm =3D qemu_opt_get_bool(opts, "cpu-pm", fals=
e);
>                  break;
> +            case QEMU_OPTION_compat:
> +                {
> +                    CompatPolicy *opts;
> +                    Visitor *v;
> +
> +                    v =3D qobject_input_visitor_new_str(optarg, NULL,
> +                                                      &error_fatal);
> +
> +                    visit_type_CompatPolicy(v, NULL, &opts, &error_fatal=
);
> +                    QAPI_CLONE_MEMBERS(CompatPolicy, &compat_policy, opt=
s);
> +
> +                    qapi_free_CompatPolicy(opts);
> +                    visit_free(v);
> +                    break;
> +                }
>              case QEMU_OPTION_msg:
>                  opts =3D qemu_opts_parse_noisily(qemu_find_opts("msg"), =
optarg,
>                                                 false);
> diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
> index 4673ab7490..a3de2e2756 100644
> --- a/qapi/Makefile.objs
> +++ b/qapi/Makefile.objs
> @@ -5,10 +5,10 @@ util-obj-y +=3D opts-visitor.o qapi-clone-visitor.o
>  util-obj-y +=3D qmp-event.o
>  util-obj-y +=3D qapi-util.o
>
> -QAPI_COMMON_MODULES =3D audio authz block-core block char common control=
 crypto
> -QAPI_COMMON_MODULES +=3D dump error introspect job machine migration mis=
c
> -QAPI_COMMON_MODULES +=3D net pragma qdev qom rdma rocker run-state socke=
ts tpm
> -QAPI_COMMON_MODULES +=3D trace transaction ui
> +QAPI_COMMON_MODULES =3D audio authz block-core block char common compat
> +QAPI_COMMON_MODULES +=3D control crypto dump error introspect job
> +QAPI_COMMON_MODULES +=3D machine migration misc net pragma qdev qom rdma
> +QAPI_COMMON_MODULES +=3D rocker run-state sockets tpm trace transaction =
ui
>  QAPI_TARGET_MODULES =3D machine-target misc-target
>  QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 1d8f852d89..5459e6c94c 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3357,6 +3357,26 @@ DEFHEADING()
>
>  DEFHEADING(Debug/Expert options:)
>
> +DEF("compat", HAS_ARG, QEMU_OPTION_compat,
> +    "-compat [deprecated-input=3Daccept|reject][,deprecated-output=3Dacc=
ept|hide]\n"
> +    "                Policy for handling deprecated management interface=
s\n",
> +    QEMU_ARCH_ALL)
> +SRST
> +``-compat [deprecated-input=3D@var{input-policy}][,deprecated-output=3D@=
var{output-policy}]``
> +    Set policy for handling deprecated management interfaces (experiment=
al):
> +
> +    ``deprecated-input=3Daccept`` (default)
> +        Accept deprecated commands and arguments
> +    ``deprecated-input=3Dreject``
> +        Reject deprecated commands and arguments
> +    ``deprecated-output=3Daccept`` (default)
> +        Emit deprecated command results and events
> +    ``deprecated-output=3Dhide``
> +        Suppress deprecated command results and events
> +
> +    Limitation: covers only syntactic aspects of QMP.
> +ERST
> +
>  DEF("fw_cfg", HAS_ARG, QEMU_OPTION_fwcfg,
>      "-fw_cfg [name=3D]<name>,file=3D<file>\n"
>      "                add named fw_cfg entry with contents from file\n"
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

