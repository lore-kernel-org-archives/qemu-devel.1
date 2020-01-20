Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C000C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62C0217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFtAAtZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62C0217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYIX-0005Fe-L5
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1itY9p-0002Wd-ES
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:36:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1itY9o-00076q-82
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:36:01 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1itY9o-00076E-12
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:36:00 -0500
Received: by mail-wm1-x344.google.com with SMTP id b19so14676829wmj.4
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 06:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XePX0BWKmZcT5JuJ/bO/3g/R+Bq5YtiKM4/y0EorQtc=;
 b=kFtAAtZ81j0Ge6qi8suzG/211S6rNz0AFn6/NZAnOoCtPC+7NLkoyZsj5nUboumvux
 n27C7N0wPU94fXnDjgzVYd1d2lKe8V5mT1rTAKoJWnGfNPoWhzv4PwYwOTHYNo7EvZ/Y
 yrmD8+r6qFNkFyl8noJn8vR1zlFQLMcZ2eimQpY9vxYKB+3/IxRlkv/1InDjOIfR/Fz6
 Z28kTFUGUNZk/7GS5zQr46vBT3yR5hoNH+wXOwiimGH66cvwxLk3yI4IqfiE7GgwiBnk
 +qTDlVnBohV04Pe6W7ceuIJPfwekjre+9vVL+LFUpqqa6gRaAowYrOYX3XpVxgJ/ezYi
 VQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XePX0BWKmZcT5JuJ/bO/3g/R+Bq5YtiKM4/y0EorQtc=;
 b=TxDc93tEOQW5wF2elimK/pTjC0GacHXFV+Ate1d5JGzmS8aHevbkSnzCXSITp5zfSf
 i6TRXRTa4tADsERvY/7dGHDbugs7utj7joOMVtcUtlYSHLp4OUByXCA5ORdimPQL8HmZ
 iy72X209NJWZblVZNPG0ER4o/dUnf+as+qyHqsqPTixY3+XOK5o1KxVelDtjh8xSqAUi
 zh7AYTt2nuL4uBt0eb1qHEa+DAH12MvhH28C5NP3KQSzs3Ebc1H9T3otZ2nf4m5g5Bib
 DKv5BX+ppWeyNADfn5vh7sDW4HiAsfV16w5/E6r6V8gL1e5yzhoYhwFvAtzmGp5RO+Ta
 cqzw==
X-Gm-Message-State: APjAAAWlCfjgiIluMr9ufsO/0Icm5+h3YPTYtq1TQQppc2wApQ3n6c6Y
 LwoGTQpLicJwalGU1skd3bE=
X-Google-Smtp-Source: APXvYqxZUl2vlTsi/f98x3t7kZEXZcutjinHBZr6lRaNdAkmYF3D31nkp3ROhxLMSAfh/qNjXEAnUA==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr19863771wmc.78.1579530958980; 
 Mon, 20 Jan 2020 06:35:58 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id y7sm59351wmd.1.2020.01.20.06.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 06:35:58 -0800 (PST)
Date: Mon, 20 Jan 2020 14:35:56 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH 0/2] delete virtio queues in virtio_scsi_unrealize
Message-ID: <20200120143556.GH345995@stefanha-x1.localdomain>
References: <20200117075547.60864-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline
In-Reply-To: <20200117075547.60864-1-pannengyuan@huawei.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: fam@euphon.net, pbonzini@redhat.com, zhang.zhanghailiang@huawei.com,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2020 at 03:55:45PM +0800, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> This serie patch fix memleaks when detaching virtio-scsi device.=20
> 1. use old virtio_del_queue to fix memleaks, it's easier for stable branc=
hes to merge.
>    As the discussion in https://lists.nongnu.org/archive/html/qemu-devel/=
2020-01/msg02903.html
>=20
> 2. replace virtio_del_queue to virtio_delete_queue to make it more clear.
>=20
> Pan Nengyuan (2):
>   virtio-scsi: delete vqs in unrealize to avoid memleaks
>   virtio-scsi: convert to new virtio_delete_queue
>=20
>  hw/scsi/virtio-scsi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> --=20
> 2.21.0.windows.1
>=20
>=20
>=20

The patches could be squashed by the maintainer, but the code changes
are fine:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4luswACgkQnKSrs4Gr
c8hfCAgAkbmq5tDMW/z0SNypDVheFkhNhKeaFjCBpG9hYEGW9o8mOaGn3BzN6cnQ
4xmNaBEPl7/pY4eeQP92gVcGatgEi3serexIRkB2A1MER6QDUvIqSxQdPln4mwIs
BlWF7a4tdQ2z8p/q/8w4jQ0igNb3f5JEK6ERRMTm/wZ/9AKK5AgC7luXyckpwhlw
rDE68A39acJz8cPRkeMNt1I7alN305lji54gv5D+UzT1nOU0Vnr5Qz2z6yyAnKku
4fYsODNojHX2rl4gXM+ztXPzKhZMfaJMRmSVjUGEItBmtYsY6L3t7vu4vD7y3KO5
NN5fAWCWNbdL5ce1HtDYKCi+C2OVew==
=uYaa
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--

