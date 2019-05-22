Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42863C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1125B20856
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz8Xj3XU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1125B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40085 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTOr9-0003Bt-Ay
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 06:52:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTOn7-000186-Ok
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTOn6-0002Ig-Qy
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:48:13 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:37142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hTOn6-0002Hn-Hs
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:48:12 -0400
Received: by mail-wr1-x430.google.com with SMTP id e15so1739142wrs.4
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 03:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=lGShna3XuYd+KBcAzAIqDjRt5KtAM5vXw6vBvhBjCk0=;
	b=Qz8Xj3XUp7tWG94MwibVwcPR5gywD0MOUi2YK2vMUW7PQohkHPDL2cCuQNQS22AzH4
	CdSKtCNp10XalbZhAsREYZlfE/XdtaX8qIbPLjY2yXiXSikXY+OBy1LvKmh0DpdoAFdC
	us9i/c3HBDcJ0W5rNv7nSaBGGjc1xvMKaY14OcngmxxCuQdJJdk4zD+NEtO27tkbGFwn
	eSAr814BF9i0rbB6wfMaUzJiw7eCuvQx56OetefiLmjcPT6NpsOf50KZ5g4HifddE2d3
	XnE529cGyoy13HYO49X61pDbuHWUeo7qL5KKOS31Qy1inMxD1romaDONflw3bTY/Onq6
	MXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=lGShna3XuYd+KBcAzAIqDjRt5KtAM5vXw6vBvhBjCk0=;
	b=jxddM+jMbq4CCT+f6Hj98hA54uX7DUiec37e9sQew05V+X3O0+YfK9CinJ9P4ZImZq
	FARgGzkPLBRMBc9GLj6rv1m9Rq59iPNTmj0QCZ+NnnlFjRlgurGi/VnMVF03bhDyLfA7
	MwxBKAMN7NfKySTjz8B+lVBv23ZXAoRr/QlM634w8Zy1saMRFCJlQl/6p3RhPWBUmZnT
	eKB0HClN+05P6vqDrNYq2mijER3UIHP5eNVFeEaM4JXPy/bXZ0bM773AcPlqE0RS1FFv
	BKHa6EBKKGnilEQ0N/KFY2p7Ukr95rqUBfzqJVlytwJmbXFyqsFBV7klHM5R8XPaxihp
	WBkQ==
X-Gm-Message-State: APjAAAXjLVCOzb3lczWaotEW0PG0greJ4K/dtdqxZm6gFvw/eI2V0y4D
	FgsbO/nk8CFQdxAlT3y3YR4=
X-Google-Smtp-Source: APXvYqxnOLt/B1s1fnTXW+rApOdQ4QrBRBfUbqENv6TwtJD7/YQ5V3G1pqw+tinQ+BpozTPcvms5bA==
X-Received: by 2002:adf:9c8a:: with SMTP id d10mr126309wre.9.1558522091611;
	Wed, 22 May 2019 03:48:11 -0700 (PDT)
Received: from localhost ([51.15.41.238])
	by smtp.gmail.com with ESMTPSA id v11sm617828wrr.87.2019.05.22.03.48.10
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 22 May 2019 03:48:10 -0700 (PDT)
Date: Wed, 22 May 2019 11:48:09 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190522104809.GG27900@stefanha-x1.localdomain>
References: <20190521103650.18479-1-stefanha@redhat.com>
	<0630a607-9216-6b75-54fa-0a1308f2eff0@redhat.com>
	<20190521113059.GB4971@linux.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2NLGdgz3UMHa/lqP"
Content-Disposition: inline
In-Reply-To: <20190521113059.GB4971@linux.fritz.box>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: Re: [Qemu-devel] [RFC] scsi: restart dma after vm change state
 handlers
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2NLGdgz3UMHa/lqP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 01:30:59PM +0200, Kevin Wolf wrote:
> Am 21.05.2019 um 13:04 hat Paolo Bonzini geschrieben:
> > On 21/05/19 12:36, Stefan Hajnoczi wrote:
> > > This is RFC because I am waiting for a test result on the system where
> > > the bug was originally discovered.  I'm also open to nicer solutions!
> >=20
> > I don't think it's too ugly; IDE is also using a bottom half for this.
>=20
> I think the IDE case is different, see commit 213189ab65d. The case
> we're protecting against there is stopping the VM from inside a VM state
> handler, which can confuse other VM state callbacks that come later. The
> actual order of the IDE callback vs. the other callback doesn't matter,
> it's just important that all start callbacks are completed before stop
> callbacks are called.
>=20
> In our current case, the problem is not that we're confusing other
> handlers, but that we rely on another handler to have completed resuming
> something. If that other handler changes e.g. to use a BH itself, we get
> an undefined order again.
>=20
> The clean solution would probably be not to use a VM state handler in
> scsi-bus, but a callback from the HBA that tells the bus that the HBA is
> ready to receive requests again.
>=20
> If we go with the not so clean solution, maybe at least a comment in
> virtio-scsi would be in order.

I explored this approach originally but found it hard to connect things
together in an easy-to-understand way.  That's when I abandoned the idea
and used a BH as a hack, but I find it problematic in the long-term (too
many things could go wrong and cause a regression).

Time for another look at a proper callback for DMA restart...

Stefan

--2NLGdgz3UMHa/lqP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzlKOkACgkQnKSrs4Gr
c8jdbQf9HIAgA93DRG351VWIW0t+iGWlmJkABj8ZtaRnjLSwWBjXIgS8CxXEsFvq
iPszZYVHgy4ixDxcMVH9cBNMlQO7oktYiBBkOosfnfdT/io91sBXHpUBdQmASr/A
7qm0jkBkIZhBahgyTU27/gsbyEvj1FEk7nGDlK1gM9EzyNVcvPmH7331yH3T3/OY
ZoUtqYo/Or37E4SPuSWGhR+o5hZ3IubRDsEiKavwTJj5A//F2f/ndhXILAnChB+V
NYqatdoXfnew4zlcQaBGHjH0QxxFkzGinir6xhVa+LrBrVh/jR9QSf20TdbShQmf
A8FPnHDE9G7PW/s8R75D2JdrviZiNw==
=EcS5
-----END PGP SIGNATURE-----

--2NLGdgz3UMHa/lqP--

