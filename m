Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3B7C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C3C20772
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjF0PMXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C3C20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrl0I-0006UN-FW
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jrkys-0004Y2-V6; Sat, 04 Jul 2020 12:25:34 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:35354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jrkyr-0002DO-62; Sat, 04 Jul 2020 12:25:34 -0400
Received: by mail-io1-xd43.google.com with SMTP id v8so35175238iox.2;
 Sat, 04 Jul 2020 09:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=siYZvVhE9VeBBvLQIX/nnAed+rLIHn4bVXcuyvDsWaw=;
 b=pjF0PMXkE9pbfyA44NA0kCnTofn8BML3M2OwLhH+Sqsxxe1sGclQdp8aRABF6oUm7p
 jl3jluIF8Iod+vAQYD9a9T9hizpvwz6WnAjoWUqHG6YxzqwkxwFtal6rAmecurpCeu63
 HodGkRhRHtWuT2Pe9TYLrfl5xbRYOk9LLYdPHTMPdK0DhgKFqlWb+OJKfZYFsG/Mgude
 iMrzKgB1Y747nHlXa24vTJmzsISKSK+ZiOvur0XiEJN8zeFh9UgKrjT9VXbPu7hZm6iB
 4IkItqkdEv9WRqjf/co0WnxmfLXBQ+uTU17T3TFxcuXcGW+OlroDBON4fZDJU7C+YvxT
 s7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=siYZvVhE9VeBBvLQIX/nnAed+rLIHn4bVXcuyvDsWaw=;
 b=Ur1TxrUvsEojZNOW1oH3y523YTzrUAodO1m2GD8Yk2/NVggs7/CEtFMzqMnCsEzl28
 xXtbf0OddWquERw7B03dj0cfY9+CQQ1+hxtJi9neg2RYijQAeuiezQr48KkJYxBpg1Jt
 PsWdlrcjZ8k3GQkftK5IEvxdx0sYVFkL+sCQolLWYj4Mj/gAaxFeou9JFnogszvD8HCY
 eoxXqdBQAKFbj2oluxLngQ/WjULyfJK7YqEsWRLoXPVp2ASBCNta3VZ7stNsddQ/jXAg
 snnkzgh9aIsDdh9nZ3nqo9MXO8gc9cQNDw5zA+9gke+IQnSEx5G2rE+PLXoD1QiNb44U
 4rsA==
X-Gm-Message-State: AOAM531gkq379GngljReOhM3QtxZXrqfCCiyfjwmBGVOuRYlt8HqUxO1
 JxnI5ppPm0Xp0hRcMk2+4nIvXuiJmTHMzQqnA90=
X-Google-Smtp-Source: ABdhPJwZwrn7vzEIJbGYJoQZG3XTTSfTQJEX4yl2ivSAb5nZSnnjPxLr+c9nvkov/DkXTccC1tmUb5GLEFGW3coDSTU=
X-Received: by 2002:a6b:8e56:: with SMTP id q83mr17709001iod.61.1593879930979; 
 Sat, 04 Jul 2020 09:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-27-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-27-f4bug@amsat.org>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Sat, 4 Jul 2020 09:25:20 -0700
Message-ID: <CADBGO7832C0Rw+RbZBRuDAGGtwhk9RV+bHVBHe+EXxLupbqfig@mail.gmail.com>
Subject: Re: [PATCH 26/26] MAINTAINERS: Cover dwc-hsotg (dwc2) USB host
 controller emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000019cac205a9a017dd"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=pauldzim@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Leif Lindholm <leif@nuviainc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000019cac205a9a017dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2020 at 7:50 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> Add an section for the dwc2 host controller emulation
> introduced in commit 153ef1662c.
>
> Cc: Paul Zimmerman <pauldzim@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2566566d72..e3f895bc6e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1651,6 +1651,12 @@ M: Samuel Thibault <samuel.thibault@ens-lyon.org>
>  S: Maintained
>  F: hw/usb/dev-serial.c
>
> +USB dwc-hsotg (dwc2)
> +M: Gerd Hoffmann <kraxel@redhat.com>
> +R: Paul Zimmerman <pauldzim@gmail.com>
> +S: Maintained
> +F: hw/usb/*dwc2*
> +
>  VFIO
>  M: Alex Williamson <alex.williamson@redhat.com>
>  S: Supported


Acked-by: Paul Zimmerman <pauldzim@gmail.com>


> --
> 2.21.3
>
>

--00000000000019cac205a9a017dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Sat, Jul 4, 2020 at 7:50 AM Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">Add an section for the dwc2 host control=
ler emulation<br>
introduced in commit 153ef1662c.<br>
<br>
Cc: Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@gmail.com" target=3D"_bla=
nk">pauldzim@gmail.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 6 ++++++<br>
=C2=A01 file changed, 6 insertions(+)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 2566566d72..e3f895bc6e 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -1651,6 +1651,12 @@ M: Samuel Thibault &lt;<a href=3D"mailto:samuel.thib=
ault@ens-lyon.org" target=3D"_blank">samuel.thibault@ens-lyon.org</a>&gt;<b=
r>
=C2=A0S: Maintained<br>
=C2=A0F: hw/usb/dev-serial.c<br>
<br>
+USB dwc-hsotg (dwc2)<br>
+M: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
+R: Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@gmail.com" target=3D"_bla=
nk">pauldzim@gmail.com</a>&gt;<br>
+S: Maintained<br>
+F: hw/usb/*dwc2*<br>
+<br>
=C2=A0VFIO<br>
=C2=A0M: Alex Williamson &lt;<a href=3D"mailto:alex.williamson@redhat.com" =
target=3D"_blank">alex.williamson@redhat.com</a>&gt;<br>
=C2=A0S: Supported</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto=
">Acked-by: Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@gmail.com">pauldz=
im@gmail.com</a>&gt;</div><div dir=3D"auto"><br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><br>
-- <br>
2.21.3<br>
<br>
</blockquote></div></div>

--00000000000019cac205a9a017dd--

