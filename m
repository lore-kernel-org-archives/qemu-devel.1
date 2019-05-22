Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3373DC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A002089E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgP3qbR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A002089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43029 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTQzw-00060A-7V
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:09:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTQxn-0004uN-8e
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTQxk-0003eZ-3H
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:07:21 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hTQxg-0003Y8-FS; Wed, 22 May 2019 09:07:17 -0400
Received: by mail-wr1-x443.google.com with SMTP id f10so2224772wre.7;
	Wed, 22 May 2019 06:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=ZnqaMVXz43BKpvV6zX7vzHgO05RW4CoKSBB2FDGReDY=;
	b=KgP3qbR4ipJI3GJrmrqUth7StlphsNceyI06MmDbbxI3LXcb2CNnx1azv+AnOvxAUN
	g1YB3TF+FM91HPjftol8rNBM6je00F/YDSHj8cgAltL4J80YPFuUN19cOKVZEUUxQlSx
	6u5B8XLWAjYoBOwVJAWN3d9WEAtdpKO8Y5SFTVR40/hULUCYr434RIl0TzsitigeHY+r
	mYmahzgnGEd3pxP/FumnSHYSpGeWR+ZI9mJa/qJKZTP+k2DfwoAIh5heVXsV4ip/d6vS
	YQ0MZWJy52vfdLNrUf53HPzxTciKn+mfbiNX/mIXe8ayV9uvTQ9yCSsSNN6iUFEsMRKK
	kWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=ZnqaMVXz43BKpvV6zX7vzHgO05RW4CoKSBB2FDGReDY=;
	b=eUz8SWdxXhnKAcswiTAZF3mkR6X5xWrP3VDi0AhcEWjMMJtr+0acGg2dVU0WDXJgOI
	83A3JHeKWMuw3K777dsfQfMXlb7gUi8mnBy+D+7VqBbMuqNFZoyD3lgihf4YdjNxe5gq
	QfL84AlhAE4qlxB5mdTNMdeG1VidkZTyqtgA3vS+xKY4Jk1/TbVy3kZQ4Yu3/tzR39Au
	CU6Yo7nyRQemuu3EqZOaU68dZFbdk0S6e2Qc2xiu+teIRnbdSHfjeloCjKPFgordFVPI
	8fAp7cEDWEw8op6H4bEiqPBqP95fJKQtjrmPbwqI7m7lu664d7MFL50eGRCHAf2kQgv4
	PLJQ==
X-Gm-Message-State: APjAAAXqyM6BbCoTotmzxcdG9FNe4fanwM7RKkslhcuYpYTwFMgeK66f
	p4efV3x7Csya+Np+zAIIOjI=
X-Google-Smtp-Source: APXvYqz2iVUS6qUkfCetm5cBEZ4MqzgJeHgvONM3d52iyWz9d0OIZfE+bcx2TPtS0wlaiHSBXc+Y3A==
X-Received: by 2002:adf:e2c8:: with SMTP id d8mr1921783wrj.14.1558530433342;
	Wed, 22 May 2019 06:07:13 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	i17sm25524488wrr.46.2019.05.22.06.07.11
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 22 May 2019 06:07:12 -0700 (PDT)
Date: Wed, 22 May 2019 14:07:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190522130711.GI27900@stefanha-x1.localdomain>
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
	<20190521235215.31341-2-mehta.aaru20@gmail.com>
	<d932237b-03bc-5dbb-17dd-bcca5ce121c8@redhat.com>
	<1c277edc76e47fbbaae0ecdd6774e24ac9a94ee5.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ijf6z65S790CMqo8"
Content-Disposition: inline
In-Reply-To: <1c277edc76e47fbbaae0ecdd6774e24ac9a94ee5.camel@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [RFC PATCH 1/9] qapi/block-core: add option for
 io_uring
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ijf6z65S790CMqo8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2019 at 06:21:51AM +0530, Aarushi Mehta wrote:
> On Tue, 2019-05-21 at 19:39 -0500, Eric Blake wrote:
> > On 5/21/19 6:52 PM, Aarushi Mehta wrote:
> > > Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> >=20
> > Sparse on the details. The subject line says what, but without a
> > 'why'
> > for how io_uring is different from existing aio options, it's hard to
> > see why I'd want to use it. Do you have any benchmark numbers?
>=20
> For peak performance, io_uring helps us get to 1.7M 4k IOPS with
> polling. aio reaches a performance cliff much lower than that, at 608K.
> If we disable polling, io_uring is able to drive about 1.2M IOPS for
> the (otherwise) same test case.
>=20
> More details, and the source for the above is at
> http://kernel.dk/io_uring.pdf

So that Aarushi's email isn't accidentally misquoted later on:

These numbers are not via QEMU.  QEMU is likely to show different
performance results and they are expected to be lower due to
virtualization overhead.

Stefan

--ijf6z65S790CMqo8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzlSX8ACgkQnKSrs4Gr
c8hV5Qf/UdTURfM7bX1PGAKxvuavlbfyXByTiXivTpDkdMG9lsgul5MkwvorU2XY
S9ViUDq61ag5uiVEdNYGd4x2XM52oukwbJxaDQodGq00QnU+kZL9aIc8d48v+C/u
lSK7Gjo11vHS+yqEKMue5ebvG4d1/depnUdGTaiE6QOasqBof8f92FQNHw+SwKK2
kOSRmHKZH36xH3gh+vnVhTsuKJ5J4uX6fkQmIwaBHVVfsiCb0XzKYoJ6atG4qdAR
95QStCwkhIh+oLcYAswJ/U6APpB4K4wBaF/TES+1mGZ0IbgUgcBX1vN8UN/2QJF+
Hh+PfEnJXJlraNuaveb6IbY+UAUrbQ==
=vb+E
-----END PGP SIGNATURE-----

--ijf6z65S790CMqo8--

