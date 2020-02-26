Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7372AC4BA21
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 19:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E0F20838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 19:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5Dzk0xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E0F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j72jD-0000CQ-6X
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 14:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j72iY-0008C0-Ad
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 14:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j72iW-0005VT-JF
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 14:51:38 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:42343)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j72iW-0005Sh-CI
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 14:51:36 -0500
Received: by mail-io1-xd44.google.com with SMTP id z1so462174iom.9
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 11:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2NMEqmwPemm+6qNd2dVLZgwQhKB4HA80TZ73P4BPnvs=;
 b=J5Dzk0xc7Vewdep0ANbtFuz04X56cc5/FIQb6A2FRR1qCFAc8U+rCIMCDU+S+Xkk3f
 rzOtMKejwsa9sd+mRmo055uLoUzANJVE1gZGcBykwZkVY6qPmA4kRXR1BMygivCefroB
 jLqX4D1zXKvepgG8xIQKjLe9Jl/UoviUv61rrSw5uG1ucOeEUcfIN3HXrVL+KvFN3GtM
 3F3sg9r5zsC5RZ39cvrVlIno7eMirx1Rvzb1+jytQVD6W31gMOX9ZIfgJ1GZKUVWCjpG
 gGj+ELiDArhRfZ08WXmrPWVvTE8m8M6ny8IHclQ9XK9ALDxLy+xYo6UpmrXFXFCEBVoV
 PhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2NMEqmwPemm+6qNd2dVLZgwQhKB4HA80TZ73P4BPnvs=;
 b=lCLMaCvWDsRA1cOdtUpm7ZDoKNfQkkl9K6ms5cEu+3poHgbdYxRYKCcT9B8gjzOml+
 G/LZPESefoeRC0+lPE2JJkLXY8iFi33NArew2FhvC46Uk3yVs7JXCuv7K8RJubC5gzfY
 Q0zNflXAS6mJkqNQjuCehkntR4Dh48Igk+Yv7LD8pCo0L2/vNVAer38Gt498e8TLYh8k
 t4PcNZptlQh88Qhazn7HIGL/PXk8u3LJsbUNuJOcfpgwnvBG1LCOzmZDJy86IsUyrXb1
 GLt9ioPyXh8rcZd+5bbUj/O2GV2M+LGlIjcs7e/t+MYLUNHeEbJNh5zRCFc3jVZTNYpF
 Ww3g==
X-Gm-Message-State: APjAAAVSB++3iqJ1ynyijnM5X+9iuL1Z4V82OyhvnD15npnC2TMKfF9z
 QVZji+YabJ2kZaH2kipZzu6XtKpJKSdJb1SHku0=
X-Google-Smtp-Source: APXvYqwJNZuNMVaWXyjObU+nDQYD2KONFScGeucXc6o9AdaLZ9UWKU4TMKvpN/znRU2oYF8qdnCsTSboqn4fyTvvcIE=
X-Received: by 2002:a6b:7902:: with SMTP id i2mr210407iop.67.1582746693744;
 Wed, 26 Feb 2020 11:51:33 -0800 (PST)
MIME-Version: 1.0
References: <20200226163539.31960-1-imammedo@redhat.com>
 <875zftxl9q.fsf@linaro.org>
In-Reply-To: <875zftxl9q.fsf@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 26 Feb 2020 20:51:22 +0100
Message-ID: <CAPan3WrSnZega5HmVOV+36brCJpsVcC9HLfEcn-0h0389WCcmg@mail.gmail.com>
Subject: Re: [PATCH] softmmu/vl.c: fix too slow TCG regression
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000073437e059f7feefc"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 hsp.cat7@gmail.com, Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000073437e059f7feefc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Igor, Alex,

On Wed, Feb 26, 2020 at 7:21 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Igor Mammedov <imammedo@redhat.com> writes:
>
> > Commit a1b18df9a4 moved -m option parsing after configure_accelerators(=
)
> > that broke TCG accelerator initialization which accesses global ram_siz=
e
> > from size_code_gen_buffer() which is equal to 0 at that moment.
> >
> > Partially revert a1b18df9a4, by returning set_memory_options() to its
> > original location and only keep 32-bit host VA check and 'memory-backen=
d'
> > size check introduced by fe64d06afc at current place.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >
> > PS:
> > This should take care of regression and give more time to think about
> > how to remove size_code_gen_buffer() dependency on ram_size
>

Thanks for your quick response on this! I just applied this patch on top of
latest master (db736e0437aa6fd7c1b7e4599c17f9619ab6b837)
and indeed it seems performance is back to normal. The avocado tests for
cubieboard are also passing again like before.

So for me:
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>


