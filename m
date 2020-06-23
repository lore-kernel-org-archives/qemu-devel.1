Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EDCC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:35:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66F420738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="of4exNtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66F420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jni96-0005l0-4Y
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jni8N-0005Ll-5L
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:34:39 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jni8L-00065F-Ew
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:34:38 -0400
Received: by mail-wr1-x443.google.com with SMTP id z13so8580346wrw.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 05:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=aWLx0vDnHHJFIlEay8gfSFe3fMfW8vak8CzFumn1GyU=;
 b=of4exNtkalEjvs0WMX5I8+mq0xGHSWQcwMBtTsD3Uh1HW2BLiah+Kuzo7VnCuN069B
 zmwjRuzaE8LPuFPdTZ1k1c99nrojKWaDGs/Kq4ueWTfuQGGhGLNS6pReytbwVsdWjX4C
 8152HEqDBw3J1+ogtQO4KK1q+S6vpJYiHsd4T8xEWnuOHTumxoaRinwTFhrzE/ElazGN
 qdR4L+1EGnABkM2/KIdSqIQenFF3Hn+a+OQ459QFOFLBVTaQnPN9KwNA9w8gqpnyVzCK
 gCLqnmJkj57tCPfTh4cLBjFZrWTTVrGah2+ab4LSHHPbjI64Zmg1W5S1Y7i4nlzwMnSi
 pfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aWLx0vDnHHJFIlEay8gfSFe3fMfW8vak8CzFumn1GyU=;
 b=H0bHiTxDcD2o0dVYfjoyaNUxGxO9/Xq97SR1jn+WU5QF1HlUDApSC1aw9kW3bxEEI+
 n2xZBwPvBhEfwzvaK3XrxAn/Me4AgCGf7017dZfkKejLdZ5xW9ya4FK4mFmwNI+AcrCB
 M2xGPeIbliEgz5u1+QfA5Nrt/pjJ3QN3aR4T/wTmJrcVeew8TFnpXo7E3qWGqWvL3g6r
 Y/kSMg79Hf9TaZhFCuSOkbFvnby4JAsP1rFlWiRU7YID4BseIUnbQzFdV6JmN1h3UPfF
 aAorY8zJQlX+y/1cPRZw+VObdP34M8K4AXCod5I4MwUKrudeR17ZSiTsYQau45KEdWG1
 Dcew==
X-Gm-Message-State: AOAM531cNSD50q+cJXAjwtAOtk6U8mzgIli4NgnKFPwvWBBFMvP2ynIO
 mZ36sOR7S6Sgz0zyojtYR/DKwJb+
X-Google-Smtp-Source: ABdhPJwsD6UUg+/amn00oMDGHO6Tox0394d0BirJvXTtyqErAxWyWQsA52ZEHutQSrX1z1Ul3m9MkA==
X-Received: by 2002:adf:f08b:: with SMTP id n11mr24220012wro.312.1592915676008; 
 Tue, 23 Jun 2020 05:34:36 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o10sm22233515wrj.37.2020.06.23.05.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 05:34:34 -0700 (PDT)
Date: Tue, 23 Jun 2020 13:34:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Colin Walters <walters@verbum.org>
Subject: Re: [PATCH] virtiofsd: Use clone() and not unshare(),  support
 non-root
Message-ID: <20200623123433.GG36568@stefanha-x1.localdomain>
References: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
 <20200602095547.GD9852@stefanha-x1.localdomain>
 <7b355ffb-2b96-4984-a198-ac40a07c422e@www.fastmail.com>
 <20200617125014.GC1728005@stefanha-x1.localdomain>
 <add0c8d8-7214-4976-83f1-b06071682837@www.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NPukt5Otb9an/u20"
Content-Disposition: inline
In-Reply-To: <add0c8d8-7214-4976-83f1-b06071682837@www.fastmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NPukt5Otb9an/u20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 08:55:36AM -0400, Colin Walters wrote:
> On Wed, Jun 17, 2020, at 8:50 AM, Stefan Hajnoczi wrote:
>=20
> > Something along these lines should work. Hopefully seccomp can be
> > retained. It would also be necessary to check how not having the shared
> > directory as / in the mount namespace affects functionality. For one,
> > I'm pretty sure symlink escapes and similar path traversals outside the
> > shared directory will be possible since virtiofsd normally relies on /
> > as protection.
>=20
> Yes, though two points:
>=20
> - As I said, I don't care about that for my use case; the operating syste=
m we're testing is going to e.g. run on bare metal hosting workloads itself=
, so if it's malicious we have already lost (reliability against *accidenta=
l* damage is always nice though, like a stray rm -rf in some test script wa=
lking into the host)

It's not just for security, it's also for functional correctness.
Have you checked what happens when absolute symlinks are accessed?

If we're lucky well-behaved clients use FUSE_READLINK before accessing
path components. Then the symlink resolution happens in the FUSE client.
But if not, absolute symlinks will access the wrong files (oops!).

Accidental race conditions are possible too, especially when both guest
and host access the shared directory tree.

> - Probably the best long term fix would be to use https://lwn.net/Article=
s/796868/ anyways

Yes, I think this is a requirement for achieving correctness without
pivot_root()/chroot() due to the issues mentioned above.

--NPukt5Otb9an/u20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7x9tkACgkQnKSrs4Gr
c8hf9Qf+Ls6K7uBvu4uTUPt4O7wsWxx1hm44yRBhUb2jSh7rsnqGMYYhBMLFjxFP
W3x/fGQH45B6GulctksGwxMgbKPwqK2nnTrOOX4xO4AofCLwMq82ECKUMxnhnHgx
PcuD3UJcYjKGXrLbZ7iWVvLKKCFO1jKhOv4UKmQVNtJ0QUSgSkKVxv+LO4UJ2Rq2
E8PJQa3raXNigHjBlFjyNeC/n2ZNItXN2cGHxL5hKXqRfVw1aVX+DCL2esnohLUb
rZVhyPSb3lCAjOVmGI3pvQ9CRi7exAeMHld7OYQ0iaO+D/QHBlg6MbEObmphz8tc
wJe6AGg8dJgFlXNEOg+NGk20cXXPDA==
=LJCp
-----END PGP SIGNATURE-----

--NPukt5Otb9an/u20--

