Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265E9C35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49DF20732
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAvA3IDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49DF20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Bzn-0004nF-5F
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 06:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j6Bz2-0004HO-5T
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j6Bz1-0002PG-7I
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:33:08 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j6Bz1-0002Ow-0r; Mon, 24 Feb 2020 06:33:07 -0500
Received: by mail-wm1-x342.google.com with SMTP id b17so8996026wmb.0;
 Mon, 24 Feb 2020 03:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=r1kcDu5CfZeLD5BWq94J9DVKoGZrm8HFNLBAPpYL/aw=;
 b=fAvA3IDWLhIT/sAJkqVXbqDuS+3/+YExqkYWvyWXLLi1kjdECqiN9gGc5S52OBPE4W
 FBeldcvkCPMKMdVRAwc5lq9as3pMl96lfOfXLvQyyDjWWouahRzd2hH/t/WeR9oY8nYJ
 YCGXAYhCjtM5K0gj8TwjGaODd6+cTE6OXViwMx3o8/p0ZTfu/hezcSyokvMwMVosJsKU
 kK3eYLGqypAUkrCc3YEovgXaac67DzhrUrPhJjizN71k0wM135cwfdDnrbSgwp3dCLFQ
 6cblJICqd1ird70eGiR24vq+fOU2vw5awka+52lYEmTbdzLxL6XUCPvZ+hporO3DCwDp
 N3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=r1kcDu5CfZeLD5BWq94J9DVKoGZrm8HFNLBAPpYL/aw=;
 b=AompSeXZL0Xcg07zXZTVeo5BaGbppCsUP4zaXwbi3QRAyEW7UBeDaTcAqXm52a/J9B
 kz4G+fL/XTvDorutCB2nzHCpsnnVeCVWT5RtQAPoy3bWK0IjpcwYw8Ei6+cm1tgGV8cd
 AIIwYC93PPgTd4HwHbrFohmdxsUtq5HgpI5MmzuMeQbYSYdRLmPKDxb9pU/X5cEa9vWr
 VeAGNSpCMMmW49psw44rPrO+2/26leAF3LvLqYKnRWkmSzJCAlcGGbUzs9I1bg3UGnm8
 R1tuSBW0lgXMe+c1i24vnmVzM+zv+sEkVGOQaHBvA1JJeTYHeao4yJ4fv8rj26scmLkW
 GnnA==
X-Gm-Message-State: APjAAAW9W1yZcg5JpqWeQNkjui06qXrpMUF8kJ01RwQ1Nb+bws85akhw
 2SItHGFoxMCOlPrZrkHhg8xpJmhGaJkJpw==
X-Google-Smtp-Source: APXvYqxIu6Wf+dT5ul1xz+SJsMPNyKCheoBxH2E7tu2kLqvj6DvJ/b/wNkMdssgjfeBa3AiNwZUMzw==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr21715599wmj.170.1582543985470; 
 Mon, 24 Feb 2020 03:33:05 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id n5sm943211wrq.40.2020.02.24.03.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 03:33:04 -0800 (PST)
Date: Mon, 24 Feb 2020 11:33:03 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL 00/31] Block patches
Message-ID: <20200224113303.GA1896567@stefanha-x1.localdomain>
References: <20200222085030.1760640-1-stefanha@redhat.com>
 <158236281080.7375.15959926465237508138@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <158236281080.7375.15959926465237508138@a1bbccc8075a>
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, mst@redhat.com, lvivier@redhat.com,
 mreitz@redhat.com, alxndr@bu.edu, bsd@redhat.com, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 22, 2020 at 01:13:32AM -0800, no-reply@patchew.org wrote:
> This series seems to have some coding style problems. See output below for
> more information:

The checkpatch warnings are benign:

 * The include/qemu/queue.h coding style warnings are because this is
   code imported to QEMU from elsewhere (BSD?).

 * The 80 character line warnings can be fixed by Alex in a follow-up
   patch.

 * MAINTAINERS changes have been made, but the check is known to report
   false positives (especially if a wildcard M: line is added and then
   new files are introduced later in the series).

Stefan

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5TtG8ACgkQnKSrs4Gr
c8hysAgAq85RtynzTdqTgDGPFQnD2yvGRVffbxTGzKUicxehJuhrqqMuv1nX6dWo
q5tjBcJjmlT2Uf53gGeH7+V13QfpmGQyYb2RNCITCRb+E/NJNf1iAdH7kE41+skL
/wfQDWypUxc82SsHe9MM9oK+WnaIrTDatocXELM6SM/rnPxIDuPo4PmbKmPWpNAI
v/L1W429wmTmQhoAOVcIsVBTWIvf1ogdcSpzuQkTe72KWlS+HvyIo/TIJl9jnzE6
dkTN2i9ptyClf1u5/86ErXRG+bGsOajaMIthfvj3G2P1DbHy8Phk8K8B5huAY1nJ
rDV0zaP1lAByUhVOxVeuokl7JP7lLw==
=1R3Y
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

