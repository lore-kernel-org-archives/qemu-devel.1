Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE396C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 14:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7756C20818
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 14:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJ3s+09+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7756C20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32775 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEEdy-0004m6-F6
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 10:56:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEEcm-00042U-F4
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEEcl-0008EC-Aa
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:54:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hEEci-0008C3-I5; Wed, 10 Apr 2019 10:54:48 -0400
Received: by mail-wr1-x443.google.com with SMTP id y13so3359790wrd.3;
	Wed, 10 Apr 2019 07:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=oQ2jwaqugorts+WPSxD3ShCdkBPE9FILfqIx5QHq95I=;
	b=sJ3s+09+GZHIWrMZKnWLJzlFDmUJUh21T5dC5d99xn+lCmAlaa1GFpjxwIALX9Ja92
	IOPHC3jOicq3QhVMRFSKb9d0Xmpaxnx5Pf+/DNGT1msSXDNyNDRp3AxwYIFBsLM1okKj
	lfOuF1obE/yD8ihX2ye530XjVyCynAB6HzZtgLjdwx10aPNwR1sJmT6PsOJxEm53hCef
	4lqSoifOTKBWNPrA2hu22ZZEYASUTDL0imvj05S2wJs0Svc6/O3MH1qkBi6KJwGAXBOj
	/QYo4zuxR9yQkhsy6FgY0MTnoyemJMG/xTFVEDmhVlavRd+xiU20/TvBtbi3G0tO30zF
	2ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=oQ2jwaqugorts+WPSxD3ShCdkBPE9FILfqIx5QHq95I=;
	b=VJbKt9gn7nl/TZh9zzxhQ+9EaP6lRvhrFRBmlGOSY4DuN8SXhSJlw8XO+yB7adcoYP
	i27gyJdwFxGuXoPn+GdHzABL9hfMH06DTxWhfIUWNP5BDLOAjuo8Rau28zkhTIgAlgLn
	KPqoDyI0nisgxyRvDOexVgdYiOjNBkjOxK6Za4wm1GBdAhKXtuj6q7wibn7FQnmab8dj
	2NVqtgYw8k99dUvZCYgrOleJtSKsXKUlwgcZAAPITIFkve4SjYftwTVdkInfxck8bbfP
	k1SC4nu+AMOGerHZcqZjWHhUNp4cP6l4uVruSpUb5qhaD1GVM3xC6U33abyvjXdYqyWx
	Bjjw==
X-Gm-Message-State: APjAAAXQhCaurKm8N0EVynd8KAMCyMn4PZBkdbfjf5k3l92AjXQHSO1u
	+MYXJZcagAhBXRvnwSUezKU=
X-Google-Smtp-Source: APXvYqxMjhmWdmnkfYY03NmkZ0/JyoW9cWkoivrnwnUF5zXGmM79o7GkdHp5lQdrhob2Yexu3Jl7Aw==
X-Received: by 2002:a5d:530e:: with SMTP id e14mr24906411wrv.18.1554908086886; 
	Wed, 10 Apr 2019 07:54:46 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	p3sm53598956wrx.71.2019.04.10.07.54.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 10 Apr 2019 07:54:45 -0700 (PDT)
