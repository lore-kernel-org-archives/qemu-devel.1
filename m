Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9922C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F972075E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ok2dtSmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F972075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpuKZ-00039y-Pb
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 08:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48719)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hpuKP-0002lJ-Pi
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hpuKO-0002gJ-IR
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:55:37 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hpuKO-0002fM-BS
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:55:36 -0400
Received: by mail-wm1-x341.google.com with SMTP id v15so38463027wml.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 05:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=TcIOA9nGtrxVq0wmFVORI6Ct3ZOsmSmnIe7al7fJBcM=;
 b=ok2dtSmwRW/7e4d0qUuLjF0iHGdwvo9B3EkyiwAhFWM/sQWV1bqtUNkuwsg9vgEXiw
 HqnsjwVLwtlg0OSuWDm/TIB6G2agmMPeibDyQnENUVjWEgtPybfi+WFNucoKLt3zuQ36
 Fnot/oBlTG0xSd5YoIM27LOV6Zca5iLSHmofzRxlLKnaxx0AXN2sDhDPxLHNLV+VubSU
 7JkrtQoQYb81zseq/i6cX3OyhCTLNnqFTXnmRBuE8UzyfxzEDu/WeApInUBtLXtFW9Ns
 jNtzCkbLwUnQZqWX1zw8ITCrVFcZK1lKkTHeXXZ64i3p1QZUWwdTRDfwSCVYLPj64j1b
 +KXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TcIOA9nGtrxVq0wmFVORI6Ct3ZOsmSmnIe7al7fJBcM=;
 b=OJy3+Kmfei50Mkn/U8hH0PF9K5wjOERJUV1/XJ7srfoHv2vKDq9smcmpHpnlACjqhE
 CDPN/o4nJHs2j+8OyH58yXy8FTi71wG6PMI7TfUWK+0Y3b1G1IE5aGjsY40IehxO7rOA
 38wdQMreZFNzxUk0ACGG9iLjRuQrYacUIyjur20fNJtVU9Wr+O3B0qYB2A/nr92oXllT
 39PGV+CgVPCOTtUlTMYERheme5pUvbpDmKGsPBMcPbqIHEa0zeIA4LjN/91C9/jzxG8Q
 ElY04CAwbsK51rCaBnPiIm356EhZ/xVRcWqcmWprmOyBosalbYoqPn20VB+hKIgjcICa
 TaTg==
X-Gm-Message-State: APjAAAXIzhOzjBX32kPsSaXvbDiYXnBptJ9Ylnr9KZO94qhUIENCyajV
 lrhF72vV4uADd/Oo37FrLM4=
X-Google-Smtp-Source: APXvYqzX/JX5+oUj62IRIr5RxXFCRA5deJNU6/iZ4FeYOggvOJTeNJEV5mNFMX9NEE35aMFKLozEXw==
X-Received: by 2002:a7b:c251:: with SMTP id b17mr70967429wmj.143.1563886535047; 
 Tue, 23 Jul 2019 05:55:35 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x20sm32421732wmc.1.2019.07.23.05.55.33
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 05:55:34 -0700 (PDT)
Date: Tue, 23 Jul 2019 13:55:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190723125532.GA5445@stefanha-x1.localdomain>
References: <20190722132344.30798-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20190722132344.30798-1-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Avoid sending zero-size packets
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 01:24:44PM +0000, Oleinik, Alexander wrote:
> While fuzzing the virtio-net tx vq, I ran into an assertion failure due
> to iov_copy offsets larger than the total iov size. Though there is
> a check to cover this, it does not execute when !n->has_vnet_hdr. This
> patch tries to fix this.=20
> The call stack for the assertion failure:
>=20
> #8 in __assert_fail (libc.so.6+0x300f1)
> #9 in iov_copy iov.c:266:5
> #10 in virtio_net_flush_tx virtio-net.c:2073:23
> #11 in virtio_net_tx_bh virtio-net.c:2197:11
> #12 in aio_bh_poll async.c:118:13
> #13 in aio_dispatch aio-posix.c:460:5
> #14 in aio_ctx_dispatch async.c:261:5
> #15 in g_main_context_dispatch (libglib-2.0.so.0+0x4df2d)
> #16 in glib_pollfds_poll main-loop.c:213:9
> #17 in os_host_main_loop_wait main-loop.c:236
> #18 in main_loop_wait main-loop.c:512
> #19 in virtio_net_tx_fuzz virtio-net-fuzz.c:160:3
>=20
> v2: add details to  comment for the change to qemu_sendv_packet_async
>=20
> Alexander Oleinik (2):
>   net: assert that tx packets have nonzero size
>   virtio-net: check that tx packet has positive size
>=20
>  hw/net/virtio-net.c | 15 +++++++++------
>  net/net.c           |  9 +++++++++
>  2 files changed, 18 insertions(+), 6 deletions(-)
>=20
> --=20
> 2.20.1
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl03A8QACgkQnKSrs4Gr
c8h7eQgAnhrHRu1MMJMo/jS6giCQ9OTL/Xb30Rxqi5YshqSQdTwzEu3Jyqd7uCII
/PWrY8XTIGnpoWS1EyHWKq3/+UB5Qzi7lHE2yInaUJK83lPSeeb3Dmi2U2v7eDu9
zfigkxhpZFCXatwKwq6JOVNd6rnRUg7rZW/7ZoN5t6pYXU9wtWZyRPI2oY6ZcRuC
1gjK4hEXCUQEFK3VQiqkb7KvYC/bn9MKsSCypgcH1nrcsnU10A7nhFxZ/4mVtXKI
LBYW83LHUjfa/bRiV0hdnPWG++GEqnZ1gqVWnDRRyRlKsV6zLrqO9tY8/3qYOfj4
tkXX0fAZItv3bKUhOg0bvbxsBolw+w==
=j9/+
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

