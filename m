Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5F9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49449217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFBks/3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49449217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYIn-0005Yi-7x
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:45:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1itYCs-0005vx-6M
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:39:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1itYCr-0000cc-8X
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:39:10 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:44294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1itYCr-0000bL-1r
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:39:09 -0500
Received: by mail-wr1-x434.google.com with SMTP id q10so29828979wrm.11
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 06:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=29lIhgwefgZh29oZkUv7IA27hzI9002Q0phHV/evwM8=;
 b=GFBks/3N8YrtxNTwQZfSZdBAle3A4yhRVqCzHhuqZsUVbsXOYxxUvewQ6NODsifMe3
 y/YwVkE8o8UCBIpO/0tgjAqzMuAMsyPSB9qDADxIWSbMKH22lL2oe39bvjAUOoyU1vLO
 KdU5INWVgXn3sIuf3ononkB/R28cwJjjev5ANgIT3SPoAwahMXqRvqvy+3RSg8CDjfO1
 7AM5z2ScPR8VRjIIF8pvD8q9Zq++hJSuxzyXxZtazzyGXZyqOUquh/qCTUn3tZbAfRQl
 aeP0hfiQNDk8gzV0dKGTk2icQl6Nnc1SBdWG9K06yCwC5tjTRwgFkBNlF4M6/JH1WZqb
 5X+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=29lIhgwefgZh29oZkUv7IA27hzI9002Q0phHV/evwM8=;
 b=iwJa9VYlrXusNq6K1Ko1Ucko0Ud3uAK0WDSnCzF+AuT2LKs4PVNmXsVBoA5MgeQROm
 0zlP+mBbBZSgQUUJQw4Q9272k/KXo2ZzIky9+vLiyxhKtIux2mj/BXFMXCQ2HfgS0oSg
 07b0zpP8KloisTRRzav+ERZ7hSSSU5YPeCQA/SNWObRfXtVJbC0pG8hhobC/WY9geSWX
 NNWNH2LWAZxyTg+J/71Sz+kYMHFM4tHT9Ed8zGzXy5m+yYTL9TV997jFOjflu9/f0lbP
 UslEYIkOU6DmsjWIDoXGFT0njC+egHPDBBSucWEpG5fcQRZy+C5b/Z7fURn425RBpsQ+
 jAsA==
X-Gm-Message-State: APjAAAW17423Gotui9EXaMJBjMT3/xvLk3jrp76IFPuTdjT659SdIyVe
 yBRDYWTsodQibEDn4ONxZRc=
X-Google-Smtp-Source: APXvYqx79QDCPfP9d6UpapUeSH3eWzJs5xRMbOY5Gr9cOBrzdExgG+Kx2Kog92unWwpaqyufFPksrA==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr18419271wrp.322.1579531144520; 
 Mon, 20 Jan 2020 06:39:04 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u18sm47638957wrt.26.2020.01.20.06.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 06:39:03 -0800 (PST)
Date: Mon, 20 Jan 2020 14:39:02 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Proposal for handling .hx files with Sphinx
Message-ID: <20200120143902.GI345995@stefanha-x1.localdomain>
References: <CAFEAcA-_Y0Qaw-S83tMAph21opaDx-2y6aPbv5J_J0Bo4bgJuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MFZs98Tklfu0WsCO"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-_Y0Qaw-S83tMAph21opaDx-2y6aPbv5J_J0Bo4bgJuA@mail.gmail.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MFZs98Tklfu0WsCO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 17, 2020 at 05:30:43PM +0000, Peter Maydell wrote:
> So I think my current view is that we should do the very
> simple "add SRST/ERST directives" to start with:
>  * scripts/hxtool needs to recognize them and just ignore
>    the text inside them
>  * write the hxtool sphinx extension (shouldn't be too hard)
>  * conversion of any particular .hx file then involves
>    replacing the STEXI ...texi stuff... ETEXI sections with
>    SRST ...rst stuff... ERST. There's no need for any
>    particular .hx file to support both texi and rst output
>    at the same time

Nice idea, I was wondering how we were going to deal with .hx files.

Stefan

--MFZs98Tklfu0WsCO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4lu4YACgkQnKSrs4Gr
c8iYZwf/ZpMEEghDs+TuUD1nDd4birZJS7yummRhvLvGVrzi3I7gJountgW9b41q
V33tbRmgeeGDL+LgKYC1Ewt4RYn1KbkL82FxtOe43evqyVbdoPCwWM586KlqhabN
hjxXcGK/vshpC7ulbtUVKI+Zh9GTw3/6IpfyMLqPDJNm0eVbspxjTSeAY2ugnZNP
GMuXyIm/Dory2yVaf7rWTHJg0xbE1KQCmtukgQma9U6dN7Gy5Cg491dTi+v26oET
tTR7OMLckLbP2JxRvbInK+0a+9nZj2xDBMLoKkvwPXUv5JzhAM+mRl5kDvmsyVYk
79uFL5D4SQn8INZq+d4lWBi2J/velw==
=JUKB
-----END PGP SIGNATURE-----

--MFZs98Tklfu0WsCO--

