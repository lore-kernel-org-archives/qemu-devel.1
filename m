Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8E6C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174FB205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT/LyHwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174FB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDdyv-000702-VW
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jDddY-0006SR-Ay
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jDddV-0008GT-7S
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:29:43 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jDddU-00086i-BC; Sun, 15 Mar 2020 20:29:41 -0400
Received: by mail-ot1-x342.google.com with SMTP id e9so8888752otr.12;
 Sun, 15 Mar 2020 17:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Aeps3KqOoSmptvpzrRBOVSbkASBRanm2c20/xsw2bdM=;
 b=ZT/LyHwpPT5w+MsjsnjGYSnpzNXGWtMvLAcPuNHY3kyxswNzgZZgQVrvcJIClxHYxX
 JeDKOurwguAZqfbIZNFBdaHb3W5+MCix84E+5MygxQLz5wCFi4SaLywp3J8MT/13tGeJ
 1jcOPCvnxM0VAogCyK0D5Yw1YZ7TwFF9BI2mrbKAr0dimxH4QS7xIKYW68qYTP0/roa6
 8zo2jj14otpzQ/oqCqITrU1TsNDIdHEm8vxA6gnGPCy44yI6t/0fSSoBPKPp6VuTipRW
 iKeAkS96JEbuLG4kcVnAGIioiOXPqoDCEiDPzxAe5ItQWxr6CbPyhVa9nbgSw7Z+nrUz
 UeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Aeps3KqOoSmptvpzrRBOVSbkASBRanm2c20/xsw2bdM=;
 b=J3aQyMeN5y5rdNUUsWpfXghQE1r/p9hqeizxiDhzkgC1wgbkmvyUrP/Lfsm/2iLssE
 abWxElJ5LQl2WnA9chdFK5Ih5LsFrPYi82Ov6sQgIbNHl6K9IeQK61DOFw55mM5lU6cx
 XPIEjdWjl9vsgaf147DS9xstf38KVr/rtTfeUjQcMiCZM1h/KFOnqzflh7qorW19f4Xz
 n02pOcM34BeLYDxwM2L7FjbS862GO0WPl+zD/Po8vsl0nm7Mnx6yyvhpy7LPdhJ4B7vq
 R337qXWN23hLrFfQGu8dOWT8uL0XH46JNfU51S4IStpInUbLK+Gc1L+kUZkaGb96d6DI
 5IPQ==
X-Gm-Message-State: ANhLgQ1UcI+7sCnEYFL05de6uZiR4o7nnM5rmINprbZdL0C5O/pA8A2l
 oQ3yZJPXgw8S7j2+IXCZrI1Zczl9pazn7wsUZQI=
X-Google-Smtp-Source: ADFU+vvdfSkJnrny3CkhZNxEEgNlign5GvV5IyGUdIU+qnvWWdP22fuopdxZEtXKuytlgu/AjTk1jGQRN0p2bbMP0X8=
X-Received: by 2002:a9d:7a47:: with SMTP id z7mr21631562otm.341.1584318578709; 
 Sun, 15 Mar 2020 17:29:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4044:0:0:0:0:0 with HTTP; Sun, 15 Mar 2020 17:29:38
 -0700 (PDT)
In-Reply-To: <20200316000348.29692-2-philmd@redhat.com>
References: <20200316000348.29692-1-philmd@redhat.com>
 <20200316000348.29692-2-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 16 Mar 2020 01:29:38 +0100
Message-ID: <CAL1e-=gWOZzFKd9OdkTRJj19NX56BcpQBz6r9RY3orsrgf9mMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] target/i386: Restrict X86CPUFeatureWord to X86
 targets
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000018578505a0edeadb"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Peter Lieven <pl@kamp.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000018578505a0edeadb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, March 16, 2020, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =
wrote:

> Move out x86-specific structures from generic machine code.
>
>
Philippe,

I a kind of have hard time understanding what is achieved with this patch.
Is this pure code moving/reorganization? What is the logical connection
between this patch and the whole series (that is about removing unneeded
building for user mode)? How does this patch affect build time for user
mode?

Sincerely,
Aleksandar




> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  qapi/machine-target.json   | 45 ++++++++++++++++++++++++++++++++++++++
>  qapi/machine.json          | 42 -----------------------------------
>  target/i386/cpu.c          |  2 +-
>  target/i386/machine-stub.c | 22 +++++++++++++++++++
>  target/i386/Makefile.objs  |  3 ++-
>  5 files changed, 70 insertions(+), 44 deletions(-)
>  create mode 100644 target/i386/machine-stub.c
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index f2c82949d8..fb7a4b7850 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -3,6 +3,51 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
> later.
>  # See the COPYING file in the top-level directory.
>
> +##
> +# @X86CPURegister32:
> +#
> +# A X86 32-bit register
> +#
> +# Since: 1.5
> +##
> +{ 'enum': 'X86CPURegister32',
> +  'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ],
> +  'if': 'defined(TARGET_I386)' }
> +
> +##
> +# @X86CPUFeatureWordInfo:
> +#
> +# Information about a X86 CPU feature word
> +#
> +# @cpuid-input-eax: Input EAX value for CPUID instruction for that
> feature word
> +#
> +# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
> +#                   feature word
> +#
> +# @cpuid-register: Output register containing the feature bits
> +#
> +# @features: value of output register, containing the feature bits
> +#
> +# Since: 1.5
> +##
> +{ 'struct': 'X86CPUFeatureWordInfo',
> +  'data': { 'cpuid-input-eax': 'int',
> +            '*cpuid-input-ecx': 'int',
> +            'cpuid-register': 'X86CPURegister32',
> +            'features': 'int' },
> +  'if': 'defined(TARGET_I386)' }
> +
> +##
> +# @DummyForceArrays:
> +#
> +# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internal=
ly
> +#
> +# Since: 2.5
> +##
> +{ 'struct': 'DummyForceArrays',
> +  'data': { 'unused': ['X86CPUFeatureWordInfo'] },
> +  'if': 'defined(TARGET_I386)' }
> +
>  ##
>  # @CpuModelInfo:
>  #
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 6c11e3cf3a..de05730704 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -505,48 +505,6 @@
>     'dst': 'uint16',
>     'val': 'uint8' }}
>
> -##
> -# @X86CPURegister32:
> -#
> -# A X86 32-bit register
> -#
> -# Since: 1.5
> -##
> -{ 'enum': 'X86CPURegister32',
> -  'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ] }
> -
> -##
> -# @X86CPUFeatureWordInfo:
> -#
> -# Information about a X86 CPU feature word
> -#
> -# @cpuid-input-eax: Input EAX value for CPUID instruction for that
> feature word
> -#
> -# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
> -#                   feature word
> -#
> -# @cpuid-register: Output register containing the feature bits
> -#
> -# @features: value of output register, containing the feature bits
> -#
> -# Since: 1.5
> -##
> -{ 'struct': 'X86CPUFeatureWordInfo',
> -  'data': { 'cpuid-input-eax': 'int',
> -            '*cpuid-input-ecx': 'int',
> -            'cpuid-register': 'X86CPURegister32',
> -            'features': 'int' } }
> -
> -##
> -# @DummyForceArrays:
> -#
> -# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internal=
ly
> -#
> -# Since: 2.5
> -##
> -{ 'struct': 'DummyForceArrays',
> -  'data': { 'unused': ['X86CPUFeatureWordInfo'] } }
> -
>  ##
>  # @NumaCpuOptions:
>  #
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a84553e50c..0753fe4935 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -37,7 +37,7 @@
>  #include "qemu/option.h"
>  #include "qemu/config-file.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-visit-machine.h"
> +#include "qapi/qapi-visit-machine-target.h"
>  #include "qapi/qapi-visit-run-state.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qerror.h"
> diff --git a/target/i386/machine-stub.c b/target/i386/machine-stub.c
> new file mode 100644
> index 0000000000..cb301af057
> --- /dev/null
> +++ b/target/i386/machine-stub.c
> @@ -0,0 +1,22 @@
> +/*
> + * QAPI x86 CPU features stub
> + *
> + * Copyright (c) 2020 Red Hat, Inc.
> + *
> + * Author:
> + *   Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> + * See the COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-visit-machine-target.h"
> +
> +void visit_type_X86CPUFeatureWordInfoList(Visitor *v, const char *name,
> +                                      X86CPUFeatureWordInfoList **obj,
> +                                      Error **errp)
> +{
> +}
> diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
> index 48e0c28434..1cdfc9f50c 100644
> --- a/target/i386/Makefile.objs
> +++ b/target/i386/Makefile.objs
> @@ -17,6 +17,7 @@ obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-posix.o
>  endif
>  obj-$(CONFIG_HVF) +=3D hvf/
>  obj-$(CONFIG_WHPX) +=3D whpx-all.o
> -endif
> +endif # CONFIG_SOFTMMU
>  obj-$(CONFIG_SEV) +=3D sev.o
>  obj-$(call lnot,$(CONFIG_SEV)) +=3D sev-stub.o
> +obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D machine-stub.o
> --
> 2.21.1
>
>
>

--00000000000018578505a0edeadb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, March 16, 2020, Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">Move out x86-specific structures from generic machine=
 code.<br>
<br></blockquote><div><br></div><div>Philippe,</div><div><br></div><div>I a=
 kind of have hard time understanding what is achieved with this patch. Is =
this pure code moving/reorganization? What is the logical connection betwee=
n this patch and the whole series (that is about removing unneeded building=
 for user mode)? How does this patch affect build time for user mode?</div>=
<div><br></div><div>Sincerely,</div><div>Aleksandar</div><div><br></div><di=
v><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Acked-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.=
org">richard.henderson@linaro.org</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0qapi/machine-target.json=C2=A0 =C2=A0| 45 +++++++++++++++++++++++++++=
+++<wbr>++++++++<br>
=C2=A0qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 42 ------------=
------------------<wbr>-----<br>
=C2=A0target/i386/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0target/i386/machine-stub.c | 22 +++++++++++++++++++<br>
=C2=A0target/i386/Makefile.objs=C2=A0 |=C2=A0 3 ++-<br>
=C2=A05 files changed, 70 insertions(+), 44 deletions(-)<br>
=C2=A0create mode 100644 target/i386/machine-stub.c<br>
<br>
diff --git a/qapi/machine-target.json b/qapi/machine-target.json<br>
index f2c82949d8..fb7a4b7850 100644<br>
--- a/qapi/machine-target.json<br>
+++ b/qapi/machine-target.json<br>
@@ -3,6 +3,51 @@<br>
=C2=A0# This work is licensed under the terms of the GNU GPL, version 2 or =
later.<br>
=C2=A0# See the COPYING file in the top-level directory.<br>
<br>
+##<br>
+# @X86CPURegister32:<br>
+#<br>
+# A X86 32-bit register<br>
+#<br>
+# Since: 1.5<br>
+##<br>
+{ &#39;enum&#39;: &#39;X86CPURegister32&#39;,<br>
+=C2=A0 &#39;data&#39;: [ &#39;EAX&#39;, &#39;EBX&#39;, &#39;ECX&#39;, &#39=
;EDX&#39;, &#39;ESP&#39;, &#39;EBP&#39;, &#39;ESI&#39;, &#39;EDI&#39; ],<br=
>
+=C2=A0 &#39;if&#39;: &#39;defined(TARGET_I386)&#39; }<br>
+<br>
+##<br>
+# @X86CPUFeatureWordInfo:<br>
+#<br>
+# Information about a X86 CPU feature word<br>
+#<br>
+# @cpuid-input-eax: Input EAX value for CPUID instruction for that feature=
 word<br>
+#<br>
+# @cpuid-input-ecx: Input ECX value for CPUID instruction for that<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0feat=
ure word<br>
+#<br>
+# @cpuid-register: Output register containing the feature bits<br>
+#<br>
+# @features: value of output register, containing the feature bits<br>
+#<br>
+# Since: 1.5<br>
+##<br>
+{ &#39;struct&#39;: &#39;X86CPUFeatureWordInfo&#39;,<br>
+=C2=A0 &#39;data&#39;: { &#39;cpuid-input-eax&#39;: &#39;int&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*cpuid-input-ecx&#39;: &#39=
;int&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;cpuid-register&#39;: &#39;X=
86CPURegister32&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;features&#39;: &#39;int&#39=
; },<br>
+=C2=A0 &#39;if&#39;: &#39;defined(TARGET_I386)&#39; }<br>
+<br>
+##<br>
+# @DummyForceArrays:<br>
+#<br>
+# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internally=
<br>
+#<br>
+# Since: 2.5<br>
+##<br>
+{ &#39;struct&#39;: &#39;DummyForceArrays&#39;,<br>
+=C2=A0 &#39;data&#39;: { &#39;unused&#39;: [&#39;X86CPUFeatureWordInfo&#39=
;] },<br>
+=C2=A0 &#39;if&#39;: &#39;defined(TARGET_I386)&#39; }<br>
+<br>
=C2=A0##<br>
=C2=A0# @CpuModelInfo:<br>
=C2=A0#<br>
diff --git a/qapi/machine.json b/qapi/machine.json<br>
index 6c11e3cf3a..de05730704 100644<br>
--- a/qapi/machine.json<br>
+++ b/qapi/machine.json<br>
@@ -505,48 +505,6 @@<br>
=C2=A0 =C2=A0 &#39;dst&#39;: &#39;uint16&#39;,<br>
=C2=A0 =C2=A0 &#39;val&#39;: &#39;uint8&#39; }}<br>
<br>
-##<br>
-# @X86CPURegister32:<br>
-#<br>
-# A X86 32-bit register<br>
-#<br>
-# Since: 1.5<br>
-##<br>
-{ &#39;enum&#39;: &#39;X86CPURegister32&#39;,<br>
-=C2=A0 &#39;data&#39;: [ &#39;EAX&#39;, &#39;EBX&#39;, &#39;ECX&#39;, &#39=
;EDX&#39;, &#39;ESP&#39;, &#39;EBP&#39;, &#39;ESI&#39;, &#39;EDI&#39; ] }<b=
r>
-<br>
-##<br>
-# @X86CPUFeatureWordInfo:<br>
-#<br>
-# Information about a X86 CPU feature word<br>
-#<br>
-# @cpuid-input-eax: Input EAX value for CPUID instruction for that feature=
 word<br>
-#<br>
-# @cpuid-input-ecx: Input ECX value for CPUID instruction for that<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0feat=
ure word<br>
-#<br>
-# @cpuid-register: Output register containing the feature bits<br>
-#<br>
-# @features: value of output register, containing the feature bits<br>
-#<br>
-# Since: 1.5<br>
-##<br>
-{ &#39;struct&#39;: &#39;X86CPUFeatureWordInfo&#39;,<br>
-=C2=A0 &#39;data&#39;: { &#39;cpuid-input-eax&#39;: &#39;int&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*cpuid-input-ecx&#39;: &#39=
;int&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;cpuid-register&#39;: &#39;X=
86CPURegister32&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;features&#39;: &#39;int&#39=
; } }<br>
-<br>
-##<br>
-# @DummyForceArrays:<br>
-#<br>
-# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internally=
<br>
-#<br>
-# Since: 2.5<br>
-##<br>
-{ &#39;struct&#39;: &#39;DummyForceArrays&#39;,<br>
-=C2=A0 &#39;data&#39;: { &#39;unused&#39;: [&#39;X86CPUFeatureWordInfo&#39=
;] } }<br>
-<br>
=C2=A0##<br>
=C2=A0# @NumaCpuOptions:<br>
=C2=A0#<br>
diff --git a/target/i386/cpu.c b/target/i386/cpu.c<br>
index a84553e50c..0753fe4935 100644<br>
--- a/target/i386/cpu.c<br>
+++ b/target/i386/cpu.c<br>
@@ -37,7 +37,7 @@<br>
=C2=A0#include &quot;qemu/option.h&quot;<br>
=C2=A0#include &quot;qemu/config-file.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
-#include &quot;qapi/qapi-visit-machine.h&quot;<br>
+#include &quot;qapi/qapi-visit-machine-<wbr>target.h&quot;<br>
=C2=A0#include &quot;qapi/qapi-visit-run-state.h&quot;<br>
=C2=A0#include &quot;qapi/qmp/qdict.h&quot;<br>
=C2=A0#include &quot;qapi/qmp/qerror.h&quot;<br>
diff --git a/target/i386/machine-stub.c b/target/i386/machine-stub.c<br>
new file mode 100644<br>
index 0000000000..cb301af057<br>
--- /dev/null<br>
+++ b/target/i386/machine-stub.c<br>
@@ -0,0 +1,22 @@<br>
+/*<br>
+ * QAPI x86 CPU features stub<br>
+ *<br>
+ * Copyright (c) 2020 Red Hat, Inc.<br>
+ *<br>
+ * Author:<br>
+ *=C2=A0 =C2=A0Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@re=
dhat.com">philmd@redhat.com</a>&gt;<br>
+ *<br>
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
+ * See the COPYING file in the top-level directory.<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;qapi/qapi-visit-machine-<wbr>target.h&quot;<br>
+<br>
+void visit_type_<wbr>X86CPUFeatureWordInfoList(<wbr>Visitor *v, const char=
 *name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X86CPUFeatureWo=
rdInfoList **obj,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<b=
r>
+{<br>
+}<br>
diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs<br>
index 48e0c28434..1cdfc9f50c 100644<br>
--- a/target/i386/Makefile.objs<br>
+++ b/target/i386/Makefile.objs<br>
@@ -17,6 +17,7 @@ obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-posix.o<br=
>
=C2=A0endif<br>
=C2=A0obj-$(CONFIG_HVF) +=3D hvf/<br>
=C2=A0obj-$(CONFIG_WHPX) +=3D whpx-all.o<br>
-endif<br>
+endif # CONFIG_SOFTMMU<br>
=C2=A0obj-$(CONFIG_SEV) +=3D sev.o<br>
=C2=A0obj-$(call lnot,$(CONFIG_SEV)) +=3D sev-stub.o<br>
+obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D machine-stub.o<br>
-- <br>
2.21.1<br>
<br>
<br>
</blockquote>

--00000000000018578505a0edeadb--

