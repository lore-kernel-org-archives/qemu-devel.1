Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734C6C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5A2206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlcBSO98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5A2206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in277-0004vL-DD
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 10:10:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1in26U-0004V8-0g
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:09:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1in26T-0005Zv-51
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:09:37 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:38612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1in26S-0005Z4-Up
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:09:37 -0500
Received: by mail-wr1-x430.google.com with SMTP id y17so39554875wrh.5
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 07:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9OlDTiJa93awgMJ3IT1E6DCaMBZ7w+lmIK0sdirlfNQ=;
 b=rlcBSO98RJupMv0CRwOVYicSqAZpbGqSQMUs5Wth2UN9V5q0mUToY7cFlmRuQ/rcnp
 b/RgjiN/3WxAVqEAOa+1PCYbmv22OxqTdLSLLF7XUSEd943QwSnD1kl6MneYBUoWwDWL
 1VTOS9yfV25Uu6a+PqL5RCttnVKHDyRMdHz175NVLOQRZpd0GntJXZyKM2NadQpLIhFP
 mcQgg6TN51jaljdW/7WuFJ+PN9W86NDcowHfq0zpeD2HDmQK8QbgV3aiFPsDrwYv3QKq
 +MmVuV9G+BvFhFOLsvpbvhcwZiuhHmMErCSpEC/bbBJ9aHTX9Zyg9sW/Ga1q7AYA0cw3
 y7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9OlDTiJa93awgMJ3IT1E6DCaMBZ7w+lmIK0sdirlfNQ=;
 b=tc9m04LqtqrAUG1vmAUufVYqRA1JzEGktXmPlVpVAGM3XoKElOf5yMjyDSwxWV1C7R
 uEgreM8Fzt2n5QmoHnCucLHH4SDhDOIKlNLIILNjSoW0i4sP+4eQkIcq3Jk3RsSBTW28
 p5MhbzhlEpbkWRVr9yVaaw3XtRAq5b0Za9qsnwyu70SBuI1DM4O4k7Wz/JK+mbw+Vg4p
 DJLe7yUvrkHUew1lmfn8KaNK2P+oSX5BDJvDMLViTDRWetyr91U7bBpX2cZdTHkwxQWH
 GjR8jDdur7ptYq6AasvunzzEl1ixRKg/7KHZnt28AihZZUnSWKWvcAJOIJoXQDhtfS1R
 Megw==
X-Gm-Message-State: APjAAAXYuqgBYHAFO9ljqyRYAGFIPlVESfOvB/KzSVb9dZeJVIsZdgof
 CmUw4L8n4gzOygPm+80KR+s6vvxuqk8=
X-Google-Smtp-Source: APXvYqyxMJRAv7gvn6ulyZ9dSw9X0fnfa5GDwafiesVR8+yK5vVkCjeyEukBaDuK8RmbDgMSgRbhFg==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr83167883wrl.117.1577977775944; 
 Thu, 02 Jan 2020 07:09:35 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b16sm57873139wrj.23.2020.01.02.07.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2020 07:09:35 -0800 (PST)
Date: Thu, 2 Jan 2020 15:09:33 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: GraphViz extension on QEMU Wiki
Message-ID: <20200102150933.GP121208@stefanha-x1.localdomain>
References: <b4291830-5edd-5f7e-6170-63e43b6e629d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="r/w8vo2lxBmCPGjQ"
Content-Disposition: inline
In-Reply-To: <b4291830-5edd-5f7e-6170-63e43b6e629d@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Jeff Cody <codyprime@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--r/w8vo2lxBmCPGjQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2019 at 07:05:04PM +0100, Philippe Mathieu-Daud=E9 wrote:
> I'm not sure who is responsible of this...

Jeff maintains the web server and wiki.

I can look into things when Jeff is too busy, but lets see if he has
time in January.

Stefan

--r/w8vo2lxBmCPGjQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4OB60ACgkQnKSrs4Gr
c8jWBggAuWuMxL5mGBR37IRZKqL/NoZfxrLMyMrqwuFCFy9rsosWo9Je9vxsVV9U
pAlBllAs1FpZeSmAIqObX1js2B8XEgc6oV3yYF3BvvupVMPHLdJW9zXVyTTzF8tq
G6YMoktwUqzTMimJUtmmPewOIl0/xuIC1kCyb7Njob28KzkWzLj88gbl/a258pXY
e6+l7/d+rW+OWN13DsxxCOoxt2VIhZp6rZ9Ppt/qKKoF23VPn+imUNnpT7ZjCDaV
ttwd/smEUcVl1ooyMmUwxvt4eSD3WmPvNYdNEXrdih3JqODOm4dAkLTf2wdH/yK2
RxSmbpp0m5pFLznVzM5npuXmUAmFzA==
=rkf3
-----END PGP SIGNATURE-----

--r/w8vo2lxBmCPGjQ--

