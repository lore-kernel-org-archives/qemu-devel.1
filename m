Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A5CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02AF20656
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTLaK9fK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02AF20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyEt-0003wn-2E
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jyyDQ-0002Pg-OU
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:58:25 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jyyDN-00073B-23
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:58:24 -0400
Received: by mail-wr1-x444.google.com with SMTP id r4so5446878wrx.9
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fK8G8vsXTaMxYMeQBYEmiliHgY72d4w087OBu+g8CNU=;
 b=pTLaK9fKhT/D4sD2nLeXhXRvvLKN7OnoyiokR2+jYq9roWPpcq8zwrH5km0YwzOfWw
 0Twpd7hJcywzz21WrS3dsx31k7xUohMt90C1U8JVlqeVyvVR0PSGszGstp9CbqTcGmOY
 XFRDcFwf7O8VRxe7XiZClsHTrtaXFQGxDpbVxGSUZqAevP02vqOKEFFeJRXSaFOxaAHl
 D7ZV76Y2f4QWId5MCCp2c4q8Rq6sQZm4kiAwF/S/nAXsivi5iVIz3q9vMdOJ2SaIEVTl
 yQPI+iRvRdHW9BLdzpZHjuuaVCqXEjLwLCTb2pcIWYZKfl7z29Osp7mTWmL/bwEXMkER
 UQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fK8G8vsXTaMxYMeQBYEmiliHgY72d4w087OBu+g8CNU=;
 b=hbtJyqy4MVmKD92quRMTD93iMhCyrgmeYWzozWuMRKfW6v+XTxZi4IdcCFrIrZNeBn
 5d3BJ2aAQUB1f9chAOc/ckQrdcc8nTzLYijZjXZpm0FqA6/ySD31JBAAH9UKnh4MNdk0
 A2IOXkNCQmvyjFKfgdb5JDetAo0Lji2CgiEztbNi78izwbUeo+PPQ/4K5VV02BWNqELW
 O5M1rr0yir4F2G1G+DzsWBnUvdYt7ASj6P4vMJiUXdVnLlIG0uE9gmISynG3QgZbafWO
 HkGGcaFucKIohgbai5dChXryI61/prVwT4orkVNNMByInTuRCmTfiryMBzYSPECaJ8QU
 gMSg==
X-Gm-Message-State: AOAM5323GTfROQhp4Ss4b1vGWMWggwTmmlo/LhGUsANY2Snba7RdokW8
 Mhish1CgKkBqMUC3tJ+94xojzcJ/btRxXV9y2IA=
X-Google-Smtp-Source: ABdhPJy+JtQrUgIszTkYWe3Zbq6Vuo6giMfwzpzSgS3kmuxpVRyWDQ7sV0c2Jgel//NpciRV4GLCaCEoW/I/3vfEpgc=
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr9044118wrp.96.1595599099085;
 Fri, 24 Jul 2020 06:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200724133011.2488055-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200724133011.2488055-1-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 24 Jul 2020 17:58:07 +0400
Message-ID: <CAJ+F1C+x6ET7CxwzT+xKsNZkkKbBLm2xwJQ2zT3sQ_dO9yjb9A@mail.gmail.com>
Subject: Re: [PATCH] tpm_emulator: Report an error if chardev is missing
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary="00000000000081465e05ab305dfa"
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000081465e05ab305dfa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 5:30 PM Stefan Berger <stefanb@linux.vnet.ibm.com>
wrote:

