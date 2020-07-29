Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40718C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FBD20809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPHRLQ4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FBD20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ln9-0005IJ-Az
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 09:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0lm9-00040e-53; Wed, 29 Jul 2020 09:05:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0lm7-0006FI-EW; Wed, 29 Jul 2020 09:05:40 -0400
Received: by mail-wr1-x442.google.com with SMTP id a15so21560836wrh.10;
 Wed, 29 Jul 2020 06:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=DTO40fdW7o1GwYYDAdV5m6TuDnv9KZFM1VjVJXBxTkE=;
 b=JPHRLQ4/tAG47Zeffu7fcCEKG/1iFCdkvr76J3IsqzuKcWi4E2FNj03W/Aas9eE6bv
 Jy6cmQqjPu1UO1o0nr5pyTCN/uwB9bCza7y1bkfnYKGi5gOIDb/fyNzroOhJdZjQIri7
 zw8P3W7g5rrOY0dY7rl477VOq0wFTA3vD6YNSasVfvoEVj+pzRlqDauojsowDfBqjaR9
 HKNCXUJsIskdLK/WkPWkJHkuHGnlfBnYOvfirXFDOiPnbf8qkuVDpSCUtZaE3CeuUVBo
 iAGh6NlOZtLcUGsVt5gTN0c+zXOiZxaBbolXGJSY8I6+94M78iRhjek4jC+EA6xkiMd6
 Nixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DTO40fdW7o1GwYYDAdV5m6TuDnv9KZFM1VjVJXBxTkE=;
 b=oQScKFYLEy9Cu04DAG8ZqdvtNBGKh1gNSkf4s7+Zi4vRuuozrHP/qF0NS7UbeO8Im6
 dTivotAC0e7/VKtc0+QuQccgkoQMNRtJSaHmDNa5Y0MVS1ayGiqfjEbysUV9v7jGpM6B
 fTFFrYJV4EUQXSkRyR89RC+ToGvHkqS/mW3AI2V0IAz6gDdXgDcPZFEXIq8L/IL0pj22
 SpOccgDVS7mNOIWI5sbRJNdjSxcSk6vWVTlOS/gAXKk3o+OA3ZYV0pSSz9T00S5R8XCZ
 1FLW9jYwvNViAwdIYevv4H7hXIEMO2YkSV8e78/XGMv8jtF5vXGqFwVPfNz91Gp2ctpS
 pguw==
X-Gm-Message-State: AOAM531TUAsFfNPGkjDpCJ2peWKWERpZ4lTDQUJOfQWnclPmiTYlP+Rw
 JQd3UTPPoPDoCfQ0ZYQmgdE=
X-Google-Smtp-Source: ABdhPJyvi9Ka3KIscpWqhUckB8IgCE7FGu1eX98eD2iGREW3OHFuXF8OsF0VSxOfin8REczWeXUoyw==
X-Received: by 2002:adf:c108:: with SMTP id r8mr30669908wre.41.1596027937588; 
 Wed, 29 Jul 2020 06:05:37 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id s19sm6536871wrb.54.2020.07.29.06.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 06:05:36 -0700 (PDT)
Date: Wed, 29 Jul 2020 14:05:35 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Josh DuBois <duboisj@gmail.com>
Subject: Re: [PATCH] trace/simple: Allow enabling simple traces from command
 line
Message-ID: <20200729130535.GI37763@stefanha-x1.localdomain>
References: <20200723053359.256928-1-josh@joshdubois.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8/UBlNHSEJa6utmr"
Content-Disposition: inline
In-Reply-To: <20200723053359.256928-1-josh@joshdubois.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x442.google.com
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
 Josh DuBois <josh@joshdubois.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8/UBlNHSEJa6utmr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 12:33:59AM -0500, Josh DuBois wrote:
> The simple trace backend is enabled / disabled with a call
> to st_set_trace_file_enabled().  When initializing tracing
> from the command-line, this must be enabled on startup.
> (Prior to db25d56c014aa1a9, command-line initialization of
> simple trace worked because every call to st_set_trace_file
> enabled tracing.)
>=20
> Fixes: db25d56c014aa1a96319c663e0a60346a223b31e
> Signed-off-by: Josh DuBois <josh@joshdubois.com>
> ---
>  trace/control.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--8/UBlNHSEJa6utmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8hdB8ACgkQnKSrs4Gr
c8g8gwgAuj6ssPoPgFWZJRabKA/Em82RP0LWZ8VcPwPV78khfgxy6PZt7zVRArSG
XKsWFemEkElQXIUQntbOwfQqceOJxrSO7zkeQiiMBRqa4v9bqam7XLXeRV2QQmn8
4zgRSp++iQThjufEPotHS6ReFMhPNq52bXBSe4cHt9lnzHGGAQ2VnP5uJM5db2pn
nzj8zxfJrKO8z0Vt0lTSLqKFmIuZfyjDsUa7NZ8ctpVt6zZmD6/JJ5F+HUB/mC1b
H4SJ6eD4glsVCzbHpLRFnHXA/EEcknRKLYaHaREAt5HCZEFz11/xJRSLiWqa5EqP
eBY8JT/St9BO9NLSWCP+/fx87k+mDw==
=TAF2
-----END PGP SIGNATURE-----

--8/UBlNHSEJa6utmr--

