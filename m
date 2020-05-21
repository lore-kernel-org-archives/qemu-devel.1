Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F4BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8BEB20671
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn6DIdip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BEB20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmOM-0008WS-3v
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbmNc-0007Qb-I2; Thu, 21 May 2020 10:41:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbmNZ-0001VC-UP; Thu, 21 May 2020 10:41:04 -0400
Received: by mail-wm1-x343.google.com with SMTP id u1so5777937wmn.3;
 Thu, 21 May 2020 07:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Qbn3/N8kDRpD+99kltHI4c1WJWGdJcjnxaBoVF5gZ24=;
 b=Qn6DIdipxdl3IRbPMOluX2OIFcJJPnogieCwAo1s0bMseonqHRFfmmPONuDFD8rPig
 mlGCqpjQE3cvZkN3ctJyA/LgGdsY5j03eaC3ChTXu5yOWRqKnDsiHgbqVWvseQsccYE8
 bWSz5rtlEb0ukAzSQdHXxo2wPQwbh6FYSabr4Q67sx/rP+xQN2nrmxSvYcbjlops+C+Z
 l1ZUMp/8LPahK8PzOQCtPLKt4+VNWLcnCcQTLKfnUTleRlT0xZXJEgiId42PxhwtZXaJ
 zQ5rCcaP1nORlyZz73ReyWGlts0fpSbZUkjCa/OGscus7K3H1n3G7KJDc4PV2+lUADc9
 EbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Qbn3/N8kDRpD+99kltHI4c1WJWGdJcjnxaBoVF5gZ24=;
 b=j9eYDc+H/XZjLIEXg8fGvjddIizHEbtGNznXRgFyiCg1kICF1kuYiV84cdMbam8Zcj
 /p/Hv2bMzbAIt5DAOoICDe67CEmY2z6QO8SY5NeW+WgzPzHVR7kU0fpo63E2FHmTzXmn
 QDlRH5tURBxqVZUJK0KdmK74i+RtdN4q8LlCtyBdikQigjVFN7x7m/N8CcjnVZdLYZQt
 LuHPjueCRWc3dW/0ng8P868YGHFfYIpyBAF1J6G0Tid+tHVWkBrBLcSBexTS2RzttzGS
 O6qKWIBA23q60dYvfddeOwsql9C15o897Qdm01vvXmITDOAYw0sB2Sw4YVEO6GXa7G2y
 8rXA==
X-Gm-Message-State: AOAM530u96+Ir3BXV/UTbJYHLito3P6V+hEyyy/xXiAfaKOqFYgPpq3D
 5SQFvAIQBUFsiGsfTIVv3iR64SwxHKk=
X-Google-Smtp-Source: ABdhPJzSBTZfPXo7AvhV1w2lzJY1zv/xQvg+PcLwJQmKlIm3rO9iE6g0qvbfwjOj002x8w5QQhdRgw==
X-Received: by 2002:a1c:c38b:: with SMTP id t133mr8944280wmf.31.1590072059983; 
 Thu, 21 May 2020 07:40:59 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 40sm5470963wrc.15.2020.05.21.07.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 07:40:58 -0700 (PDT)
Date: Thu, 21 May 2020 15:40:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] io_uring: retry io_uring_submit() if it fails with
 errno=EINTR
Message-ID: <20200521144057.GM251811@stefanha-x1.localdomain>
References: <20200519133041.112138-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L/bWm/e7/ricERqM"
Content-Disposition: inline
In-Reply-To: <20200519133041.112138-1-sgarzare@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--L/bWm/e7/ricERqM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 03:30:41PM +0200, Stefano Garzarella wrote:
> As recently documented [1], io_uring_enter(2) syscall can return an
> error (errno=3DEINTR) if the operation was interrupted by a delivery
> of a signal before it could complete.
>=20
> This should happen when IORING_ENTER_GETEVENTS flag is used, for
> example during io_uring_submit_and_wait() or during io_uring_submit()
> when IORING_SETUP_IOPOLL is enabled.
>=20
> We shouldn't have this problem for now, but it's better to prevent it.
>=20
> [1] https://github.com/axboe/liburing/commit/344355ec6619de8f4e64584c9736=
530b5346e4f4
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  block/io_uring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--L/bWm/e7/ricERqM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7GkvkACgkQnKSrs4Gr
c8hxpAf8DSucS8cjD26Tx4em+qi4Rm3s52Z5jUntet/F/c0YJcgagACxnpwFRp8O
+mv4+QwA2yGLa0KGXH08hdMviqDv89rL7SebcuGjhsUrAyNrzQXt9nvUEwQFXOX0
1jJR81uqPWQdmeAjTioxkHcA6/+0xEZvgP/i8eHrHxnafnFQ/eHn6GnEMHOweI/x
zRBCpk2hfFSrC90fHdHfwIa6Er3fQh4F88x1gz8zBjFE37ewSVdem46QbPiYhBKh
frrzHwZF6VVzv+gfAuN2+HIPkKv6c02Sza7HFm3V5iJoi805JjCmiUx+zyEkPLLf
OTwddXZ+gtcBXS3grfbD3fqZA/riwQ==
=A0Yr
-----END PGP SIGNATURE-----

--L/bWm/e7/ricERqM--

