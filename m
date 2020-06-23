Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DDAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725782070E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzFcLRPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725782070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkkR-0003T0-Jm
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnkVA-0003EH-74
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:06:20 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnkV8-0001W8-Bn
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:06:19 -0400
Received: by mail-wm1-x343.google.com with SMTP id 22so2441751wmg.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 08:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=PxEXhYLbmH1o6u+grMyWsHnAH2Lm9BUoWtjkfx2PRsQ=;
 b=bzFcLRPM8dyN9xEr89boLO7PFuM5iyjGW3txKKFfgQxhDIfqZi5nNZHQvyYlaZYXcx
 81zVul/FpqrsJVOVuCWUwa4zNwQSeuYzdXdEg4dIblNfyM4D/EgW0J2g0ozZ36iRMK8y
 /aX9bUNzJPAkXTxXJfq7z2KL78d3fN4jzkhrZEzg+9sLMozo/xGME8RMYOXZ9co/Jfpz
 n8SnlV0ISCXu0GFCvGS22seukEKAOikwv/NTaLv9ckJYxRwXxSbAi3XtTHbrm6Agj5LR
 4LHnKSZxc8csvXm/u/m/PEddMqTCMG6/zTkOo9HWXNBvjDa1GeONVXIscchGhseIn+VN
 i/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PxEXhYLbmH1o6u+grMyWsHnAH2Lm9BUoWtjkfx2PRsQ=;
 b=dPeXuF51dpHSqpcSQrL1wxvypKEcLxVd/Vwo6qNvuXCX1NogL0mXRJDpWwsz8tncGL
 Stbri74zUtopNAgooktQwmfXmho40Rs6QiQ9DLRTzFOlL5TywLc/WmSqEnHr9nn5uHk8
 xXa66pwKA2UQ4b0Pcfmh0WrfYXxEXfKoZEg2ZacHKXhIkV1R9ALdjAIY8VFEJLOhGwHH
 qvj0abUoU5N1rQQz177qLa/GY8Fpt4bLQdABPxczCooB2jM70M3EIOINS3wxGXFtX2s1
 EugUOESVyWP+cWHXFSka3bbNQD0ZZMlrJHjPR9PmQot2UV8TvUV4dScOiU6hz8TsqSg4
 yYJQ==
X-Gm-Message-State: AOAM530TlshEZ0sDCk84BwLLqYhg1YsGu6GrdEByKFNjOk3T83shstPK
 Ti1sUC7IGQ6JN4F9j9DJleo=
X-Google-Smtp-Source: ABdhPJyTbBEPTxsNv7WhA6YDtQz5c3O0kmktdUbyvXJt36jPXn25Qb5H17B3hYEEs3Bz3pwLYUOkfQ==
X-Received: by 2002:a1c:ba08:: with SMTP id k8mr11127633wmf.28.1592924776803; 
 Tue, 23 Jun 2020 08:06:16 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w13sm23154330wrr.67.2020.06.23.08.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 08:06:15 -0700 (PDT)
Date: Tue, 23 Jun 2020 16:06:14 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH v2] Stop vhost-user sending uninitialized mmap_offsets
Message-ID: <20200623150614.GV36568@stefanha-x1.localdomain>
References: <1592650156-25845-1-git-send-email-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="U8v/hV883cEE9JJG"
Content-Disposition: inline
In-Reply-To: <1592650156-25845-1-git-send-email-raphael.norwitz@nutanix.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--U8v/hV883cEE9JJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 11:50:44PM +0000, Raphael Norwitz wrote:
> Prior to this change, the vhost_user_fill_msg_region function filled out
> all elements of the VhostUserMemoryRegion struct except the mmap_offset.
>=20
> This function is often called on uninitialized structs, which are then
> copied into VHOST_USER_SET_MEM_TABLE and VHOST_USER_ADD/REM_MEM_REG
> messages. In some cases, where the mmap_offset was not needed, it was
> left uninitialized, causing QEMU to send the backend uninitialized data,
> which Coverity flagged as a series of issues.
>=20
> This change augments the vhost_user_fill_msg_region API, adding a
> mmap_offset paramenter, forcing the caller to initialize mmap_offset.
>=20
> Fixes: ece99091c2d0aeb23734289a50ef2ff4e0a08929
> Fixes: f1aeb14b0809e313c74244d838645ed25e85ea63
> Reported-by: Coverity (CIDs 1429802, 1429803 and 1429804)
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> ---
>  hw/virtio/vhost-user.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--U8v/hV883cEE9JJG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7yGmYACgkQnKSrs4Gr
c8jGCQgAsfDgSYJlS14g6FIBIco9/+A5fjN/eZKlpFKPeb3OCGY15I4RriyMzWAr
ELe80wovYoKcAfyXT4EslHIt0OXxQCBi4aRtH/XbTGG+eDdTd/f30q4q/47iFcoU
mjaZrf4mz11PEZX0tZ7H+qPLkd20RfJZTqhP8cgBJndKP2qeHMmtffgABmj0SRw/
EsiF9GIG40NeDmK9fr8dfONaJAS+65GfvoiDpbXSz2aXLpBVxT4pWH5n1UoXVOua
M4APv5egoYiIi32QJN+zhU5H7BYUiMa9iDCEd49c45nE5V9EOcCKWY/J0PGRqTgM
btmxc9Kk3I8MflSOT2XPrh6n051ruQ==
=wMjz
-----END PGP SIGNATURE-----

--U8v/hV883cEE9JJG--

