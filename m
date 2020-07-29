Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5540C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A8B20809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPRHBgs5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A8B20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0loQ-0006YG-PJ
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 09:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0lnH-0005fZ-7F
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:06:51 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0lnC-0006Ry-BD
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:06:50 -0400
Received: by mail-wm1-x341.google.com with SMTP id 3so2902045wmi.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 06:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5L9Q4aXuFwXNoJyMGOy0jR693SvohQNa2Qx6CVbFXeQ=;
 b=GPRHBgs5TV4SuH+TMp5AIlutd+uAzyf64+VF2ycPq23XARm00RwAB6HA4s4689PR6P
 qYrX/5z75M2MvIL/Bhigtd+7WcGpFsLmAG9KzoR2sYuVn0BMtRvuzKosNavF0Uva41O0
 71d52DWWxxjXcZOAwL4v8KTl53vsMy/wuECZBAhvTJtU0fRUJV97qVaGID8Jex3o4qlQ
 kGtl84Is8UbZotvv0PDw/kKXP0WBBDJTU4r/juPNFcPPRQ9q1NIVxPBZ7am1K+hJGMvG
 7i07yQ4Tmlk6uO4e4bZ6wumTXEUZyr8a8DPf1IZ/nIAHLhVfkn3333sNaMX+jROba10i
 mCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5L9Q4aXuFwXNoJyMGOy0jR693SvohQNa2Qx6CVbFXeQ=;
 b=aJRH/F4Gq7JF60nSWi7VCpIMT5HHOJ25gK0uaOKuXywW9EVGohwgnkN0wE5Go/qQ5r
 jsGHBXavMkWZu3ugFiLS5yVgpm2Ueod+GC9h22MFsUGmVqO9HyHQZMMhtw9/oAlpGQTU
 VhCK6wdiwpo7i0r3Je0N0qE32fWcEWxs22QKOz1TvL6LrkqmU6TnArx4aGRcvXa+xrLW
 VzhkMzmq0wWdy35e9pg99ByZez1gkOlO/kXQ4k1bfuP+mG6BcNkHyN5F8AWMUKfVLi+t
 r82jwnnLZ39ekZKHXC4wkdX1L/BaogQgFzPShdpZ1fC06LThABsl71crtikknjHinN64
 ztRw==
X-Gm-Message-State: AOAM531/UghmUu4SGQuMsp+IB22QywpDktDRxI7OkzZGez0MuBGv4AMJ
 4R8+/vZCXt31BL5E4/wRnXc=
X-Google-Smtp-Source: ABdhPJx4A1AG/k7Kcd3L15fYrZ9BfDQ7UkcFeV/+ieh68RskwmPoQ/z4sFa38b4EWc6yTdcGna8Mww==
X-Received: by 2002:a1c:4e0d:: with SMTP id g13mr8671622wmh.177.1596028004851; 
 Wed, 29 Jul 2020 06:06:44 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z12sm5052045wrp.20.2020.07.29.06.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 06:06:43 -0700 (PDT)
Date: Wed, 29 Jul 2020 14:06:42 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v4 0/2] trace: Add a trace backend for the recorder library
Message-ID: <20200729130642.GJ37763@stefanha-x1.localdomain>
References: <20200723132903.1980743-1-dinechin@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="W13SgbpmD6bhZUTM"
Content-Disposition: inline
In-Reply-To: <20200723132903.1980743-1-dinechin@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--W13SgbpmD6bhZUTM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 03:29:01PM +0200, Christophe de Dinechin wrote:
> The recorder library implements low-cost always-on tracing, with three
> usage models:
>=20
> 1. Flight recorder: Dump information on recent events in case of crash
> 2. Tracing: Individual traces can be enabled using environment variables
> 3. Real-time graphing / control, using the recorder_scope application
>=20
> This short series introduces a new "recorder" back-end which connects
> to the recorder. Traces using the recorder are intentionally "always on",
> because the recorder library is primarily designed to record
> information for later playback in case of crash, tracing being only a
> secondary capability.
>=20
> An example is given of how the recorder can also be used separately
> from generated traces. The example uses locking, which can make sense
> for both post-mortem and real-time graphing.
>=20
> Changes in v3:
> * Address coding style issues (C++ comments, wrong include, etc)
> * Fix args type for HMP command (for now, still a single command)
> * Add basic help for HMP command
> * Use pkg-config for recorder information. This requires recorder
>   1.0.10 or later.
>=20
> Changes in v4:
> * Rebased on current master
> * Fix GPL v2-only license
> * Remove confusing #ifdef around #include "trace/recorder.h"
> * Added myself as a reviewer for trace subsystem
>=20
> Later patches wil address larger topics that were discussed that
> would impact other tracing mechanisms, as well as GitHub / GitLab
> build tests.

Thanks, I will take a look next week. QEMU is in freeze at the moment
and new features are not being added until QEMU 5.1 is released.

Stefan

--W13SgbpmD6bhZUTM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8hdGIACgkQnKSrs4Gr
c8js6Af4uFe2wvyTtdVN1vZ5DAGmO0+ytMdQr2VhERB22eBREAZZSi9pIWXEqzdc
KBOjwXvhpTK9+62qLU4Fcuak0m7RHkpi1AJ5ovn0AVmOzU7DmQSpx9YKJo84QyfL
jDL6koylLEWw3wNueeu/E6W++yggWHkCoOL8sE1E75cb9GmKb3NYucf5/pcXfhCO
wWK06S0W1N5Uczpk0O9qMlM5k2DfQF6gmgq6ODk2GfldKVdNeDi2rj92tqydkVhl
CyPrgfGEsDtv/1cvB+2dItWTvBiau1McFCdiXco8pnEWF3AeNV7Gt+o4VkoXqECt
Ts5o7SMiGhFERGznHboEyrRSYeTW
=3uA+
-----END PGP SIGNATURE-----

--W13SgbpmD6bhZUTM--

