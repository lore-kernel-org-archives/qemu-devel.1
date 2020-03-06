Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBAAC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3B62084E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQueorP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3B62084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADNx-00043L-FS
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 08:51:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jADND-0003ZA-EX
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jADNB-0003HV-GO
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:50:43 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1jADNB-00032t-6P; Fri, 06 Mar 2020 08:50:41 -0500
Received: by mail-wm1-x343.google.com with SMTP id u9so2451570wml.3;
 Fri, 06 Mar 2020 05:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rA45ZMGawz0Szc3SJM0WsjB20lovPO1o770lErFb6g0=;
 b=mQueorP4vo9Yj4wRN8iyeUoiDG81cyHOjK4EyicIdguhSQVTvQXItzr4sF5yvnOSJw
 JJybb5kK6vbjZYtzHsHR+j0lnmP70f5+8j0uTc1yHqHDBj8RnZDptVGSBHfFhTJdbt4S
 grECAPTN4fm6pYSLdJk5v3jjfGPW6pZkqVnUi5ITXBA0YQBREs3crvD9enLz4YGlocL3
 0l+EEkGIj1pReWk2rsam6wIHrzxZkDpMknx+8/7OhTwVqxn1RyCrMCuusG5cHM1w+5cg
 mvyYDUj68uBnrCCqx/SiYi0LLOzhrchdRMYE8rYSLn/Ij1kD8NgR8Zh6QDuj+YnS3lMx
 Ml1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rA45ZMGawz0Szc3SJM0WsjB20lovPO1o770lErFb6g0=;
 b=nEStaSYWAimBKAR8/GcDVxAO+BR81fvBwUPG1hAqjvYKbXrJdMKv6ISd9UkOsYUpeO
 gxK1CoTRmqIKNJR98RP54PIfIv5F65KKQRgafSNrKG20HZXsRdwEJ3vwPasmtGXlCbBS
 juPrlL1cZ0awk9wGwjFe8rm5xPXWce5j6pP6Pxw4eZ0s6MCiMW53meGnbp2MSVraJ213
 G2KQfwE64MEMjfsv8rIEdosZ6c/BJhz0pg7ZoM17yUT77B9SclVFUqsH56puqcncLuZQ
 NiEdmiF9uG8aun1wqrf6EfB4UGS6EspmLs02mvqtUTid42HN1HP0uCQgKG9Gz++kvA5M
 GVQQ==
X-Gm-Message-State: ANhLgQ0IPk0jX+7cG2nfVAz5/8RqQ0/pu1QlKNuvtUfoIsfa3zSP0S/I
 UsHpWlzb/5tZB6s2+VZAnik=
X-Google-Smtp-Source: ADFU+vugAgbJEuN5B2ze/xhB+Nv8UoN9toZPOBWRWJu6wTAk0vbn7r+C1ovD6oFAZnwMmQLC/Ymmyw==
X-Received: by 2002:a1c:9a45:: with SMTP id c66mr3927719wme.115.1583502638858; 
 Fri, 06 Mar 2020 05:50:38 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c23sm11779967wme.39.2020.03.06.05.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 05:50:37 -0800 (PST)
Date: Fri, 6 Mar 2020 13:50:36 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 7/7] aio-posix: remove idle poll handlers to improve
 scalability
Message-ID: <20200306135036.GP1335569@stefanha-x1.localdomain>
References: <20200305170806.1313245-1-stefanha@redhat.com>
 <20200305170806.1313245-8-stefanha@redhat.com>
 <58ce9251-77ba-9db2-b1c1-fd97cd175e9a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vzUQzca511KWT6Hk"
Content-Disposition: inline
In-Reply-To: <58ce9251-77ba-9db2-b1c1-fd97cd175e9a@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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


--vzUQzca511KWT6Hk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 06:28:29PM +0100, Paolo Bonzini wrote:
> On 05/03/20 18:08, Stefan Hajnoczi wrote:
> > +    /*
> > +     * List of handlers participating in userspace polling.  Accessed =
almost
> > +     * exclusively from aio_poll() and therefore not an RCU list.  Pro=
tected by
> > +     * ctx->list_lock.
> > +     */
> > +    AioHandlerList poll_aio_handlers;
> > +
>=20
> Not sure I understand the "almost" part.  If it's accessed only from
> aio_poll() it is protected via either AIO_WAIT_WHILE or the BQL, not by
> ctx->list_lock; if it's protected by ctx->list_lock (using
> qemu_lockcnt_inc in readers), it is an RCU list.

aio_remove_fd_handler() removes nodes from the list during
aio_set_fd_handler(), but only while holding ctx->list_lock and the
count is zero (no readers).

All other access is done from with ctx->list_lock incremented.  This
code needs to be reentrant in case of nested aio_poll() but nothing else
will access the list at the same time.

Therefore RCU is not needed.  ctx->list_lock acts more like a rwlock.

Stefan

--vzUQzca511KWT6Hk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5iVSwACgkQnKSrs4Gr
c8g6qAf/RVGHKryUjIC2Z+GAzKgxrTXZgLMs1y2PQgGOk7zFlz0Vry/5mf+7z6wN
6hUWjmizwDcj33kbxSd6ur07hRyUC8GBSkDtb7H8/iHE/G+ikNBgrMck0ZKorkaQ
KQEPuCrTZsFVw/aserl8Blc5dhcM/qHZkzST3BKU4y2KOiLaihNe8Za9Bhv8aafU
ddzRmaiIpK3lq2cUXQm6Si8QbQirq/piG8kaaCwjq+FQNZM++teEzvLRo7PHBL8h
JZsIgdWqVZSoAlytXitwez1fRhXSnKcadzQZnsauxkyu8fiFmJAeiHmw64i9LVvj
1BWtHl5KZ1e1UMukSd36Tsxvu4Rq6Q==
=QKn+
-----END PGP SIGNATURE-----

--vzUQzca511KWT6Hk--

