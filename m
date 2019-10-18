Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C947ACA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977C4222CE
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF2FV5kU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977C4222CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLPCj-0002lK-PZ
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 06:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iLPC6-0002JF-Ji
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iLPC5-0007rd-La
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:09:14 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iLPC5-0007rG-FL
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:09:13 -0400
Received: by mail-wr1-x441.google.com with SMTP id r3so5606714wrj.6
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 03:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Jlq9FZcvZf1xuE9ojcvY5JlBHqwm16Z+6mIUoj9IPzM=;
 b=DF2FV5kUcyitm5oZPiUc2ykgH0BQy8b0fX7wXHXDgYvAiUuhxxBpi0KJsjt57Tpban
 0hWI8ILTGkrl4whQuwNi/QBoV5mApDPxyiAHGRV1CnkvBToqNfeId622UWt6dp2ps59j
 E8kBZKnkjAvuBxwj3SGQLonltN0a5hUowxJDk/4kIk6n2Wcx+wa7iXMrzK0tOBlT6nZ7
 VzfATyh4BcrKfAYrpvfXudNXU7hM/Xcs/PABv/8ZOgy22VAjyWaxa21oJavO6jLE0b6W
 OXxvJgCU56Sd60esaDUDQPbVRMgyaM0yo2P3CTmUiUwgQSJZEP2yJuVSpnFhSHvI9Hqb
 pkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Jlq9FZcvZf1xuE9ojcvY5JlBHqwm16Z+6mIUoj9IPzM=;
 b=XwK7lEpj0q2R7Ux+RyB5rY7bE6XPk3Z5t0SdfeXaYlROF2AwBlt+DtTmvCdnO/t3HL
 yuGHcH7t/dClgw/98tt/Kas8zAGHJnqOz0BWOs3KkaB/XCCjpVwRCdMTstd1qwuZRJjB
 swJVw1agFhI9HkmW61gPiHOclodINgW66jjHaw9jOE7Qpd9MQVX9as5GLBZCo78nIWtx
 3DEEcfEfUwilIEZRFvgcrMkO21GFo9wXq3zS/X5pmNBrrTahAf9R7IFQ2+X012WjCdDY
 CcowVCtzQ97zHqiciredLpfYMF6VjD8jyhF+qsPTvCFfpc/m8vAG4ntsg0hHA0mTWij5
 YoNg==
X-Gm-Message-State: APjAAAUv9QhktjQsE42NZ89bYP3gTVKx0DmYvgscmXJ25hqPy6cXoK2K
 s0iThbTgMFL8t6V3k8JjYyI=
X-Google-Smtp-Source: APXvYqyt9B0RBlUcRDg7Gx/W7jLab4kkuohNtIpTuUqeEzV5piRUdi7bKuBQaXI/1Vc4iRpRmJ7HyA==
X-Received: by 2002:adf:9c81:: with SMTP id d1mr6779098wre.238.1571393352116; 
 Fri, 18 Oct 2019 03:09:12 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v11sm4474454wml.30.2019.10.18.03.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 03:09:11 -0700 (PDT)
Date: Fri, 18 Oct 2019 11:09:09 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: Two fix for xattr operation
Message-ID: <20191018100909.GB9360@stefanha-x1.localdomain>
References: <20191016103754.2047-1-misono.tomohiro@jp.fujitsu.com>
 <20191017100528.GA24790@stefanha-x1.localdomain>
 <CAOssrKfR=sfE1RzOXzvPbdQg-g7i5-f8W9y8bWFnO=gyJ2VMsg@mail.gmail.com>
 <20191017160953.GC1266@stefanha-x1.localdomain>
 <CAOssrKejcfVWXw6Nu1owyEeofTdVp6BNx4bL91ma2g7bg9-nmg@mail.gmail.com>
 <CAOssrKdbAT5s=CYG6PBtE6OYdqgwG8vp9T6QMJpwZ7X3tKjPmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <CAOssrKdbAT5s=CYG6PBtE6OYdqgwG8vp9T6QMJpwZ7X3tKjPmg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: virtio-fs@redhat.com, Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2019 at 09:16:36AM +0200, Miklos Szeredi wrote:
> On Thu, Oct 17, 2019 at 6:48 PM Miklos Szeredi <mszeredi@redhat.com> wrot=
e:
>=20
> > Even simpler: allow O_PATH descriptors for f*xattr().
>=20
> Attached patch.  Will post shortly.
>=20
> However, I think it would make sense to fix virtiofsd as well, as this
> will take time to percolate down, even if Al doesn't find anything
> wrong with it.
>=20
> Doing unshare(CLONE_FS) after thread startup seems safe, though must
> be careful to change the working directory to the root of the mount
> *before* starting any threads.

Thank you for extending O_PATH, that's great!  This will be the cleanest
way to perform xattr operations.

If your patch is accepted I will send a man-pages.git patch to update
the open(2) O_PATH documentation (with a minimum kernel version).

I've added the unshare(CLONE_FS) task to my todo list in case no one
else gets to it first.  I may not have time to work on it before
Novemeber though.

Stefan

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2pj0UACgkQnKSrs4Gr
c8ihKAf9HtkKCMKQu3EvE+nGschLd/P5PZJdPs1o2ZmGG6yHO5lSlBMt8eNF5frd
58XBP5jHk/0ii88ZFSXYXcvm+MaMIuEPKTfZSKY91vkjmp45NGqkLeq83F1wMoXE
LDZCgba/h8ZTY6e/g0WrNUyNywUvqhOcvl7Fk9NfIjaMNtNl7U/IewiETe+ekY68
4WMdHFOCjqkmwZZ+VowJTtiofRWAGlqn98IJA08qE3jTTtONVGxNge/CmHqkihEa
oLLleTxItT++w1Vh0gvqQWLUPr/QQEy2ZyMr8zOuAy85mytJZu7XhFx15orpr6Ul
awL/0E+Ek2F1tDbq+PFNcAX4SwEnmQ==
=bw0r
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--

