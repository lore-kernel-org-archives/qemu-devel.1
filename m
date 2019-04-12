Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279E3C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24FA20850
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZNh3EvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24FA20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39995 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEzOn-00076Z-UA
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 12:51:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hEzNV-0006B3-6c
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hEzNU-00020q-B3
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:50:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hEzNU-0001zw-0n
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:50:12 -0400
Received: by mail-wr1-x441.google.com with SMTP id k17so8135634wrx.10
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Jo0VUfpR648vKRA6lfxNozVctRL2gzhLlARDrlANnCU=;
	b=iZNh3EvA1zrrdHwUn58LAsYoZDOMJUHsVgwvLtLP7PSgn1YodM7DTD1hZamUScQXfS
	jet1CzJnluAJhCpZt6sXa9sqX43Tl4NNAzCDn6XiHqMYWQjja0JhUVc+TB2/bavyiPZo
	ekbRhN42c5KkdFbepekMbB6m7P7AT8iStmzY704giErI9XMNWDha2WqDis9VgdD9Xkud
	OguYLHWBkDFJMh+37i9+4yL7Tjz1w32ZClikKwVXPNCiQW4bSC9s4U1SmDtKfONuNT6F
	/PBSCQ0Fny/c9pLeDLfmFE0St8qvcmPJxrrwsuC/fdbXuCwFVuqfHj+/nT+XBtNQY9N4
	E+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Jo0VUfpR648vKRA6lfxNozVctRL2gzhLlARDrlANnCU=;
	b=UpTKPittG6gywdU3nIS+a2tDljtQz9zabqZrPkVfxWEVjwTC3kXokySSqOGxempQr9
	Xs2HUDSKFUS+HZCXN8cRPnY59Y0Jy+FUViPksA81q1T5ua7ku8FuhXC78FArcPyQsymn
	8+Bw08SVs8kjYJpONqYec/6W1T0oUA7CV7Sd5jvNduFO2Et1mlB8q0M9TyzCYhaggu3w
	7KuzEd6qcjKkWpbX3p9iUGo2WVnyMgPy/5U9EFT5CYMopwuIbYR12NNkw3DspTIKsfYM
	K3tr94zvsVAlYrGFrYy3cv/zA+zKnVFZ5W/y9saiWftY2FhUN4PNA+fGWdbh9JdUqefJ
	3gsQ==
X-Gm-Message-State: APjAAAWZKmgCrRqWE8vxh4utnteT+8uFfsPF4kTpzKEFKxcPuHKjHjxv
	1TFlbA0MZzQjKtA5WrrwvDktZZq9hZrxv4iSXks=
X-Google-Smtp-Source: APXvYqyOFqHkZ9dsB6NyWc5aZ/E3qldfhze66gG9a9KlPUZNa+EP+3BncHQADyQuRa9ZubB5dQG2gWwxSOztf8XW/oo=
X-Received: by 2002:a5d:6101:: with SMTP id v1mr15492522wrt.222.1555087810525; 
	Fri, 12 Apr 2019 09:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190412163706.3878-1-philmd@redhat.com>
In-Reply-To: <20190412163706.3878-1-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Apr 2019 18:49:58 +0200
Message-ID:
 <CAJ+F1CLOO=cSAnGsR1vXToEhYCtVSUXypJ4fMmoO-T6yp9NNkw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH] vl: Add missing descriptions to the VGA
 adapters list
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Stefano Stabellini <sstabellini@kernel.org>, QEMU <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>,
	Paul Durrant <paul.durrant@citrix.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412164958.eNLA2QUJLt0i1QQhblR5NKEdBFI6zsbD0wxYq7WKFGA@z>

Hi

On Fri, Apr 12, 2019 at 6:37 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Some VGA adapters do not contain an helpful description,
> this can be confusing:
>
>   $ qemu-system-arm -M virt -vga help
>   none
>   std                  standard VGA
>   cirrus               Cirrus VGA (default)
>   vmware               VMWare SVGA
>   xenfb
>
> Add a description to the missing adapters:
>
>   $ qemu-system-arm -M virt -vga help
>   none                 no graphic card
>   std                  standard VGA
>   cirrus               Cirrus VGA (default)
>   vmware               VMWare SVGA
>   xenfb                Xen paravirtualized framebuffer
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Based-on: <20190412152713.16018-1-marcandre.lureau@redhat.com>

nice follow up, thanks
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  vl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/vl.c b/vl.c
> index 840c45c00fa..dfeda8bd7fc 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2029,6 +2029,7 @@ typedef struct VGAInterfaceInfo {
>  static const VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX] =3D {
>      [VGA_NONE] =3D {
>          .opt_name =3D "none",
> +        .name =3D "no graphic card",
>      },
>      [VGA_STD] =3D {
>          .opt_name =3D "std",
> @@ -2067,6 +2068,7 @@ static const VGAInterfaceInfo vga_interfaces[VGA_TY=
PE_MAX] =3D {
>      },
>      [VGA_XENFB] =3D {
>          .opt_name =3D "xenfb",
> +        .name =3D "Xen paravirtualized framebuffer",
>      },
>  };
>
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

