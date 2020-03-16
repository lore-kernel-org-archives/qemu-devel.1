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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9AFC10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BD120674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kich0Ix+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BD120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDeWs-0003YP-FQ
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 21:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jDdfU-00072A-BC
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jDdfS-0008Tx-37
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:31:44 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jDdfQ-00080m-6L; Sun, 15 Mar 2020 20:31:40 -0400
Received: by mail-oi1-x242.google.com with SMTP id g6so15977708oiy.1;
 Sun, 15 Mar 2020 17:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=I6Nj2y3FxESwIcrZRt8R5otWYdEPJTeU6/ivLhvs6k8=;
 b=Kich0Ix+9fskW/bjUvqcBlvwDYvuLdKgWd+ObljcdlLoDVsgD+j7UaicIYjObs6n/N
 ZmJst9dgX+96IxEt4B0by7o/LsSy23m+KB7TIDua6wIOTlGd6wOs/xs2QE/VDTtGlVIV
 eKaZ8vWkUcFHD4b1H6tGI8iAEp3/2EEJ3u9h489b2Vuhu5yYgH6+qbfS9MWBKfYwrxj0
 AMl7dFkEM37Sf/yYIaOeSEL3tA0U4vwzdyd+s5v8XGVGoTtZTzggRCt8hdV9EFoutzxD
 Nu/r/1qBubZILI7ZYkwfcyOFWCHe0mkeGqp8J2K1ntvbLrBmP4C60d+1RT9HuR6S7eNQ
 goIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=I6Nj2y3FxESwIcrZRt8R5otWYdEPJTeU6/ivLhvs6k8=;
 b=KBuCM1XC4vx8dx0+pV5QHzR6FVKJLOe8Cqv6rkvRMpawJ6LLrgsyMKkR0nMm9xiy0v
 G8aYo6MXfjBvmmS0OC8LHiNthxhXC64IEDwvBwUVXox2+YK2WpONl5orgMtWOTK7OkWc
 xzCKQcU1i/EguvRY4G2SKqr3r2Jps3P6T3mcX/2Do7aFoUNovrnrQFJhZ+SR2GxQM8G0
 59jBpaeYNPV1MGrpHMGBY8YLIf0e4v9aADtCiXz+v5/OTGP7FMDmSa+gRJgnDDauN9Ut
 5knNhVy71SmqUoE9vowZvHQDUkIigFaLaOYhTw7ZcprUhiiz/1dM5OWeRuu6zAaWeiv0
 jzjw==
X-Gm-Message-State: ANhLgQ0uFB3dsIJrDC53hYG9hKyjM7O0DeqAsi6jgXECZt0ryTyXVAIh
 QYKer3gvMTH8FJis1vs9HoxxlFEoNr28bXFlB+Q=
X-Google-Smtp-Source: ADFU+vtb9lSbHKUJB5XCTSKJYBvLgJ56shuxzM6CaepFUisYR66c8YWJGg+EUIvaS5sp8RWRic7AAG94K640o/hpblQ=
X-Received: by 2002:aca:c596:: with SMTP id
 v144mr15731245oif.136.1584318694870; 
 Sun, 15 Mar 2020 17:31:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4044:0:0:0:0:0 with HTTP; Sun, 15 Mar 2020 17:31:34
 -0700 (PDT)
In-Reply-To: <CAL1e-=gWOZzFKd9OdkTRJj19NX56BcpQBz6r9RY3orsrgf9mMg@mail.gmail.com>
References: <20200316000348.29692-1-philmd@redhat.com>
 <20200316000348.29692-2-philmd@redhat.com>
 <CAL1e-=gWOZzFKd9OdkTRJj19NX56BcpQBz6r9RY3orsrgf9mMg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 16 Mar 2020 01:31:34 +0100
Message-ID: <CAL1e-=idkHcnt=UtKbAL3FerQFdW4vK93i3eA=r5s3SfJy1+Jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] target/i386: Restrict X86CPUFeatureWord to X86
 targets
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000004d23405a0edf1ec"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

