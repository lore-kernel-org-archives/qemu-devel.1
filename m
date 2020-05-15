Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1271DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB62D2065C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ZglycMKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB62D2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZUZf-0002nT-Om
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 03:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZUWZ-0001uw-Qf
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:12:51 -0400
Received: from mout.web.de ([212.227.15.3]:49799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZUWX-0006vq-Di
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589526737;
 bh=Jt/Hh60T+VAAF9RWmzxGb/Izhgtcinj9RJ8Jh4YL/PA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ZglycMKUDCKcHnLjn70K0PyhOs8QU/TBqwm1JrAJwnkjQoyTylx1sykoYWq9NkLhx
 K9PwPRM4f4nOjr8q6Ll1goe4O+A7p2xrMPMdw/9gPjWQFigp5dKNJhTGM8lUu3Ji59
 L93LXo75FtS1cL+o5rovakFT3MZlJJwbzFmxdWyY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.164]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lnmpz-1isUOM2H1j-00hssC; Fri, 15
 May 2020 09:12:17 +0200
Date: Fri, 15 May 2020 09:12:08 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: About migration/colo issue
Message-ID: <20200515091208.40817d99@luklap>
In-Reply-To: <7a26ed7efed94d2dbff591521d31076a@intel.com>
References: <7a26ed7efed94d2dbff591521d31076a@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nWtBU=aJAqbYdpefLvjVjLf";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:rbz3MYVDFhHWUmPIAVsPAd+hiukeoYSeJxLork2VEhTxKyGHZSN
 sUHJzEjWuhHI+TKKF7SOTU+j6/zWllXbyM5oOcWRJYjaitl90u6ADhAaWEOacJgR9BtU6pp
 WIwMX0TMN2pc1kgXGydmQmQ1e3UoxyYJVT7s8a/kHgcrC8YLni3LsbxOW0uwMPUL+Aw/9IC
 3eOpyMnTddLyeWpO+XpzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SO1TpSJCcAE=:kLYoU26iWUYKEZR6tjwynb
 eKvqP54v7dcWF09XSNHVLEk9c9MkCJ5T5M8fnspWOUBjKFPxyppq494hkLSGU99oxMO4jz5lq
 K8CT1IzvBjWfZESPvhnHp0GlRg8FjCTVP8r7JogHWxq2CfAxu7xBxLitfNgrbPBD4sZIsZ25O
 fVdoigIEHX0/QOUzKyUFac+9AORFM08Ia6KhlB3bjPh+v0Xhul3vPPCWE/JO39Ae/+7q6RON6
 73mMdnKYEds2pzYxW4fY8WbnuRUsWXHqHLzRNzKGaXbR+E/mrzrJkfeZvfbcq77NM7M2r1baZ
 dc0bNnG2Pbp8fSoCR2MC3NnbhI3KzsezItLiBNnwXtL0CKErId2FLai7d6OSIpoT36m2x2pB/
 0FI3pQzUvudXw1S4FkHVEO7dv5K7uAqOnSmefycvk+IqRAcP9dHlMBCfIy3X6MQ/CUYmMLEHc
 GtB3uFiOmZ50k/NIJXQoxIhBc3T5olCk0PooT0s+Uo23oPijVPE0w3oYiz2vbNzqsCGxxqc6F
 3k+842tvkOhGMwD5fIm3upDVDxF8Um7+gOoFJoHIaCW6TzFyul2Z83+GcqUYjOe8vmQLmONEX
 EDH15R1HRMUWo/E7jRq3+/4XGwuhOr+20b9bI/7m7lC+L31QzwdXw7aIcfRehoyVm5HfbcgbW
 oVxQgjipbGUXHOZi/zvAlig5nd10dO9qi0i1rxPUi3w4UTgy5h2D14xuHiFEHqI9ZMvSD90yF
 5OwU4pC1j9Pa86oJ1dGLhK9aN5MtLPgISU68qGxPwtWa/j3MvKVASde3r4384cmqvJMJD7lWJ
 Bo4Kyxjb03dor0OvgdgSi5aIHLLkVNfmWyJXmBnO6f/+40sEwP+GaLDMlGVyiqNOobg9UkWC9
 F/MfVzBEw2/e9CPhXE6Ufu0X2mUrK+KLrU0+ld2PCPzMr2gc3j8xuLy79+NGkO+C9QTbcgV+R
 RlymL/BXH8y/QYwAWefwnx2thHIVrWf2ZYvQak8EpgtLyIUosFtmZQtD9yK5BwpK052tulsf+
 V2lbG8FWxY4CwI8eXUiwBi2cwNKhjpooVUEjH5edeU+5S+eJFR3+IpWXsRSg4AAJSGzGYi8ss
 9dEd2NhNHBikth85xGMvc8cRnG6Qjjv/hJdcEmezgKFJJ4L2LanIotkiD0AXtm1rZmzUrCfN7
 ojkjVe/aDZKM661zvDXFH5TPzBfg7qv+LxU4vQ8eMwLDjAXM6azDsBZ+hm8RLyJOgAwV7hWQW
 Ruzh/bhYvYhzWAFmr
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 03:12:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/nWtBU=aJAqbYdpefLvjVjLf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2020 03:16:18 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> Hi Hailiang/Dave.
>=20
> I found a urgent problem in current upstream code, COLO will stuck on sec=
ondary checkpoint and later.
> The guest will stuck by this issue.
> I have bisect upstream code, this issue caused by Hailiang's optimize pat=
ch:

