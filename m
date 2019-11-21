Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1716CC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D330920409
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jP3zlog6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D330920409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmcB-0005S7-QF
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXmad-0004no-3T
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXmac-0005wD-2K
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:33:42 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXmab-0005vT-Pe
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:33:42 -0500
Received: by mail-wr1-x441.google.com with SMTP id z3so4444022wru.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 05:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YKiSUPMy3jGzYNHPKdZejHgYRb4Zvfac5Y85g9FPbnU=;
 b=jP3zlog6ZmnW9VDMITGnbK3Yg89H442CZoZeJKdIP/Pd6r5m27E8M+JY8X496EMJ6z
 15hN1Z/x0ztZ2DEVB94XWQ85sTdkm/GXAK1EKlzTHKtegXiw3s4FUeKsldDgXmw4Gp5N
 qdX4yFxI2biC/k7N6Q6t547Oi1ifXofvYLqqfHvwh4ybd7CGyJcaxf1RI7GB1mM+P7I7
 /w4fg37HPJkxQMgq7NS+V2vzcdMBQeV7k0UqPulUbx17n4eiICwhbtJ6yBGtgbl4/Njh
 cNbstrg/to3l+fTriwaXk/Nm294jVtZj5wrYDSBo2Np9APkWy5yU4MRjOmRqSoN66QQl
 lLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YKiSUPMy3jGzYNHPKdZejHgYRb4Zvfac5Y85g9FPbnU=;
 b=Z919Y9nsUXXmEidzRdbes22qCotEQ+PNDYotxXCW3w5tyJ08amDjC4onlaTUGLYVJQ
 AGDuheoDNG+jCbZSSB68xFvfgw6Z8RhJ6vU08GWo87G2pFrl/bkKFHPRSicY9vxlsPQJ
 mdD3/01KfyFGVSPID923VasrArZeNTk6fudJ5hKvHmyGHXU1jdcvwW9bN/SMshCi0nu6
 qXgYUu/JE0Idss4+A2uU+BwpnrJk41pnT8qVXxLiodXpDe/1NGjX44uCs5SGVQh10LqR
 byBf5u312k8BEWYWwvjPS59NZoGK4bZDcNwyTM2xEDkeXmOLL9RmeVH/pE5BAzN47XC/
 ACjg==
X-Gm-Message-State: APjAAAXET2oOxvQdCMK3R+o2Ibod41gg/46+87udlP9lWSAiuoCEizj+
 L3rdDW+72mwcstixp9Pc+Cc=
X-Google-Smtp-Source: APXvYqyKyhQ7IZZni90jttOVsi/IK6oi72fBmD96T4vYEaMlAWsfeb80NBn+FrFseB/PlZHinyMuJw==
X-Received: by 2002:adf:f6cf:: with SMTP id y15mr10190381wrp.97.1574343220615; 
 Thu, 21 Nov 2019 05:33:40 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z7sm1700794wma.46.2019.11.21.05.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 05:33:39 -0800 (PST)
Date: Thu, 21 Nov 2019 13:33:38 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v3 0/2] virtio: make seg_max virtqueue size dependent
Message-ID: <20191121133338.GU439743@stefanha-x1.localdomain>
References: <20191112111354.26324-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KAk/33nSS6LK84p9"
Content-Disposition: inline
In-Reply-To: <20191112111354.26324-1-dplotnikov@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KAk/33nSS6LK84p9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2019 at 02:13:52PM +0300, Denis Plotnikov wrote:
> v3:
>   * add property to set in machine type [MST]
>   * add min queue size check [Stefan]
>   * add avocado based test [Max, Stefan, Eduardo, Cleber]
>=20
> v2:
>   * the standalone patch to make seg_max virtqueue size dependent
>   * other patches are postponed
>  =20
> v1:
>   the initial series
>=20
> Denis Plotnikov (2):
>   virtio: make seg_max virtqueue size dependent
>   tests: add virtio-scsi and virtio-blk seg_max_adjust test
>=20
>  hw/block/virtio-blk.c                     |   9 +-
>  hw/core/machine.c                         |   3 +
>  hw/scsi/vhost-scsi.c                      |   2 +
>  hw/scsi/virtio-scsi.c                     |  10 +-
>  include/hw/virtio/virtio-blk.h            |   1 +
>  include/hw/virtio/virtio-scsi.h           |   1 +
>  tests/acceptance/virtio_seg_max_adjust.py | 135 ++++++++++++++++++++++
>  7 files changed, 159 insertions(+), 2 deletions(-)
>  create mode 100755 tests/acceptance/virtio_seg_max_adjust.py
>=20
> --=20
> 2.17.0
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--KAk/33nSS6LK84p9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WkjIACgkQnKSrs4Gr
c8iW2wf/d2TzoZk3X1YF7s4s3ufWXNtNXMfWvGxGxm1PAaH9llUFS2ZwQgPfmLz6
g/GdFVLLbkHYzjr63FswbIDS8dKfTb2rROwDXTxGzVQ/BkH+/vK5ilLjjT9X3U7e
SJEJIaNnBbfa2hJmydFMqHw2+Ko1PWXv+A1gJeCjrI8SsezNx7F/3fxy170+gcHN
XIjmEIWyCiCTnk9SawoJOkeYg2nsKkqaC25I1YDq7F8dr0l3z2jvS7fevheN2/KX
IdSh9rFH2IwdZHsz+q7BiYst5qi03e83HaIIJlbQYtFlP8h8t5TcKJH76UN1bx/e
0gZ8cSqVnBZpiClASE8DBD8pt/x/Rg==
=R4UR
-----END PGP SIGNATURE-----

--KAk/33nSS6LK84p9--

