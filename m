Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8310C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83169208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkYKcrsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83169208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1S3u-0007Yr-QT
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 06:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k1S2r-00074v-RD
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 06:13:45 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k1S2q-0000ZO-1R
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 06:13:45 -0400
Received: by mail-wm1-x343.google.com with SMTP id p14so8117047wmg.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1gkrmFg0o+12Y03vP1FnEKruTlzpJFIVm0HRG9MN2V8=;
 b=YkYKcrsBgLHYHGVJ43tmH16sSa2eAcMwTqPvmgVUKZzZB5dhDmTk83CkjSRyQnQvcx
 Al2f0EH+vIgUebabdG+VWknE8juifG3ejKDWR4Epk6WCdOrC/0Zo9+s81GSoqWZEI5tp
 oX13iLnAVzlipY1QnjYaYN9CVv+nthWS4NGyePT3/VAQT+oc3ZZSMee5+UggjjSo+RYr
 Azr1FqAYGMmAXP4pG9Su7zlrIFywofbnEti+m/SUdDoe88yr4rIOAWmikPAUYJvEoY5m
 0Ac+izV0ZYJGccBUIwTMewf6ocpj+VRdEtIl70kNNwhdpZ0qENIEAOGXb+lsgiYGtwAP
 kDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1gkrmFg0o+12Y03vP1FnEKruTlzpJFIVm0HRG9MN2V8=;
 b=PqH5sRRFOfJD2DvEMc9XzY7Wg/L7aMh7QHIULnvg0w8ZUoI0XqxxibUjvzkbuSTNVm
 4JKQENG7IiVTHo/1T3T4mzflxvUbspJQ9ukov+X360XYjEBNMQxR9Yv6izVLxRmGgo1Q
 juFEgwef+EW4U/z8i/cKW+l2vSVxEo1IZOYf5LmrdNPpxHFZw12ojOjJr90k1Ns0zfZF
 4lt+H+p3ZF3TBDknnhvkH77WO3IKHjxpfUaePbsJ/xzoJXyiI5P6o/YZXn2ZOTPgU7cP
 D6i85p9lvjHTk+jQFnEQIWD1ayOqb6cLzSgGAEF5S6q/bAyC3ZqXNQSg5uI4gUW8L9/N
 elgQ==
X-Gm-Message-State: AOAM531swUQpQsKXy7VE0q9R6w24mjLbW8b7lP2Tm1s/JGmRjzJIpLAP
 Lcb0GyZdiQ/4kS+H8RRGSHA=
X-Google-Smtp-Source: ABdhPJzZQKhZcWRLSBVwjBQI1G/y9nmNWX7hTZyyq6+hn+3T4WwMdqQtnsQpU0bSz6ga+mjkhHbswA==
X-Received: by 2002:a7b:c008:: with SMTP id c8mr1518117wmb.59.1596190421325;
 Fri, 31 Jul 2020 03:13:41 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p15sm12632865wrj.61.2020.07.31.03.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2020 03:13:40 -0700 (PDT)
Date: Fri, 31 Jul 2020 11:13:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Pincus, Josh" <Josh.Pincus@windriver.com>
Subject: Re: [PATCH v2 0/5] virtio mmio specification enhancement
Message-ID: <20200731101338.GA177875@stefanha-x1.localdomain>
References: <DM6PR11MB4331B490586462DE7353E0B8F9710@DM6PR11MB4331.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4331B490586462DE7353E0B8F9710@DM6PR11MB4331.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "zhabin@linux.alibaba.com" <zhabin@linux.alibaba.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2020 at 08:15:12PM +0000, Pincus, Josh wrote:
> We were looking into a similar enhancement for the Virt I/O MMIO transpor=
t and came across this project.
> This enhancement would be perfect for us.
>=20
> Has there been any progress since Feb, 2020?  It looks like the effort mi=
ght have stalled?

CCing Alex Bennee. I think he recently asked the same question.

Stefan

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8j7tIACgkQnKSrs4Gr
c8hBuAf+OmPRYxvZokWgMkN08xj8gRvvsYKyjcYDdgX/rT2XKHyUAwL1nadrkyW+
OEx3K+jwC9f6Z2ICwRg08ccNCKct3Si4abzvk8Ky3HMFFh5k0Bt2RnUdTeJ3dws0
X1Vkd+RMaLdGv8Jdm4KoGDpCx1lXtjY+cVtzMt3bC2g0QUwXrs91wMTbS3RSbP1A
lBfgkUwrr3p4ZoDQooCINljLPfAGFmgQLuWOQHopMss4e+IKKkC5otjNPVgZanUs
Fvu/P+6lt3nSpsKNqCJBqsBNEqo7JbvwsMUd8dDrn47Xrwyjl6kDMITpRgr5gQAw
xJTdNfpW9eouJ0XSbZNU1nZZQu0XMw==
=KbmI
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

