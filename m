Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CDDC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA3E8206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqOXyYSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3E8206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPRlg-0000xe-Hc
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 10:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kPRks-0000Vw-Mh
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:46:22 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:41198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kPRkq-0006vi-DO
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:46:22 -0400
Received: by mail-wr1-x435.google.com with SMTP id w5so9901552wrp.8
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Mti8ToBgeF8Xz8ii2x7rVmWXfXxcziA9CWhs2/5AMEo=;
 b=GqOXyYSc7hqR7m+PYE0zPD9UnibSUIVSI8A/3uHbx25H4uPe8Djx0YXph+V1W64iUr
 XwhtUbptGAqonoJp9MNFNvKsssIpVp1CSKeVqOynJDPW9ChZuchcZ58OABG/SslXNJbt
 3wqKD25DA2LV3BwcVnR1fFb/s2LTxI/GtgT8mdMyPpmTj5f+NAPn+aVAfN+4Xk2cMkGw
 QbRcvYL0qkFrvhbQFGc3krQcMyyhSmHAe2nLY3jZXN+Z9h9hFOPagpTqjSgNKTTKIx6L
 VjsU5mQ7IG+ZsG1NbQXzVjUoG0g4exPie9H0A/tkPDryhIC7GCeVI9YMbvDcueXrsqjj
 tXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Mti8ToBgeF8Xz8ii2x7rVmWXfXxcziA9CWhs2/5AMEo=;
 b=hViZZX2InhsxPmD1WVVVPQ72xxt/Fs8Tku3Mwbv5o+SEiBhSq319SftCl1bIjA74u4
 17YKQk8EHFSyDxLLwVAHNKN/qmdReVT9+CnsJdijkeXqdZbU5tqek8IpP97vsnaNKHz+
 tb+JlDY6vbPeajN7xZvhci3909j1L5vET748Cist5HudJrCMOSx9o2uZqC6wR7zfisXL
 sBOi3+wRftoXWu9ErAaYUJNRNbzNuYhuSE7fpBs6h8fGolWsvzKFYWyZ0xdv4vNU7Qae
 EndMFJnC68zJyPUed/N8h9EPfXaNDq0mpSbJnyg2D5B3TDCZf5oYYmF/vE9UwLP+1N14
 r3BA==
X-Gm-Message-State: AOAM533ITyFjlylSyaFll6C7tZM/51G5v57kM4az0MDhFQI/zX4umLtn
 JiLqn2VX6iOr1FiQ/yyEJF0=
X-Google-Smtp-Source: ABdhPJz3USeDjZJlyWbMTaAKsHxwnbf3k3DjM4vHKrfgkQJg1Rkm4IqH3DyGE1iatUY7ikg32gfWrQ==
X-Received: by 2002:adf:fd49:: with SMTP id h9mr8172713wrs.115.1601909178459; 
 Mon, 05 Oct 2020 07:46:18 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u66sm370498wme.1.2020.10.05.07.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 07:46:16 -0700 (PDT)
Date: Mon, 5 Oct 2020 15:46:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: KVM call for agenda for 2020-10-06
Message-ID: <20201005144615.GE5029@stefanha-x1.localdomain>
References: <874kndm1t3.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline
In-Reply-To: <874kndm1t3.fsf@secure.mitica>
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x435.google.com
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 kvm-devel <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2020 at 11:09:44AM +0200, Juan Quintela wrote:
> For this call, we have agenda!!
>=20
> John Snow wants to talk about his new (and excting) developments with
> x-configure.  Stay tuned.

Hi,
Juan will be offline tomorrow so I will moderate the call.

You can join the call from your web browser here:
https://bluejeans.com/497377100

Meeting ID: 497377100
Phone numbers: https://www.redhat.com/en/conference-numbers

Stefan

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl97MbcACgkQnKSrs4Gr
c8g8IwgAxK7tu8b3HFYwYyigwdvR/mgdyTPF5sj4wq+uwsJGrn+QZxEyg1SbFGCX
WcEy1vWEO9gXdcAkNvswz2sogML3vEQV7RE9zXLEC3S5sTK7LB2k7Is4oXKPgP0+
5tbKK4l3GU1bs4Z4rgZT/iBvikhuvdEtHulFWdE8SO/WsmbRctyowNuNHolSm34Z
+GPFQGhxShZeSAftHMirCyYFiz/M5pAzjOUCsTUGMCRevNC0XAuYa8pf9VTwSJwr
CyV1Ks+Lrc2DP03BuPKblwUbkFt/muiNjaVEyVBd65TIcoBx5pn2c3xSxCgy0CYz
RQulsmPO8OgcLb038/MsKZsjuNLjMg==
=hwnF
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--

