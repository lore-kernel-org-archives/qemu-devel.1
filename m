Return-Path: <SRS0=ydMe=SX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618B7C10F14
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 17:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA4F2077C
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 17:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYmha5JD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA4F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55205 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIFs3-00064Z-FJ
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 13:03:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hIFrB-0005dQ-2k
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 13:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hIFe6-0004aB-2s
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 12:48:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hIFe5-0004ZG-Pj
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 12:48:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id b1so1836039wru.3
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=OBBXcXLrwQ+TtDcGJ54zXa/cMlQgEVmi7rLAacvs60s=;
	b=aYmha5JDShw9NjfHNE+BNY1BJUrns0UJSGe4f4hKBf8pr/iN1LJjfBFeNmDAzlyizs
	9JG5yhYWggwGoeo2nsup2+aH5hjkfdEeqkuaF6sbLT1HSJFnJ5I3iQKk5s577X4qCYqn
	pMhPpMUjhFkNU3MLx2e1gpdJC932ZpHf+cKQZk+8ETmkydLeX0aau5dHGWQVyrBgRFP+
	rWa1VI6BD3f5j+bF3RMwnghhehyF84A7Fn02hgssEznvWDXKXS9+epKjpJLT6nMzDVBa
	D2Tdq9tt59dGakcVR8rSM8rMGsiCssY2TsN+d+U3g2oiDciGhCBTpjq5ZrqLYGWyTQEh
	FzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=OBBXcXLrwQ+TtDcGJ54zXa/cMlQgEVmi7rLAacvs60s=;
	b=YTvZ97qwOt0nAxe5jIa+SLPRMjoKyC9WZRpOLDQEBxfURP53M43BolI7wZulbAo/5Q
	BT7ibw40zBjyAqqa4LndeFmV3b0EAeRnRatJdTO76rKajz0jjkSCOYZOFr7Uk7HrP5QG
	kuZUZ/6E63L4YepDbxTOx4n/bEx3jnBZGaFrS9UXsn5k6iZfGW6uUvPgXcPE+VTsN7KR
	wbqc7jXIKdDdsAnOgRKWJGNFa4MRIkNyfL/Mrwk1UUtZA+AoQMUxUN1CKl5sHx00Ye1Y
	u/oRNrPfArteGjT7KcvfqYGi+tsepMdQNj8Fjv3c+AbAeL0r961vOc+IA4fxhWmqXPOV
	VEHg==
X-Gm-Message-State: APjAAAUh0MXG/EHkLCvsrvqQNUCH50pPT4ChzwuJo/lc0huH+UWsGAiB
	M64h9n2XPoPf83I2IteYxc0/R/czKBQLXOME1oM=
X-Google-Smtp-Source: APXvYqzK0m1Fvg3Kix1Ns6zASCJ/pmPM+tFenw9djMz4wdUB4wt4bpVh+a7xOnAnTvLLZp7KlQ86bmYprxRCdJF6euU=
X-Received: by 2002:adf:b641:: with SMTP id i1mr10263102wre.288.1555865328142; 
	Sun, 21 Apr 2019 09:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190420091016.213160-1-fengli@smartx.com>
In-Reply-To: <20190420091016.213160-1-fengli@smartx.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 21 Apr 2019 18:48:37 +0200
Message-ID:
 <CAJ+F1CKz2=LpT1i1ES3MjfgBEeazqCWGdvaHfen1w-8UiBbdrA@mail.gmail.com>
To: Li Feng <lifeng1519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: fix bad vu_log_write
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
Cc: fengli@smartx.com, QEMU <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190421164837.k5HCD3iKCQscExYIW0whXLOWOiO012zX3_6PsCinXlc@z>

On Sat, Apr 20, 2019 at 11:11 AM Li Feng <lifeng1519@gmail.com> wrote:
>
> Mark dirty as page, the step of each call is 1.
>
> Signed-off-by: Li Feng <fengli@smartx.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  contrib/libvhost-user/libvhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index e08d6c7b97..2689de6d1c 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -433,7 +433,7 @@ vu_log_write(VuDev *dev, uint64_t address, uint64_t l=
ength)
>      page =3D address / VHOST_LOG_PAGE;
>      while (page * VHOST_LOG_PAGE < address + length) {
>          vu_log_page(dev->log_table, page);
> -        page +=3D VHOST_LOG_PAGE;
> +        page +=3D 1;
>      }
>
>      vu_log_kick(dev);
> --
> 2.11.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