> This patch fixes the odd error reporting when trying to send a file
> descriptor to the TPM emulator if one has not passed a valid chardev.
>
> $ x86_64-softmmu/qemu-system-x86_64 -tpmdev emulator,id=3Dtpm0
> qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0: tpm-emulator: Failed to s=
end
> CMD_SET_DATAFD: Success
> qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0: tpm-emulator: Could not
> cleanly shutdown the TPM: Success
>
> This is the new error report:
>
> $ x86_64-softmmu/qemu-system-x86_64 -tpmdev emulator,id=3Dtpm0
> qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0: tpm-emulator: missing cha=
rdev
>
> This change does not hide the display of supported TPM types if a
> non-existent type is passed:
>
> $ x86_64-softmmu/qemu-system-x86_64 -tpmdev nonexistent,id=3Dtpm0
> qemu-system-x86_64: -tpmdev nonexistent,id=3Dtpm0: Parameter 'type' expec=
ts
> a TPM backend type
> Supported TPM types (choose only one):
>  passthrough   Passthrough TPM backend driver
>     emulator   TPM emulator backend driver
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  backends/tpm/tpm_emulator.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 9605339f93..55cbc9c60e 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -568,6 +568,9 @@ static int tpm_emulator_handle_device_opts(TPMEmulato=
r
> *tpm_emu, QemuOpts *opts)
>          }
>
>          tpm_emu->options->chardev =3D g_strdup(value);
> +    } else {
> +        error_report("tpm-emulator: missing chardev");
> +        goto err;
>      }
>
>      if (tpm_emulator_prepare_data_fd(tpm_emu) < 0) {
> @@ -925,6 +928,11 @@ static void tpm_emulator_shutdown(TPMEmulator
> *tpm_emu)
>  {
>      ptm_res res;
>
> +    if (!tpm_emu->options->chardev) {
> +        /* was never properly initialized */
> +        return;
> +    }
> +
>      if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SHUTDOWN, &res, 0, sizeof(res)=
)
> < 0) {
>          error_report("tpm-emulator: Could not cleanly shutdown the TPM:
> %s",
>                       strerror(errno));
> --
> 2.24.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000081465e05ab305dfa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 24, 2020 at 5:30 PM Stefa=
n Berger &lt;<a href=3D"mailto:stefanb@linux.vnet.ibm.com">stefanb@linux.vn=
et.ibm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">This patch fixes the odd error reporting when trying to send a f=
ile<br>
descriptor to the TPM emulator if one has not passed a valid chardev.<br>
<br>
$ x86_64-softmmu/qemu-system-x86_64 -tpmdev emulator,id=3Dtpm0<br>
qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0: tpm-emulator: Failed to sen=
d CMD_SET_DATAFD: Success<br>
qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0: tpm-emulator: Could not cle=
anly shutdown the TPM: Success<br>
<br>
This is the new error report:<br>
<br>
$ x86_64-softmmu/qemu-system-x86_64 -tpmdev emulator,id=3Dtpm0<br>
qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0: tpm-emulator: missing chard=
ev<br>
<br>
This change does not hide the display of supported TPM types if a non-exist=
ent type is passed:<br>
<br>
$ x86_64-softmmu/qemu-system-x86_64 -tpmdev nonexistent,id=3Dtpm0<br>
qemu-system-x86_64: -tpmdev nonexistent,id=3Dtpm0: Parameter &#39;type&#39;=
 expects a TPM backend type<br>
Supported TPM types (choose only one):<br>
=C2=A0passthrough=C2=A0 =C2=A0Passthrough TPM backend driver<br>
=C2=A0 =C2=A0 emulator=C2=A0 =C2=A0TPM emulator backend driver<br>
<br>
Signed-off-by: Stefan Berger &lt;<a href=3D"mailto:stefanb@linux.ibm.com" t=
arget=3D"_blank">stefanb@linux.ibm.com</a>&gt;<br></blockquote><div><br></d=
iv><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre=
.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div> <br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0backends/tpm/tpm_emulator.c | 8 ++++++++<br>
=C2=A01 file changed, 8 insertions(+)<br>
<br>
diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c<br>
index 9605339f93..55cbc9c60e 100644<br>
--- a/backends/tpm/tpm_emulator.c<br>
+++ b/backends/tpm/tpm_emulator.c<br>
@@ -568,6 +568,9 @@ static int tpm_emulator_handle_device_opts(TPMEmulator =
*tpm_emu, QemuOpts *opts)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tpm_emu-&gt;options-&gt;chardev =3D g_str=
dup(value);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;tpm-emulator: missing chard=
ev&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (tpm_emulator_prepare_data_fd(tpm_emu) &lt; 0) {<br>
@@ -925,6 +928,11 @@ static void tpm_emulator_shutdown(TPMEmulator *tpm_emu=
)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ptm_res res;<br>
<br>
+=C2=A0 =C2=A0 if (!tpm_emu-&gt;options-&gt;chardev) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* was never properly initialized */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SHUTDOWN, &amp;re=
s, 0, sizeof(res)) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;tpm-emulator: Could no=
t cleanly shutdown the TPM: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 strerror(errno));<br>
-- <br>
2.24.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000081465e05ab305dfa--

