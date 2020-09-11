Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B2AC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4BD2221E5
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZakIuf6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BD2221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGfzF-0003Ut-IO
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 06:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kGfyW-0002S5-OJ; Fri, 11 Sep 2020 06:08:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kGfyU-0005Yc-UW; Fri, 11 Sep 2020 06:08:12 -0400
Received: by mail-wm1-x342.google.com with SMTP id e11so3751113wme.0;
 Fri, 11 Sep 2020 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QwXnKMZ6OYLtmDATXHlNcuEnLPm9sjav2g8IQnmUExw=;
 b=ZakIuf6SfKCR9cR/0UxwkLvKstwuZ/pJyJHeWeXVIB9Mvt2PidkIS0taUAUgHoWLOa
 kCfhKlqwkIXHM55tFaglW10PYSJs1m1KIYV7lGB6Qo86Cag7rLxAEhMP1djS93SqYHOl
 wou9+Q+pkrGPVrYqbhbXDh6CB0Vd+8Cl7vMGUQgZqVhx/HbiX5pzB28xRogCfRaXdXP3
 RV7/I1PmQvZkzDiFNRM5T5STuwj/V2V/iK2IszgtILFTzF5LUd8RQfTm6zl3msw2wqUo
 nn0P4MPGbhlJvICTmOwUM0fjJwt1vy/Rt3McMpxeIxolwBvuR62GNgVerGuPmFoHoDSu
 0mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QwXnKMZ6OYLtmDATXHlNcuEnLPm9sjav2g8IQnmUExw=;
 b=IxKWq5qdCpyQy9oPWKbpGjLhr4W+PjId01qao8df1a0bdtBjI0txdKzc0ndK9qJEL4
 owM10Cb3pAKkTyhSQ5W6rqoxlNCzrCDS9KuecPa30lKhoFo7wsvPDJxMP3TGEhC/6gVI
 kf299S0FOjP6JNI1LVHTa6fWrGhxfaLCjxQwHBZtzksdPdPK7h9wY8zgqN1f/LoI/+Qr
 rskaMTXeXmK+MfXnGFdSsjvxswa0U+H6naHL9/zhcWu4bauk0OUpqWLpOEflM3oePhOQ
 q3yHu5tPlwWCvXPerjAUdS5NRJK85Zd27OBtHeh7vujfG4NfPTnOwUiSN15toun5EfV2
 ITbw==
X-Gm-Message-State: AOAM531NqM8wkKL2sUBC4tzO50MN8DPaRHOvnXqMUDJgjiaP4j1/eucJ
 QQsEc5FztOqHhN/wDEn6V+0=
X-Google-Smtp-Source: ABdhPJw0uvaKMhtTFWp9MkneHOviF8mNAaocxQa7yFA/Vs+Z/jjIvWjlkVs2bAZ+zpXC9NYKbzgqOA==
X-Received: by 2002:a7b:c182:: with SMTP id y2mr1503013wmi.21.1599818888552;
 Fri, 11 Sep 2020 03:08:08 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id q12sm3438623wrs.48.2020.09.11.03.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 03:08:07 -0700 (PDT)
Date: Fri, 11 Sep 2020 11:08:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: duboisj@gmail.com
Subject: Re: [PATCH] trace/simple: Enable tracing on startup only if the user
 specifies a trace option
Message-ID: <20200911100805.GB81586@stefanha-x1.localdomain>
References: <20200816174610.20253-1-josh@joshdubois.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <20200816174610.20253-1-josh@joshdubois.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Josh DuBois <josh@joshdubois.com>, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2020 at 12:46:10PM -0500, duboisj@gmail.com wrote:
> From: Josh DuBois <josh@joshdubois.com>
>=20
> Tracing can be enabled at the command line or via the
> monitor. Command-line trace options are recorded during
> trace_opt_parse(), but tracing is not enabled until the various
> front-ends later call trace_init_file(). If the user passes a trace
> option on the command-line, remember that and enable tracing during
> trace_init_file().  Otherwise, trace_init_file() should record the
> trace file specified by the frontend and avoid enabling traces
> until the user requests them via the monitor.
>=20
> This fixes 1b7157be3a8c4300fc8044d40f4b2e64a152a1b4 and also
> db25d56c014aa1a96319c663e0a60346a223b31e, by allowing the user
> to enable traces on the command line and also avoiding
> unwanted trace-<pid> files when the user has not asked for them.
>=20
> Fixes: 1b7157be3a8c4300fc8044d40f4b2e64a152a1b4
> Signed-off-by: Josh DuBois <josh@joshdubois.com>
> ---
>  trace/control.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Thanks, applied to my tracing-next tree:
https://github.com/stefanha/qemu/commits/tracing-next

Stefan

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9bTIUACgkQnKSrs4Gr
c8hzBQf8D8XdsiArhw6Lnezf3Y5UQDheBWptZHGf6Swa6qLHjvD47gfllVNuFQgV
ldlJsv4vLOmacGFuKoj6CONo4cPwGKSnODWy22D5DYSFegDaObVrBkySIwzlMe1+
IAbCIy80yiO9AkG2+TZ0oRG95xV4nU4lLQ1/UMWwgwbLwKp66pjdx5MMhbInJpxX
uDxn/lKDcnAIqko/hR9Elg8yXzAFKoX9Tq/yNK+NH16Pi04f+Oz0W7ta6v1UNJZK
PaZMrMwT0C3V5vJe2mpmxuFNOFMgx/JlsUB8VJcvM4xC/zvSkVlyIqnGxMqD2iuA
uoW7jRyNtyJ8EwfeeB/O+pfUm+KRVA==
=Fi5B
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--

