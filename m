Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CD0C352AB
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 22:00:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143E52075D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 22:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143E52075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDboP-0003nW-7U
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 18:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iDbmj-0002Ph-3o
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 17:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iDbmf-0008Ri-Qa
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 17:58:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58640)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iDbmf-0008QS-Hi
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 17:58:45 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CC6F54E924
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 21:58:43 +0000 (UTC)
Received: by mail-ed1-f71.google.com with SMTP id k5so240016edx.13
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 14:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vv4ytIdxSiWNgzg2fR+elJv7kpy3C+1GEpjEDpmZAcw=;
 b=VlSMUt2Wlm4556SbW4dGjkW5Lgr+NRP8GwaN7I5ONqgK2xsWYTCtCHaCQrkYisvnaS
 EdwfrC2MNCQZCursADKfXmoMg2CkR/05ysUujs9wSEF/JIAR6694Cr2yTqC81OOOrRPK
 mwrQYfTqoS6BZeCTMpRiz8Adlyv9aOZNjcnVd/fltMiFWDR+dv8s0+LtgdRI3HPVwczZ
 QDqVPEE7/W0WZ1iXXBrpUiPMNno7u8fW/6obhhQ1outvGAOYBECXwv4EseYAbU/McTeP
 MgzXY0yHrSMQ7/3V39WSpZ4htSVzhCnKBmr0xR1UAJVUTDJuiJAtiB8EuG+cfdp4MZBy
 7/dw==
X-Gm-Message-State: APjAAAWAZBGijXghD/QX2wql3KwqQNLn8gVD572Cl4+tyN6ejW8nffpB
 caFYeE+QBmj75FIra8c4I8YKU87pqXp0k0bKdiruopvX7QJSy58C3zC54e4uliUCKGu+p9QPzVt
 mPvEDBEQCaaRLrnDSFOHtk50qnS571og=
X-Received: by 2002:a17:906:60d0:: with SMTP id
 f16mr5145597ejk.267.1569535122414; 
 Thu, 26 Sep 2019 14:58:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxKkZLfeHF1lepWnqWxblGylDxX6ma8eVDSvJhqxcKxG2AC50oyFAQKi/KbKq8sZnNuaUgUQqiygkbP1xeXKbE=
X-Received: by 2002:a17:906:60d0:: with SMTP id
 f16mr5145577ejk.267.1569535122115; 
 Thu, 26 Sep 2019 14:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190926212326.4092-1-ehabkost@redhat.com>
In-Reply-To: <20190926212326.4092-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 26 Sep 2019 23:58:30 +0200
Message-ID: <CABgObfa-PHfeNVVYCuEFJ4_=KADJEddJS1k0Au+sOgtxgundDQ@mail.gmail.com>
Subject: Re: [PATCH] i386: Re-add "pconfig" CPUID flag name
To: "Habkost, Eduardo" <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006ab28f05937bdf03"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: thomas.lendacky@amd.com, "Kang, Luwei" <luwei.kang@intel.com>,
 qemu-devel <qemu-devel@nongnu.org>, Robert Hoo <robert.hu@linux.intel.com>,
 kai.huang@intel.com, berrange@redhat.com, robert.hu@intel.com,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006ab28f05937bdf03
Content-Type: text/plain; charset="UTF-8"

Is this really needed? QEMU's value of pconfig=on vs. off should be
provided by QMP CPU model queries, if a property is not available then
Libvirt should not try to set it to off.

Paolo

Il gio 26 set 2019, 23:23 Eduardo Habkost <ehabkost@redhat.com> ha scritto:

