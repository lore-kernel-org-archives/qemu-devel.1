Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70308C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B6D2074B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E76xyY+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B6D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtU9y-0003iI-He
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtU9Q-0003Hy-PJ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:51:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47815
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtU9P-0002t3-8v
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594291894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3fzBoxykhdKPJYf3PCdUI2RVBnwBsrm9uzlALfP6E/M=;
 b=E76xyY+W1sZFztTGABQ+NYW7qakkDAm4dVcgdpDeSbgmz4/UWaIwGw9YlSMW/w888VewD6
 ORit+l5Wa7Nx57uyq8lnlIjRCpr7utYlh3NmMa6FJq47LC2221UY3WjSfsDhsoaYksR8Zy
 fZQhFW9hhHv0eSP1ePjUD9yi06Fm45Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-muc7zVgxMruY0ijhMOFuvw-1; Thu, 09 Jul 2020 06:51:32 -0400
X-MC-Unique: muc7zVgxMruY0ijhMOFuvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1855802C2B;
 Thu,  9 Jul 2020 10:51:29 +0000 (UTC)
Received: from localhost (ovpn-112-165.ams2.redhat.com [10.36.112.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 634737F8C1;
 Thu,  9 Jul 2020 10:51:22 +0000 (UTC)
Date: Thu, 9 Jul 2020 11:51:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] Remove the CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE switch
Message-ID: <20200709105121.GB511889@stefanha-x1.localdomain>
References: <20200709053456.4900-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200709053456.4900-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2020 at 07:34:56AM +0200, Thomas Huth wrote:
> diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
> index f0b66320e1..a4e6446ed9 100644
> --- a/util/coroutine-ucontext.c
> +++ b/util/coroutine-ucontext.c
> @@ -237,19 +237,15 @@ Coroutine *qemu_coroutine_new(void)
>  }
> =20
>  #ifdef CONFIG_VALGRIND_H
> -#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && !defined(__clang__)
>  /* Work around an unused variable in the valgrind.h macro... */
>  #pragma GCC diagnostic push
>  #pragma GCC diagnostic ignored "-Wunused-but-set-variable"
> -#endif

What about !defined(__clang__)? Looks like this will break clang builds:

  warning: unknown warning option '-Wunused-but-set-variable'; did you mean=
 '-Wunused-const-variable'? [-Wunknown-warning-option]

Stefan

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8G9qgACgkQnKSrs4Gr
c8gySgf/fkJnk+3BO20QsoZ3VptUj55w0JzTo3CHcFei4SBeVeqsMB+EqRL3Fq6Y
nzxCsg8vbLKaf062eFwq+eGgs6jEcbrZLxQcTQo+ibsbKinSXmnlb7F7g0h0MzC8
oe66N8Ck5olz0kVx8gw3+v6TTH/hNHxYvkZHjiL8waAxc2oMlsguP6HUqmPzf8yc
ZMP90GxU8U57XAAcT/CDPDjcbZnNJ1yJC6JUARQdp7kn0h0tZQFOr4gR2GxvRvXL
7sZjATTBi6yFufdwOjLYlDuDi810RoyqiJJx/6zCQrZJ27aVjaEk5pUN/emy2xXG
KLivm/cXhJwJciYUt1F219IL6fGXWA==
=6JiX
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--


