Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAEFC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928C42085A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnEzxzKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928C42085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60657 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLqqL-0003tZ-FU
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 11:08:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLqpU-0003X8-WE
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLqpP-00064L-15
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:07:26 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:34139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hLqoz-0005LV-VE; Wed, 01 May 2019 11:06:58 -0400
Received: by mail-io1-xd43.google.com with SMTP id h26so15071736ioj.1;
	Wed, 01 May 2019 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=3Z6DGwCQpGYfMCcsBq7/VlNUnGULfRlUtb0lybxTfR0=;
	b=gnEzxzKNZieokzjlGVwpu2Jnttsn1lcrmOsKu23DeoqBkIcPONKDCDDwN8mkmodIA3
	8yFFfYNJ/XbQ0fL4A7C9tJ2SKyrDtqcLCIkRFsuPKxL5O4LHEP8XVBtiRrKjbKUIfOhh
	Mi411sYNpAirQU7iwc3RidcvS8WF281WvHn4xVZuqruRBF/jvMx7AMvgv9TODzeqJsBh
	L+Y0NsJ+V5O9chbfeCmAe2gciltc1vr+2TZWM/hqA91RL+O1zwPVqvUiqGJZsSi03l/J
	+ffsNjW+gUwrLpkP1n0M+lFJ2hjJa5zAS8772pJK7czgbBTAczFzCF/5QMlQ5h7mAu+G
	msnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=3Z6DGwCQpGYfMCcsBq7/VlNUnGULfRlUtb0lybxTfR0=;
	b=i/uZzDBSdmhtUAbmKeFPLVgk8EeUUZk6ifw/2vFZNekg2mjEUzBwx01Yqoz7CO/pbt
	4adM2RVoUnfk4L6xmluzOSKpggyh1VZu5MX4uHzhjogMKkBsD9wg+lG6ofmE5crKL4dQ
	N2A1oqTR0PCpWU3VHJshMngSk6s2ntKz8j7f444UPBKM0U0Lwp79ynssDZGlC4Df36sV
	bBRUPeSJHUJKVLtvp5OSiZ677QXZAmlK4p9mTVSEZyxftdkiNYXQwKDL9keq13HvKO2t
	aDjsVCRdxNnI+gkzTC+1dRjI6RNUXTUf37GoreBHB3jgoleoW9Ue2fNdJCJ+bMSUwAV1
	wC6Q==
X-Gm-Message-State: APjAAAX5w5Fl8Tkj9RO4Kgwhn0E4Opuc1SIylaMn+G5nHAu6vMKJnjsD
	E4V2yHHVCR11cALPe+RSMAs=
X-Google-Smtp-Source: APXvYqwkofFS/e2hWWVe72ubXiLSQZedIE9gR9XPsYxtppJLqbvsXxYuEc7P0xsmze7eJmRcv1cBRw==
X-Received: by 2002:a6b:fd10:: with SMTP id c16mr33930371ioi.172.1556723202404;
	Wed, 01 May 2019 08:06:42 -0700 (PDT)
Received: from localhost
	(CPE64777d5479c3-CM64777d5479c0.cpe.net.cable.rogers.com.
	[99.228.64.175]) by smtp.gmail.com with ESMTPSA id
	t127sm3198015itb.32.2019.05.01.08.06.40
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 08:06:41 -0700 (PDT)
Date: Mon, 29 Apr 2019 12:13:31 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190429161331.GC13640@stefanha-x1.localdomain>
References: <20190429105741.31033-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <20190429105741.31033-1-kwolf@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qcow2: Fix qcow2_make_empty()
 with external data file
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
Cc: mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429161331.MyBXPOn3otffbfwKyiwbauL_Br6k607lK5SJQNJkons@z>


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 12:57:41PM +0200, Kevin Wolf wrote:
> make_completely_empty() is an optimisated path for bdrv_make_empty()
> where completely new metadata is created inside the image file instead
> of going through all clusters and discarding them. For an external data
> file, however, we actually need to do discard operations on the data
> file; just overwriting the qcow2 file doesn't get rid of the data.
>=20
> The necessary slow path with an explicit discard operation already
> exists for other cases. Use it for external data files, too.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcxyKrAAoJEJykq7OBq3PIU8cH/Rp4YpsMyrtD9O2KA5mvpEcB
JutWX3bfCQxwPfT49VwhL2beKHLoc4sLlh+t4K6kyB4TIoK/GHGQFKN9/La6waTy
yUg4YJ74O9Ir/Cny9Q+ht1HdqWJ/1FRPulNwJENwAQ4UbBp0vL3KrUe6VDX2aRgC
vSGnqlKE+IGJz+qHOWkIP3csgsyFWc7i7GCT9z11mP7LAjoZf8NETz2D53RoT2/N
/9gLXONIoAMpr+SJWUv/NUH60ZtDWYfDPwztYmziY5syHd0L4j3l29sT3aW+MFEH
c8qMctinA3E+JqIr0cs8/BSZLxkgBdRDIxa5S57haNf3b7XZx4XXDJfzXWCtKC0=
=pAiJ
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--

