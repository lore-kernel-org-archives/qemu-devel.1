Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C92CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7583A2065C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4MTsRG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7583A2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2uDA-0006mu-MY
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 06:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2uCa-0006N8-9r
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:29:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49608
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2uCY-0001CG-Ne
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596536986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UXtD5cnZrjbdtLa5cPUNoAsw7Tcp4n+0tgg2QXAl8uk=;
 b=V4MTsRG8R6prYcMYdaDZUcuO+jv8ZAA4yADDPexhUr5tl0NNgZ06Qlr/CGLibdz9GokkB6
 pI07/sqMSBY8od0Z7kmmOyCoSau0DMTz7TUfT6Stl67UaquIsEA3m+vJYXaFYQEClaR+ev
 3tP2a5pjcxxITLUT02ori9GBVuaY6pQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-eISsAhP7N7KJIJiMU6U86A-1; Tue, 04 Aug 2020 06:29:44 -0400
X-MC-Unique: eISsAhP7N7KJIJiMU6U86A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1552E1005504;
 Tue,  4 Aug 2020 10:29:43 +0000 (UTC)
Received: from localhost (ovpn-112-116.ams2.redhat.com [10.36.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A604F7178F;
 Tue,  4 Aug 2020 10:29:42 +0000 (UTC)
Date: Tue, 4 Aug 2020 11:29:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] aio-posix: keep aio_notify_me disabled during polling
Message-ID: <20200804102941.GB1284284@stefanha-x1.localdomain>
References: <20200804052804.1165291-1-stefanha@redhat.com>
 <20200804052804.1165291-4-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200804052804.1165291-4-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2020 at 06:28:04AM +0100, Stefan Hajnoczi wrote:
> @@ -597,15 +574,38 @@ bool aio_poll(AioContext *ctx, bool blocking)
>       * system call---a single round of run_poll_handlers_once suffices.
>       */
>      if (timeout || ctx->fdmon_ops->need_wait(ctx)) {
> +        /*
> +         * aio_notify can avoid the expensive event_notifier_set if
> +         * everything (file descriptors, bottom halves, timers) will
> +         * be re-evaluated before the next blocking poll().  This is
> +         * already true when aio_poll is called with blocking =3D=3D fal=
se;
> +         * if blocking =3D=3D true, it is only true after poll() returns=
,
> +         * so disable the optimization now.
> +         */
> +        if (timeout) {
> +            atomic_set(&ctx->notify_me, atomic_read(&ctx->notify_me) + 2=
);
> +            /*
> +             * Write ctx->notify_me before computing the timeout
> +             * (reading bottom half flags, etc.).  Pairs with
> +             * smp_mb in aio_notify().
> +             */
> +            smp_mb();
> +
> +            /* Check again in case a shorter timer was added */
> +            timeout =3D qemu_soonest_timeout(timeout, aio_compute_timeou=
t(ctx));
> +        }
> +
>          ret =3D ctx->fdmon_ops->wait(ctx, &ready_list, timeout);
> -    }
> =20
> -    if (blocking) {
> -        /* Finish the poll before clearing the flag.  */
> -        atomic_store_release(&ctx->notify_me, atomic_read(&ctx->notify_m=
e) - 2);
> -        aio_notify_accept(ctx);
> +        if (timeout) {
> +            /* Finish the poll before clearing the flag.  */
> +            atomic_store_release(&ctx->notify_me,
> +                                 atomic_read(&ctx->notify_me) - 2);
> +        }
>      }

Hi Paolo,
We can avoid calling aio_compute_timeout() like this, what do you think?

  bool use_notify_me =3D timeout !=3D 0;

  if (use_notify_me) {
      atomic_set(&ctx->notify_me, atomic_read(&ctx->notify_me) + 2);
      /*
       * Write ctx->notify_me before computing the timeout
       * (reading bottom half flags, etc.).  Pairs with
       * smp_mb in aio_notify().
       */
      smp_mb();

      /* Don't block if aio_notify() was called */
      if (atomic_read(ctx->notified)) {
          timeout =3D 0;
      }
  }

  ret =3D ctx->fdmon_ops->wait(ctx, &ready_list, timeout);

  if (use_notify_me) {
      /* Finish the poll before clearing the flag.  */
      atomic_store_release(&ctx->notify_me,
                           atomic_read(&ctx->notify_me) - 2);
  }

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8pOJUACgkQnKSrs4Gr
c8hrMwf9H0WkQA8/zQVxKbwBsg/pXLrYjJ9zjC6CehzVSVNxz13vc0cMsWBd6Jvo
ge4wP+keLw7hPVnN4qSweW9uI50D3PB0N2QlTypmEEe30PirJlNFfmGzgyYT2hUn
hhN0eT9WYURb4a8uCuvORc74ahBWiwfNUL5Ff0F9fUvqzUxJILc/MRfQSxhuDFIA
D3WuLN+iDYE1pLO+hySl22kBsFAd7dhqvw3DT6kOgtvyYPcY3D/Co0PyzZl3sK76
fMNTU+raWjSM6tX3e8IxHPVpI9uoQn2YUgJLofGDoZ76VAA8SNiK3/RYlbJlxage
TX9hO7A1J3XGhpRwG85pNeJLWaekmQ==
=gOxG
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--


