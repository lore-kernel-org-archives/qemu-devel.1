Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019FFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98E52072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgkjtXuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98E52072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbiJ7-0004wO-0W
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 06:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbiIS-0004Fn-P7
 for qemu-devel@nongnu.org; Thu, 21 May 2020 06:19:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbiIR-0001Jg-RA
 for qemu-devel@nongnu.org; Thu, 21 May 2020 06:19:28 -0400
Received: by mail-wm1-x343.google.com with SMTP id m12so5123204wmc.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 03:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=96n/mLTCUacmDvmL76dlGoIhSiRV+x+FZJrXHAy/FkM=;
 b=XgkjtXuCdRpxhUdnE7ZdSk/3UIwAKlYhTcg6UVel6VRG89NRoRBJ+UmBSm1XnL0cu9
 OZFpdBEMlRZLr8mXgHv/ivYyoPUcEyabVEKqqkaSMQASpav0K8oasxIvYLYpMC/zoBAB
 ixCY+E8YI6sFv6+eIRwwLh5vwATaCr+fxpL4sivUwkp01ZveJJpkkncSSvdHKQO9CYYt
 WxXEiVNoJlWcsAyNVRH03DtLz8vxRi+mxM0svKG+2evYqs7w16aYSsAE3udUMBYA+B5R
 YjAuzFdgBOOBcUucGYiQFKm8uqWi3VUJ0451WYz5zXGThD4TTvEILRlptIdfR2AGkfUO
 yYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=96n/mLTCUacmDvmL76dlGoIhSiRV+x+FZJrXHAy/FkM=;
 b=GrfhA1N+erZQP+C09a/JB2beOggoucQWlpPrWjrohPxmL1tLo6HSw/pIVDe/amyrYp
 wkBbibCNz5bkqSdj8VpeYeM2q5jQQUCR6bAAdj7xtBs4FB5R4juwJivNXdq3bmUAvU8/
 luctStfxm6PquhWK0XznUTy0y3EbzELGODKyWkDZzpuTaMbr/0DwQV8GM8jn8azOgVKL
 dw6nImcKkeEmwQiq1jmOOlRSE0knPITloQx470zVE6YS6n1z5uf7+3oJfUY/Mj2EToxo
 6xeqfvqYQrg9tA1xCDHrCtDJS5GrlRva+e3WV30VMCGQObTt443DtTY/zYOSOxqRgnnp
 CRKw==
X-Gm-Message-State: AOAM532aQ7TUzB4shkiya1HZxF3EgvuRj7i+DM0Z1uR1igtVaUrRDuSY
 8h3rWp9WDYDmyKhj5EYvDyw=
X-Google-Smtp-Source: ABdhPJyOkYgrJNLcqknhg0Sk85cg48eghKHqWYukqeshaG9lwEUTJHZBDYwhHhR2aEpN0BLWu2dXHA==
X-Received: by 2002:a1c:a7cd:: with SMTP id q196mr8075563wme.141.1590056366212; 
 Thu, 21 May 2020 03:19:26 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id m23sm6035731wmg.45.2020.05.21.03.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 03:19:25 -0700 (PDT)
Date: Thu, 21 May 2020 11:19:23 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] virtiofsd: Use clone() and not unshare(), support non-root
Message-ID: <20200521101923.GF251811@stefanha-x1.localdomain>
References: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
 <20200506191614.GR2743@work-vm>
 <20200507092832.GA1104082@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5CUMAwwhRxlRszMD"
Content-Disposition: inline
In-Reply-To: <20200507092832.GA1104082@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Colin Walters <walters@verbum.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5CUMAwwhRxlRszMD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2020 at 10:28:32AM +0100, Daniel P. Berrang=E9 wrote:
> If the person in the host launching virtiofsd is non-root, then
> user namespaces mean they can offer the guest the full range of
> POSIX APIs wrt access control & file ownership, since they're
> no longer restricted to their single host UID when inside the
> container.

What installs the uid_map/gid_map for virtiofsd?

My machine has /etc/subuid and /etc/subgid, but how would this come into
play with these patches applied?

What happens when an unprivileged user who is not listed in /etc/subuid
runs virtiofsd?

Stefan

--5CUMAwwhRxlRszMD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7GVasACgkQnKSrs4Gr
c8gvkgf/ct6/Xkc//lXF8jqoyYxSoMaPtPb/HhEsPgX9+OB71ZJMKgRnuWLfSqsm
jCsIDr6UWldHeAx8bTkX9TUcEHd1ZJocEkuAYtgyvpZLiUEghaevZCtrqD55FQLQ
AL8P0BQbwNOSBFJX6Rwtmta0LsEe5+d9wb2H+zIhpbkBiyIkLk29YMdYnsvLfmk0
R/WQynw4jiD0oo8TiFctXu8JDBdbNKPZmhbS83TpFTBOQiGWP2zP7fcNAkrApyPi
CU3TO2lZaE/3ib/481XaI6/wr+O1jZD4VBXAGONj8Vt3KL969efP7kPWP9t9JNX6
HFOUaYPFJz7kBfvP3iraXY5VxxaWrw==
=6rg3
-----END PGP SIGNATURE-----

--5CUMAwwhRxlRszMD--

