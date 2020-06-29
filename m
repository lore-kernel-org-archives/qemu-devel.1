Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5660C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3E823D5A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd737Wip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3E823D5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpthD-0008Hs-QN
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 09:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jptg8-0007gA-VR; Mon, 29 Jun 2020 09:18:32 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35306)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jptg6-0005Hu-Tn; Mon, 29 Jun 2020 09:18:32 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2so14603307wmf.0;
 Mon, 29 Jun 2020 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=iRWo28FuxDyc/zoNbZIPsjj0FPD5HGUwpJ3gF2bSzYg=;
 b=Bd737WipyHOipl98g6ti15NF1H4d+RQmoBBIwZrxoVK1Rrw4coKoiUpB4YI9DffGwu
 Cimpo08xNRoL7yThvXLMs7uY0cuvjSY6ord8n/OvbpB/m4Q5seR2b3GpZvsognedFQJ2
 TX1VSr8Pmi1wsbgnm2G0dq4g/+x3XcXV7pD7DqysLhYKl+ZWud5tpagjniJxT1ACyJY3
 EGsJi7yF+o0HGD5LzlM/O697HFd+fxUap/yneKTSJlxIhnf2A1Dgh6lUu2Nr3JwH6h8T
 T+j8yDZIhyK7en+qzROjxyDP/38ufwA+RcRPU/lZ8TPVuzBYEWCVIM7G673oBSKgeHrh
 LHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iRWo28FuxDyc/zoNbZIPsjj0FPD5HGUwpJ3gF2bSzYg=;
 b=iPoM3DWIg4iYz8gUSFO4spFG2nEzEEMsmPN/esZu7vW6DmsE4pJ7TKCSACPBWhl+cy
 mAcc1dxz/qRTIre86g+ZIBnILYdNrFdOrkvgNrxS7luZ4tb9kpJ228H69odWveJuVpLF
 +9LG/+oXz/pbYys0fO9l4/0kbL2rALoP83OenYuQG3vaI0pJty+WRWieIlJTnkkd7yTe
 D651+Y34DVv/sugn7Dk4tnKcsr+vf/tb192Y3xCy/iCISQ66XvIUOHKDB0R1Z40zXqiS
 2st+JpboYDyWwjMShKpi17aHzY3+Wbt/FgCoGwlyaQ0yauD7eS3NnJypGoeoXCQC7IRt
 nZrw==
X-Gm-Message-State: AOAM530vic3Vkn5e1mDOREx63IMBOUPQseqq0Z62tcfDX3sm9qT8DY26
 k8lAr9l7+qDj3sHTFtXkRnc=
X-Google-Smtp-Source: ABdhPJxkC0DepoYrKHPZC9xKUp1yDHeI+uvEyZioA7+tlR3Rb6S200oANdDjJ8ZON1VDImSytpf8ng==
X-Received: by 2002:a1c:1d04:: with SMTP id d4mr17586195wmd.156.1593436708935; 
 Mon, 29 Jun 2020 06:18:28 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v20sm50050020wrb.51.2020.06.29.06.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 06:18:28 -0700 (PDT)
Date: Mon, 29 Jun 2020 14:18:26 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: David CARLIER <devnexen@gmail.com>
Subject: Re: [PATCH v2 0/3] following up haiku build fix
Message-ID: <20200629131826.GM31392@stefanha-x1.localdomain>
References: <CA+XhMqxLQoYmsrocFOM4zwaNX9FhfcAb0EamrvQL6XouB+vDOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Kc9HNjpzOXVc7FFU"
Content-Disposition: inline
In-Reply-To: <CA+XhMqxLQoYmsrocFOM4zwaNX9FhfcAb0EamrvQL6XouB+vDOg@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Kc9HNjpzOXVc7FFU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 03:00:57PM +0100, David CARLIER wrote:
> From 6fa7a4108236f513201192654e07c7044a3d7e58 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Fri, 26 Jun 2020 14:48:28 +0000
> Subject: [PATCH 0/3] following up haiku build fix
>=20
> David Carlier (3):
>   check sys/signal.h presence
>   define SIGIO for haiku
>   qemu_init_exec_dir Haiku implementation
>=20
>  configure                   |  8 ++++++++
>  hw/xen/xen-legacy-backend.c |  1 -
>  include/qemu/osdep.h        |  6 +++++-
>  util/oslib-posix.c          | 20 +++++++++++++++++++-
>  4 files changed, 32 insertions(+), 3 deletions(-)

Please send multi-patch series as an email thread. Using email threads
make it easier for humans to apply all emails, mark them as read, or
delete them in mail clients. Continuous integration scripts may also
rely on email threading to identify patch series.

A patch series email thread looks like this:

 [PATCH 0/N] Cover letter
   +-- [PATCH 1/N] First patch
   +-- [PATCH 2/N] Second patch
   ...
   +-- [PATCH N/N] Last patch

The In-Reply-To and References email headers control threading. See the
git-send-email(1) --thread option (it's enabled by default so either
your gitconfig or command-line have disabled it).

Thanks,
Stefan

--Kc9HNjpzOXVc7FFU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl756iIACgkQnKSrs4Gr
c8hFfwf+Pk0AiGlSKbMfRKpCa/ERJ66EAaMzElZxq2yVCnnybAuGsr0Ke6JuQPmY
tmsYVWFTdoA+hbCCJuvphLc7V7cKFOgsfxQZeOlnzGin1DAKliaSmJh4/iEWubpo
7WtHukTB3aXftZVf/XIlDdEOl2YCGBkBFRksJiLCaUWN2bQES+5/Zd4CCzDXiI0d
0gG22UWmrgVCuDjby3CZSIxa+xI5qdrLPFaT2s3xQObJA36jhxDU+ZjX36SKEo7D
QHcfRAulxbnkK5OOEJ5C3BBWSMr3fpWfeNWYmnA5A890PJR5B0dP/XwGxQq6QgKu
oCLXeEaluDGjHIhc1L7IhQPzQoTpQw==
=UxzI
-----END PGP SIGNATURE-----

--Kc9HNjpzOXVc7FFU--

