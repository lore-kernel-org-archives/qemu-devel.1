Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2904BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A735820723
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiNsPUJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A735820723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkSN-00072R-GL
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnkBs-0007ND-Uf; Tue, 23 Jun 2020 10:46:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnkBq-0004MA-Bl; Tue, 23 Jun 2020 10:46:24 -0400
Received: by mail-wr1-x441.google.com with SMTP id g18so11773917wrm.2;
 Tue, 23 Jun 2020 07:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yh3GjChhveR7dB+sE/rtvDZhFV/1/0QQvdcijxqZsOc=;
 b=fiNsPUJPzsjyiAWv2YhZuB5bL5N8hi9B9myGIDEvZQz3lNiHaN8RhbQZEFSlI50un6
 s+5pQzggZvybDTse/X/n9a9RG2dJSx1sEc4P4IVyhYFaAk2gdNTIkk+VkwS0eFRTsfSo
 XWFjtAAewabx0HBf1C8LDFb5IGz/X2hOwCBYkQa/5931mEV9tYyJn31sPl6VLWv01uJx
 4mWHfO6awELQvsrQDX32PW8o82iEGdSbgTRVsdshekhycARqkGUQSuspFmCrvjRtqzSv
 DaRaexm5K/D2aqvPZluMHz3iCzjVc4c1Afdhwyx45zGmqr/f268jn3WrKzkEMQj3Zlkx
 GQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yh3GjChhveR7dB+sE/rtvDZhFV/1/0QQvdcijxqZsOc=;
 b=n910XANqgLnARudCvDaddSZo3MWsheZzPDMLOXPPhLoIrELzTN3um+0oSpfSffENCH
 Me/GHuMj4YlJ5iuc+JFMzp/UAUeF5wj+HOv+fI2km7msX3t1X8SfzcIRoRcGYadu8RUD
 yMFg5EJ/y5R9wPvMgrcz/08sUm9fLEm7oCLdN9v9rDjQ7b8RPZHuOz6WqrUS1Kqt8KXC
 P4fL4eYomofD0IJY2mqCG2rr4iC9IuVCSLyNqhWZMJaq0Obtn+FaqSme3xgoYiU+ujrv
 sBTedxkEfm3LkH0YUj7zNhFmL98kQbq8wclp7NxJG3lrWbzKz/5oEKN/uauGyEYWIUoW
 heCQ==
X-Gm-Message-State: AOAM533DRRCGdAt2rExuDXW09ecItGs7LpLl+GfMHfwuwddyD1hWU5wF
 cEVK81rULjFImLaBRLLgMa4=
X-Google-Smtp-Source: ABdhPJwtfPvCs1N/lCmAd+E96yWEufKgwLnbGuZ8WV4oB/gfAbNKa9E4aopZWmRnkurVyBjq1Wzisw==
X-Received: by 2002:adf:81c7:: with SMTP id 65mr24646900wra.47.1592923579811; 
 Tue, 23 Jun 2020 07:46:19 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v66sm4269210wme.13.2020.06.23.07.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 07:46:18 -0700 (PDT)
Date: Tue, 23 Jun 2020 15:46:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 0/7] block/nvme: support nested aio_poll()
Message-ID: <20200623144617.GQ36568@stefanha-x1.localdomain>
References: <20200617132201.1832152-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZqRzwd/9tauJXEMK"
Content-Disposition: inline
In-Reply-To: <20200617132201.1832152-1-stefanha@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZqRzwd/9tauJXEMK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 02:21:54PM +0100, Stefan Hajnoczi wrote:
> v2:
>  * Reword comment in Patch 1 explainin why its safe not to hold q->lock [=
Sergio]
>  * Fix s/unwiedly/unwieldy/ typo in the Patch 6 commit description [Phili=
ppe]
>=20
> This series allows aio_poll() to work from I/O request completion callbac=
ks.
> QEMU block drivers are supposed to support this because some code paths r=
ely on
> this behavior.
>=20
> There was no measurable performance difference with nested aio_poll() sup=
port.
>=20
> This patch series also contains cleanups that I made while examining and
> benchmarking the code.
>=20
> Stefan Hajnoczi (7):
>   block/nvme: poll queues without q->lock
>   block/nvme: drop tautologous assertion
>   block/nvme: don't access CQE after moving cq.head
>   block/nvme: switch to a NVMeRequest freelist
>   block/nvme: clarify that free_req_queue is protected by q->lock
>   block/nvme: keep BDRVNVMeState pointer in NVMeQueuePair
>   block/nvme: support nested aio_poll()
>=20
>  block/nvme.c       | 220 ++++++++++++++++++++++++++++++++-------------
>  block/trace-events |   2 +-
>  2 files changed, 160 insertions(+), 62 deletions(-)
>=20
> --=20
> 2.26.2
>=20

Thanks, applied to my HEAD tree:
https://github.com/stefanha/qemu/commits/HEAD

Stefan

--ZqRzwd/9tauJXEMK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7yFbkACgkQnKSrs4Gr
c8gmIgf+McKrMcHNYhoFqA2RF5UEGb3/eQYjE47S8m6gfJ/PXsO4Fki97oB4l1nG
MSZlF8NBhU94SiAdKR6TIehhCNvkoFHHU8Y6AHNVK61LEbeF/K/fIo+RYFRmH2NO
ST8dOnmZzvoQLzP9vwseHvyYHrcbAqJQ7GVw69TacVtS87aAoAGzoaOqNhPxwxMk
bGykCsLCTBVHiGqy/zWRjGlCqHCpyEckq9deom/a4Ot4YLQDvVK/pBO7GPJ1APJU
NKUJKgypcukMhNtaeGYPnPZxDGvrCDk41BZvK+noSByP8BX0vKtEktdiWLoeB2YC
ybDL8scZNeQPaBY2xEUWDFVSt/jd5A==
=VxZ7
-----END PGP SIGNATURE-----

--ZqRzwd/9tauJXEMK--