Date: Wed, 10 Apr 2019 15:54:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190410145444.GA11035@stefanha-x1.localdomain>
References: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<ad53e61a-a911-c019-3f68-2bd05b7be944@redhat.com>
	<468cc6c9-c338-a4fe-57b1-b4df5b2b24c0@virtuozzo.com>
	<20190408100442.GA11997@linux.fritz.box>
	<20190408101449.GB11997@linux.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20190408101449.GB11997@linux.fritz.box>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/io.c: fix for the
 allocation failure
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
Cc: "fam@euphon.net" <fam@euphon.net>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410145444.D1e4IyN2cI_cd2rZGpOgphF3HOXcAHhr-K1TKPkJo4E@z>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 12:14:49PM +0200, Kevin Wolf wrote:
> Am 08.04.2019 um 12:04 hat Kevin Wolf geschrieben:
> > Am 08.04.2019 um 11:44 hat Andrey Shinkevich geschrieben:
> > >=20
> > >=20
> > > On 06/04/2019 01:50, John Snow wrote:
> > > >=20
> > > >=20
> > > > On 4/5/19 10:24 AM, Andrey Shinkevich wrote:
> > > >> On a file system used by the customer, fallocate() returns an error
> > > >> if the block is not properly aligned. So, bdrv_co_pwrite_zeroes()
> > > >> fails. We can handle that case the same way as it is done for the
> > > >> unsupported cases, namely, call to bdrv_driver_pwritev() that writ=
es
> > > >> zeroes to an image for the unaligned chunk of the block.
> > > >>
> > > >> Suggested-by: Denis V. Lunev <den@openvz.org>
> > > >> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> > > >> ---
> > > >>   block/io.c | 2 +-
> > > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/block/io.c b/block/io.c
> > > >> index dfc153b..0412a51 100644
> > > >> --- a/block/io.c
> > > >> +++ b/block/io.c
> > > >> @@ -1516,7 +1516,7 @@ static int coroutine_fn bdrv_co_do_pwrite_ze=
roes(BlockDriverState *bs,
> > > >>               assert(!bs->supported_zero_flags);
> > > >>           }
> > > >>  =20
> > > >> -        if (ret =3D=3D -ENOTSUP && !(flags & BDRV_REQ_NO_FALLBACK=
)) {
> > > >> +        if (ret < 0 && !(flags & BDRV_REQ_NO_FALLBACK)) {
> > > >>               /* Fall back to bounce buffer if write zeroes is uns=
upported */
> > > >>               BdrvRequestFlags write_flags =3D flags & ~BDRV_REQ_Z=
ERO_WRITE;
> > > >>  =20
> > > >>
> > > >=20
> > > > I suppose that if fallocate fails for any reason and we're allowing
> > > > fallback, we're either going to succeed ... or fail again very soon
> > > > thereafter.
> > > >=20
> > > > Are there any cases where it is vital to not ignore the first fallo=
cate
> > > > failure? I'm a little wary of ignoring the return code from
> > > > bdrv_co_pwrite_zeroes, but I am assuming that if there is a "real"
> > > > failure here that the following bounce writes will also fail "safel=
y."
> > > >=20
> > > > I'm not completely confident, but I have no tangible objections:
> > > > Reviewed-by: John Snow <jsnow@redhat.com>
> > > >=20
> > >=20
> > > Thank you for your review, John!
> > >=20
> > > Let me clarify the circumstances and quote the bug report:
> > > "Customer had Win-2012 VM with 50GB system disk which was later resiz=
ed=20
> > > to 256GB without resizing the partition inside VM.
> > > Now, while trying to resize to 50G, the following error will appear
> > > 'Failed to reduce the number of L2 tables: Invalid argument'
> > > It was found that it is possible to shrink the disk to 128G and any s=
ize=20
> > > above that number, but size below 128G will bring the mentioned error=
=2E"
> > >=20
> > > The fallocate() returns no error on that file system if the offset and
> > > the (offset + bytes) parameters of the bdrv_co_do_pwrite_zeroes() both
> > > are aligned to 4K.
> >=20
> > What is the return value you get from this file system?
> >=20
> > Maybe turning that into ENOTSUP in file-posix would be less invasive.
> > Just falling back for any error gives me the vague feeling that it could
> > cause problems sooner or later.
>=20
> Also, which file system is this? This seems to be a file system bug.
> fallocate() isn't documented to possibly have alignment restrictions for
> FALLOC_FL_ZERO_RANGE (if this is the operation you're talking about).
> FALLOC_FL_PUNCH_HOLE even explicitly mentions the behaviour for partial
> blocks, so there is no doubt that operations for partial blocks are
> considered valid. Operations that may impose restrictions are explicitly
> documented as such.
>=20
> So in any case, this would only be a workaround for a buggy file system.
> The real bug needs to be fixed there.

I agree regarding the root cause of the bug, but the fallback behavior
is reasonable IMO.

Andrey: If you update the patch with a more specific errno I'll queue
that patch instead.

Stefan

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcrgO0AAoJEJykq7OBq3PINnIIAKa/FHkhOU/Ig9ItoT/P43Sf
IvgoBgvK4A4evNGF+wYDPhTTS+pwXvdstPNu/CgKTeOHAXK2UasgC3gmoBc4TvMR
CaK6eqtpIT83bk6ef+6JROOCJguWh6MxtLOUs4l9q4PJG9AMQytveaPrag42pFzC
CxNc1YaDzkRxgDqiWYVI0hXgi3d79C00e5SzUpn4rwRDeGGpbUOnP9WCRvITiyTF
0xv1hIoPB6dH+bpssjjgBcanIUYlwicwS8sbUeZGTWpCswOsrI88BEIU+jPtCDny
+r1Ftwm9x4COrnExIIp/OuyzDCrInq4PWA8lBVv5TwS8Q6+LAuSFjKw5EQYy0/s=
=4zWi
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--

