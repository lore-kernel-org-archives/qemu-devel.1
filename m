Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDF0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D042070A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D042070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwRIo-0000MW-42
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jwRI0-0007w2-5S
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:24:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jwRHy-0000d9-5e
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:24:39 -0400
Received: from mail-vk1-f200.google.com ([209.85.221.200])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jwRHw-0003DG-Vr
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:24:37 +0000
Received: by mail-vk1-f200.google.com with SMTP id r80so3352476vkf.12
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 07:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ex3Drp2/xMrM7bWHQG+JNvv9Yuyz9bB342f6DEV+G0Q=;
 b=ogVfmeUEXcfiZAYkiY7dpdwyX/1I1sNgv6u5e+m18vo2h99+buxzlvsv6ttLSew0xO
 /oSururER7Mi5RKHFzi0aPjQF4l7+kkJuZfREPgaJSSjuQJn2tm0Fp81KwM+xcoUBFa1
 eDqaHmE0dG81Rm4SFM271UH/wlUwEkF+zHJFProZQ4GsaOBcUNvhfVXj1kWaFc5Qge+p
 TnAUdbRDjFqbAzGfmK1p8SSfGd5hNrJB5imp1AaBJb+SimgUYe9OkYmGdn4nvKzYdYJi
 AbSQr37huMuvNQwbrZMBE6MIc/OpvBWZzPw5eTFTaO30cjInKhbt/PEYrayUPAynyvtM
 PrNQ==
X-Gm-Message-State: AOAM532XEeQGyMvsO776hLzwaRReQnvT5byAVM9Q9u8YswKg0Z2QOZbL
 QuJ0kqNfKvOEba2OpsxBs0v4a1PqyjzEZv/JII5ij7qvA6NNUv4kq85x3zTtAxFsnw4Kgxmpmkr
 V/jdI4myziImgz3nUtGU9b9aQjfHp+I4vavQRL+nUnTy1jgmH
X-Received: by 2002:a67:330e:: with SMTP id z14mr7050152vsz.94.1594995874787; 
 Fri, 17 Jul 2020 07:24:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyob3uXUXm1kuDddT7XKCyVaxJKUPRLkW/Hah1wKg6Fmx5agU32+fL4jpmkVHaRXkYSn9I4fdDZDyH3zdbF+74=
X-Received: by 2002:a67:330e:: with SMTP id z14mr7050138vsz.94.1594995874576; 
 Fri, 17 Jul 2020 07:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200717105139.25293-1-alex.bennee@linaro.org>
 <20200717105139.25293-5-alex.bennee@linaro.org>
 <alpine.BSF.2.22.395.2007171529440.1227@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2007171529440.1227@zero.eik.bme.hu>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Fri, 17 Jul 2020 16:24:08 +0200
Message-ID: <CAATJJ0+JV0PFcPBdr5CbMnQF2FZrSe7B0g0fGmzOobHhjOdfJg@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] util: add qemu_get_host_physmem utility function
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: multipart/alternative; boundary="00000000000085e7cb05aaa3eaa2"
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=christian.ehrhardt@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 09:40:52
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, "Daniel P. Berrange" <berrange@redhat.com>,
 richard.henderson@linaro.org, qemu-devel <qemu-devel@nongnu.org>,
 f4bug@amsat.org, cota@braap.org, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000085e7cb05aaa3eaa2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 3:32 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On Fri, 17 Jul 2020, Alex Benn=C3=A9e wrote:
> > This will be used in a future patch. For POSIX systems _SC_PHYS_PAGES
> > isn't standardised but at least appears in the man pages for
> > Open/FreeBSD. The result is advisory so any users of it shouldn't just
> > fail if we can't work it out.
> >
> > The win32 stub currently returns 0 until someone with a Windows system
> > can develop and test a patch.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Cc: BALATON Zoltan <balaton@eik.bme.hu>
> > Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> > ---
> > include/qemu/osdep.h | 10 ++++++++++
> > util/oslib-posix.c   | 11 +++++++++++
> > util/oslib-win32.c   |  6 ++++++
> > 3 files changed, 27 insertions(+)
> >
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index 4841b5c6b5f..7ff209983e2 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -665,4 +665,14 @@ static inline void qemu_reset_optind(void)
> >  */
> > char *qemu_get_host_name(Error **errp);
> >
> > +/**
> > + * qemu_get_host_physmem:
> > + *
> > + * Operating system agnostiv way of querying host memory.
>
> Typo: agnostiv -> agnostic
>
> > + *
> > + * Returns amount of physical memory on the system. This is purely
> > + * advisery and may return 0 if we can't work it out.
> > + */
> > +size_t qemu_get_host_physmem(void);
> > +
> > #endif
> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > index 36bf8593f8c..d9da782b896 100644
> > --- a/util/oslib-posix.c
> > +++ b/util/oslib-posix.c
> > @@ -839,3 +839,14 @@ char *qemu_get_host_name(Error **errp)
> >
> >     return g_steal_pointer(&hostname);
> > }
> > +
> > +size_t qemu_get_host_physmem(void)
> > +{
> > +#ifdef _SC_PHYS_PAGES
> > +    long pages =3D sysconf(_SC_PHYS_PAGES);
> > +    if (pages > 0) {
> > +        return pages * qemu_real_host_page_size;
>
> The Linux man page warns that this product may overflow so maybe you coul=
d
> return pages here.
>

The caller might be even less aware of that than this function - so maybe
better handle it here.
How about handling overflows and cutting it to MiB before returning?


> > +    }
> > +#endif
> > +    return 0;
> > +}
> > diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> > index 7eedbe5859a..31030463cc9 100644
> > --- a/util/oslib-win32.c
> > +++ b/util/oslib-win32.c
> > @@ -828,3 +828,9 @@ char *qemu_get_host_name(Error **errp)
> >
> >     return g_utf16_to_utf8(tmp, size, NULL, NULL, NULL);
> > }
> > +
> > +size_t qemu_get_host_physmem(void)
> > +{
> > +    /* currently unimplemented */
> > +    return 0;
> > +}
>
> For Windows this may help:
>
> https://stackoverflow.com/questions/5553665/get-ram-system-size
>
> not sure about other OSes.
>
> Regards,
> BALATON Zoltan



