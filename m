Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61452C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6D3208FE
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFTReTcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6D3208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfRS-0005vM-9B
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jOfQV-0004nx-MP
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jOfQU-0001si-Lc
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:37:51 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jOfQR-0001qQ-F0
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:37:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id k11so17891168wrp.5
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D5sObk6zM7CPpcNkFXpi2dbYOOcLYt59wgs8YQk/lMg=;
 b=fFTReTcuC4HlpxEdbpOphGhP4AmxXL2fzewVdh9BrRxeQed6b4m5+/rbXik1DqL7KV
 S3GUtta3GIqJhXf+YD/c39JZ+YrNe26LYqPFlE3NMjWf0f3hyCviFdbhYC1K6K9+LkDi
 cqq6Px7Ac7xG6sL3RY2WM4WePyRc1dad96pOyVENdcFEAjQHrxFhRmouf+L9xHJYKsK8
 dg02kJ156903POZnVVzRrkiDbBg8UwgWAKdZ1ZtrWvseK6X0TJ2PmgTBeXQAq/KQ7XNs
 pxAJOfJf3WDZXI44Do82N0G4Gzq8OAI6wEgdlFFYd5TVcvoFji5f5h2ejqfve652wCEi
 V92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D5sObk6zM7CPpcNkFXpi2dbYOOcLYt59wgs8YQk/lMg=;
 b=tXdnyXsDgnh0EU4nzisgSOChv36gDHXv4AGJPqajx/wk8uCRVqU1Oc60ibmPn0BCHc
 c4Sl/WNH2lGMB/87i6QpXU/8Y4q4ZjFzvwQ4B82sWKEwwoAofXH0WXvLRhCO0uVXLMA/
 tschZJMdKrkXkU+IZQHaB5TmEGUG2BfrkJaftqzF7lqya7wcXDlrtMAZDOBGWBvydYRk
 IiL8nnR5XeqygwvwntE/9vDsq9atSH3oUdY69TpCSzqzsaPYR3d3d2t4gkrXBqeiyU+a
 yA4Kt7ExXM8YtHR0kl0GRna/jiDxDT1k1WEP/tdKVbHiA9hUohqp+I0KCdS6WEcy2jn9
 4eRg==
X-Gm-Message-State: AGi0PuYebi3vG0o3FRJAIUhWfNpWcA1SrDErJqpH8cdhc9hiHKGgP3aQ
 WSsrSQSxZsQjpE+e91Wkp8irT0lNMdXeiklBVEo=
X-Google-Smtp-Source: APiQypJmuxIs84FNE+pNbbmu0uumDWCcEATu4Ezx0ysPW2r1NOMNY/AeeR2UMHelT3GsOAe7yL+Pzl/XqSIwgE40LZs=
X-Received: by 2002:a05:6000:187:: with SMTP id
 p7mr27993705wrx.196.1586947066360; 
 Wed, 15 Apr 2020 03:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200415005938.23895-1-alazar@bitdefender.com>
 <20200415005938.23895-4-alazar@bitdefender.com>
In-Reply-To: <20200415005938.23895-4-alazar@bitdefender.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 15 Apr 2020 12:37:34 +0200
Message-ID: <CAJ+F1CLLpzdoNqwgMQh8j4Sd4_HGEmBt=x1wPsHXvgZ7O=8Kzg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 03/26] char-socket: fix the client mode when
 created through QMP
To: =?UTF-8?Q?Adalbert_Laz=C4=83r?= <alazar@bitdefender.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Apr 15, 2020 at 3:00 AM Adalbert Laz=C4=83r <alazar@bitdefender.com=
> wrote:
>
> qmp_chardev_open_socket() ignores the absence of the 'server' argument
> and always switches to listen/server mode.
>
> CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
> ---
>  chardev/char-socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 9b2deb0125..fd0106ab85 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1310,7 +1310,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>      ChardevSocket *sock =3D backend->u.socket.data;
>      bool do_nodelay     =3D sock->has_nodelay ? sock->nodelay : false;
> -    bool is_listen      =3D sock->has_server  ? sock->server  : true;
> +    bool is_listen      =3D sock->has_server  ? sock->server  : false;

I don't understand what you mean. It defaults to server mode. We can't
change that.

>      bool is_telnet      =3D sock->has_telnet  ? sock->telnet  : false;
>      bool is_tn3270      =3D sock->has_tn3270  ? sock->tn3270  : false;
>      bool is_waitconnect =3D sock->has_wait    ? sock->wait    : false;
>


--=20
Marc-Andr=C3=A9 Lureau

