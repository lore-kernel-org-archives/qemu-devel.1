Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74783C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 07:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E091207F5
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 07:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="dkBUZNkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E091207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1PtK-0004C6-Am
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 03:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1PqN-0003IS-2W
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 03:52:43 -0400
Received: from mout.web.de ([217.72.192.78]:57157)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1PqJ-0000vt-Bv
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 03:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596181947;
 bh=3k8OaWwjiE/sMMkrIV3Wf++LcBggb3wqBedD/3L5oYQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=dkBUZNknJoaodqbygE+wDDgb+Fcazkw0c74vKOd8bDYqktR4j/Imib/aDRomKDYZi
 +fNV7mgBoRHpdwFjQl2/J2ExV383W678NdHczJHGfwoTyncfRpUsvuF51BiKMN8u3V
 5inCcoRbgnZDzEkuf+geQDo6T9d6PEP6aj4FAlNo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.42]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lrs70-1klyo03Kyk-013gSS; Fri, 31
 Jul 2020 09:52:26 +0200
Date: Fri, 31 Jul 2020 09:52:17 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Derek Su <dereksu@qnap.com>
Subject: Re: [PATCH v1 0/1] COLO: migrate dirty ram pages before colo
 checkpoint
Message-ID: <20200731094940.7a26e583@luklap>
In-Reply-To: <20200621021004.5559-1-dereksu@qnap.com>
References: <20200621021004.5559-1-dereksu@qnap.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J.VP9aqn2UTKOSVy+4jyF49";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:vqEl0azvZ94Vtj3JXkqoT/YSqoiirLLTapXvmNjEW4SFJP1kF6T
 iMo8E4igeEBpJTPLSpzgfBycpuoT9CsvZWQa7N7v8FGewxTzj+MegDKZD+/gIfIRS7maH1B
 CBPUlGs6PMM9lzPrDsIzWYwl3oaxYkEbtGoEK7VqVfh31hR6KrT/M/gnMrAES6h3Zi3AQbq
 cKN6UG2JycAGMU+z4Vs5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Oj56s0PUhM8=:AL9D597BdW/PPyXUv7jOfU
 pBJhFPUTl6sNcWEz/eQQIqf4CjYU+ull2ij2SHxkW/HL+6QIzYpNf4oYrpHqcPpa5ZlEn+RLF
 JH3i84oXIFJ0jv0ZsaE5/IPlfSVWu0aGBTdoiEHC/eiksebCmXADVkSHIPJupWNhMGCaSJQCJ
 f+d1hdfLTR3wsMnxzg6wVrcqzWY7HUdgeqhuR7jpCh9VmUJ/+nZS3AC8eSfJE7onQjUnOKXPL
 xRflHDg0rm8pv7BJN4wmX/Ofqv7dXWNzu7q5LlxdlTPeZLzutdfgejIEh33YmYzMa8HasSN7v
 rnnr6TyMfKJTTBmb9siBQWPdP1J+ikF5exynyBmkrjRc0nffDjbQTlkaJs2cfUl+Lly38TGYM
 k1FEYMONZSSrvDaVNGkl9CqVPDE9y5dMpUyYfHSAOduf0Z5sHF3pVrxqfIHPNBH3prkRPq0m4
 xBv4ox/6fAaEK5YSNIOuC3MdvxLoPISYgItGenoO2Rww19HQQSgNNF7rwLUM+3r8cvaiVNfGT
 czbZ9pupcLowIZAUE0y24Hr6rKqDumiJH4bBXRPLpcdN6cSsPNs1+wI614LA076VPZfIoMcM5
 D0ziFMPsn/lUPPzw8Gsui3tbORBE0AfQI/MnQeSUR2g0ZzKBeDlvQWeiFOM+er0xMHO0u0KiI
 CIJsPZtMZfC5pQfeW845fktBligzvTx4kB4lbSNE6pIAwPsrcJGOJG0nSq2PYWoNWoDHrQdMb
 jg8rPIXTUKE0Ge2B6ViuI3ZXAaHlzGiHLKIt2JwqJJWb7q7bQ0VTicdGXeaW8z74eAmiT0Bnq
 YDCS1uIAxnJO8XfWo3yv1Jss7RlL6ZxEnN+ymeiFu9ZsJ1nwA4MKj6Tyk2aHhUigcEZ0SbB2b
 86QM0bf0GYOQ9UImsswcHqC7diEOEtV3IOlyAas5azkwFPiaTZlcbyXJspC2CUVtxgcDtXI6h
 keireGARMwa1/rMJbMJt7V2MmKxWGa62jVq4TA8e7nxnT/rzrjySzhgo2sRnIV+CW1FKC4D7U
 IsSP7VkrJKcwxllaHwHJgPZNT79NDk0NN2fJbF+oHAhd6POvgwzKOrI2vodnzA6s/H/cSk32x
 ktgIMCswVT1uDFvJq5HHRZKEF1tOI/hkym35tNmWu50SlD2HF3M/sN1/8aBzEuBHhFHL7pcWR
 jSzv/woW4ujj0CKRl2cSyTDJnalsIMyAKG4lBzyMMgDmyWTN+h8YE248bkeiwGPWRzNBUuFQ5
 iBUNWTWWR+9FOESEWdEUnuA+awSduEzV/q40ShQ==
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 03:52:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: zhang.zhanghailiang@huawei.com, chyang@qnap.com, quintela@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, ctcheng@qnap.com,
 jwsu1986@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/J.VP9aqn2UTKOSVy+4jyF49
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 21 Jun 2020 10:10:03 +0800
Derek Su <dereksu@qnap.com> wrote:

> This series is to reduce the guest's downtime during colo checkpoint
> by migrating dirty ram pages as many as possible before colo checkpoint.
>=20
> If the iteration count reaches COLO_RAM_MIGRATE_ITERATION_MAX or
> ram pending size is lower than 'x-colo-migrate-ram-threshold',
> stop the ram migration and do colo checkpoint.
>=20
> Test environment:
> The both primary VM and secondary VM has 1GiB ram and 10GbE NIC
> for FT traffic.
> One fio buffer write job runs on the guest.                              =
                                                                           =
           =20
> The result shows the total primary VM downtime is decreased by ~40%.
>=20
> Please help to review it and suggestions are welcomed.
> Thanks.

Hello Derek,
Sorry for the late reply.
I think this is not a good idea, because it unnecessarily introduces a dela=
y between checkpoint request and the checkpoint itself and thus impairs net=
work bound workloads due to increased network latency. Workloads that are i=
ndependent from network don't cause many checkpoints anyway, so it doesn't =
help there either.

Hailang did have a patch to migrate ram between checkpoints, which should h=
elp all workloads, but it wasn't merged back then. I think you can pick it =
up again, rebase and address David's and Eric's comments:
https://lore.kernel.org/qemu-devel/20200217012049.22988-3-zhang.zhanghailia=
ng@huawei.com/T/#u

Hailang, are you ok with that?

Regards,
Lukas Straub

--Sig_/J.VP9aqn2UTKOSVy+4jyF49
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8jzbEACgkQNasLKJxd
slgOChAAg6/br8DiPI+PJEcn30E4DqPWxxNb6d0iZnov/Imdr/P5HmtLCmLvuYza
B3fJ+fl01CbldIFL2Oo4G62Wwh1NyuOX8FEVAHFQOxIQ3KvbkoVHb5WKhy2QJz2C
47VxTyxmm1Vk3fL9OF1LNNylrO4e5Aq6uz0vAYw2ZSFFE75tKhZK1botYyIZndtt
X7ckufjobLP+JOuqCmBw6fWFtlphfdvlJ9ChN9crFQUCifRqCPnzs1kX90M47DPc
Re2aQJB6nUZwh0CFAMIF46pPt91NXHYp23wV1L1WsIbsyEUYlY0m0y14UHzwu+b9
UrJKOOzxhIUVIW//8wh+Xs023Gsl5Xw+dQTSfFbDPZzpa36XZpBff+hPbju3Uk47
29eAt4yIpbHYLPbfOL6FfoMQlInzxUToIYvrAMo3YiOIQ6T5E7sXAawqYgKTV6x3
1w1AVJgoJq/JoafO4FwYDgSEh48zDnmEcNoXTmv0wFJjX+1wMj8Gnlxmuk/h6ZSq
AQ22LIt+L18qUyHNo3jS4hszMKuSdxdWtMvYq373WtydoWTdJoYoI6PfM7Et7pgL
/qXDhSpMVbLbhISS3HAmDKDyZpOz/+VnXgIZrRbMiqAjyrOkHDVYPj9HhGfS1/Za
vCVmw60fetJOe4eWftqI+jI3+q5vbsMjEcVzrkc0A5Y8ful6JW4=
=edeJ
-----END PGP SIGNATURE-----

--Sig_/J.VP9aqn2UTKOSVy+4jyF49--