>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> FWIW I don't think it will take too long to fixup size_code_gen_buffer.
> See:
>
>   Subject: [PATCH  v1 0/4] Fix codegen translation cache size
>   Date: Wed, 26 Feb 2020 18:10:16 +0000
>   Message-Id: <20200226181020.19592-1-alex.bennee@linaro.org>
>
> Yeah I saw your patch come by on the list as well Alex. I will try to loo=
k
into it as well.

Regards,
Niek


> > ---
> >  softmmu/vl.c | 49 +++++++++++++++++++++++++------------------------
> >  1 file changed, 25 insertions(+), 24 deletions(-)
> >
> > diff --git a/softmmu/vl.c b/softmmu/vl.c
> > index a9cce78f45..da7577129c 100644
> > --- a/softmmu/vl.c
> > +++ b/softmmu/vl.c
> > @@ -2634,29 +2634,6 @@ static void set_memory_options(uint64_t
> *ram_slots, ram_addr_t *maxram_size,
> >          exit(EXIT_FAILURE);
> >      }
> >
> > -    if (current_machine->ram_memdev_id) {
> > -        Object *backend;
> > -        ram_addr_t backend_size;
> > -
> > -        backend =3D
> object_resolve_path_type(current_machine->ram_memdev_id,
> > -                                           TYPE_MEMORY_BACKEND, NULL);
> > -        backend_size =3D object_property_get_uint(backend, "size",
> &error_abort);
> > -        if (mem_str && backend_size !=3D ram_size) {
> > -                error_report("Size specified by -m option must match
> size of "
> > -                             "explicitly specified 'memory-backend'
> property");
> > -                exit(EXIT_FAILURE);
> > -        }
> > -        ram_size =3D backend_size;
> > -    }
> > -
> > -    if (!xen_enabled()) {
> > -        /* On 32-bit hosts, QEMU is limited by virtual address space *=
/
> > -        if (ram_size > (2047 << 20) && HOST_LONG_BITS =3D=3D 32) {
> > -            error_report("at most 2047 MB RAM can be simulated");
> > -            exit(1);
> > -        }
> > -    }
> > -
> >      loc_pop(&loc);
> >  }
> >
> > @@ -3821,6 +3798,8 @@ void qemu_init(int argc, char **argv, char **envp=
)
> >      machine_class =3D select_machine();
> >      object_set_machine_compat_props(machine_class->compat_props);
> >
> > +    set_memory_options(&ram_slots, &maxram_size, machine_class);
> > +
> >      os_daemonize();
> >
> >      /*
> > @@ -4296,7 +4275,29 @@ void qemu_init(int argc, char **argv, char **env=
p)
> >          current_machine->cpu_type =3D parse_cpu_option(cpu_option);
> >      }
> >
> > -    set_memory_options(&ram_slots, &maxram_size, machine_class);
> > +    if (!xen_enabled()) {
> > +        /* On 32-bit hosts, QEMU is limited by virtual address space *=
/
> > +        if (ram_size > (2047 << 20) && HOST_LONG_BITS =3D=3D 32) {
> > +            error_report("at most 2047 MB RAM can be simulated");
> > +            exit(1);
> > +        }
> > +    }
> > +
> > +    if (current_machine->ram_memdev_id) {
> > +        Object *backend;
> > +        ram_addr_t backend_size;
> > +
> > +        backend =3D
> object_resolve_path_type(current_machine->ram_memdev_id,
> > +                                           TYPE_MEMORY_BACKEND, NULL);
> > +        backend_size =3D object_property_get_uint(backend, "size",
> &error_abort);
> > +        if (backend_size !=3D ram_size) {
> > +                error_report("Size specified by -m option must match
> size of "
> > +                             "explicitly specified 'memory-backend'
> property");
> > +                exit(EXIT_FAILURE);
> > +        }
> > +        ram_size =3D backend_size;
> > +    }
> > +
> >      current_machine->ram_size =3D ram_size;
> >      current_machine->maxram_size =3D maxram_size;
> >      current_machine->ram_slots =3D ram_slots;
>
>
> --
> Alex Benn=C3=A9e
>


--=20
Niek Linnenbank

--00000000000073437e059f7feefc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Igor, Alex,<br></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 26, 2020 at 7:21 PM =
Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@=
linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><br>
Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" target=3D"_blank">=
imammedo@redhat.com</a>&gt; writes:<br>
<br>
&gt; Commit a1b18df9a4 moved -m option parsing after configure_accelerators=
()<br>
&gt; that broke TCG accelerator initialization which accesses global ram_si=
ze<br>
&gt; from size_code_gen_buffer() which is equal to 0 at that moment.<br>
&gt;<br>
&gt; Partially revert a1b18df9a4, by returning set_memory_options() to its<=
br>
&gt; original location and only keep 32-bit host VA check and &#39;memory-b=
ackend&#39;<br>
&gt; size check introduced by fe64d06afc at current place.<br>
&gt;<br>
&gt; Signed-off-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com=
" target=3D"_blank">imammedo@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;<br>
&gt; PS:<br>
&gt; This should take care of regression and give more time to think about<=
br>
&gt; how to remove size_code_gen_buffer() dependency on ram_size<br></block=
quote><div><br></div><div>Thanks for your quick response on this! I just ap=
plied this patch on top of latest master (db736e0437aa6fd7c1b7e4599c17f9619=
ab6b837)</div><div>and indeed it seems performance is back to normal. The a=
vocado tests for cubieboard are also passing again like before.</div><div><=
br></div><div>So for me:<br></div><div>Tested-by: Niek Linnenbank &lt;<a hr=
ef=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;<br>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Tested-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" t=
arget=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
<br>
FWIW I don&#39;t think it will take too long to fixup size_code_gen_buffer.=
<br>
See:<br>
<br>
=C2=A0 Subject: [PATCH=C2=A0 v1 0/4] Fix codegen translation cache size <br=
>
=C2=A0 Date: Wed, 26 Feb 2020 18:10:16 +0000<br>
=C2=A0 Message-Id: &lt;<a href=3D"mailto:20200226181020.19592-1-alex.bennee=
@linaro.org" target=3D"_blank">20200226181020.19592-1-alex.bennee@linaro.or=
g</a>&gt;<br>
<br></blockquote><div>Yeah I saw your patch come by on the list as well Ale=
x. I will try to look into it as well.<br></div><div><br></div><div>Regards=
,</div><div>Niek<br></div><div><br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
&gt; ---<br>
&gt;=C2=A0 softmmu/vl.c | 49 +++++++++++++++++++++++++---------------------=
---<br>
&gt;=C2=A0 1 file changed, 25 insertions(+), 24 deletions(-)<br>
&gt;<br>
&gt; diff --git a/softmmu/vl.c b/softmmu/vl.c<br>
&gt; index a9cce78f45..da7577129c 100644<br>
&gt; --- a/softmmu/vl.c<br>
&gt; +++ b/softmmu/vl.c<br>
&gt; @@ -2634,29 +2634,6 @@ static void set_memory_options(uint64_t *ram_sl=
ots, ram_addr_t *maxram_size,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 if (current_machine-&gt;ram_memdev_id) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 Object *backend;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_addr_t backend_size;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 backend =3D object_resolve_path_type(curr=
ent_machine-&gt;ram_memdev_id,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TYPE_MEMORY_BACKEND, NULL);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 backend_size =3D object_property_get_uint=
(backend, &quot;size&quot;,=C2=A0 &amp;error_abort);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mem_str &amp;&amp; backend_size !=3D =
ram_size) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(=
&quot;Size specified by -m option must match size of &quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;explicitly specified &#39;memory-b=
ackend&#39; property&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAI=
LURE);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_size =3D backend_size;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if (!xen_enabled()) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* On 32-bit hosts, QEMU is limited by vi=
rtual address space */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ram_size &gt; (2047 &lt;&lt; 20) &amp=
;&amp; HOST_LONG_BITS =3D=3D 32) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;at most =
2047 MB RAM can be simulated&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 loc_pop(&amp;loc);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; @@ -3821,6 +3798,8 @@ void qemu_init(int argc, char **argv, char **env=
p)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 machine_class =3D select_machine();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 object_set_machine_compat_props(machine_class-&gt;=
compat_props);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 set_memory_options(&amp;ram_slots, &amp;maxram_size, ma=
chine_class);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 os_daemonize();<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; @@ -4296,7 +4275,29 @@ void qemu_init(int argc, char **argv, char **en=
vp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 current_machine-&gt;cpu_type =3D par=
se_cpu_option(cpu_option);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 set_memory_options(&amp;ram_slots, &amp;maxram_size, ma=
chine_class);<br>
&gt; +=C2=A0 =C2=A0 if (!xen_enabled()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* On 32-bit hosts, QEMU is limited by vi=
rtual address space */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ram_size &gt; (2047 &lt;&lt; 20) &amp=
;&amp; HOST_LONG_BITS =3D=3D 32) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;at most =
2047 MB RAM can be simulated&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (current_machine-&gt;ram_memdev_id) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Object *backend;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_addr_t backend_size;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 backend =3D object_resolve_path_type(curr=
ent_machine-&gt;ram_memdev_id,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TYPE_MEMORY_BACKEND, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 backend_size =3D object_property_get_uint=
(backend, &quot;size&quot;,=C2=A0 &amp;error_abort);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (backend_size !=3D ram_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(=
&quot;Size specified by -m option must match size of &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;explicitly specified &#39;memory-b=
ackend&#39; property&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAI=
LURE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_size =3D backend_size;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 current_machine-&gt;ram_size =3D ram_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 current_machine-&gt;maxram_size =3D maxram_size;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 current_machine-&gt;ram_slots =3D ram_slots;<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000073437e059f7feefc--