--00000000000004d23405a0edf1ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, March 16, 2020, Aleksandar Markovic <aleksandar.m.mail@gmail.com=
>
wrote:

>
>
> On Monday, March 16, 2020, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
> wrote:
>
>> Move out x86-specific structures from generic machine code.
>>
>>
> Philippe,
>
> I a kind of have hard time understanding what is achieved with this patch=
.
> Is this pure code moving/reorganization? What is the logical connection
> between this patch and the whole series (that is about removing unneeded
> building for user mode)? How does this patch affect build time for user
> mode?
>
> Sincerely,
> Aleksandar
>
>
Ugh, I think I mixed up your two series. You write too much code. :) ;)


>
>
>> Acked-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  qapi/machine-target.json   | 45 ++++++++++++++++++++++++++++++++++++++
>>  qapi/machine.json          | 42 -----------------------------------
>>  target/i386/cpu.c          |  2 +-
>>  target/i386/machine-stub.c | 22 +++++++++++++++++++
>>  target/i386/Makefile.objs  |  3 ++-
>>  5 files changed, 70 insertions(+), 44 deletions(-)
>>  create mode 100644 target/i386/machine-stub.c
>>
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> index f2c82949d8..fb7a4b7850 100644
>> --- a/qapi/machine-target.json
>> +++ b/qapi/machine-target.json
>> @@ -3,6 +3,51 @@
>>  # This work is licensed under the terms of the GNU GPL, version 2 or
>> later.
>>  # See the COPYING file in the top-level directory.
>>
>> +##
>> +# @X86CPURegister32:
>> +#
>> +# A X86 32-bit register
>> +#
>> +# Since: 1.5
>> +##
>> +{ 'enum': 'X86CPURegister32',
>> +  'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ],
>> +  'if': 'defined(TARGET_I386)' }
>> +
>> +##
>> +# @X86CPUFeatureWordInfo:
>> +#
>> +# Information about a X86 CPU feature word
>> +#
>> +# @cpuid-input-eax: Input EAX value for CPUID instruction for that
>> feature word
>> +#
>> +# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
>> +#                   feature word
>> +#
>> +# @cpuid-register: Output register containing the feature bits
>> +#
>> +# @features: value of output register, containing the feature bits
>> +#
>> +# Since: 1.5
>> +##
>> +{ 'struct': 'X86CPUFeatureWordInfo',
>> +  'data': { 'cpuid-input-eax': 'int',
>> +            '*cpuid-input-ecx': 'int',
>> +            'cpuid-register': 'X86CPURegister32',
>> +            'features': 'int' },
>> +  'if': 'defined(TARGET_I386)' }
>> +
>> +##
>> +# @DummyForceArrays:
>> +#
>> +# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList
>> internally
>> +#
>> +# Since: 2.5
>> +##
>> +{ 'struct': 'DummyForceArrays',
>> +  'data': { 'unused': ['X86CPUFeatureWordInfo'] },
>> +  'if': 'defined(TARGET_I386)' }
>> +
>>  ##
>>  # @CpuModelInfo:
>>  #
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 6c11e3cf3a..de05730704 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -505,48 +505,6 @@
>>     'dst': 'uint16',
>>     'val': 'uint8' }}
>>
>> -##
>> -# @X86CPURegister32:
>> -#
>> -# A X86 32-bit register
>> -#
>> -# Since: 1.5
>> -##
>> -{ 'enum': 'X86CPURegister32',
>> -  'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ] }
>> -
>> -##
>> -# @X86CPUFeatureWordInfo:
>> -#
>> -# Information about a X86 CPU feature word
>> -#
>> -# @cpuid-input-eax: Input EAX value for CPUID instruction for that
>> feature word
>> -#
>> -# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
>> -#                   feature word
>> -#
>> -# @cpuid-register: Output register containing the feature bits
>> -#
>> -# @features: value of output register, containing the feature bits
>> -#
>> -# Since: 1.5
>> -##
>> -{ 'struct': 'X86CPUFeatureWordInfo',
>> -  'data': { 'cpuid-input-eax': 'int',
>> -            '*cpuid-input-ecx': 'int',
>> -            'cpuid-register': 'X86CPURegister32',
>> -            'features': 'int' } }
>> -
>> -##
>> -# @DummyForceArrays:
>> -#
>> -# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList
>> internally
>> -#
>> -# Since: 2.5
>> -##
>> -{ 'struct': 'DummyForceArrays',
>> -  'data': { 'unused': ['X86CPUFeatureWordInfo'] } }
>> -
>>  ##
>>  # @NumaCpuOptions:
>>  #
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index a84553e50c..0753fe4935 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -37,7 +37,7 @@
>>  #include "qemu/option.h"
>>  #include "qemu/config-file.h"
>>  #include "qapi/error.h"
>> -#include "qapi/qapi-visit-machine.h"
>> +#include "qapi/qapi-visit-machine-target.h"
>>  #include "qapi/qapi-visit-run-state.h"
>>  #include "qapi/qmp/qdict.h"
>>  #include "qapi/qmp/qerror.h"
>> diff --git a/target/i386/machine-stub.c b/target/i386/machine-stub.c
>> new file mode 100644
>> index 0000000000..cb301af057
>> --- /dev/null
>> +++ b/target/i386/machine-stub.c
>> @@ -0,0 +1,22 @@
>> +/*
>> + * QAPI x86 CPU features stub
>> + *
>> + * Copyright (c) 2020 Red Hat, Inc.
>> + *
>> + * Author:
>> + *   Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> later.
>> + * See the COPYING file in the top-level directory.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qapi/qapi-visit-machine-target.h"
>> +
>> +void visit_type_X86CPUFeatureWordInfoList(Visitor *v, const char *name,
>> +                                      X86CPUFeatureWordInfoList **obj,
>> +                                      Error **errp)
>> +{
>> +}
>> diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
>> index 48e0c28434..1cdfc9f50c 100644
>> --- a/target/i386/Makefile.objs
>> +++ b/target/i386/Makefile.objs
>> @@ -17,6 +17,7 @@ obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-posix.o
>>  endif
>>  obj-$(CONFIG_HVF) +=3D hvf/
>>  obj-$(CONFIG_WHPX) +=3D whpx-all.o
>> -endif
>> +endif # CONFIG_SOFTMMU
>>  obj-$(CONFIG_SEV) +=3D sev.o
>>  obj-$(call lnot,$(CONFIG_SEV)) +=3D sev-stub.o
>> +obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D machine-stub.o
>> --
>> 2.21.1
>>
>>
>>

--00000000000004d23405a0edf1ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, March 16, 2020, Aleksandar Markovic &lt;<a href=3D"mailt=
o:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><br><br>On Monday, March 16, 2020, Philipp=
e Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_bl=
ank">philmd@redhat.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Mov=
e out x86-specific structures from generic machine code.<br>
<br></blockquote><div><br></div><div>Philippe,</div><div><br></div><div>I a=
 kind of have hard time understanding what is achieved with this patch. Is =
this pure code moving/reorganization? What is the logical connection betwee=
n this patch and the whole series (that is about removing unneeded building=
 for user mode)? How does this patch affect build time for user mode?</div>=
<div><br></div><div>Sincerely,</div><div>Aleksandar</div><div><br></div></b=
lockquote><div><br></div><div>Ugh, I think I mixed up your two series. You =
write too much code. :) ;)</div><div><br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x"><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Acked-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.=
org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
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
+#include &quot;qapi/qapi-visit-machine-targe<wbr>t.h&quot;<br>
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
dhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
+ *<br>
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
+ * See the COPYING file in the top-level directory.<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;qapi/qapi-visit-machine-targe<wbr>t.h&quot;<br>
+<br>
+void visit_type_X86CPUFeatureWordIn<wbr>foList(Visitor *v, const char *nam=
e,<br>
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
</blockquote>

--00000000000004d23405a0edf1ec--

