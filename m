Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F120CC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE7B20675
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dsq7XGhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE7B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54957 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOjWO-0002na-Tj
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:55:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hOjVO-000289-Nu
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hOjVN-0005qh-QH
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:54:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hOjVN-0005qF-KG; Thu, 09 May 2019 09:54:37 -0400
Received: by mail-wr1-x443.google.com with SMTP id v11so3206273wru.5;
	Thu, 09 May 2019 06:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=k6RRKwWPLYth/9ZFL0q6xP+XfwMD3JRmUnwbWJFR320=;
	b=Dsq7XGhe/7gClCA9LmjT6nYfwDFWqdydCigU+sRo0Nkplq81Rm82ECGepXastpQGcJ
	d/fppOTkmoQM5aXDwYnHH8+3D9/cRtLQdBCoKBSSKRRmhN9JXOOm5CREvxlC/go+OJWO
	ad9yGaOIRo3Fsls0fovn3UDcUtpPh8nejd/QtTMJ2F+pbGLlJ7DZ0YzXONM1hcUcXopJ
	o9121jYlZDBO4qhUeDwWlVgEUd9PoACw7kEb+SLFSBKMbdhUvQcIMQCrYmY1ngpQTlFt
	BEHJ9G16E9i4RENyllTUM8Tio5X4ZPE+xSmelvkldI/EMSIejWp5fc0x6veo7f+gY3gn
	B8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=k6RRKwWPLYth/9ZFL0q6xP+XfwMD3JRmUnwbWJFR320=;
	b=R8OWSBflCy3SS2r3i04dufN1qxk00fUjWMo6cwz8bTnXZ5tf5FVlpjN7jtE6tkB0xz
	k2k3XyECIuhPFR+mOXyJ00dWcbxfXJcVH2Hjk5XJ/jqKUgBAcnq9Tso0RaRXZCgQUCEp
	l1IjepipwSb7f5l/kV2GHewoqdA53MnsQAcb0wFioSG02fYy+gtV2J6SYJzfd0N1pdiJ
	vMPqs+7Tmys9cl72/oghgKgIvwTOSXcEWQCvbcl2SSnsuf0GOtDqg08L4/Z83HXNlChz
	DzmAtuAxwm4Jz/0jDqUILdUnJmEXMMdrGzqBUCna0SXMhCbGsuo9sgN16y7p9cAOEpgk
	XVaQ==
X-Gm-Message-State: APjAAAVPQwNH41e80YX+/rRajeeVwVETwEx3ofYWiYCggZxqEXKPpbJs
	CvFlwM/XMLqyYrDT98UTRL1TW1H+EaKu6xP5RAA=
X-Google-Smtp-Source: APXvYqxKjtmC2DRBbLGw3i37wG7R0DJ4R5h7t+6wYrgyKdjC0RO06zjmhsQuntmaDW+rNeF+zThkGm33kEoUnqQe4ng=
X-Received: by 2002:adf:9042:: with SMTP id h60mr3225042wrh.248.1557410076357; 
	Thu, 09 May 2019 06:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190509133737.242548-1-sgarzare@redhat.com>
In-Reply-To: <20190509133737.242548-1-sgarzare@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 9 May 2019 15:54:24 +0200
Message-ID: <CAJ+F1CJth8eCirh6qQK=mL-LDVStSEJhe9R+vsLX-iWytFZ0+Q@mail.gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH] net/slirp: fix the error message when the
 prefix len is invalid
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
Cc: qemu trival <qemu-trivial@nongnu.org>, Jan Kiszka <jan.kiszka@siemens.com>,
	Jason Wang <jasowang@redhat.com>, QEMU <qemu-devel@nongnu.org>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 9, 2019 at 3:39 PM Stefano Garzarella <sgarzare@redhat.com> wro=
te:
>
> Add a missing parentheses at the end of the error message,
> when we have an invalid prefix len.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  net/slirp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/slirp.c b/net/slirp.c
> index 95934fb36d..0f4ae0abc0 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -498,7 +498,8 @@ static int net_slirp_init(NetClientState *peer, const=
 char *model,
>      }
>      if (vprefix6_len < 0 || vprefix6_len > 126) {
>          error_setg(errp,
> -                   "Invalid prefix provided (prefix len must be in range=
 0-126");
> +                   "Invalid prefix provided "
> +                   "(prefix len must be in range 0-126)");
>          return -1;
>      }
>
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

