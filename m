Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C597C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C413B20872
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLX2kqsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C413B20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJCyU-0006Oo-JR
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 05:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kJCwx-0005lg-0p
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:45:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57959
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kJCwr-00070T-EQ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600422296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jvNrSGVjThtKc87/xpS8AH+Tfv2lE7mOI44q/2+iNKM=;
 b=fLX2kqsxkZaCiy2xOa3pYYQDsc4at/j6WOFfV7p8S06oOuzgrswqHgUJ9Y0UkMZ5XTGD21
 WgdsMau3smdR4h4NmwzV0zNbdqWoXjCk5lFHwFNtTitCXlDJXipHsSvTiWzzxzYgF6Ug1J
 Ez5fnZA7pRgDrdof+jr0Bb+SJQUnmyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-Zr3a78eQMju3olpJdrMAOQ-1; Fri, 18 Sep 2020 05:44:51 -0400
X-MC-Unique: Zr3a78eQMju3olpJdrMAOQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F16F1084C84;
 Fri, 18 Sep 2020 09:44:50 +0000 (UTC)
Received: from localhost (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0862A19D6C;
 Fri, 18 Sep 2020 09:44:49 +0000 (UTC)
Date: Fri, 18 Sep 2020 10:44:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v10 5/7] block/export: vhost-user block device backend
 server
Message-ID: <20200918094449.GA867958@stefanha-x1.localdomain>
References: <20200918080912.321299-1-coiby.xu@gmail.com>
 <20200918080912.321299-6-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200918080912.321299-6-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 05:23:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, "open list:Block layer core" <qemu-block@nongnu.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, bharatlkmlkvm@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 04:09:10PM +0800, Coiby Xu wrote:
> +    case VIRTIO_BLK_T_GET_ID: {
> +        size_t size =3D MIN(iov_size(&elem->in_sg[0], in_num),
> +                          VIRTIO_BLK_ID_BYTES);
> +        snprintf(elem->in_sg[0].iov_base, size, "%s", "vhost_user_blk_se=
rver");

gcc (GCC) 10.2.1 says:

../block/export/vhost-user-blk-server.c:178:50: error: =E2=80=98%s=E2=80=99=
 directive output truncated writing 21 bytes into a region of size 20 [-Wer=
ror=3Dformat-truncation=3D]
  178 |         snprintf(elem->in_sg[0].iov_base, size, "%s", "vhost_user_b=
lk_server");
      |                                                  ^~   ~~~~~~~~~~~~~=
~~~~~~~~~~

I suggest changing this string constant to "vhost_user_blk" for now.

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9kgZAACgkQnKSrs4Gr
c8gExQf/RVyjsgIbNgoSh60yQZuk6FpeDwSAiPmNBb/GXWAuB16m29nhwWMuED4t
jiFvkiW8ByyllxhF0+YJZDHmNn48uPTvEzZDGbKf6DVAneoAi8CNcioFUh4Ec29/
mGHGWBnCZl6LbATlZe+iwb3kfuG+n9GGQ1GrVaDS1JmxXpRNqy7S53f7rGw/BVhF
RLH9Oz8I+cjubSJsQrEw9N3D8yYNBJa0gnkLQBUh8gMCD3VBVdRuiKsGAlCnTmqq
IumV9uX8kSt1wr2CHPFc7zdu4r2ooExjLunYpDvecEPjIS1fQYV6Isyh8Boi0YvI
eU38iG5IKt71HN9DKeB9RW4W4D8L4Q==
=LQfE
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--


