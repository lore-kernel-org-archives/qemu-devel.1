Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBD3C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 16:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4372F2064A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 16:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7f7+ejl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4372F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36433 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLsF9-0003HU-IB
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 12:38:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLsE5-0002rq-PV
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLsE2-0003RQ-NX
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:36:57 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:33620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hLsE2-0003Nx-GM
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:36:54 -0400
Received: by mail-io1-xd42.google.com with SMTP id u12so15311912iop.0
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=pIbW7GzOBrDJL8zGiWX9TbqAbhyUF4FlYUJ8pozloh0=;
	b=C7f7+ejlEnCMUH7wEw1BDcH/bDmwELWn31M8VZKcyoLKYXO6rmxMs73G2LWBQFLl+o
	Jub6loq+CVxFXRDuSKdlQ5CVVTzs+qkBooYjPukdSBKqmPNsTUl4pJRgxdMEDe7BJyg/
	3nP3JY4QSBIwjRCf9iKdbwIPJlWfN/0UZRT3DpRY/BJ+BTDVQ9ogjdSj2EX5C88mwCSB
	6/fprn6zHGo9RAZ0QE422PjpVGJ7Et/GBvHqSjUMcjUuDTCPB5t9EG5MRH9gzPBvlELa
	gLwwin1tnJn6sRQYn60HKTOEuS2vUpYYld6eVM5kS5PTGJr3BPz9Bn61j2ruiKaUaV2W
	Oopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=pIbW7GzOBrDJL8zGiWX9TbqAbhyUF4FlYUJ8pozloh0=;
	b=V9qGvOsB78/vsaRgAdYvTvG5kDN/VRlITqR+EPBC7cQovLCFfZ8j4syZEbETtlp1MF
	DqL+dDwJT3JZ12NQTL+0Rr//8UOA9wIeH44MW+RTR30e/qHq9BFOjm+SD+KheptHMQ1d
	4fMs3l+Qx+S+4OblnJyBF2kViBv2LFGEtcmUljd2U7I3pg5eANj/iKVraAxpbcTKEImF
	F7rMhoi+xB5K/Xp8pFxD7jvNFoPP3usyDZnDAEHc4qQWs04NRRvtevUbMipcbeS7CH5J
	Apch8SN4mkWqEgeRc7uS4ULsIjHdInNcooyLux/vreUHgS5Rw9xKMM4J22jU/4UuZ0Il
	iKkA==
X-Gm-Message-State: APjAAAUe/BCyjugosmKIuhe//LU4TGRhdxh/hjvNn18NhzvfMJQfWClZ
	5wS+GzSx33cZyhXk7cxAwTg=
X-Google-Smtp-Source: APXvYqzGriMDXZaaA5sZBT5Fy/lwzTRVDFbJvdDYYtIsvN6j8s54CZGOt+qGDxaY45Vb7IJwaYHcMQ==
X-Received: by 2002:a6b:b714:: with SMTP id h20mr17518766iof.68.1556728613461; 
	Wed, 01 May 2019 09:36:53 -0700 (PDT)
Received: from localhost
	(CPE64777d5479c3-CM64777d5479c0.cpe.net.cable.rogers.com.
	[99.228.64.175]) by smtp.gmail.com with ESMTPSA id
	b72sm3241036itc.30.2019.05.01.09.36.51
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 09:36:52 -0700 (PDT)
Date: Wed, 1 May 2019 12:36:50 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Wei Li <wei.d.li@oracle.com>
Message-ID: <20190501163650.GF21155@stefanha-x1.localdomain>
References: <CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
	<60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
	<898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
	<20190416092042.GB32709@stefanha-x1.localdomain>
	<8E5AF770-69ED-4D44-8A25-B51344996D9E@oracle.com>
	<3F7E854A-3C1D-4204-8C35-893FC0614796@oracle.com>
	<20190423120453.GF32465@stefanha-x1.localdomain>
	<44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
	<20190429134048.GH7587@stefanha-x1.localdomain>
	<1A278B43-AA26-43B4-B6C2-17231E780BBE@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zi0sgQQBxRFxMTsj"
Content-Disposition: inline
In-Reply-To: <1A278B43-AA26-43B4-B6C2-17231E780BBE@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: Re: [Qemu-devel] Following up questions related to QEMU and I/O
 Thread
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Dongli Zhang <dongli.zhang@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501163650.mx7UKaKJHiYAUez2dsq-qCjH39XketFgU5DBTAvckQo@z>


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2019 at 10:56:31AM -0700, Wei Li wrote:
> Does this mean the performance could be improved via adding Batch I/O submission support in Guest driver side which will be able to reduce the number of virtqueue kicks?

Yes, I think so.  It's not obvious to me how a Linux SCSI driver is
supposed to implement batching though.  The .queuecommand API doesn't
seem to include information relevant to batching.

Stefan

--Zi0sgQQBxRFxMTsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzJywoACgkQnKSrs4Gr
c8ibRQgApviIvzBkdGSYDCfxjvmfv9kjionlS8Vj63GB5PtcEok9fvOoaQlXHIni
syrKPmZxcBVTLKmie1H5QBecbOU6FFr/wfaIQd/VIe9E2/hDjEsJKYSfQyr2vqEh
lpKb9yNfiguVWQThCruqNkwRxh62sQL9w/okJjXt+igyjNlQmonxhRMLok/AOu6Z
36td6F3oCfkEPA3apaAEbtv9mvt3ztKJ7C9tuD4U9/vSgsKNUircByDBFaxYX2GO
3zFaFo5RP10Z6aRdtOlwRdRe3Kl9DfVidVTKDf2moYHiwyvBC7nlyfMMxT810Two
ii7c1hAReVJBmJaGtwmLUwRntZZnXA==
=GFKD
-----END PGP SIGNATURE-----

--Zi0sgQQBxRFxMTsj--

