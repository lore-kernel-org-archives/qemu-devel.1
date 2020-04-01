Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D09C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27B2206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlzQ8cgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27B2206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJehr-0006Oq-VW
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 10:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jJeh0-00059u-Dy
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jJegz-00064w-Ey
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:50:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1jJegz-00062I-8J; Wed, 01 Apr 2020 10:50:09 -0400
Received: by mail-wr1-x442.google.com with SMTP id a25so425195wrd.0;
 Wed, 01 Apr 2020 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=eh4NcuUmsiKRfPo7F2Dlbjv6kmgDOUc+e6T9ONg3ISI=;
 b=mlzQ8cgsEb9oAOQJVmn9oABkCC9GwUsI1tBoLWqrIG39ReSxT+kG3rqoYnmlDYEM/1
 pVpPkgsBbdoIiWMCEx9DLf0T1Z42EdifAVCgDZcuK4SqJxWYRDfMnI/ntPHtgupDS2xA
 kgI5ybn1L/fCyCM8pujZbJ5Tqlxzt1ZQvf+jHPtHttlpw5DUIvaYK1OOieYhIZBmSZKm
 yzHdfEVVTz2Iaa1sgxUB30EXRGQPTy5oq7s1Kgxrzl9QttIys3RevbG50az4uLE6+31e
 8uZYL5HCIVbquCIwhg3IAFT3HaLXq3VqK2yhS+w9hObMsnx54u+AiXkgIIrN0POW13K9
 cd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eh4NcuUmsiKRfPo7F2Dlbjv6kmgDOUc+e6T9ONg3ISI=;
 b=enfxNO9qZWNoj9DR6w5pQGIlzoIOk3/+aS13WSAiomwD7WN5sgTV0e9bCtFwx7ADZT
 didnc5u4tvpsYQnGEltnJZyA6Jld24QN25vh0CBeJNI6bLGuKOXGKWfljmo2WFg1eGvt
 dEVM7/ax241fS+zEr3/yndd+CNbeyK4dadyggW2vzk1o+VYQqfMjsuNVdLRMx2ZXidlk
 LM3FeOMcMSNdrFv3VM62AntCKgUcBjefpXg6ltEXms322a2cPIXkGcwig2M6xqedOSh0
 P28Bc4yaxpHWHEFgQoiWR/WNfcYg1ku5aXU5roz7+FVC5AzcekF12tX5PLqg6N01xv0E
 Et4g==
X-Gm-Message-State: ANhLgQ2ZB/K8jMNt5i7x8HGFizxE5DYQM8Qj8i1urowOIxEc7zxRaLeM
 xL679ab7HeqwW9w/eFCCqNw=
X-Google-Smtp-Source: ADFU+vubC1MQZ/BXZaaHf0sDzmSSrEuzOyWG+/Eniwcmmn9UowGkXOV5ShEuMqxyuz+HBjqUiuNPeA==
X-Received: by 2002:adf:e8c1:: with SMTP id k1mr25179459wrn.381.1585752608140; 
 Wed, 01 Apr 2020 07:50:08 -0700 (PDT)
Received: from localhost (114.9.90.146.dyn.plus.net. [146.90.9.114])
 by smtp.gmail.com with ESMTPSA id z3sm2818980wma.22.2020.04.01.07.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 07:50:07 -0700 (PDT)
Date: Wed, 1 Apr 2020 15:50:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>, kbusch@kernel.org,
 kwolf@redhat.com, mreitz@redhat.com
Subject: Re: [PATCH v4] block/nvme: introduce PMR support from NVMe 1.4 spec
Message-ID: <20200401145005.GA4122@stefanha-x1.localdomain>
References: <20200320215029.32727-1-andrzej.jakowski@linux.intel.com>
 <20200323132829.GJ261260@stefanha-x1.localdomain>
 <ce4e1dd3-1053-d487-0bc4-539174583b13@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <ce4e1dd3-1053-d487-0bc4-539174583b13@linux.intel.com>
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
Cc: haozhong.zhang@intel.com, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 dgilbert@redhat.com, yi.z.zhang@linux.intel.com, junyan.he@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2020 at 10:05:26AM -0700, Andrzej Jakowski wrote:
> On 3/23/20 6:28 AM, Stefan Hajnoczi wrote:
> > Excellent, thank you!
> >=20
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Awesome, thx! Not sure about process...
> Is this patch now staged for inclusion in QEMU?

Kevin or Max would normally merge it.

A review or ack from Keith Busch would be great, too.

Stefan

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6EqhQACgkQnKSrs4Gr
c8iVKwf+NxJnSyqkfe+tQ17OQXUm23Sb16WQ43nzf/vMqJEoANQSUOxNqVksIMKm
2oIy25XB9HBeHvC7nxsmUkICkvObSV+voMwO04Ri8ins6xBRR0nEfJ39EhVAxcGv
wX4DJIEf9dsd2QFU31vhvAxL5Eh8PP2efFGpsSZGBnWdathon9q7HDox5O9VR+Ip
GwjW09Y8YGG732QrjOBZWS6nHysSrERQCYhhzo3bFPS1hE7iEFdk4dzxrgOzR3dS
9z1+XQMPh8Y5jftAn5ILvsbodv6pIxER3NNrCKBXp1YiuKsz0y56j7mctMZNXPf8
lES49MCXxjEYdVXGP7J4aZJedLw52A==
=4B0F
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--

