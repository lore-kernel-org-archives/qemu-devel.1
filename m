Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2CAC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:25:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371FA2075A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auGg78cT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371FA2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVb5n-0005Y2-9w
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVb51-0004YI-BA; Mon, 04 May 2020 09:24:19 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVb50-00063G-4k; Mon, 04 May 2020 09:24:18 -0400
Received: by mail-wm1-x343.google.com with SMTP id k12so8392519wmj.3;
 Mon, 04 May 2020 06:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=P6mz5i5MjURQjd76DBHa/3fb9OF1Vg3Yy6baRWjyx7A=;
 b=auGg78cT5GOY6cmXD7x/7xTsPgANoyyUerjFaG7vgaBcg7veJftCjDSttF9OhEOucD
 7oBrmEREAgfGzKsbHB1ajkWYDPsO7bEV/HYGMC5oF3XWpANvvUWL9oMMBnSOZad0xugr
 9JrqcRJcEQ9yODHKbHwFnNnv/z06eFpnYX/8ycxqTvHB8UyW0Vx9iMlR3q/RspI1y7lU
 C+AxfUBfdkkowUnTmxVPHobbcT7Dq8/2XRcERyVLzTww+yTSEKi1Y77nclxce4R2tap5
 UNGMj5e3pMf4kj/3ndijoySX09o8ejRaui80VkaPCa97Jx7XSrrkGwowCA4Z+J1/Nu5j
 n5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P6mz5i5MjURQjd76DBHa/3fb9OF1Vg3Yy6baRWjyx7A=;
 b=jSTlv5fEAyztqffa+R11YUVFQZt4lvEw8/mw3dfLvpNuLBZhNfSv7w3OY53ey7ycUL
 eXenM2JSs+yfawbB7ZEnRhZAxsIWtCuywIUd34IL6toARaZmq3rFNrLwSp4VHLzmYch3
 jS0wgo87hbs9iP7dGOO7R6SvOIuHEbIjTQbCu64NDFeVdvFx0/FJ/bgV4cbUL6Wkack8
 lTRtUP9X+dy2is00x2dNyfYmlVLIxnGxEgNvnW9ribTINYbyU054zMnEVx0ORiPfW2K2
 bx5BBDs7PW01LC/4ygIdyIUNJOjqcGneBtJ0K2KrGb5/vBSECZDbObQsas9AXbkqrlxG
 HPnA==
X-Gm-Message-State: AGi0Pubdao5DvpbkBU6FL4fyI5x0aiCO7wgamdM02iIOINkIPyVilQh5
 +c1LFHg6elPTgfwUtlAxWfA=
X-Google-Smtp-Source: APiQypIAcV9PuN2gQUytBlAtuuqmyLRY6CYmKxlauENAICA9PS4UhuxyKVAkvfqRaG3xtTTz0bpmGQ==
X-Received: by 2002:a1c:4304:: with SMTP id q4mr15752880wma.152.1588598656261; 
 Mon, 04 May 2020 06:24:16 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w12sm18609055wrk.56.2020.05.04.06.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 06:24:15 -0700 (PDT)
Date: Mon, 4 May 2020 14:24:14 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH] iotests/041: Fix NBD socket path
Message-ID: <20200504132414.GF354891@stefanha-x1.localdomain>
References: <20200424134626.78945-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Content-Disposition: inline
In-Reply-To: <20200424134626.78945-1-mreitz@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2020 at 03:46:26PM +0200, Max Reitz wrote:
> We should put all UNIX socket files into the sock_dir, not test_dir.
>=20
> Reported-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/041 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Cool, thanks for fixing this!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6wF34ACgkQnKSrs4Gr
c8iEBAf/b5I9xULCCdjKSHvIGDpCS6GcN2/GtrCo8KC81ECncNmXR1ywAG6wRKk9
EdGXbZyBwIqig4Ae3up6aTDtbFYyEhkDbIPkg9AmyTGybyBn++HLKhG8cC4bVThb
51E7ohCw9Z1tbnpoBdUnSJ7khV6ZfJnFIO6r1Kru/zAEV2A44+Pv9Cz59jwBp6vF
qQNZLQpJzSQHBhDYSrhtTw0xwe+axbS5pScIZv6BEKVC4J6Rne9ruBUk8nCiQ3/r
5UalI5UGoFYpps+7OEhqe+RrtUKyL44PwOgPWHRxUfHbrItgUB0pf9QWaLeAdlfb
HpFqJQ70zCpXpRChiWgxqfPlVX6yGw==
=ZKvG
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--

