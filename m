Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAE2C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEEBC2467D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e48+3sH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEEBC2467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBblK-00088W-4J
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jBbkN-0007Va-LR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jBbkM-0004RZ-Gh
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:04:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44664)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1jBbkM-0004PV-8W; Tue, 10 Mar 2020 06:04:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id l18so4921411wru.11;
 Tue, 10 Mar 2020 03:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=uXMrZYnm/ajnvjX6gnUdkac+2PvDH3IwSNKAlytOR00=;
 b=e48+3sH0ZuW5dQPiWi2Vc4LB7lTQh6dde67axOIddMKJmmsrc7ZdSRkl/21vh8RiF5
 rBSx/xmGmD2uGp1JA2smQTxll3ZpSu3X/Iqmxn40o1IeQvdHKdGbQVozwnWGzIRq1XSq
 WQ1K/gZNkATFPazrhnXMCW+bKSEONSFIAlT4t5zKiVxhxWnYGWP7NKwxkdcgM/AmPi+Y
 wojJveRUTVLmE6F+cMiy5KEr2Iu5FFQHBUnuY1UREo1z/LmAYG7TGUQ3jyzOOQ36KqQ/
 LbP2ZMNUbZuClj5Bnqu7IkwWbSZMoQkJT8ElUfxVW7wwFdBinaP7p7ICDxuU6ARuw3zE
 rETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uXMrZYnm/ajnvjX6gnUdkac+2PvDH3IwSNKAlytOR00=;
 b=ptspRVjGgSOYTFbdbXSooXiGzplUE5cLCw8WViZNaH4yvWo2Zg1Z+1OqFe/Zxapb/8
 UpMX+p3DhjcwiNs4niRiE8ovN7SKV7xc/gxUoZXwSw8GtjNwgqarnAtyBoAF42FhA7ZB
 alnO/NcIEZb+An0BQHrNMzA9gm+i1ruyDSf0CXf4CBN0+rN4NR09MCJgyCD539P1vvKf
 w+wHFGJogAwJaEQ1pVGkVu5dJ3ntmH3OR59BzJyCKX9w/Nfo2m8KnkOyrDm33kjYpE//
 fH0R9Fcjp7wUouNAzuSQZFubDpjetKi6Z/xBfCUgpti9XxXATuEz9HB4x1NFh69bcuQk
 B9dg==
X-Gm-Message-State: ANhLgQ2rrOX8y749fAtXD/zBw+oacvZutWQE4swdZg7ZBwNBOXCMH5dr
 ksN4IUrAgrhV5dV06WGWcOk=
X-Google-Smtp-Source: ADFU+vuznQAqxDTPoiJFir3VM5yK+rt4XSjq5tmc14hwUKXz2JYoQalPnh6pQU8DKvEvqJXGUO+pHw==
X-Received: by 2002:adf:eac8:: with SMTP id o8mr13531314wrn.105.1583834661143; 
 Tue, 10 Mar 2020 03:04:21 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id y200sm778371wmc.20.2020.03.10.03.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 03:04:20 -0700 (PDT)
Date: Tue, 10 Mar 2020 10:04:18 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: =?utf-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Subject: Re: I am trying to fixes a issue with QEMU with VxWorks.
Message-ID: <20200310100418.GE140737@stefanha-x1.localdomain>
References: <CAE2XoE-XeFmmPHsy6KT-zHtRcZqZnuWzaXR+SkMP60cCL2jx0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Content-Disposition: inline
In-Reply-To: <CAE2XoE-XeFmmPHsy6KT-zHtRcZqZnuWzaXR+SkMP60cCL2jx0w@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2020 at 11:26:07AM +0800, =E7=BD=97=E5=8B=87=E5=88=9A(Yongg=
ang Luo) wrote:
> When I am running QEMU to simulating PowerPC.
> And after running the following powerpc code:
> 00e2b5dc <intUnlock>:
> intUnlock():
>   e2b5dc: 54 63 04 20 rlwinm r3,r3,0,16,16
>   e2b5e0: 7c 80 00 a6 mfmsr r4
>   e2b5e4: 7c 83 1b 78 or r3,r4,r3
>   e2b5e8: 7c 60 01 24 mtmsr r3
>   e2b5ec: 4c 00 01 2c isync
>   e2b5f0: 4e 80 00 20 blr
>=20
> The QEMU are getting stuck and can not running the following instructions,
> What I need to do to inspect which instruction are getting stuck and how =
to
> fix it?
> Any means to debugging that.

CCing ppc maintainers.

You could begin debugging this using QEMU's GDB stub (the -s
command-line option), TCG debug output (the -d command-line option), and
the HMP "info status" command to check that the CPU is running.

Good luck!

Stefan

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5nZiIACgkQnKSrs4Gr
c8h5jAgAu1I6lrbULmQIgondpjsK8q0VmBAPPTkIrNl76WaQGx/IpGjkbjjDVwsW
oNMI6jxRnwYK524FKVYzPSbkhwyjhfasf+hTx+ksVOmZ1JNx27auKi5b6x4r9xqu
xS+tu2ebDaRG7QH/518LSae0Se212fbloaxDPA9Ak00acB47eFZYB7kaG97KSwWy
xLROFfX+7DcKTwjuHxUvgZXAjWeE8K9V0bmfU40vkiy98yQY2jUsXmYRh4lU6BC2
RlV4C5RK9uLssg8GB7mZ0vW5HcRIQ/hQCBQJhjuwlsu+Z06wrDXFKJlKgwu/XP+n
R16OE8ADI6f/DF3PvnDQSMiPYNi2sA==
=y4I4
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--

