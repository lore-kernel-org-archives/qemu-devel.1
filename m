Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C9CC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 09:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7960520833
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 09:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urANTKIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7960520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47400 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFyCZ-00025V-Iw
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 05:46:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hFyBZ-0001kk-BA
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hFyBY-0001hH-9r
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:45:57 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:34990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hFyBX-0001gS-Vj
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:45:56 -0400
Received: by mail-wm1-x335.google.com with SMTP id y197so7703552wmd.0
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 02:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=SPNc/aEQoivrFh0MGeHrH8t/sksXPyESYK5lAdqE8bU=;
	b=urANTKIBAkjfMRPF0PSCtx9HT5T4b0Exl0yRjrjH/9h2vnnkQjIe62lwOzIF+adxB+
	/29DAkzFfY2rjPFLJ0x78eTh3tbgmJq66+NThtpb+ei59n4eVChAJy0lSQx0gofwBKuv
	rKD8vECRIIBjkTqEnJSVkPC7rVmn3gGCQnxETrRELly1b6g8fV6WUAdPU8YIu0/ELrnx
	F0BToqc/NwNYlQd4QfHSjqGdtWVcUwFLc1bUMv2LSgopxgR5Ele7ZuqEq5+hYP1/irTQ
	usC9o7N/d6H/tA+9hNMZ0gG+yqiL+ZjJxWASoPe4IRoeflQNGKYxnVWyu0nAwb0ZTZtO
	cx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=SPNc/aEQoivrFh0MGeHrH8t/sksXPyESYK5lAdqE8bU=;
	b=V5iGh8E7A9iNFgBurJsJElAnupVxkSb8uIoGHrU+iWqh1ZsInQ7i2XECHlmC00LfLt
	A92BYKoMvbQn61vzdd/eJZDSFfS/ZWPHzpB1tKApmJXwIKI/843MXSCSa/AV4VcJE+tB
	btNFk4dEv4ZZ+STYzbjDWT5VtBh1K5rl/ZmA7vMUcyV7bdgVFTUktTu54/7VZloKe/rf
	0XvfZvgVjCyy+SkUH9iYfMH15SYJDkn6orAWLY4ZmT41cwpvbVtgdKjeHvO1xK2hqxHM
	cy4i8YmqGEOJpSVKyzRiK/xv5Re/OXaD2T8nWQjzD9WJFnX6lfkFN3Llm3/37CIoHb03
	vD0g==
X-Gm-Message-State: APjAAAV4wXtEDfYEXt/Pu7/QtHLDTRvHbm6ynRoTG7PKgw/Z35pGOwja
	ysrb1ckPH7XtwxT9MGTXe84=
X-Google-Smtp-Source: APXvYqzdnCoFYrqcZnQPGMKVXxsPvGlg/pZhu3s+COktPf11ICqA9r+TiG5R1z1yZ6dHKfZ3TeOIOg==
X-Received: by 2002:a05:600c:220b:: with SMTP id
	z11mr20974962wml.73.1555321554411; 
	Mon, 15 Apr 2019 02:45:54 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	z140sm42819825wmc.27.2019.04.15.02.45.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 15 Apr 2019 02:45:53 -0700 (PDT)
Date: Mon, 15 Apr 2019 10:45:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Message-ID: <20190415094552.GC29134@stefanha-x1.localdomain>
References: <20190412152652.827-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline
In-Reply-To: <20190412152652.827-1-dgilbert@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: Re: [Qemu-devel] [PATCH] hmp: gva2gpa debug command
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415094552.lNRMV_GcBQ7tCqN5-lvVgAuvPuaIfm7KDDhXZzLscOQ@z>


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2019 at 04:26:52PM +0100, Dr. David Alan Gilbert (git) wrote:
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index d3bad2fc27..ba4690b9ac 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -585,6 +585,21 @@ STEXI
>  @findex gpa2hpa
>  Print the host physical address at which the guest's physical address @var{addr}
>  is mapped.
> +ETEXI
> +
> +    {
> +        .name       = "gva2gpa",
> +        .args_type  = "addr:l",
> +        .params     = "addr",
> +        .help       = "print the guest physical address corresponding to a guest virtual address",
> +        .cmd        = hmp_gva2gpa,
> +    },
> +
> +STEXI
> +@item gpa2hpa @var{addr}
> +@findex gpa2hpa

s/gpa2hpa/gva2gpa/

Aside from this:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJctFLQAAoJEJykq7OBq3PIAx4H/2Jqy65fbr9jEnv2uddXwZ2k
b4oveNjiw6XfLmH+K/NllFbHCj76EpxYQv6jDZ7otKUTeOxJzRi4zN8UtBhVY1Hb
2qh3bsyenANAeCnJUNUZAKHmohYGFHMMBQh1EAHXecQLkNTVLdaJWn8OIri/kD2+
Ewy+DCs03WBN16DZV/BDnP0XWtjs3xN/Buohi19ULioXT6kNcudum2gOdRcFZL32
NXa5f7QThgrnZmkXoSDPUlQqwEupdv2nAVhImQ0J5GOkvOwa+gBCR2NVBGJ+EgnL
EZyfDmohXRwrcyyXTCFQwheBWTQR+7N/kjz3xs8Fu+YoTKg2OayNa3MAowAMReE=
=Ad1y
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--

