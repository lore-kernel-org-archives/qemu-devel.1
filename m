Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5428C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A502082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOAiXqCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A502082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIfo-0002Ye-OW
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1izIfA-00029h-Hx
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1izIf9-0003Gj-93
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:16:08 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:52293)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1izIf8-0003GE-Vu
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:16:07 -0500
Received: by mail-wm1-x329.google.com with SMTP id p9so2026438wmc.2
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 03:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TsjkVIE55b4/FN35k7YjC7lFTodw1t6xrGOJ744UyRs=;
 b=WOAiXqCNrpOwXlJVMSAGU8ucc0ja1I8vrMWwkeFcp5iBC2yTwAaQA5l7KT2RSRbP8+
 0tzwbKI4SLN1FPfiA62zZ3Cz4seB8h1/NI4V6oDBb/nqKNz4BGqhlc8R7jKb2pLj+xcr
 Bgewypj4S14YQfg4h9zsB98k8dQQlIYQWegIHweukcxFuvVEcZUiVRrMe6PrlFJdVQT4
 uQN6TBtmKA2lPwSAvQe3tu1EkRthRG88mFyf+glLdpCIdyiWs8t1LqXI+V8+z3DETVWY
 vYa2vwc3TSeaVLAQd79jbOJtl4dnY+HurIF4YKmO3PriRwZqlPXVb1bTsoz7C6GmTjtG
 cp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TsjkVIE55b4/FN35k7YjC7lFTodw1t6xrGOJ744UyRs=;
 b=mZ+XbncbQj0Tb7xpej0unZZRZCXbFcH/HGRuCPCuWakEPCI/ZAEX0EWlJO5n6KjpOh
 64hldMVez9RjgSVbWMPMwNx3LWV+EPXJJF+zjx6W/PCve1M9wj9Zn1H6AzYW7NdsMkIK
 1mrnyJzqaDpJxqky+8pS7eRgfEU6wqc6mb/YHy0rH8IsLoKBduj0COrzxnWhfbf/Fpyd
 qni+Lp+fxYyzg1kkErSgh6LDEtPRBBdPjjhFJbDwVDhGy5CoObKQrLQnNI6sN0EUXJcA
 7DWnqGSdCHsuULPg+VhZ5xbBVaD+HdzWqiO1hNK6kettQVqm7pSAC0tFOIQZqIByz7DW
 Ssgw==
X-Gm-Message-State: APjAAAXbR3LJ19NDFvMfZGsF+znKReI7zcRad3mHS8lBrG7rxt3oXrkt
 4gmiDZgjIQsHfO6zyNy7xy4=
X-Google-Smtp-Source: APXvYqyDrKzukea/tA5cshpUZNo4UuQyb0V0d/Sff0XDngO2uzJeJhgBd/hmhtdu+cHih7X/2WDFsw==
X-Received: by 2002:a1c:a584:: with SMTP id o126mr4946117wme.163.1580901365565; 
 Wed, 05 Feb 2020 03:16:05 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id g7sm33979504wrq.21.2020.02.05.03.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 03:16:04 -0800 (PST)
Date: Wed, 5 Feb 2020 11:16:03 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [GSoC/Outreachy QEMU proposal] Extend support for ioctls in QEMU
 linux-user mode
Message-ID: <20200205111603.GD58062@stefanha-x1.localdomain>
References: <CAL1e-=j5WJkV=X+KkfBuS3pjf6z3aJrtu4xpYeVbjEUYiWxxTQ@mail.gmail.com>
 <CAFEAcA8E9s2wZWVxanUDXu=5qcjn6XY5_6t8vUO+LjuJnA7nOQ@mail.gmail.com>
 <CAL1e-=j=nVJd9Q3JmZsimgSPy=noYhqE8hz4r5RjwgTPw9WwuA@mail.gmail.com>
 <CAFEAcA_FbFub4_z+e0YPMT8UTbm1SWmfovkKnLKODvMZMfGa+A@mail.gmail.com>
 <CAL1e-=jMnEpOw+fOqGfY2+uiUTYr0zgnMZxpVUK2Y=PA3YAFMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Content-Disposition: inline
In-Reply-To: <CAL1e-=jMnEpOw+fOqGfY2+uiUTYr0zgnMZxpVUK2Y=PA3YAFMQ@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 28, 2020 at 09:48:33PM +0100, Aleksandar Markovic wrote:
> How about this:

Thank you!  I have posted the idea here:

https://wiki.qemu.org/Google_Summer_of_Code_2020#Extend_linux-user_syscalls_and_ioctls

Stefan

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl46o/MACgkQnKSrs4Gr
c8g+xwf/Tjn5M0u05nrHajpRUqj4gJ5kBw04ll0VrK/bD3u+OXSbHRR7T8UdkCqA
EavTIC3sOueXkzLH0BDpKmHTyGvTM2+aFoim4X0pRhzKbS0WMoNfMcsg6oIejLVq
zwNRTPm/3RRP8M2XAJ5dKgzHpHJWeA9crDIM0DHtPfaR3/g+KBitdH5WopfGAkIz
2MiXclm8h+iwkorxoBf3h9/t7Yw/o9o60ywUtiq2d/lM+9ZqSoEQdU6+vEjQwHyx
+zUKiMTqYIs/owwTVgJu/4LvvAYfxFh1ge3oR3qB0lpIIwh5trnpEz4WNKbxnMcg
75Um/gfw6U/zxOPEU2SNxpba9mgwWg==
=jaZP
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--

