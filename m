Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91C2C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C032173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJYUQuES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C032173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSOcz-0000B6-Lu
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSOcE-0007mr-S8
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:57:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSOcD-000721-V4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:57:06 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSOcD-00071h-Ou
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:57:05 -0500
Received: by mail-wm1-x342.google.com with SMTP id q130so4234291wme.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 08:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=cv++VM4MYiqOjOrBo2sj5uUnF958acH4427QgRn9C28=;
 b=FJYUQuESmC+MCwnEjbui4G0fq8dTHYWYAQGziHdbhbri0NxEr2LBjxhdg+JjvrWw3N
 N6IoZJ0HlG+f4yoNzKOYGSzM8YXfvKEQZSPnq2Gl2w/eQ0gRZv2LLD/RG6ghbosWShiM
 SDrykg84HWzinmAWGH77xRTnHaz5/XNyaIufGUPzU8pB0C9K1bwk8L0pAWGSBBFQEVn0
 wkfknb2/o3jaw2/4c218qRtiEbBfKXGUxyzceWxFEoZgLZBCMtyu8tj3ymP7yeYHc0Au
 f7v8/1odTT+rjXzkmbRAuGsGPm3hsRo3Jhi/qTvYb9hXclPyYt4RYr4doQV+79qPfBnA
 MnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cv++VM4MYiqOjOrBo2sj5uUnF958acH4427QgRn9C28=;
 b=tN3uvZYhAGFkJIWAu+j/Tau9elCis4bqDVRTYySBtFItbdXvGm5uUKnqFDcPOK8Zmq
 RrYC5/Zc/UfQrSGr3K6OrAfDkhM3Rc6qJwwYI4D4eG0Eh28y0NlomSwM1P7XLF7wU6mn
 L0T2nIvU6FkYf+/BPHmJM8Ccnm6c7WzkJJnpB7mXgHOU3kNYdWecLC5+7ga5U4cDIq4c
 LCTitYGjIqBmONmalvJ6oUKFcgeMJplzUlPFhLv3Nfgr/j5Hpwdg7aNvkd63h+HNJxWT
 AHG/kYe4O07Y3ghbD3E45+IK1T88I3kxMl6T3R4lsI0aplbuQp0w639Hu6+i0vGvcxRn
 K+Qg==
X-Gm-Message-State: APjAAAVedgOxhDZGn+fvcJ4ob8yJ4Ey3wbafRdDLzHGrPMoQi4E28cXi
 NfR04814XubM83lPj3oV3Vc=
X-Google-Smtp-Source: APXvYqxx+dpksTjB02N4lGdI0JEeeN7S+4CnBy4RnTgbbanMM+bWajL4s0GXh+lVv4CnAciVUXQSdQ==
X-Received: by 2002:a1c:99cb:: with SMTP id b194mr3681613wme.100.1573059424719; 
 Wed, 06 Nov 2019 08:57:04 -0800 (PST)
Received: from localhost (178.165.129.116.wireless.dyn.drei.com.
 [178.165.129.116])
 by smtp.gmail.com with ESMTPSA id a6sm2612549wmj.1.2019.11.06.08.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 08:57:04 -0800 (PST)
Date: Wed, 6 Nov 2019 17:57:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 13/20] fuzz: add configure flag --enable-fuzzing
Message-ID: <20191106165702.GL340561@stefanha-x1.localdomain>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-14-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7l042bGvurpep9Wg"
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-14-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7l042bGvurpep9Wg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2019 at 02:49:59PM +0000, Oleinik, Alexander wrote:
> From: Alexander Oleinik <alxndr@bu.edu>
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  configure | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7l042bGvurpep9Wg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3C+14ACgkQnKSrs4Gr
c8jU+Qf/Y/g7KW7VUiJNUpZhC+3ZuxPth0Aaup5NKralyceLo99zoguz3AE80rVk
FsJW+GSimHY6jG0bbneQK7Z20W7Z1iPgRt9Q796TnDBo4RvchCmoYgzSRMl3WSvq
eimmQWy5i/hodZRu3q1yEaoi47n2t8WOm3sBJoA4SLzgZeIo3sNdzzl6NpwXEKNN
x/Z4/eSkLMBjFdF3wYTRcQVas/Q8s4Ala/fmoJxrSU9Acr7ZphH12wL5izc5epU0
UJ5x/LvCrb1tje0huSn5tgtIjy/dsY/FM5x3pHZxuaiNV4n6Fn+kjPvA49ZJQWcu
RPR++YIv6/mz/hz7jdY+PHvcuTnyVQ==
=eews
-----END PGP SIGNATURE-----

--7l042bGvurpep9Wg--

