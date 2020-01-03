Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151BBC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8E52085B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlF2pyou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8E52085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inKzu-0008PD-D7
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 06:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1inKyn-0007St-G1
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:18:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1inKym-0003fu-Eh
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:18:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43884
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1inKym-0003c8-9H
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578050335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BWl+Pq8nNO1mRORhibPO5vbeNCI4pZukjr7nNsEd5Gk=;
 b=OlF2pyouQYnOBetL3Bg6E3MfSb85xgZIgCDYQHJ0orY8Kd1+4DCavaKwu3TmIlCnaFKga8
 W6HbIgDHkpGDZnbbRWr6JtMe1QNmU4kDXfPpsQU4k6++FUx5tK9eHaoswgmRuqQqT3E3Ps
 doxnlOvrw28T3SeWHBRw7iOiIAuGaDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-KpaCK2uSOZyJ29VbquKhVw-1; Fri, 03 Jan 2020 06:18:52 -0500
X-MC-Unique: KpaCK2uSOZyJ29VbquKhVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23DCF107ACC4;
 Fri,  3 Jan 2020 11:18:51 +0000 (UTC)
Received: from localhost (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EF5C60BF1;
 Fri,  3 Jan 2020 11:18:48 +0000 (UTC)
Date: Fri, 3 Jan 2020 11:18:46 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v6 14/21] fuzz: Add target/fuzz makefile rules
Message-ID: <20200103111846.GH130240@stefanha-x1.localdomain>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-15-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-15-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SUk9VBj82R8Xhb8H"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Darren Kenny <darren.kenny@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--SUk9VBj82R8Xhb8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2019 at 09:34:48PM +0000, Oleinik, Alexander wrote:
> diff --git a/Makefile.objs b/Makefile.objs
> index 9ff9b0c6f9..5478a554f6 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -86,10 +86,12 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
>  # qapi
> =20
>  common-obj-y +=3D qapi/
> +softmmu-obj-y =3D main.o
> =20
> -softmmu-main-y =3D main.o
>  endif
> =20
> +
> +
>  #######################################################################
>  # Target-independent parts used in system and user emulation
>  common-obj-y +=3D cpus-common.o

Not urgent but as a general comment for future contributions:

It's nice to avoid churn in a patch series.  softmmu-main-y was
introduced in this patch series but now it's being removed again.  Can
this be consolidated with the earlier commit that introduced
softmmu-main-y?

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--SUk9VBj82R8Xhb8H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4PIxUACgkQnKSrs4Gr
c8ioIAf+P4mc/FHU31Dr6e1PBPWyGq7dalSLIfIAAVwCS5jf7ybfnbSoNx9MQ73r
OhG4QUk2RDbWVnMtMVrvyzLhuBGb5OjaT/vUZsAAXRv07HGKKdcYevtouc/QPOF9
3wLn6tm7zva2+1FMBcw4t9ESJ0MRdzjCwqTG6Ps2ZHty3VF5s+bG7C34U5hgWbmH
2qGuxo9ntIMWYHf65IC7wCrptMyMxvmnmETOpmPmBMRa4tYaQIMGddJi7QPEOlv/
fB8dN4QiikHoO0IYIT3iWvItvAOlxVI5cb1PaEHH0EzES+087G+RQPn29oxTanis
BqGq7o2vGITug/GyNO4agOoxFzfgQw==
=cqji
-----END PGP SIGNATURE-----

--SUk9VBj82R8Xhb8H--