Hmm, I'm on v5.0.0 (where that commit is in) and I don't have this issue in=
 my testing.

Regards,
Lukas Straub

> From 0393031a16735835a441b6d6e0495a1bd14adb90 Mon Sep 17 00:00:00 2001
> From: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Date: Mon, 24 Feb 2020 14:54:10 +0800
> Subject: [PATCH] COLO: Optimize memory back-up process
>=20
> This patch will reduce the downtime of VM for the initial process,
> Previously, we copied all these memory in preparing stage of COLO
> while we need to stop VM, which is a time-consuming process.
> Here we optimize it by a trick, back-up every page while in migration
> process while COLO is enabled, though it affects the speed of the
> migration, but it obviously reduce the downtime of back-up all SVM'S
> memory in COLO preparing stage.
>=20
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Message-Id: <20200224065414.36524-5-zhang.zhanghailiang@huawei.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>   minor typo fixes
>=20
> Hailiang, do you have time to look into it?
>=20
> ...

--Sig_/nWtBU=aJAqbYdpefLvjVjLf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6+QMgACgkQNasLKJxd
slgrkw//ZonsKWA960c7NkDtfKFKVnT4+x02E8H4AKJF3MLDVh7xPx/j8iukVMTd
4ZgjR1Voe+vigjcHYW37WdNddcAsorxDFnVnq6w0uf0WflL04G5I7/p5LEJcXJOj
eKyebFoL33tLBGL6+jM7bDSc1nmt4adyQBbOwhaE71yA5lxlXOVJh3Anj3i/V1sa
qtW8E/Ew3PjEGmF8AZzCFsptJcyXgddHEwOaT+HOBzyvkMJxsJHH3R8Xf2ltWup9
G67lYg7U18dp3lkcebU/8txnS+51WUyc+Qg1snhWu94EmVfZSg2nfTzWxnT22Qcl
Hd4w7or3FbVeFjAlUyraAShQYNRLlBwRPfdAYTHoPXwhjIqalGaGEG64dX89GHPr
6mTHei+0xnBm1NB7ujMdeTG/qLAqohsvoiSeqJJ3qJdrh3FcL0zx/29ADO35S9M1
RD3y8+pZ22U+o6xnpCjvbLBUxV7McEDExRLNQaj+wngsipp+bLFQrS3qUUdE931g
oUf1q0kBpGQVMIYmoesObWlV6LfXlv+w4O9wCdGF4Ncvp1QScu2cuknKUm3w+gnt
1oACYPd2l5V5AQnohMKx4AYl0Tsvy9j37x36SLx1qJ8+ljOE9mIFr9w1R7Vsqvio
c0YFe1BvzJGyYvFIFaZkgNN83BeleOzqlYpoeDFaaShz8c8AWi0=
=atUk
-----END PGP SIGNATURE-----

--Sig_/nWtBU=aJAqbYdpefLvjVjLf--

