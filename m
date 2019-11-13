Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD46DC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C4A222C9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TXQQWyzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C4A222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUu3h-0000GO-J6
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iUtpI-0008Mq-Q7
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iUtpH-0006ol-DU
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:40:56 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iUtpH-0006of-4R
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:40:55 -0500
Received: by mail-lj1-x244.google.com with SMTP id r7so2877674ljg.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=u3Cv8WUE2l7b3jexTec4eGt7y3TTD6iPElcZZTnvLYc=;
 b=TXQQWyzy1kE1W++iWSc8JbHt3LtJA4kJyjDMMxQKTia4QErt4voKinALfrn4HyRAdz
 9A4HbUizINPZ+mXY7cq/L05cKrnM2ukNueTRRaeje1nfbqNlKxnKXDmp0tZrP5zzPza3
 G2ajMrhaaDJ5Y/qdhoA6azqpM2+06L7l8u/MuBMuTIFhNB5h7hbGUVaBbwPaa4SuJRvv
 SG0qsqhtt46dOc1VZTmLwatWQJZ3tK4oHWXSQnYFJMPov0r7zCD3Esk/gy1c0CdQgyoB
 FNyYaVY40fHSkgLLLI7p9PwmdkRjUM7VvAah3tleUsNPsr53A2L2fkoAzKuQxCU1+NK5
 7GXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=u3Cv8WUE2l7b3jexTec4eGt7y3TTD6iPElcZZTnvLYc=;
 b=r3et6O+76I5aZxbROILeGpdWWkfheD9zq+YpZdq5QUtBeixqDQRhebnKlOpVSJsuQ6
 QagEVaSIlovMgrpK95TtpOnJhOnDgOZ8Uwi7vFESxJ7Cu932r3W4hVkJ0c5CB8KiofsO
 bAsdcXRGbHGIg5vHZApuDMTzF+2jlB6m5C94PA2MGvWpMvp/D3yFno7XRmMszVm/4D0j
 uwprpJNi7deSY5k98rEhmDLvFSK5GFeWjpNiS4ECHGdUcOxNr8z5yR8QXkVzgtHWfDFg
 UPHnprp2jmcKqnzQ7xYxTKZuZuyScxQPwb51S3eV7s8Qw8F5F6/TESN4K9yX1BIuZQr6
 iK+g==
X-Gm-Message-State: APjAAAURBCjo2JyqTEGILm/PVdOgHf5B0pCNykP3fXh2OE6+wkfB725C
 RYheeTMFta96M2TW7kaSG57CNn7aSN8xL/79lkErS1oE8tg=
X-Google-Smtp-Source: APXvYqwRgCRlWfb7c6lm6lv5Ll7Qto9k29EpNpHoPo69hHImX20MsJqW7FpoXilSdcRwn6jw3HkbTBFARpMK1BZ/TpA=
X-Received: by 2002:a2e:9f4d:: with SMTP id v13mr2933292ljk.78.1573656053538; 
 Wed, 13 Nov 2019 06:40:53 -0800 (PST)
MIME-Version: 1.0
References: <20191113115952.775-1-alex.bennee@linaro.org>
 <20191113115952.775-4-alex.bennee@linaro.org>
 <SN6PR13MB2272B60021982C8C7F680CAA80760@SN6PR13MB2272.namprd13.prod.outlook.com>
In-Reply-To: <SN6PR13MB2272B60021982C8C7F680CAA80760@SN6PR13MB2272.namprd13.prod.outlook.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Wed, 13 Nov 2019 09:40:42 -0500
Message-ID: <CAEyhzFt_BBoH3AHwK7WHyFgCtqwz6nW9i=qPWprwi+jLHhfrew@mail.gmail.com>
Subject: Re: FW: [PATCH v1 3/5] docs/devel: update tcg-plugins.rst with API
 versioning details
To: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 Richard Henderson <richard.henderson@linaro.org>, f4bug@amsat.org,
 cota@braap.org, stefanha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 13 Nov 2019 at 07:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> While we are at it fix up the quoted code sections with the inline ::
> approach.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v2
>   - fix grammar
>   - mention we also will fail to load outside the range
>   - clean-up code sections
> ---
>  docs/devel/tcg-plugins.rst | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
> index b18fb6729e3..718eef00f22 100644
> --- a/docs/devel/tcg-plugins.rst
> +++ b/docs/devel/tcg-plugins.rst
> @@ -25,6 +25,23 @@ process. However the project reserves the right to cha=
nge or break the
>  API should it need to do so. The best way to avoid this is to submit
>  your plugin upstream so they can be updated if/when the API changes.
>
> +API versioning
> +--------------
> +
> +All plugins need to declare a symbol which exports the plugin API
> +version they were built against. This can be done simply by::
> +
> +  QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> +
> +The core code will refuse to load a plugin that doesn't export a
> +`qemu_plugin_version` symbol or if plugin version is outside of QEMU's
> +supported range of API versions.
> +
> +Additionally the `qemu_info_t` structure which is passed to the
> +`qemu_plugin_install` method of a plugin will detail the minimum and
> +current API versions supported by QEMU. The API version will be
> +incremented if new APIs are added. The minimum API version will be
> +incremented if existing APIs are changed or removed.
>
>  Exposure of QEMU internals
>  --------------------------
> @@ -40,16 +57,14 @@ instructions and events are opaque to the plugins the=
mselves.
>  Usage
>  =3D=3D=3D=3D=3D
>
> -The QEMU binary needs to be compiled for plugin support:
> +The QEMU binary needs to be compiled for plugin support::
>
> -::
> -    configure --enable-plugins
> +  configure --enable-plugins
>
>  Once built a program can be run with multiple plugins loaded each with
> -their own arguments:
> +their own arguments::
>
> -::
> -    $QEMU $OTHER_QEMU_ARGS \
> +  $QEMU $OTHER_QEMU_ARGS \
>        -plugin tests/plugin/libhowvec.so,arg=3Dinline,arg=3Dhint \
>        -plugin tests/plugin/libhotblocks.so
>
> --
> 2.20.1
>
>
Reviewed-by: Robert Foley <robert.foley@linaro.org>

