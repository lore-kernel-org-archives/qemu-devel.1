Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FA4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01AA22582
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3fre6dP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01AA22582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvP2O-0007Qv-Uo
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 13:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jvP1o-0006th-H0; Tue, 14 Jul 2020 13:47:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:56085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jvP1m-0000TP-TU; Tue, 14 Jul 2020 13:47:40 -0400
Received: by mail-wm1-x342.google.com with SMTP id g75so7495181wme.5;
 Tue, 14 Jul 2020 10:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TEqivOCHfZ33LaJ1/9p3UazZrDIw97LiCSr9fJSLwMA=;
 b=Z3fre6dP4Ckm5PujWQRqGWB7GRhmM/fEwITa0Mce6ySsZPpSRo8JLIkvLlRjM/dsDz
 ufLlQJmGb/x9V6aM61A7IdnupnXaZWJBMDqkKqvj1jD8Mv/7d5YQf6cHNkpqvHc1K9Ht
 PgQAFyyU9HBnh13/EGlw+MRK0GqeulUwNHehnfBgQMRJpySdNdf/61avaqzb8sdnDlqQ
 pjqzWmgQmzGwG5rA1HbjVjk+JPT9Im+4zxyA8Ow1R0FNGVNEJC4/g/VNSUC+QBLE8MLf
 19HBSLqzjbBzvu8qwOuraw2/Pc3zWirxcHxgZVeHsgw9FgU35NFQDtybVwY2M430a9fH
 YaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TEqivOCHfZ33LaJ1/9p3UazZrDIw97LiCSr9fJSLwMA=;
 b=SlEF0CxFYViNMbMSsdeJD+aB0VjegfL31WwBNFQ1K3wD8yYxTh4vdgzJZMDlb8KdmT
 3c3Q9kqnhx8r8CRsMJELNt51BbkoDhyfkZ2eARWNMhK+u7a7MSYVL9eOh6YdqUj9U48k
 JrnhP5LVvd6ySMohwUgZ21ka7bYEHz3MjAJtjUypOJw1Aw5fPY+bO/uEcYP5v3SIm/Cg
 UJurc34Ee9a91/p58DE9jo9ltSf4WHGrtjsNgYyB8rTWLQXwKqXpal+GRBgHuN5P88RT
 /0aVW5pgReAVxI7Ud/iLYhU1KS0K8Q5Mp2IcnW1bWOUs4TlnMf+OHbNUeCtP2BUxpHDv
 Fhqg==
X-Gm-Message-State: AOAM531utxfykW/AH224xdhcisp817cJGdQIzk/uUgCm2oUdu+YR1NhA
 PY6Q7WDPvgZwBaz9vamQ9NepDUf4jUirbgZSwsDN1eKIzJE=
X-Google-Smtp-Source: ABdhPJwPwIOFYKKHe9Qtdt0sVRhHlqEmdzfmWTrOWChQ7mA23InrRS/dVEN5emFdZoDKi6ELW3+MjNmYTSDpXJS7CKs=
X-Received: by 2002:a1c:80c8:: with SMTP id b191mr4807576wmd.37.1594748856014; 
 Tue, 14 Jul 2020 10:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201625.4177419-1-stefanb@linux.vnet.ibm.com>
 <20200707201625.4177419-2-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200707201625.4177419-2-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Jul 2020 21:47:23 +0400
Message-ID: <CAJ+F1CJrf27kbfHun=xfGBAgAU1m2ib-U79Xp3dFRD9Evw=oMg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tpm: tpm_spapr: Exit on TPM backend failures
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000119c4405aa6a67e9"
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000119c4405aa6a67e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jul 8, 2020 at 12:17 AM Stefan Berger <stefanb@linux.vnet.ibm.com>
wrote:

> Exit on TPM backend failures in the same way as the TPM CRB and TIS devic=
e
> models do. With this change we now get an error report when the backend
> did not start up properly:
>
> error: internal error: qemu unexpectedly closed the monitor:
> 2020-07-07T12:49:28.333928Z qemu-system-ppc64: tpm-emulator: \
>   TPM result for CMD_INIT: 0x101 operation failed
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  hw/tpm/tpm_spapr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
> index cb4dfd1e6a..8288ab0a15 100644
> --- a/hw/tpm/tpm_spapr.c
> +++ b/hw/tpm/tpm_spapr.c
> @@ -306,7 +306,10 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)
>                              TPM_SPAPR_BUFFER_MAX);
>
>      tpm_backend_reset(s->be_driver);
> -    tpm_spapr_do_startup_tpm(s, s->be_buffer_size);
> +
> +    if (tpm_spapr_do_startup_tpm(s, s->be_buffer_size) < 0) {
> +        exit(1);
> +    }
>

Not ideal, but consistent with CRB & TIS.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

 }
>
>  static enum TPMVersion tpm_spapr_get_version(TPMIf *ti)
> --
> 2.24.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000119c4405aa6a67e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 8, 2020 at 12:17 AM Ste=
fan Berger &lt;<a href=3D"mailto:stefanb@linux.vnet.ibm.com">stefanb@linux.=
vnet.ibm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Exit on TPM backend failures in the same way as the TPM CRB and=
 TIS device<br>
models do. With this change we now get an error report when the backend<br>
did not start up properly:<br>
<br>
error: internal error: qemu unexpectedly closed the monitor:<br>
2020-07-07T12:49:28.333928Z qemu-system-ppc64: tpm-emulator: \<br>
=C2=A0 TPM result for CMD_INIT: 0x101 operation failed<br>
<br>
Signed-off-by: Stefan Berger &lt;<a href=3D"mailto:stefanb@linux.ibm.com" t=
arget=3D"_blank">stefanb@linux.ibm.com</a>&gt;<br>
---<br>
=C2=A0hw/tpm/tpm_spapr.c | 5 ++++-<br>
=C2=A01 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c<br>
index cb4dfd1e6a..8288ab0a15 100644<br>
--- a/hw/tpm/tpm_spapr.c<br>
+++ b/hw/tpm/tpm_spapr.c<br>
@@ -306,7 +306,10 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TPM_SPAPR_BUFFER_MAX);<br>
<br>
=C2=A0 =C2=A0 =C2=A0tpm_backend_reset(s-&gt;be_driver);<br>
-=C2=A0 =C2=A0 tpm_spapr_do_startup_tpm(s, s-&gt;be_buffer_size);<br>
+<br>
+=C2=A0 =C2=A0 if (tpm_spapr_do_startup_tpm(s, s-&gt;be_buffer_size) &lt; 0=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>Not ideal, but consist=
ent with CRB &amp; TIS.</div><div><br></div><div>Reviewed-by: Marc-Andr=C3=
=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lur=
eau@redhat.com</a>&gt;</div><div> <br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
=C2=A0}<br>
<br>
=C2=A0static enum TPMVersion tpm_spapr_get_version(TPMIf *ti)<br>
-- <br>
2.24.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000119c4405aa6a67e9--

