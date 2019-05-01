Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A2FC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 16:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152922064A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 16:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evVhyxA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152922064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36461 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLsGr-0004Na-C0
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 12:39:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLsFc-0003eJ-Cs
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLsFV-0008JW-TB
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:38:29 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:39671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hLsFT-0008Be-UM
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:38:25 -0400
Received: by mail-it1-x143.google.com with SMTP id t200so10641106itf.4
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=GyRCAHqg0DGgczTHoAx3sY9N6hvb3II3EihBLe5LnoM=;
	b=evVhyxA368sdX3GrlpQ/h+3mgf9KJK0bqDe2gTsb/wfxGzzZ91HswupDzgrvBWno8i
	jXPAzNLjXpHI+XAjC8amlcGv5Y18POxFea22bYb8npOPdswTJ7gpcSl9PMVJ70kI1PNv
	PvR40/z6Es/8OEKnYbjBoonVmE+eZXkTg5GpCXgo9UpfPcIWy44loU8SIRGb0DuCMyWK
	WL6yr/D57AeiosUI5wOy/8J15M1HNt9Qlxt7Ks/m0GiuSfQ77VpTRQwQ4lsvD32CMgkt
	4Ya/b2vAaaqbiNZzoTHKoxaIdaasg6dGmNQNQXYjpKsdhWNPqjtc2J3W6gmvjx61ENbC
	7p7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=GyRCAHqg0DGgczTHoAx3sY9N6hvb3II3EihBLe5LnoM=;
	b=JOSE8R4Do1bzM5ocmrC0rmQER4J26TfNNqvL4a8ze7G1+aG35PM2/8UYq4UJC3+oEK
	WVXXJ2EMFD52GzuLWkV+j6Hkj43UnPI3fjxtIexjtFjBONgULZsC3C5ZZXGfvekX4Y/5
	bz98uVmVAGV8YmAzWKdXXrbIxMKypO3qnNKBxCARahzbVBy+9KoLOGoA6omr+lPUaSUa
	XFr37gwKsvpyeDWUuRTj4xGkj+PMNXLXmUeyGxrfQW1hB4FkfrMKKvk1PnJdMIt+WBp8
	jQKw3F/6mptb5S9W2LAYQof3KGtLb3b4bTIMzkozM/Wtqw4szYK8bzhttYlCEHC1dyJ7
	KQRQ==
X-Gm-Message-State: APjAAAXmr0Ln+oj5XIcbBidCU77zaUv3PETDr7/egdXGFJGz/2dVvCv2
	lYvF42Ru+mSZWoQ8Ir6++7I=
X-Google-Smtp-Source: APXvYqxU/9aDTiIGKRpKn48cOmo/9TeLuJyM6MIM1Yg6xrSsRoIizTAPRl61yh/uc7KYniyM9dcuIA==
X-Received: by 2002:a24:4ace:: with SMTP id k197mr9115381itb.46.1556728703060; 
	Wed, 01 May 2019 09:38:23 -0700 (PDT)
Received: from localhost
	(CPE64777d5479c3-CM64777d5479c0.cpe.net.cable.rogers.com.
	[99.228.64.175])
	by smtp.gmail.com with ESMTPSA id y18sm2566181ita.3.2019.05.01.09.38.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 09:38:22 -0700 (PDT)
Date: Wed, 1 May 2019 12:38:18 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jie Wang <wangjie88@huawei.com>
Message-ID: <20190501163818.GG21155@stefanha-x1.localdomain>
References: <1556604614-32081-1-git-send-email-wangjie88@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zrag5V6pnZGjLKiw"
Content-Disposition: inline
In-Reply-To: <1556604614-32081-1-git-send-email-wangjie88@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: Re: [Qemu-devel] [PATCH] vhost: remove the dead code
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mst@redhat.com, qemu-devel@nongnu.org, wu.wubin@huawei.com,
	eric.fangyi@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501163818.deTwMXY_H1fa1e0esJpyxdZyqP9re8N9cPafKARm20Q@z>


--Zrag5V6pnZGjLKiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2019 at 02:10:14PM +0800, Jie Wang wrote:
> remove the dead code
>=20
> Signed-off-by: Jie Wang <wangjie88@huawei.com>
> ---
>  hw/virtio/vhost.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Zrag5V6pnZGjLKiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzJy3oACgkQnKSrs4Gr
c8hBFQf/e/Fr6WTm/gXOwl2i6yZWMUavOzlvbsWS7sWINHRnV5O/nxz2mgNq9fLi
EQWHxO/1Mo2AKo8N0A/XwJgsqVw7B3xn9FA7NRKdhTZLXbNDPLRjL90rGYFLTDoQ
cPWUx/2eA68zw+2pHs43X/TU/lWkFvO/B36tgFSYTJqiTotr/FK9GnE4GDt04XJ3
hQ5dNj1qH7vTZoBCetXVpg/I5xXXxznC16P566F5zKfM+nuVfqVT3+PMsXcxunea
c2WK1ZVzzMZch+xKbGmDcSqm9Nxq8vZEP86BgHy9sr34QWguqrlVV2pzLFs2+3js
CpDHT+lBJ0x/+RX5vYzS0CeFFPqj1A==
=UKPw
-----END PGP SIGNATURE-----

--Zrag5V6pnZGjLKiw--

