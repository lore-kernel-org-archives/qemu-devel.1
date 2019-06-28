Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7120C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24402064B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwSanR8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24402064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgsFm-0002pR-N5
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46066)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hgsAr-0000dN-Aj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hgsAl-0003tx-Fm
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:48:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hgsAj-0003o3-Lw
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:48:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id c2so6585926wrm.8
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZitzNtQ5JwDH10v1ZnVBJDH+0ZF/VPgOgXa5rZY13Tw=;
 b=GwSanR8QEgHSCjGL852Stjr42v+FRA4c38w5520g96Q/OHZ3r9piXBAqFScdXAVR56
 e8wsZBIzdw3WOKdP4TmTXYwI5BwHuTrFJL9gCq3vneTuOCKYEVKR1fHgAMHAxRm784as
 kwVXvIzd/fOCx2wFfRNtBKz16iVCwdMLKvfflvNpjB0gatpyhZjTzSq663odq0dzHKHL
 fNAtfLqeGkTT5X0BYum5byPouIhcixzTFV9E2O8pMMzIP9hzyqZeXnTNjsukQT5L6adx
 ZJ2CJPSVg+rgyMGRp1IIlIw1dUcY8U7aNKTOgwtux+wu9ipUOy2fwTmGhWb+AZ6F4YXU
 JuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZitzNtQ5JwDH10v1ZnVBJDH+0ZF/VPgOgXa5rZY13Tw=;
 b=RKyQVAZY2S4qM+rD273/BepzRniGHQJJqyCWkZ1TklIV5Cy5t3KSBfATMBhTm28jxj
 G2Lk6dthc+q8tijkS/CYiCzSz+Xpgk6THq9kIYAOaISQEJZBmqps5peUCa5s4rhG2gTR
 agst06kzik0SZ3fjmlpM2SpKuVDVPClFDBm+4UkZWN0iqp3tZnyvmvgnC8INNTNIJ2Zo
 4N6kNKeZTVE8yM3dRAfdlG6xEPyqgNngPEdilU3e4AAco+l3fHg1yGBynHnVSVjg3Qpg
 mW3n0NLjZSarRuzxQpRsB71e94JzofZdKqMzKZZfO3bmgbbB1Wy0RdpTxI4VF71k3+Gg
 JGSw==
X-Gm-Message-State: APjAAAVSfs+5oVNfgf/0RW0BeSVqVNy+CxWCxrPDGd2Xccc6eCEJNbXf
 wEmaqzaKn0uYW+YD/QU9YmgkmB57ubE=
X-Google-Smtp-Source: APXvYqxw5maG5XujjMn5gAPNTRvFb9oMI0PU6woxiVdrx5CmLAIzVWsJtUeXiezgwmzs6atzjQu7vA==
X-Received: by 2002:adf:9e89:: with SMTP id a9mr8196689wrf.78.1561733287592;
 Fri, 28 Jun 2019 07:48:07 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o6sm5549589wra.27.2019.06.28.07.48.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 07:48:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 54AF71FF87;
 Fri, 28 Jun 2019 15:48:06 +0100 (BST)
References: <1561727317-30655-1-git-send-email-liam.merwick@oracle.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <1561727317-30655-1-git-send-email-liam.merwick@oracle.com>
Date: Fri, 28 Jun 2019 15:48:06 +0100
Message-ID: <87pnmxahqx.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] docs/devel/testing: Fix typo in dockerfile
 path
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Liam Merwick <liam.merwick@oracle.com> writes:

> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  docs/devel/testing.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index da2d0fc9646f..3ef50a61db4d 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -327,7 +327,7 @@ Images
>  ------
>
>  Along with many other images, the ``min-glib`` image is defined in a Doc=
kerfile
> -in ``tests/docker/dockefiles/``, called ``min-glib.docker``. ``make dock=
er``
> +in ``tests/docker/dockerfiles/``, called ``min-glib.docker``. ``make doc=
ker``
>  command will list all the available images.
>
>  To add a new image, simply create a new ``.docker`` file under the


--
Alex Benn=C3=A9e

