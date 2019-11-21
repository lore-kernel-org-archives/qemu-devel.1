Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC01C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B0220659
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDIHrgY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B0220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXjmV-0005qW-R9
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 05:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXjlU-000575-SZ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:32:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXjlT-0007AJ-Vf
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:32:44 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iXjlR-00076h-RZ; Thu, 21 Nov 2019 05:32:41 -0500
Received: by mail-wm1-x341.google.com with SMTP id f129so1713642wmf.2;
 Thu, 21 Nov 2019 02:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=GncgCXk93OcPGsrTXAkV/1BETEx5bNcJYOs9h9JsWkE=;
 b=vDIHrgY3IA2qGmY0jd4xCmLtGkhCLjjtVA9ENjHdBHrY1OIUpyJwW8ZD7zxQ1QiZdt
 Opef23Wh0wGG7RXiUGhX/KVDaOd7YmPpMlEuuyRoqytnBDaicJL/R5rSN17mKSQjDMOT
 DwsSsUKqXVM4sWpQ9mPq+iw3LHv0jIAwvnulYlH8hIHu1YVkI1BqkTw/1PTtyYDBx8bK
 1aQy50hlS6GIaGNPMXiKH4MFCiSFS67yXHtTeIlLNMmvCSbvHc5MFRag16KT2/amgzGx
 Nf5lLIS8f0cU95nnGXEOqW3+WWjBrIGiZdLyGpPiuFuUavB/cMuNealpiR0x+NSntlHV
 2oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GncgCXk93OcPGsrTXAkV/1BETEx5bNcJYOs9h9JsWkE=;
 b=T/8dqUkhAtYOHY7tJDB2SnXnrbl49gaskwneQ+RV4x5GL2WFry7wxsiXzii9XCMQeA
 tOy/Phgs3Ag4E7fLIe1cnKPPe+ggJPMJrbpLEJD7eSIOjfanNSxQf0Kv3wJYSp9HbRIT
 N1j3QrEcCPgXRqmSl7ZwQaA+D5yTI323x9r/kL7rW+TYuqexbE9g28t1wrMceUEc02BE
 /JJdLB2ES36sTTkwQV8DtsPOYVhBPmwOgbviNnPBXuLK0F16/mQJnVAQwSL0bau4wVWX
 YplZj003Mf85xVAYai8jvTNLXOO8rfmuOuwvHDnTqwYAnBRDzkCl2A8+UTJCjiXHfZlR
 4S1Q==
X-Gm-Message-State: APjAAAVgsvavEVuGnlEfOAV6qJbrlRGOz01dL5V0i1OVqWs3503XLgPU
 rU9VfJiTcTKxlKqyGszfzIM=
X-Google-Smtp-Source: APXvYqybzTDfyoBrBwcOTvkoUiUPyEZljiucO1kBGYUIfawi67VjYBW64l74SDl30dG9DXQdSGjJMw==
X-Received: by 2002:a7b:cbd9:: with SMTP id n25mr9364839wmi.64.1574332360675; 
 Thu, 21 Nov 2019 02:32:40 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id y6sm2862220wrl.17.2019.11.21.02.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 02:32:39 -0800 (PST)
Date: Thu, 21 Nov 2019 10:32:38 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH 00/18] Add qemu-storage-daemon
Message-ID: <20191121103238.GF439743@stefanha-x1.localdomain>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <8a9a5eae-d388-867b-f4a1-080e876389b3@redhat.com>
 <20191106145800.GC7548@dhcp-200-226.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QNDPHrPUIc00TOLW"
Content-Disposition: inline
In-Reply-To: <20191106145800.GC7548@dhcp-200-226.str.redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--QNDPHrPUIc00TOLW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2019 at 03:58:00PM +0100, Kevin Wolf wrote:
> Am 06.11.2019 um 15:37 hat Max Reitz geschrieben:
> > On 17.10.19 15:01, Kevin Wolf wrote:
> > The only thing I don=E2=80=99t like is the name, but that=E2=80=99s wha=
t <Tab> is for.
> > :-)
>=20
> I'm open for suggestions, but I thought 'qsd' was a bit too terse. :-)
>=20
> (Actually, maybe we could even pick something that doesn't mention
> storage or block? After all, it can do all kinds of QEMU backends in
> theory. Not sure if there's any standalone use for them, but who
> knows...)

It's likely that non-storage use cases will want to a daemon too.  Maybe
just qemu-daemon?

Stefan

--QNDPHrPUIc00TOLW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WZ8YACgkQnKSrs4Gr
c8iT7ggAvAS1gdP4P0cZkwEWnprjbPpabNmI5Fwz8nO1uYMtGLNChvpsWhPVjGni
DQOOw6ne0bONIs39W3M3NjKtLVgydpl8/euSIrIdhXW5MbeoiC8nZ0FySWbZxB3S
rCEsPpiLhUTfE6DUl+dwsgmnGfKYg5Bi1n4DxbMcpR1WtekmYNsYp4sKLcn8TOz7
z4Lp438kzO13KEnT8BG2xq3iBaiQQ+5HwDF4dHGVxX4ivvxN9+/LzekYmVY18nIN
9HQoHUI+lIyBhRzuzcvc9mfXtHbDaY6Lrk5zt5Wr1XcSoBcofTAO76rCkDQr9O+R
AQiLLCBtsFCQmaMFBH928/P092hfjw==
=gTW0
-----END PGP SIGNATURE-----

--QNDPHrPUIc00TOLW--

