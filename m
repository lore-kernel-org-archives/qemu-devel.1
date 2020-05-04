Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64676C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7CE2071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7CE2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXob-0001CE-DQ
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVXlU-0004Qw-E2; Mon, 04 May 2020 05:51:57 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:35719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVXlS-0001rb-MY; Mon, 04 May 2020 05:51:56 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MHndY-1jPTTm2eNK-00Eu2R; Mon, 04 May 2020 11:51:32 +0200
Subject: Re: [PATCH v2] Compress lines for immediate return
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Simran Singhal <singhalsimran0@gmail.com>
References: <20200401165314.GA3213@simran-Inspiron-5558>
 <20200403125301.GD146016@stefanha-x1.localdomain>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <85e649e5-5ce1-866e-801c-4385eb9c25d7@vivier.eu>
Date: Mon, 4 May 2020 11:51:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200403125301.GD146016@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IUpxxvdxAyMgoPXKMzFgC4Z93WFaQSU2L"
X-Provags-ID: V03:K1:B0vemVVc6zxBf2NO+fSd7UdV0bnvzFN18n+XxNYVKYs08b4DU5U
 lscsJFRMrzhRqt18TxBkC4YW/5tXUInZyaAo1UGVYZQGPmMjyAl2wfVSqAS1G1HmV/IuecY
 UnS592p/L/xWa8riMtmzanWhYJrNSK86a1iMghf8TRlZ2PHCbfNPZdrXRIS4D2SeJivinkc
 Mbuq8CHcseYwONeqIO/MA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3CPr9MERVao=:7fNwkti7W+2oFVz+XZq4MQ
 8CHJymy17eKrZ9RIxC+kHlD1aDqBWcZXmOshPNlIqL+v+/5t7xcPvvL2dY5QrNogxdbVnnEEq
 THp07PkAxLSz7IjCtHwi6kShZyIfVdF9AEbZhv3DZGZZXXbZ4n5AasNU2gZZLn7OQ1zzdAP5K
 u313RzFN00eaBx1cnMvVQARI53pxtWCgCEcfF0fOF1r3a9vrRQUmk9PRELX1ULO+3VXuS73d+
 vIVtAtRpAhMXaQkSkGlVOadQOsgXE/aUloC5XyGl+m0aX8szuwNAUTG6xgqLcwZBswfub6GbY
 kKTpCtTauozueI2pSyIIorPRoDFr1jOVQl+B1qknZ0/3ZlymadPt2lMBU9xxjHILvwvZaNBy4
 PoScDrQ3HW8vr3fW59IhjWH4YjA9bBfxsBujWg7ZHY73tNrBYA38BuczREnaDm2cJKPJ952Wq
 F2b2PiEstVL7wmVgHclXUah2AQc43XcjcCtqdb/yX1gg76bDb016HmpMWxIw+fIT+XGZ4osOL
 893cae877hwC+7tEwq+BexAUFEQWa4YRkUUyJTqed07G7wA8NXYPlslUIuyf/zPITlm4obaqP
 zi8NKG0jpTx3h6OEZGlXNkcDMIT8jPqm+giS86OZJ7ds5DPg3yHQpakk0LSrpJwTPSfcGmGqK
 RmJBurpqcs2Bg3q3etZOWcQ1b4MORWMEjRfuFcFSaROWu0G8V7jyRdZ3MqzZK4isN0CPWWykP
 mY6iE+dW/0xO6WQJyOIDMHGGeCBMbN6t2Z1Gy0JnIo0FQoAywSYze6u8ivR6Q/qqbsWkwBXX1
 zaQxV/zpWcWYNLUd0lHZ39NVlcMt9Skp1WdpNppzyVRPHnIJaXEQVrShB4b2Thm9LBHj0oe
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:51:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IUpxxvdxAyMgoPXKMzFgC4Z93WFaQSU2L
Content-Type: multipart/mixed; boundary="yW2uBl7fbcovMPdtAvldpeVBDIsy6oD6K";
 protected-headers="v1"
