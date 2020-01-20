Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F8FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814E722464
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5prAGTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814E722464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYPR-0004x0-K8
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1itYNp-00030g-Oy
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:50:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1itYNo-0006Vy-NW
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:50:29 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:43445)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1itYNo-0006Uz-HK
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:50:28 -0500
Received: by mail-wr1-x434.google.com with SMTP id d16so29875318wre.10
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 06:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2McqOyMlykh/myZdIIfdUj1SwrkV0TsSgQCMDHqCtKw=;
 b=D5prAGTRY5qK2G2pjEKifWksTcApK5nsl9Knp9Hn3ffNvzK3mMrQ1NnaE/2OsLamMW
 XZZ1VMeTCpLfU92b/stwGkEPnFGAyHrgHCiW8OG+p6/AHdjOXeiZbHt6NKVsDkHf/80C
 l7JG2/4+oc22HFwl4i7ZveIGEQOi2+AQqGNb72EGVX2tms6MaFU+80ECfV7oWnQ2lKqf
 uhTpY2crTjzIL9u2jVwqODXYQVeLST2xFKIwzSAYBMBjTRqAn1lT4y7s1892drZt+OIY
 JhukqAustzfUJqfRlfWQ0VGhw32TpIPt3k+XdtQhT0wxYY9bX7Wnt/OONxgPxPgPaKFN
 mk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2McqOyMlykh/myZdIIfdUj1SwrkV0TsSgQCMDHqCtKw=;
 b=s6xw2b7v8oyzL7HgucPPfNsyegKTB474Q82FzIjzj9zzDQjhZRc16sv++R70s3Ub35
 hTR3B4Zujxb56ASk4MrwccU8hVj2bs383O5lVgIKX60Yb1eKEcgnGzr8KY+8MYRVRM4C
 rurM+Lagu3z6ghS6q95FYg7BA1eZo8ycX1UtAl2iRCn85U7dun1f+d3nKzVO3kimSc+o
 IMWVko/vOCHwLHSNqSkY1gj2AU0+itM1Fq0R6PHQcBDsGwRERDIgaQG/ACp9XJ8a/msV
 u+TJZkrCXePzHt/QtP8LX+p7Bg613Px0QHFdaSGM16a1zZRFH21xDWCx92kcHyzeMFnh
 i9vA==
X-Gm-Message-State: APjAAAWByGn8WTaYrphZY7F4TeyoCvxHgEVClAdaSkcpsyQoijsgN8yE
 5n6uZQ2FC1sh/MGdLMtW8a4=
X-Google-Smtp-Source: APXvYqxDm/0+lVSqXkghUbH3X+B/wuJnlcUNcNRHVT0mV4viVPpIiDLoTdRj9NFYwbKIhllOhuxP9Q==
X-Received: by 2002:adf:fc08:: with SMTP id i8mr18323220wrr.82.1579531827066; 
 Mon, 20 Jan 2020 06:50:27 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id f1sm49338747wro.85.2020.01.20.06.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 06:50:25 -0800 (PST)
Date: Mon, 20 Jan 2020 14:50:24 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>
Subject: Re: [GSoC/Outreachy QEMU project proposal] Measure and Analyze QEMU
 Performance
Message-ID: <20200120145024.GJ345995@stefanha-x1.localdomain>
References: <324a-5e231180-7-6946d180@169257031>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HcccYpVZDxQ8hzPO"
Content-Disposition: inline
In-Reply-To: <324a-5e231180-7-6946d180@169257031>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HcccYpVZDxQ8hzPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 18, 2020 at 03:08:37PM +0100, Aleksandar Markovic wrote:
> 3) The community will be given all devised performance measurement methods in the form of easily reproducible step-by-step setup and execution procedures.

Tracking performance is a good idea and something that has not been done
upstream yet.  A few questions:

 * Will benchmarks be run automatically (e.g. nightly or weekly) on
   someone's hardware or does every TCG architecture maintainer need to
   run them manually for themselves?
 * Where will the benchmark result history be stored?

Stefan

--HcccYpVZDxQ8hzPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4lvjAACgkQnKSrs4Gr
c8jLbwgAroy/m9RtjdClst/GVKwM0an5nZUhZgPyiS8ZCgek+tV251GvMutuhyrC
qGQDhzDWmTuNzGQvRWJDMagSMK3hQsVuZ68dajjCIx16xjG3jX+QkJEMobWv8akW
Rpj6ZAz4v1Uzj12qCz9ofYg1NOEoSWCxykEutvKfMUPZfcSnwCnjGoxsXFxqbo9d
E2m1XDA1cIx0yz1QCYj3GdL3iuitQfiO4VfM+D1rtV1qYo2XfXq/GEBl6NGBQJEO
FN2nd+Ja8QDlrNfRrKBP98oYbykGl7SYXCd+Wywqg0nSI8u2Rqoz01VmkbIcfAUR
3zptD6t+ZHRp70PwaK/M/y6XzYh5xw==
=y/MB
-----END PGP SIGNATURE-----

--HcccYpVZDxQ8hzPO--

