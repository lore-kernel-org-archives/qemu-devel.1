Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A54C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C686122527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pP139/Zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C686122527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifMTq-00027O-Js
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 06:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ifMSW-00019E-TQ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ifMSU-00073l-Qq
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:16:40 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35938)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1ifMSS-0006wX-7X; Thu, 12 Dec 2019 06:16:36 -0500
Received: by mail-wm1-x343.google.com with SMTP id p17so2060143wma.1;
 Thu, 12 Dec 2019 03:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QqnQQsmBZgDoDwaMdeOpBLjTR0utyxmr0HW0TLKef0s=;
 b=pP139/ZcPZI/iroT5ektJ0fpNjduKZx2hVMtqPEoazJQk+j8qnCODJoz8oJAupt8Ne
 pJSoQxwSzi9fmAkXxiA8qgXFWk+KK4+HJgsrwkEIPBEGxY+yyQQT1Bbm0xnr6KQjz7cW
 PuCmeJFrHyxvNY5XDwMtCrFNovEXg4b2QBzmHaW31iGathCTfPWFNmHuLZt4YPoTeicp
 oaweRjU16K+6lPmIGXyp/YfX8vGEQ1emB6e+jmxkO90okxQA68kM80aWlfMq/IfIDZ67
 nRERkj4XSOjEOdTNBewNgW5goobjYy7CxxA5hQtMzFma3Ku3lEpPKY1E+FGATWEPi0Cc
 35ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QqnQQsmBZgDoDwaMdeOpBLjTR0utyxmr0HW0TLKef0s=;
 b=UdnCJkbNfRh9MKaVRUW2gZOi6R81V0S/swYXq1AUJf4nrNdZ/14K3bxkk6Tgq+HrmZ
 oOVG1vzPz4hByFjcv/sW5OitvzGNsH4pOaPblvpVhJn4Ay6oN7GUPltKKczTXlN8VsuP
 MdXau7zJ6bsv95EFPxKhKuAREQiymfyEwte3ytT7Bi9ytz6w/2VtZ8XPaFm45qmy6T1k
 myHx/SlS3SIs+c4+8JRb34yVl95qTi+OoPU5Uy97NPucaPwwygFhQMUdozOpqAThNiHk
 ZgARv41ysxWaU56fGHxNJNQPyh2hCCIBAipU5K+SRhzsCIEyQFTI0LBtb2F8oby6sLT6
 9ZRg==
X-Gm-Message-State: APjAAAWRvV37ijaRl4EIdZYfAQMAis7VVriVveS0VlJtaYiKyT4ie+rf
 DMAuYm47ZyqUBtxCzP49BT4=
X-Google-Smtp-Source: APXvYqydYS/sEFtCcv0+kT3ZHBH4UV/NGQlIsE1q3MjE8bPXZOiO2A/BqWiW6LRN1iUkcBuMhqsCIg==
X-Received: by 2002:a05:600c:2207:: with SMTP id
 z7mr5779038wml.138.1576149395122; 
 Thu, 12 Dec 2019 03:16:35 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b185sm6276906wme.36.2019.12.12.03.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 03:16:33 -0800 (PST)
Date: Thu, 12 Dec 2019 11:16:32 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH 00/18] Add qemu-storage-daemon
Message-ID: <20191212111632.GB1141992@stefanha-x1.localdomain>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <8a9a5eae-d388-867b-f4a1-080e876389b3@redhat.com>
 <20191106145800.GC7548@dhcp-200-226.str.redhat.com>
 <20191121103238.GF439743@stefanha-x1.localdomain>
 <20191121110816.GB6007@linux.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <20191121110816.GB6007@linux.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2019 at 12:08:16PM +0100, Kevin Wolf wrote:
> Am 21.11.2019 um 11:32 hat Stefan Hajnoczi geschrieben:
> > On Wed, Nov 06, 2019 at 03:58:00PM +0100, Kevin Wolf wrote:
> > > Am 06.11.2019 um 15:37 hat Max Reitz geschrieben:
> > > > On 17.10.19 15:01, Kevin Wolf wrote:
> > > > The only thing I don=E2=80=99t like is the name, but that=E2=80=99s=
 what <Tab> is for.
> > > > :-)
> > >=20
> > > I'm open for suggestions, but I thought 'qsd' was a bit too terse. :-)
> > >=20
> > > (Actually, maybe we could even pick something that doesn't mention
> > > storage or block? After all, it can do all kinds of QEMU backends in
> > > theory. Not sure if there's any standalone use for them, but who
> > > knows...)
> >=20
> > It's likely that non-storage use cases will want to a daemon too.  Maybe
> > just qemu-daemon?
>=20
> Do you have specific use cases in mind? Most backends seem rather
> useless without a device to attach them to. In older QEMU versions,
> maybe you could put multiple network backends into a common vlan to
> forward between them, but even that vlan concept doesn't exist any more.

I was thinking about the model where device emulation happens in the
daemon.  We've since agreed that device emulation will continue to
happen in a more traditional QEMU process, so I can't think of
non-storage use cases at the moment.

Stefan

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3yIZAACgkQnKSrs4Gr
c8hPTAgAqSffByDjSVqzXSwNbzHdFHT5Rtaj10cNPnl1w9VlQb5j3S5dI9qy4AFr
k4nS1gLq8xAFtzvsQQVh+DjFyQQ6ypPMrFgs7A3Fo/tROfoA5dvTNPxCUMCXETsA
8oQplSEemknMbQU2UEkamtyngTEyFV+sA8wVTKh45zQ7jCbo3kllHg/9URBYOWEk
XYv/A1SV6YFQJX5apTeMKy0EjUgbLUs7hGQavJEmtmZigHRrHbrWwucRVzRhXicP
sfpTvfZ3km9kdD+cdbCSJFXVXxoSetdfZ8FLhURiayKZunEwB360vH8U1yOYkXFG
MAWdrvapibEpq3jabi35g4H0sosVvg==
=9wZC
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--

