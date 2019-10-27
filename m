Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E196CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 14:45:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9F421D81
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 14:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5RAyrEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9F421D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOjnQ-00028s-0B
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 10:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iOjlc-0000wR-Cz
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 10:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iOjlb-00024B-Ee
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 10:43:40 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iOjlb-00023G-7A; Sun, 27 Oct 2019 10:43:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id z11so7198055wro.11;
 Sun, 27 Oct 2019 07:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=z6uoEPgaioym69uv7SWEmxCc8ps7fEed0Agj5iIOTok=;
 b=o5RAyrEXyHEV97DD3d9C2ifk+oUqrGbic2H1GLV91JXyUsqiHfPs5jVhHl/EZu+JfE
 +QMJWDNuDYBzrYxTkRRPsycLPlos+SK8Ghze3DHfuSn+9ALnZt8SEcRRs9qlYz8DIqLI
 /GKZIL0cM2oQOe++wy0V/wVWYXVKXZbYfzlS8BGSRZW0tn8IWQ0D3klt2jfX24SdhCK7
 4ee9c7JAm4tHH0b9ortidfEHPD0Mr9N7xvSaSoEBBsEcqlVdMk6dKl1/ZqIWzPbn9JB2
 6Gkr/0+vbzoH50Z0+zd4FciQzaFPrl64ZHMdynpsROduFXH72kqEEOw3iv5pkqyezROG
 Re6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=z6uoEPgaioym69uv7SWEmxCc8ps7fEed0Agj5iIOTok=;
 b=BuBXLe4R0wWC2qs/5IkhsajyTutM7d6I90Gxa/XDI6bau3kXx3ak4jv3T81x5hLXDY
 4wbQ7ll3Zh6Qup0mkKYlCv+Q1fG6ihJbVFhWbcp/DdnvHaWIvn6YyOHD5lJs+DRmGoR5
 UBqJ0dOvfUKKJWmD82bJyQONhbmFFgLbB5K08LuJAbq0qb+kFIenwZI/1lnQjgbl/4FU
 eF+6CO8jDB4Y1QcwBRGmIuJrGBCLCwfkt15xQiyGWJcO4A+qBY8rWv33pwdm1FDr+HWh
 MF1urBv+qIg39pXXQw2Bauz0Cg90hX2sMojyGncci1rWbhSpnzZys7Ch2ichGXRQWd+T
 OHpQ==
X-Gm-Message-State: APjAAAV/OW3bTkyaUptb1CrSdjcUH8Sud3+faJesac+RFmH05y/eIlm2
 6BZOIh5CWFK/8+J0sA9DSdU=
X-Google-Smtp-Source: APXvYqxkL9KmxDrGrMyfbxyr0bmGRd6n8OgjFWfT/j0i+ydImWykqFBBFiDx6ZfhG2uMHExiv2mgiQ==
X-Received: by 2002:adf:db0e:: with SMTP id s14mr11960758wri.341.1572187416686; 
 Sun, 27 Oct 2019 07:43:36 -0700 (PDT)
Received: from localhost (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id 74sm9875357wrm.92.2019.10.27.07.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2019 07:43:35 -0700 (PDT)
Date: Sun, 27 Oct 2019 09:30:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Han Han <hhan@redhat.com>
Subject: Re: [PATCH v2] qemu-img.texi: Describe data_file and data_file_raw
Message-ID: <20191027083038.GE4472@stefanha-x1.localdomain>
References: <20191021011421.24748-1-hhan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Content-Disposition: inline
In-Reply-To: <20191021011421.24748-1-hhan@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 09:14:21AM +0800, Han Han wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1763105
>=20
> Signed-off-by: Han Han <hhan@redhat.com>
> ---
>  qemu-img.texi | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl21Va4ACgkQnKSrs4Gr
c8iSPQf8D4VWhxSEFhQTJ+R/7SQsMv3SEpoZLQMF81eQCTAc85gvVOIDw6x44/cH
+7/jU4xMMqFi9W/GEjuLZMHwKyLQLp7ohx/YT92a4DUFa4ADLPNXf8tYQxL8wOyW
l4iau33jWtC3MchRg9iJgfONYlgjdnhnsvb5U9KQksvlwTtZph/TxorCunuE9+Bn
73DG6kBMfkySeDiCVbnCLzeMvfcJWisTzkvOX2PTn5zveDrAd8pw4IpAfIXRC/DB
rHMFJjYrkW25NoH0d3BIYubkQfGqdhscVjqVDzkg/iJ8mmBnLkqJXSOrVVpXjvdd
rsBwGbX3keTPuF24wgZr6aplGnXqug==
=Eb9D
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--

