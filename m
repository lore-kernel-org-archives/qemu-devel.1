Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCE9C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A957921849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as6EdWO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A957921849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoPOB-0004S2-Np
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 05:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41589)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hoPNj-0002lM-T3
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hoPNi-0000rK-Ul
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:40:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:39793)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hoPNi-0000mK-Nf
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:40:50 -0400
Received: by mail-wm1-x331.google.com with SMTP id u25so18017679wmc.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 02:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wtuA9BNJ/tbzsn73UQipYDf0LItqv6HCUcVg45jkUnw=;
 b=as6EdWO80zpy2aM1DJkWnTujqyNgAe1iOqw9TiHAOLof8Uzno5wM9glZdRlu2BYkHQ
 ikbZ6nv4nDDNcX/5ToH4gZzMpCDeUv7YuGsDoU5nOh98PAQnsfe1Zk/ny/QzfXX23NQw
 ju02GL/jiYl2WpDK/2tw8jwo4xXYnLOdmAmbFpV9EjY3Jl9d2H10OOvXu7mIU0vG1L5I
 E686UC7W/7T62VkP9G9O4fEf0AZRpg2Qcrg18QULCzZkqk2nxOmOqOjuW3W3oz0x2Lgh
 i5urPU/tmJpDgKXFjolHo/xDcU7et+8lUdSlqpbsPFPR3Kdg86pjNilDlDADyx4itEr+
 49XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wtuA9BNJ/tbzsn73UQipYDf0LItqv6HCUcVg45jkUnw=;
 b=YlYVro4wA4mqLN6PaWdJHzNCLXIBPUfZ06m1JiDp3Tq1ycmZqeXdrP0fdqfxn1CT/E
 JLxtxoTsYvOQggpaw6ET05/X4mRHMMQ1v9Ypdf0wtAew9B6C2VX0DrtIP80Fg1RHL/OZ
 BB9ID3voBWRkRd2kOifXtm+kbfDLSbwrHqcT8YX7wFFrwcuOEuhezpzu+MUM1mqbeudO
 ruix3S0+VYnR5cIYlhRjPOBW/8bZbGWWxMhVn2byi1SNu34nZpt8ManKqekGB+QapGjc
 SwETQYB3jmS6455mKSEH+aoISDxI89TaVye2VjKPmEZMhclrjeAAeBMCPgDLcIRW4zF3
 YDow==
X-Gm-Message-State: APjAAAWUqdroof4Z8AHFDtSEq9/vIJVBspHyGF4dAkk86SCzho2PMn64
 kfYAtkSYd58oAVqT/wbBjcw=
X-Google-Smtp-Source: APXvYqxYD/z97+akPiA6lLv9OXZmvYR2t1QUNv61By/nnQoNohPgcmlyrAcopgGQBIDpqfc6Jbosbw==
X-Received: by 2002:a1c:b68a:: with SMTP id g132mr49132135wmf.66.1563529248964; 
 Fri, 19 Jul 2019 02:40:48 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id y6sm24023435wrp.12.2019.07.19.02.40.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 02:40:48 -0700 (PDT)
Date: Fri, 19 Jul 2019 10:40:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Anton Kuchin <antonkuchin@yandex-team.ru>
Message-ID: <20190719094046.GC18585@stefanha-x1.localdomain>
References: <9f644e46-6fc5-01ea-068a-fdbf9e08b828@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: <9f644e46-6fc5-01ea-068a-fdbf9e08b828@yandex-team.ru>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: Re: [Qemu-devel] What events should be handled in iohandler context?
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2019 at 06:19:31PM +0300, Anton Kuchin wrote:
> I'm trying to understand contexts and handlers/notifiers and a bit confus=
ed
> about two contexts living in main loop: qemu_aio_context and iohandler_ct=
x.
> It is mentioned in the iohandler_ctx comment that qemu_aio_context can't =
be
> reused because "iohandlers mustn't be polled by aio_poll(qemu_aio_context=
)"
> but there is no exlanation why.

It's a historic thing that existing code depends on.  Users of the
iohandlers API do not expect their fds to be processed when
aio_poll(qemu_aio_context) is called.

New code tends to use qemu_aio_context because the AioContext API can
also be used with IOThreads.  This means processing can run in the main
loop thread or a dedicated thread (IOThread) without code changes.

> I tried to find examples and failed to understand why virtio-net eventfds
> are registred to iohandler_ctx with generic virtio callback
> virtio_device_start_ioeventfd_impl() but TX bottom-half and handlers of
> back-end TAP use qemu_aio_context.
>=20
> Can you explain a little bit why we need some fds to be polled and some n=
ot
> to be polled? And how can I choose which context is right for me?

By default hw/virtio/virtio.c uses iohandler_ctx although devices can
use virtio_queue_aio_set_host_notifier_handler() to attach the
host_notifier to any AioContext.  virtio-blk and virtio-scsi are
examples of doing with with an IOThread.

The iohandler_ctx vs qemu_aio_context separation is a conservative way
of maintaining assumptions in existing code.  There might be code that
can safely run in qemu_aio_context instead, but it can be hard to
foresee issues caused by switching so it only be done if there is a good
reason.

Stefan

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0xkB4ACgkQnKSrs4Gr
c8i1wQgAgAUL1ItajavVrzg33Tfk8A5oqB8lsrWJ5w+LN+/tHx/GRGculiVWRK0K
lEyeHr9VTSmpBNQZj7SECj1Y/q4Xiy+Fy4p0/Pubct+noEA0kFiEIT5PBh40ll5U
JJ4piHt4K5EOYHj7UZLma+jnyV1/0H8EzzCKRtbHWSd1SDFy0aHIfWm/Gzq6OMfs
9iaUhcT9fwZG1fc3OS9LxKTJRfbfeWAiqll6G5bSgEx2UXihfZGNQq7ol6RHW1u5
i2xmiLjl4beLYJ2dRVtP7HpHZlqeq12WG9aj2pOFT/a+8LxTS6Oi/DJa3G6caI86
atfKCvX4kS8XjXFLC6pIubPByaRcUA==
=6Yu2
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--

