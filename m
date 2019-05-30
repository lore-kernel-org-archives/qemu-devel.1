Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD1BC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA52525816
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1X/+Ykr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA52525816
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52269 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWJ22-0001hD-WF
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 07:15:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWJ1F-0001Pc-Bn
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWJ1D-0007BT-AM
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:14:49 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:36004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWJ16-0006Tu-0k
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:14:41 -0400
Received: by mail-ot1-x32b.google.com with SMTP id c3so5222394otr.3
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 04:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=7S80cV5knHmrXM47s8zBbdEdF6vW3v/n5IaGA+1+7fQ=;
	b=q1X/+YkrLpFzUipO+lY7gi2XBc+spptkxNpH3lTlydtSd8PFqSKQ9KKPicFOzP+3Eh
	anQiIeMXb0ebDyKnOJqRdjM9wHMprVsizjQu8bRliG17UkABrk6XS6MdOsIFUuhkd+tB
	/DM4QhMykF+kw+te+XXx1MNYoxbIoUt2Qb2W5/8AgbNpqqhRf9LPYDkUgp2ow2JLITeS
	G7ai/kq31QY/Dd6pN0B4DUEmr6wqU6jHdMVCTGkRu8NHBf0u6rY0WppJ2RpWyL6t/CzT
	3oPZa8ZaWVQKL1/L/0BL4NiB9Od6SXlyq+R1koMSqrXqbw0AZb3i+TWjRt/F1OUL4rcu
	WO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=7S80cV5knHmrXM47s8zBbdEdF6vW3v/n5IaGA+1+7fQ=;
	b=YVDHGyFV1Ubm4PYSKAdbfXqIdvGYeCRKVxHI19DCc1hpQZ7zvy1YJRpnkokg3KEQZr
	USIo2ebBgpC3uELUFFC2Zct0TTN/JbXz0kjXWfQ/1yzkZ7rqujfgv4bUwHVcjBuYai31
	aC60a7piTmDnkAVnab1RrzsQX9ekuYQaEpvh3aLxPazJEtUAO4v8W+pYyu3x26RGZpoI
	R/06HxBlq2zShQnwyKTWq4JhJsgIW1A2BjawihRW+cdVtHiV79nXqJ9Iwyz3ZC/VFjQ4
	1gop9BYZJSq0bYyvN/yrs1aqDt5ZzA+fH6/E1tVAo838iZ+cEKIW8Iuc1A9Ml+OjH5j3
	XiPA==
X-Gm-Message-State: APjAAAXPdAL0n+mxrioOa0GKBQoL3hkU5jddAW9afIBJ4b+g71nBVJLs
	/6xsVGS4RYuTOxCCtay47YlR/8nSczow1Ci5dK+2EA==
X-Google-Smtp-Source: APXvYqx9zq64BsGyESpfuzhmazn/pRLjyEbuZD1gIZvu5RJkVoEa7LLZYe0aWLsRuidNtx5xogqor3sNnWDZWLJFzZM=
X-Received: by 2002:a05:6830:149a:: with SMTP id
	s26mr2016972otq.221.1559214877511; 
	Thu, 30 May 2019 04:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190529044020.27003-1-kraxel@redhat.com>
	<20190529044020.27003-6-kraxel@redhat.com>
In-Reply-To: <20190529044020.27003-6-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2019 12:14:26 +0100
Message-ID: <CAFEAcA_CK0K=Hn2b4_0=0jsMc2RMmzBtbeXFdvs7+vdr9=eozw@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] [PULL 5/9] contrib: add vhost-user-gpu
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 May 2019 at 05:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Add a vhost-user gpu backend, based on virtio-gpu/3d device. It is
> associated with a vhost-user-gpu device.
>
> Various TODO and nice to have items:
> - multi-head support
> - crash & resume handling
> - accelerated rendering/display that avoids the waiting round trips
> - edid support
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-id: 20190524130946.31736-6-marcandre.lureau@redhat.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Hi; Coverity spotted an issue with this patch (CID 1401705):

> +int
> +main(int argc, char *argv[])
> +{


> +    if (opt_socket_path) {
> +        int lsock =3D unix_listen(opt_socket_path, &error_fatal);
> +        fd =3D accept(lsock, NULL, NULL);

Here we call unix_listen(), which can fail, but we don't check
for the error, so we can pass -1 to accept() as an fd, which is bogus.

> +        close(lsock);
> +    } else {
> +        fd =3D opt_fdnum;
> +    }

thanks
-- PMM

