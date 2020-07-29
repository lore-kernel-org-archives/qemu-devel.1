Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6F2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:32:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35ABE2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWGo/3Dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35ABE2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0jO1-0005pT-Fb
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 06:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0jNB-00056n-EO; Wed, 29 Jul 2020 06:31:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0jN9-0002qJ-Bh; Wed, 29 Jul 2020 06:31:45 -0400
Received: by mail-wr1-x442.google.com with SMTP id b6so21114367wrs.11;
 Wed, 29 Jul 2020 03:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=a3m8BCuEi4AsopKJRQJco/GkRE9YjHTQXQr6wg8nJRI=;
 b=jWGo/3DgAuRtB2yIuf9fSom6Mj9MYgTcbYlR5cOYZoEXHyR3U/2VD6nmryBia/xSV0
 IFV6nWTWZt0oT8o6zdyhtPzWqA005olUuBGQIrdzSs6XtVmfpW72r/OvnnSydnrO09hs
 +qYnoGMFe9cC6zjKtaiB51q7c6gUCAvY9MFDOI+L6XQjaJB7Dv9FKB+VcHawHKdw74Nf
 /sg933yBz91RuQkNzULlpdO1k+TjTbAyt2rpwUCku+Qt4Jg8D8K05zYsGypAqT7xB6Go
 oBIoJaP8roqRIAqOEhQryVEhiZMj95vGWbu06RsUqfyRDewrw34w8Zbw+NSDiqgvCk+j
 OTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a3m8BCuEi4AsopKJRQJco/GkRE9YjHTQXQr6wg8nJRI=;
 b=R31wCxFCDs+FpWf4nsGkpfgPCNEqM/MRNMrsyDVBoV8dmSdnP9LaCrQwetKM54uwt+
 tAtP0CJZ40xRWp2QdJEAspjsJOZ5rsrkOSohYC1C6LLLnQFqC6Muoxk5v5E+alAbKzoI
 IsUBaVnDJGua/5dj0iYlRBKFC/W2ddWg7GLp5RBo/pQBvQGqFmeRZC9T31OrbmH9rKaJ
 7LSsjwSi8tLz0B9xx6bAcBTEVPr6o67ydNgO0idOQNO8J30vtzNlRPBtztGrrWKZI0s1
 hGEuOS2acy7rdciq2oBjAB6aMnPeU/dNq1deNqiWGHJmSpF9W0lA9aj86W05bR9/+LNj
 NM1A==
X-Gm-Message-State: AOAM531lIw78C0YF/yM2KVZZIP0DI+Mk0YIoAIOlBt6DZPCawcWCose2
 4Rma9JwnT5JqmOO03jAgkEs=
X-Google-Smtp-Source: ABdhPJwS2AyTexZlA5n6EemIiSsP0XQgnlfd83Ng8yNSdaDfw8Q5dmrJx3lLkzPfmzv1mrcWfaxNZw==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr26104603wrv.280.1596018701577; 
 Wed, 29 Jul 2020 03:31:41 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 62sm4761125wrq.31.2020.07.29.03.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 03:31:40 -0700 (PDT)
Date: Wed, 29 Jul 2020 11:31:39 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PATCH 0/2] block: add logging facility for long standing IO
 requests
Message-ID: <20200729103139.GC37763@stefanha-x1.localdomain>
References: <20200710172711.8059-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <20200710172711.8059-1-den@openvz.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 08:27:09PM +0300, Denis V. Lunev wrote:
> There are severe delays with IO requests processing if QEMU is running in
> virtual machine or over software defined storage. Such delays potentially
> results in unpredictable guest behavior. For example, guests over IDE or
> SATA drive could remount filesystem read-only if write is performed
> longer than 10 seconds.
>=20
> Such reports are very complex to process. Some good starting point for th=
is
> seems quite reasonable. This patch provides one. It adds logging of such
> potentially dangerous long IO operations.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>

This looks useful. It is indeed hard to diagnose soft lockups, I/O
timeouts, etc inside the guest :). QEMU should print more info. Thanks
for doing this!

Stefan

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8hUAsACgkQnKSrs4Gr
c8jFfgf/cb1toqVLFa+IhfpafG25Pj2oBXaLE0MkhC40adUSuRL5g1bJRG/Sz424
VkdHzrR0/8cmzKdo/EC5jvvyLbHS3O9Tfy5qXCpM5e5h4YyEOls4zTd3cfaZwIBK
yZ7jX7gyF2woqas2W+gE0crmxq0gHF+4IwFwwxe3DDFtreV0e/pQvzl4qmuGOZ3+
0EsjqgQf1k+M7f51WWNKjstwEOb/bv5WexhbdRuf7uQXarQMXvl/KmMMUlYJU0Vj
cL3pMMhPUlxp++hNji6FTyWw1whTxphptE70oQFuamK8VhgGGYFBgivp7EeOknV0
cFrjvskZU3vumi1we4/XGv6SBtVEDg==
=UjMm
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--

