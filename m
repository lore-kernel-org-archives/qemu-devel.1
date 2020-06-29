Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B907C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 142CD23D50
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMUvD0dt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142CD23D50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jptWU-0000qz-AB
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 09:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jptVZ-00080A-E7; Mon, 29 Jun 2020 09:07:37 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jptVX-0003Xk-NN; Mon, 29 Jun 2020 09:07:37 -0400
Received: by mail-wm1-x343.google.com with SMTP id l17so15335845wmj.0;
 Mon, 29 Jun 2020 06:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nkicVqB6AtB7pbMVd4jd3RpDBIwoeG3mvR00LkTjuIM=;
 b=nMUvD0dt8494UVYB0vbx8dvfy/ZA1RjS6V/VPfd1Lj0HBbeggJ7IJZjUb/e6bvJ5Vy
 PzQNHmhWokJBEg+am8V1iMM8D/xPYdTdaaJqIm6ycvx9GKOfpgfEgrZrROAu7q2HALUI
 nXY7eA25ZDbkkcWy7jLN/YyvcKpqIL/z3TFb4PFvwZ2QwKMR1qmVG19p3/hb85DUeY5C
 LveX29uXauff+PlhVpqKqgK0RcFhV/cmdwn4sqnLtF5vkCYH2rTxId6uMJ73/+GKzbFi
 sawpj6JfBEFHbVnBy9Sh1zO2ksCzGYmpc7OpfSohqvIWgS3rZfz3dnwLeL+AyZINxboX
 jE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nkicVqB6AtB7pbMVd4jd3RpDBIwoeG3mvR00LkTjuIM=;
 b=mJRsn21RTJc2YnmRhYVVv+X3hN/xKtnQP/BUkr+Yqfs2OLBVO7TLf3BH5xM2yuBQDL
 kfQxHniRi1PqWCkXlqYur0WeQuAzHU+7gRgEasQa9t/Z3qkwvfUu56kfUTy07aHyVsrU
 k67fmPiwZJxzIrgpZX9lS2IjRbMlg2/E2+uZtshsKw1dehlv38ABWQhslN8I6gumpcgp
 e2TehZZRQWRk/qmm82RA3U8HOKJo9EEaHceOk4Wf4lcudbcX+yLdGI4gPvLNZ9lRZs3Q
 qanFyY6RgW1imfEJagPTFckAhEvs40Dw6+fjBGAHI+6ii/aG5ka+pXLHHdCl7t97pKs4
 F57A==
X-Gm-Message-State: AOAM5330c1PD+QTafcGRAyRf22XzD8gQpqUXZ9tjHkdZ1o57mug5Wcg/
 szuuP/1qRw/q1Mr+2F+ArD0=
X-Google-Smtp-Source: ABdhPJzrV+lg0VArzolN7gP43KUqonuP52bfkqMDeiL/gfsqWvDHIlInLLeMFO+iWs0WJXK2r6fX5w==
X-Received: by 2002:a1c:c387:: with SMTP id t129mr9533353wmf.27.1593436053834; 
 Mon, 29 Jun 2020 06:07:33 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id g16sm46628199wrh.91.2020.06.29.06.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 06:07:32 -0700 (PDT)
Date: Mon, 29 Jun 2020 14:07:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 06/17] block/nvme: Replace qemu_try_blockalign(bs) by
 qemu_try_memalign(pg_sz)
Message-ID: <20200629130731.GK31392@stefanha-x1.localdomain>
References: <20200625184838.28172-1-philmd@redhat.com>
 <20200625184838.28172-7-philmd@redhat.com>
 <20200626122433.GM281902@stefanha-x1.localdomain>
 <65f87fc2-876a-6222-59eb-a17dd38986e7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uuKVzAmB+c+zQlhu"
Content-Disposition: inline
In-Reply-To: <65f87fc2-876a-6222-59eb-a17dd38986e7@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--uuKVzAmB+c+zQlhu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 02:48:55PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 6/26/20 2:24 PM, Stefan Hajnoczi wrote:
> > On Thu, Jun 25, 2020 at 08:48:27PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> qemu_try_blockalign() is a generic API that call back to the
> >> block driver to return its page alignment. As we call from
> >> within the very same driver, we already know to page alignment
> >> stored in our state. Remove indirections and use the value from
> >> BDRVNVMeState.
> >=20
> > The higher-level qemu_try_blockalign() API does not require all callers
> > to be aware of the memory alignment details. It seems like a
> > disadvantage to duplicate that knowledge throughout the code, even if
> > it's in the same driver source code.
> >=20
> > Is there an advantage to this patch that I've missed?
>=20
> This is required to later remove the BlockDriverState argument,
> so nvme_init_queue() is per-hardware, not per-block-driver.

Makes sense. Please include this in the commit description.

Thanks,
Stefan

--uuKVzAmB+c+zQlhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7555MACgkQnKSrs4Gr
c8iE5AgAx/5rGAko8z2nZ0xrkt9rZhe+HXfPLh+vfJ2UroX+IkFz6E5+GAY9195g
sQfVfb+ZdwvA7tnC/H3yHCclgn+8nX7zVfDFvyFsnFyZW9pYObwxpSu30F/uo3Ly
8FqNLLQga44sUn1WhSE4FoF62SoyQ6mItILEfmhRjDasO3rVSBJTT3hWopPUKTVF
R9JPci/vwnN6j8AKfsAqrFx1juedgdRBJsArmqljv4w/zxY9L9jOmyG71BS0Yr9g
0HKL9MTyMRBlMroWuIZGz9nRBqrGJV2dex/j5fhiau7QfYvG9uqz2tFGrw0Li5j3
RFa+rj4aeZ/MR4CfGTVfvsp4zccV1Q==
=3Tv8
-----END PGP SIGNATURE-----

--uuKVzAmB+c+zQlhu--