From: Laurent Vivier <laurent@vivier.eu>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Simran Singhal <singhalsimran0@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>
Message-ID: <85e649e5-5ce1-866e-801c-4385eb9c25d7@vivier.eu>
Subject: Re: [PATCH v2] Compress lines for immediate return
References: <20200401165314.GA3213@simran-Inspiron-5558>
 <20200403125301.GD146016@stefanha-x1.localdomain>
In-Reply-To: <20200403125301.GD146016@stefanha-x1.localdomain>

--yW2uBl7fbcovMPdtAvldpeVBDIsy6oD6K
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: quoted-printable

Le 03/04/2020 =C3=A0 14:53, Stefan Hajnoczi a =C3=A9crit=C2=A0:
> On Wed, Apr 01, 2020 at 10:23:14PM +0530, Simran Singhal wrote:
>> Compress two lines into a single line if immediate return statement is=
 found.
>>
>> It also remove variables progress, val, data, ret and sock
>> as they are no longer needed.
>>
>> Remove space between function "mixer_load" and '(' to fix the
>> checkpatch.pl error:-
>> ERROR: space prohibited between function name and open parenthesis '('=

>>
>> Done using following coccinelle script:
>> @@
>> local idexpression ret;
>> expression e;
>> @@
>>
>> -ret =3D
>> +return
>>      e;
>> -return ret;
>>
>> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
>> ---
>> Changes in v2:
>> 	-Added coccinelle script wrote for changes in commit message.
>>
>>  block/file-posix.c      | 3 +--
>>  block/nfs.c             | 3 +--
>>  block/nvme.c            | 4 +---
>>  block/vhdx.c            | 3 +--
>>  hw/audio/ac97.c         | 4 +---
>>  hw/audio/adlib.c        | 5 +----
>>  hw/display/cirrus_vga.c | 4 +---
>>  migration/ram.c         | 4 +---
>>  ui/gtk.c                | 3 +--
>>  util/qemu-sockets.c     | 5 +----
>>  10 files changed, 10 insertions(+), 28 deletions(-)
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20

Applied to my trivial-patches branch.

Thanks,
Laurent



--yW2uBl7fbcovMPdtAvldpeVBDIsy6oD6K--

--IUpxxvdxAyMgoPXKMzFgC4Z93WFaQSU2L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEzS913cjjpNwuT1Fz8ww4vT8vvjwFAl6v5aEACgkQ8ww4vT8v
vjxS/RAAs4IScEtPgDRP/Og+v7OrrWOdSzzzuNJySohawWzzSKkJxrl7kXuf/KfI
s1RxKqxHDGL5ehHuCy0YOxsgBXCpbw2QrKc/6peldH9qfbd6uvdwUjaJEqvTTugb
4o/mUI4mGVQuQOxLRAjoVF17V6tzLr7WVvGKobAF6+dOD8SNP/SB/yeFmlVJKUoG
T74JEIU4W6jrOyS3zjdZp60JfE+e2IHjSciL6p4LIsWEhXuvKX2EHdH2wB+0JLkM
q3cZMB9dMGS0l79k+1oIt6XKEQqeUDBKJncktxHujzrVNP4tnhnA3dGsXXVAxamg
5xm2nRwebxddMbyCrGFAK+VH3jFF7RdKPFvputeHzEnzPqJABdfz41PpI4volNO9
Gk48ZAJd4TB9ut36qVbmdrv8SPG/B4V/6VvTMRquNzlsPdg8YbXUK5lAMOAxE/ln
y4HFmmxkk2MEjVfkS/JjV1lgN8wWf6E/WMWksCL4TGRwCjRD5zGtmkW/8Y3tHPSE
QairOSYyG2Jptz/cfOkmEPkVs0VoKc9O6iFfSfgMLc9g3cLPGGVk4rbEmjcPWAYm
SLUolM5ikwgJ9nG8lh5F7zCMtXfdf5Tw/IgRugsAH5rI5xKOntbK4J1ZEKsSHG+A
hUmYUMuVtafQvS2dZnZCYJ5MaXv+ITcRNgKBj8kJojFLEaDw5J8=
=mlIO
-----END PGP SIGNATURE-----

--IUpxxvdxAyMgoPXKMzFgC4Z93WFaQSU2L--

