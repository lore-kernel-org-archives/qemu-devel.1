Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C91AC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0711D206C0
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXQXg8V0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0711D206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIGmB-00040t-Ae
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iICtA-0001DA-Q8
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 10:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iICt9-0008D1-Kh
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 10:24:28 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55241)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iICt9-0008Bo-EB; Wed, 09 Oct 2019 10:24:27 -0400
Received: by mail-wm1-x341.google.com with SMTP id p7so2858826wmp.4;
 Wed, 09 Oct 2019 07:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=SZJywyBQvSbAIwxr9G/gKwOuwgCyMY8zjtanOg2rtZw=;
 b=EXQXg8V0gaui5y0Ss9cUoC/d1MLdta5OiUbexPFxGBSBHTLqQIxVpnFGp410FwPf2t
 yJ7w6jnbzmyRaLYw8sAZUcaKlIeFDmMcXdND6BdlTeE89i8VhSiKIK3VSKML9MeOlOqe
 pf1V4r9Txk9a48f6JSyDcjAmGGQQyoZ2YN8TKgOs+SNE9oVb/GDJeiyHNTKNfvowhZTx
 Xu8oSrz+I4qsrynK3zICGL9sEfZlBsU9G9oJ8r3e/X368B36X7SgKQOwynGUVvh8nn5/
 T4a4sjsplHIolaQU/fOiuZ6WYq97RlBcdZHlejGEUwcIObhrcahTFsq69lKaDTBfndAX
 fHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=SZJywyBQvSbAIwxr9G/gKwOuwgCyMY8zjtanOg2rtZw=;
 b=I7y7vbhDSNdpvJf2fsveo6G/BEpnm5S+61ITMVFZt6vkIKWm8nK6lYrzFhtBb/sBZ3
 zDGar6ffEmzjpB+/c8JeL8pWo8Cxt6KDifaGcWCIogwoEizr/y1DywkcBIvoZ5md10EH
 yTZWTXwl3xUj7u1BuKkIBpas9TTKqwxB9BXrl/x79RxrQ1l30BF/nylU1+XuLBqD85QA
 LSy5jq14he6uuKmCXZZui+aGnT7jHKplDeundvluLjxdnLZjbBcUJhkBvZs4jh805Zos
 GQuzEd+sBAJ4Pk4e+xpNrCiAY6u0KxwhxAKeWrsM8KNf3gt+J5VEDWyKNMlPNp04GLTM
 uWBQ==
X-Gm-Message-State: APjAAAVpSmEI2BD+fGMMcXUNIkUWG0mN2OmIsGL0hX6Z142fO5vV0cF3
 MaxlUdVHacDP7AxEu6EcIn4u9/m6uEo=
X-Google-Smtp-Source: APXvYqxDZzLHRQ5Ap06KmlCIQ7FBRvFzfHGHYK5/tRiKPitLrM6UCp638/Ehd1zYD6ju/Z/kUnsivw==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr2785776wmj.91.1570631066483; 
 Wed, 09 Oct 2019 07:24:26 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z9sm3000768wrl.35.2019.10.09.07.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2019 07:24:25 -0700 (PDT)
Date: Wed, 9 Oct 2019 15:24:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] test-bdrv-drain: fix iothread_join() hang
Message-ID: <20191009142424.GS5747@stefanha-x1.localdomain>
References: <20191003100103.331-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kVhvBuyIzNBvw9vr"
Content-Disposition: inline
In-Reply-To: <20191003100103.331-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--kVhvBuyIzNBvw9vr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2019 at 11:01:03AM +0100, Stefan Hajnoczi wrote:
> tests/test-bdrv-drain can hang in tests/iothread.c:iothread_run():
>=20
>   while (!atomic_read(&iothread->stopping)) {
>       aio_poll(iothread->ctx, true);
>   }
>=20
> The iothread_join() function works as follows:
>=20
>   void iothread_join(IOThread *iothread)
>   {
>       iothread->stopping =3D true;
>       aio_notify(iothread->ctx);
>       qemu_thread_join(&iothread->thread);
>=20
> If iothread_run() checks iothread->stopping before the iothread_join()
> thread sets stopping to true, then aio_notify() may be optimized away
> and iothread_run() hangs forever in aio_poll().
>=20
> The correct way to change iothread->stopping is from a BH that executes
> within iothread_run().  This ensures that iothread->stopping is checked
> after we set it to true.
>=20
> This was already fixed for ./iothread.c (note this is a different source
> file!) by commit 2362a28ea11c145e1a13ae79342d76dc118a72a6 ("iothread:
> fix iothread_stop() race condition"), but not for tests/iothread.c.
>=20
> Fixes: 0c330a734b51c177ab8488932ac3b0c4d63a718a
>        ("aio: introduce aio_co_schedule and aio_co_wake")
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/iothread.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--kVhvBuyIzNBvw9vr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2d7ZgACgkQnKSrs4Gr
c8igLgf/ZYKb7dQZm+nG1JUcq/yk3QqLf9RdTMltnt+N3xVHLolZpYZRgjzClNBQ
n0Nxy0MNBaJypg4mIqBVqBOQOhTbSLbwx6zGhl2c9YBZUb7gu3IhOqBCCsPvWQN3
b/dGh5W3+tbYlEE8ips9y3n374w84HwhlzxhCK7ndxsxytDHbQnB8v48sMHFNPYg
YiV1E4uYhIJKCIqqhYDa9mH86a5gtGKQ8/kT2dLwNzJECFMyER/OdGRfjwU0Pgdq
6bBW33LbcW0VKNcRiMkIZSd/HGnuheRPWrOkjyR6SMaPH4nhZZXOX22Y1rt7u6V6
fD48JRtmPvmaiVvaCUDgHnnn3L4FAA==
=PSM1
-----END PGP SIGNATURE-----

--kVhvBuyIzNBvw9vr--