--=20
Christian Ehrhardt
Staff Engineer, Ubuntu Server
Canonical Ltd

--00000000000085e7cb05aaa3eaa2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 17, 2020 at 3:32 PM BALAT=
ON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fr=
i, 17 Jul 2020, Alex Benn=C3=A9e wrote:<br>
&gt; This will be used in a future patch. For POSIX systems _SC_PHYS_PAGES<=
br>
&gt; isn&#39;t standardised but at least appears in the man pages for<br>
&gt; Open/FreeBSD. The result is advisory so any users of it shouldn&#39;t =
just<br>
&gt; fail if we can&#39;t work it out.<br>
&gt;<br>
&gt; The win32 stub currently returns 0 until someone with a Windows system=
<br>
&gt; can develop and test a patch.<br>
&gt;<br>
&gt; Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@lina=
ro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
&gt; Cc: BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu" target=3D=
"_blank">balaton@eik.bme.hu</a>&gt;<br>
&gt; Cc: Christian Ehrhardt &lt;<a href=3D"mailto:christian.ehrhardt@canoni=
cal.com" target=3D"_blank">christian.ehrhardt@canonical.com</a>&gt;<br>
&gt; ---<br>
&gt; include/qemu/osdep.h | 10 ++++++++++<br>
&gt; util/oslib-posix.c=C2=A0 =C2=A0| 11 +++++++++++<br>
&gt; util/oslib-win32.c=C2=A0 =C2=A0|=C2=A0 6 ++++++<br>
&gt; 3 files changed, 27 insertions(+)<br>
&gt;<br>
&gt; diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h<br>
&gt; index 4841b5c6b5f..7ff209983e2 100644<br>
&gt; --- a/include/qemu/osdep.h<br>
&gt; +++ b/include/qemu/osdep.h<br>
&gt; @@ -665,4 +665,14 @@ static inline void qemu_reset_optind(void)<br>
&gt;=C2=A0 */<br>
&gt; char *qemu_get_host_name(Error **errp);<br>
&gt;<br>
&gt; +/**<br>
&gt; + * qemu_get_host_physmem:<br>
&gt; + *<br>
&gt; + * Operating system agnostiv way of querying host memory.<br>
<br>
Typo: agnostiv -&gt; agnostic<br>
<br>
&gt; + *<br>
&gt; + * Returns amount of physical memory on the system. This is purely<br=
>
&gt; + * advisery and may return 0 if we can&#39;t work it out.<br>
&gt; + */<br>
&gt; +size_t qemu_get_host_physmem(void);<br>
&gt; +<br>
&gt; #endif<br>
&gt; diff --git a/util/oslib-posix.c b/util/oslib-posix.c<br>
&gt; index 36bf8593f8c..d9da782b896 100644<br>
&gt; --- a/util/oslib-posix.c<br>
&gt; +++ b/util/oslib-posix.c<br>
&gt; @@ -839,3 +839,14 @@ char *qemu_get_host_name(Error **errp)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0return g_steal_pointer(&amp;hostname);<br>
&gt; }<br>
&gt; +<br>
&gt; +size_t qemu_get_host_physmem(void)<br>
&gt; +{<br>
&gt; +#ifdef _SC_PHYS_PAGES<br>
&gt; +=C2=A0 =C2=A0 long pages =3D sysconf(_SC_PHYS_PAGES);<br>
&gt; +=C2=A0 =C2=A0 if (pages &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return pages * qemu_real_host_page_size;<=
br>
<br>
The Linux man page warns that this product may overflow so maybe you could =
<br>
return pages here.<br></blockquote><div><br></div><div>The caller might be =
even less aware of that than this function - so maybe better handle it here=
.</div><div>How about handling overflows and cutting it to MiB before retur=
ning?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; diff --git a/util/oslib-win32.c b/util/oslib-win32.c<br>
&gt; index 7eedbe5859a..31030463cc9 100644<br>
&gt; --- a/util/oslib-win32.c<br>
&gt; +++ b/util/oslib-win32.c<br>
&gt; @@ -828,3 +828,9 @@ char *qemu_get_host_name(Error **errp)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0return g_utf16_to_utf8(tmp, size, NULL, NULL, NULL)=
;<br>
&gt; }<br>
&gt; +<br>
&gt; +size_t qemu_get_host_physmem(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* currently unimplemented */<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
<br>
For Windows this may help:<br>
<br>
<a href=3D"https://stackoverflow.com/questions/5553665/get-ram-system-size"=
 rel=3D"noreferrer" target=3D"_blank">https://stackoverflow.com/questions/5=
553665/get-ram-system-size</a><br>
<br>
not sure about other OSes.<br>
<br>
Regards,<br>
BALATON Zoltan</blockquote></div><br clear=3D"all"><div><br></div>-- <br><d=
iv dir=3D"ltr" class=3D"gmail_signature">Christian Ehrhardt<br>Staff Engine=
er, Ubuntu Server<br>Canonical Ltd</div></div>

--00000000000085e7cb05aaa3eaa2--