> QEMU 3.1.0 was shipped with the "pconfig" CPU property available,
> added by commit 5131dc433df5 ("i386: Add CPUID bit for PCONFIG").
>
> Then the feature was removed in QEMU 4.0.0 (and 3.1.1), by commit
> 712f807e1965 ("Revert 'i386: Add CPUID bit for PCONFIG'").
>
> In theory this would be OK, but we do have a problem: existing
> software (like libvirt) was already using "pconfig=off" since
> QEMU 3.1.0 on some cases.  This means software that worked with
> QEMU 3.1.0 doesn't work with QEMU 3.1.1 and newer.
>
> One symptom is the following error being generated by
> virt-install while trying to use the 'host-model' CPU model, on a
> host that's identified as Icelake-Server:
>
>   ERROR    internal error: qemu unexpectedly closed the monitor: \
>       2019-09-24T22:57:42.550032Z qemu-kvm: \
>       can't apply global Icelake-Server-x86_64-cpu.pconfig=off: Property
> '.pconfig' not found
>
> Re-add "pconfig" to feature_word_info[FEAT_7_0_EDX].feat_names so
> "pconfig=off" will work again.
>
> This change still won't let users set "monitor=on" because all
> accelerators currently report the feature as unsupported.  But to
> make sure PCONFIG won't be enabled by accident in the future
> before we implement the necessary migration code, also add the
> feature to .unmigratable_flags.
>
> Fixes: 712f807e1965 ("Revert 'i386: Add CPUID bit for PCONFIG'")
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu.h | 2 ++
>  target/i386/cpu.c | 8 +++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 8e090acd74..b728bd22f1 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -731,6 +731,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_7_0_EDX_AVX512_4VNNIW     (1U << 2)
>  /* AVX512 Multiply Accumulation Single Precision */
>  #define CPUID_7_0_EDX_AVX512_4FMAPS     (1U << 3)
> +/* PCONFIG Instruction */
> +#define CPUID_7_0_EDX_PCONFIG           (1U << 18)
>  /* Speculation Control */
>  #define CPUID_7_0_EDX_SPEC_CTRL         (1U << 26)
>  /* Arch Capabilities */
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 71034aeb5a..3e25505bd3 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1084,7 +1084,7 @@ static FeatureWordInfo
> feature_word_info[FEATURE_WORDS] = {
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, "md-clear", NULL,
>              NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL /* pconfig */, NULL,
> +            NULL, NULL, "pconfig", NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, "spec-ctrl", "stibp",
>              NULL, "arch-capabilities", "core-capability", "ssbd",
> @@ -1095,6 +1095,12 @@ static FeatureWordInfo
> feature_word_info[FEATURE_WORDS] = {
>              .reg = R_EDX,
>          },
>          .tcg_features = TCG_7_0_EDX_FEATURES,
> +        /*
> +         * CPU state altered by the PCONFIG instruction (e.g. MKTME key
> table)
> +         * is not migrated by QEMU yet, so PCONFIG is unmigratable until
> +         * this is implemented.
> +         */
> +        .unmigratable_flags = CPUID_7_0_EDX_PCONFIG,
>      },
>      [FEAT_7_1_EAX] = {
>          .type = CPUID_FEATURE_WORD,
> --
> 2.21.0
>
>

--0000000000006ab28f05937bdf03
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Is this really needed? QEMU&#39;s value of pconfig=
=3Don vs. off should be provided by QMP CPU model queries, if a property is=
 not available then Libvirt should not try to set it to off.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo<br><br><div class=3D"gmail_quot=
e" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 26 set 2019, 2=
3:23 Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@re=
dhat.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">QEMU 3=
.1.0 was shipped with the &quot;pconfig&quot; CPU property available,<br>
added by commit 5131dc433df5 (&quot;i386: Add CPUID bit for PCONFIG&quot;).=
<br>
<br>
Then the feature was removed in QEMU 4.0.0 (and 3.1.1), by commit<br>
712f807e1965 (&quot;Revert &#39;i386: Add CPUID bit for PCONFIG&#39;&quot;)=
.<br>
<br>
In theory this would be OK, but we do have a problem: existing<br>
software (like libvirt) was already using &quot;pconfig=3Doff&quot; since<b=
r>
QEMU 3.1.0 on some cases.=C2=A0 This means software that worked with<br>
QEMU 3.1.0 doesn&#39;t work with QEMU 3.1.1 and newer.<br>
<br>
One symptom is the following error being generated by<br>
virt-install while trying to use the &#39;host-model&#39; CPU model, on a<b=
r>
host that&#39;s identified as Icelake-Server:<br>
<br>
=C2=A0 ERROR=C2=A0 =C2=A0 internal error: qemu unexpectedly closed the moni=
tor: \<br>
=C2=A0 =C2=A0 =C2=A0 2019-09-24T22:57:42.550032Z qemu-kvm: \<br>
=C2=A0 =C2=A0 =C2=A0 can&#39;t apply global Icelake-Server-x86_64-cpu.pconf=
ig=3Doff: Property &#39;.pconfig&#39; not found<br>
<br>
Re-add &quot;pconfig&quot; to feature_word_info[FEAT_7_0_EDX].feat_names so=
<br>
&quot;pconfig=3Doff&quot; will work again.<br>
<br>
This change still won&#39;t let users set &quot;monitor=3Don&quot; because =
all<br>
accelerators currently report the feature as unsupported.=C2=A0 But to<br>
make sure PCONFIG won&#39;t be enabled by accident in the future<br>
before we implement the necessary migration code, also add the<br>
feature to .unmigratable_flags.<br>
<br>
Fixes: 712f807e1965 (&quot;Revert &#39;i386: Add CPUID bit for PCONFIG&#39;=
&quot;)<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">ehabkost@redhat.com</a>&gt;<br>
---<br>
=C2=A0target/i386/cpu.h | 2 ++<br>
=C2=A0target/i386/cpu.c | 8 +++++++-<br>
=C2=A02 files changed, 9 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/target/i386/cpu.h b/target/i386/cpu.h<br>
index 8e090acd74..b728bd22f1 100644<br>
--- a/target/i386/cpu.h<br>
+++ b/target/i386/cpu.h<br>
@@ -731,6 +731,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];<br>
=C2=A0#define CPUID_7_0_EDX_AVX512_4VNNIW=C2=A0 =C2=A0 =C2=A0(1U &lt;&lt; 2=
)<br>
=C2=A0/* AVX512 Multiply Accumulation Single Precision */<br>
=C2=A0#define CPUID_7_0_EDX_AVX512_4FMAPS=C2=A0 =C2=A0 =C2=A0(1U &lt;&lt; 3=
)<br>
+/* PCONFIG Instruction */<br>
+#define CPUID_7_0_EDX_PCONFIG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1U =
&lt;&lt; 18)<br>
=C2=A0/* Speculation Control */<br>
=C2=A0#define CPUID_7_0_EDX_SPEC_CTRL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1U =
&lt;&lt; 26)<br>
=C2=A0/* Arch Capabilities */<br>
diff --git a/target/i386/cpu.c b/target/i386/cpu.c<br>
index 71034aeb5a..3e25505bd3 100644<br>
--- a/target/i386/cpu.c<br>
+++ b/target/i386/cpu.c<br>
@@ -1084,7 +1084,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORD=
S] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, NULL, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, &quot;md-clear&=
quot;, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, NULL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL, NULL /* pconfig */, =
NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL, &quot;pconfig&quot;,=
 NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, NULL, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, &quot;spec-ctrl=
&quot;, &quot;stibp&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, &quot;arch-capabiliti=
es&quot;, &quot;core-capability&quot;, &quot;ssbd&quot;,<br>
@@ -1095,6 +1095,12 @@ static FeatureWordInfo feature_word_info[FEATURE_WOR=
DS] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.reg =3D R_EDX,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.tcg_features =3D TCG_7_0_EDX_FEATURES,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* CPU state altered by the PCONFIG instr=
uction (e.g. MKTME key table)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* is not migrated by QEMU yet, so PCONFI=
G is unmigratable until<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* this is implemented.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .unmigratable_flags =3D CPUID_7_0_EDX_PCONFIG,=
<br>
=C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0[FEAT_7_1_EAX] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D CPUID_FEATURE_WORD,<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div></div></div>

--0000000000006ab28f05937bdf03--

