Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE0DC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F357217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+tihL/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F357217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSOG3-0002l3-AQ
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSOF8-0002Aj-0h
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:33:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSOF7-0001MY-2d
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:33:13 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44689)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSOF6-0001LG-SA
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:33:13 -0500
Received: by mail-wr1-x442.google.com with SMTP id f2so17726768wrs.11
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 08:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WhrPom9W9r/b/Fpo8egsa3HXGZoLM/4hkhrw0yLgaiU=;
 b=J+tihL/m1MF+e6GmxD/kdQ4lXM6KaWT1t8GjZzC22jQvmXUIChEpKQn8hc/1Ck6Hur
 PNBoXEKPF8a5LR2ksPtZoo5869Qnx4VUscDGLXcQNTyHTbKZZOGG9JP3cLGw7OHXdY2/
 HhIvz8U6H4Gn5283i3h1U7TlqxbJt9lXXDLMtZ5KgHGq7g3Jfe9nmQMtR3mhlCM4dDaC
 FGTvDvW9P40rldj2wyTS2V9C0lh5wdvqETkCnFETngZ7MHjRUP7GJLsjGQl20xImNWx/
 oBFCExf4eSGrMg4/9Rf+/eqOS6Gsc1m+gr5476pK8o+IGQvYNzFJaa534jX6bEfcb+bL
 xCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WhrPom9W9r/b/Fpo8egsa3HXGZoLM/4hkhrw0yLgaiU=;
 b=TRawXq6w9FXbm5GrBALQijT+/CXBiPVF6TTc11ghAEyyDQa0411dPHJZ+spmUnxc6K
 AmtH1e9frG7PzA9xenlWmNpb8EhkizYtIqSkSwG7wUW9L6GEZIRO8aMb+42Xsi3JX2Fz
 sdHDPxmzxyJkvIa0jCxvwEWlhvdValBUXs0/EYvG06vjL1TNhbpxmnijGoSK363grOX9
 4KLQ/xi1tBkCr81Z9MaxHKWUmYRCzDoANxXb9TIr0hSayqtkNuaTXPFnptOQ4/KQViQf
 c+nMI5z6iAuAG2dM9Qar0x4u24zTzc6iOQNlBLDODs2XQQzpSypfD75X8D2Cle69Msb2
 LwTg==
X-Gm-Message-State: APjAAAWoKj8+EHZw0VoiLrLyCcKY+WXIlED+uxqw8EdP/8sJgDkCHASM
 sO5diFg9B5aM1ofpNN/TNzw=
X-Google-Smtp-Source: APXvYqxwZp5gM+dUfIHNlL0wLT+mIivTbk0FTx2noJ/+PSrQJbT0hpcm1NxcqDQvhp6qXB83sr0w8Q==
X-Received: by 2002:a05:6000:1605:: with SMTP id
 u5mr3357164wrb.252.1573057991818; 
 Wed, 06 Nov 2019 08:33:11 -0800 (PST)
Received: from localhost (178.165.129.116.wireless.dyn.drei.com.
 [178.165.129.116])
 by smtp.gmail.com with ESMTPSA id g133sm3063002wme.42.2019.11.06.08.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 08:33:11 -0800 (PST)
Date: Wed, 6 Nov 2019 17:33:09 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 07/20] qtest: add in-process incoming command handler
Message-ID: <20191106163309.GH340561@stefanha-x1.localdomain>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-8-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-8-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2019 at 02:49:53PM +0000, Oleinik, Alexander wrote:
> diff --git a/qtest.c b/qtest.c
> index ae7e6d779d..9fbfa0f08f 100644
> --- a/qtest.c
> +++ b/qtest.c
> @@ -802,3 +802,16 @@ bool qtest_driver(void)
>  {
>      return qtest_chr.chr != NULL;
>  }
> +
> +void qtest_server_inproc_recv(void *dummy, const char *buf, size_t size)
> +{
> +    static GString *gstr;
> +    if (!gstr) {
> +        gstr = g_string_new(NULL);
> +    }
> +    g_string_append(gstr, buf);
> +    if (gstr->str[gstr->len - 1] == '\n') {
> +        qtest_process_inbuf(NULL, gstr);
> +        g_string_free(gstr, true);

This double-frees gstr.  Please add:

  gstr = NULL;

--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3C9cUACgkQnKSrs4Gr
c8hWpwf+PDeHsrvNf0P9kybwYnV4ggGKMuakUGOueoivNgK5hv7syV2PrRvvyCDa
XwjT38+bddUfq2EDjrJ6aslC9vWWfkSRgTIx27sH6R9MvXvUrhL81f3KHqS37yVL
5d2NRd/1RPHktDBnmGDB6k9kRWMsCkJU0coMtfQI91VGQeu6gds+Vgo+xHLdt1bP
FWbjG/yt/W62NYlaspRaLn4XVsTUzsc3XOX4ccBEvAh0E1AzLBMHeN3jFTnFJoRv
PPN1VA4BN/KBm1ND+QGVCf7PSaRlhJVVwfNGjuaVDRXWTtN24xnA+fubvzPpfCaP
gG+VJqUwV/rwBCJtKA+h8jwaHCrf8w==
=FYfq
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--

