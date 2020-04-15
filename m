Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B339DC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9BB206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1YI7DSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9BB206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfQM-0004Nv-O2
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jOfOH-000268-1d
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jOfOE-00015O-Rj
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:35:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jOfOB-000148-HU
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:35:28 -0400
Received: by mail-wm1-x343.google.com with SMTP id y24so18360186wma.4
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RCPukqXeU90Sta1kCxiNpB66dVcf62a681H7MU0Gmfk=;
 b=t1YI7DSkuL2sA7XoAjLkT91WakZoqVEzk6OHRq1q2SsLaIribeop53bQNC4WE+farD
 hEYny6wsFBfUDPjaYBUCZ72d7KqEWPC6wjrJeAaREL82ImozEDBKvhss1+xxiqlAE1sB
 c4N4hJgafeKqKlm47yXyNftRnvuzOvYy0VSAbykb7h6EsNzViCmn4Nj29bcxgbyWA0dH
 UhmkMRJncsjBQ1/DfZg7JOnBWFxWhFIU2WuYhyIMnmVxypk0Kghc8ddenhNJUq/lmNw1
 mh7fB4Mw9FP8H+sFPyAF4+lW4PJqIDL2CDVRfag5M4vnUSx4OMPCYcSni9omUkotip62
 UjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RCPukqXeU90Sta1kCxiNpB66dVcf62a681H7MU0Gmfk=;
 b=KVR2jdNuwarGD0f2LssQMTSqLhtpZ5iuhGqzI5dxMD1hEb05MYjgiZ0zZ5grDV2NRV
 hWlRIhA9DD9v9lLpbcIbl7kpSlrAwzecf/M/7cMYMXT9+fDAHhaCVIftD/8ar9eWMyjD
 2tu0C+8ZtZhjOtsNVOcmL3rVdlpVMBSULGD3v/ydPqtBvng5eCO+Sh+/iLFOF9/k45kF
 h0V6u/8s/7WxJqcOsO8aKHdyr6pgaeZYOa72P7Z8GhH6CaF1Zx0+WpkuXAwinXhz/dPb
 DBe7dVNCQbwUrgT5v/EiqoveYxbgqpREZqncooIeTvcBjYWwpAj4FmQIvRnMN2sGs587
 +NZA==
X-Gm-Message-State: AGi0Pub9E9YfwZME4qg6mrg+0rfEhKUSpTUwMA/Jw0A2jdsv7OoKGuN7
 wNz//cX4kOZHJuCIMN6uKxMigjqCKxuglQdsHwY=
X-Google-Smtp-Source: APiQypKGvKrqB1CpbcMtbgEYojLyAgT7R12eFL1LuqCrxJ4ZZQFScfks8tCcm/UWJRcMRxJ+klMceExOcH93IItgv7U=
X-Received: by 2002:a7b:c404:: with SMTP id k4mr4293405wmi.37.1586946926130;
 Wed, 15 Apr 2020 03:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200415032826.16701-1-fengli@smartx.com>
 <20200415032826.16701-4-fengli@smartx.com>
In-Reply-To: <20200415032826.16701-4-fengli@smartx.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 15 Apr 2020 12:35:14 +0200
Message-ID: <CAJ+F1C+y-UXH=KARXtTK+aFFb58umRDna_jk2XjHsjDeaxkWYQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] char-socket: avoid double call tcp_chr_free_connection
To: Li Feng <fengli@smartx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, kyle@smartx.com,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Apr 15, 2020 at 5:31 AM Li Feng <fengli@smartx.com> wrote:
>
> double call tcp_chr_free_connection generates a crash.
>
> Signed-off-by: Li Feng <fengli@smartx.com>

Could you describe how you reach the "double call".

Even better would be to write a test for it in tests/test-char.c

thanks

> ---
>  chardev/char-socket.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 185fe38dda..43aab8f24b 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -476,6 +476,11 @@ static void tcp_chr_disconnect_locked(Chardev *chr)
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>      bool emit_close =3D s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED;
>
> +    /* avoid re-enter when socket read/write error and disconnect event.=
 */
> +    if (s->state =3D=3D TCP_CHARDEV_STATE_DISCONNECTED) {
> +        return;
> +    }
> +
>      tcp_chr_free_connection(chr);
>
>      if (s->listener) {
> --
> 2.11.0
>
>
> --
> The SmartX email address is only for business purpose. Any sent message
> that is not related to the business is not authorized or permitted by
> SmartX.
> =E6=9C=AC=E9=82=AE=E7=AE=B1=E4=B8=BA=E5=8C=97=E4=BA=AC=E5=BF=97=E5=87=8C=
=E6=B5=B7=E7=BA=B3=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=EF=
=BC=88SmartX=EF=BC=89=E5=B7=A5=E4=BD=9C=E9=82=AE=E7=AE=B1. =E5=A6=82=E6=9C=
=AC=E9=82=AE=E7=AE=B1=E5=8F=91=E5=87=BA=E7=9A=84=E9=82=AE=E4=BB=B6=E4=B8=8E=
=E5=B7=A5=E4=BD=9C=E6=97=A0=E5=85=B3,=E8=AF=A5=E9=82=AE=E4=BB=B6=E6=9C=AA=
=E5=BE=97=E5=88=B0=E6=9C=AC=E5=85=AC=E5=8F=B8=E4=BB=BB=E4=BD=95=E7=9A=84=E6=
=98=8E=E7=A4=BA=E6=88=96=E9=BB=98=E7=A4=BA=E7=9A=84=E6=8E=88=E6=9D=83.
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

