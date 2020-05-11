Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BD2C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF6E20643
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkkfDzer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF6E20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY9tV-000828-Ug
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jY9oX-00064f-7o
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:53:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jY9oW-0000jq-D0
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:53:52 -0400
Received: by mail-wr1-x444.google.com with SMTP id x17so11368041wrt.5
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=W4ejrBo7nrPyJLwfZ1XppUEa5/iDzAO0ZOQ42Dxi07g=;
 b=YkkfDzerKdRjnBY1tnQiEmOR9Obl4Aqcb7nLstacL4LD4SalyTzls6y13wY31shYSy
 P5lR8GkpG0+Q+JMQo/eG63/d8yA3sdEzipwZ/d8e24c3TwZDlIIpMlWn6TQjiyN0iMnr
 O/0TJrsehjOwvrFnXpRTLTYUR17JuXvllXNBhBmB4YxkED8s5QniT1zahwyE98EC9SjK
 B4WC7NCHvo0r90my9WTzZsIle1q3A5/STQkbU3sifBdKhdDRW43H4/tGUJW/umgTPE0U
 6yscda2/1ZYH+Z4U4u2pBE6QJoJuNzPIhynew37Jqgc0ZbWsuwDhKt2dTWTjBcY6qerK
 U/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=W4ejrBo7nrPyJLwfZ1XppUEa5/iDzAO0ZOQ42Dxi07g=;
 b=U5BAPUZQtpfOFHdCPfIBTxYRhtm5HWGSPuXTLOdthz1v4XpCayWv1mfoQrQOmk5hI/
 f5kMi7TvxRP1Dq7FRjEczfpTpcYTRU1OaBQBa3rlpCibRcKmNmGzbXdrrHmhcDl0i7Yw
 KGxARZY89dp2glkro+tVsDIT15qsGtLi8jZaL2rsnhBIq/TcKbNaYDzHagNr6g1FLjny
 rjwokn+1xq2X1vPiDV1xUcINwCuG5ddv725AjnTuG0+ob2gDeXx6yBg4KEajZkaYzRMt
 RIiqkY4Vs93rZ0vs+jOMz3gdnHJNZuYp10Qp9pAAqFuV7Cq6L6yVbSIorfELIaHFuqID
 eT5g==
X-Gm-Message-State: AGi0PuYpkZDog+gA58ilQE52fZQwsZXJ/DC6gEnuCrIafI5MUY75e7kC
 0vOfaecFZL08wroH+dm5BDI=
X-Google-Smtp-Source: APiQypI0x8DrV6noFcZHRW29jMaftsx0DiYmkc/4j2YcMmQpsMkySh+m/X8OJjaWbIyfO9zTmgCZTg==
X-Received: by 2002:a5d:5047:: with SMTP id h7mr19223822wrt.7.1589208830524;
 Mon, 11 May 2020 07:53:50 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id l12sm16770186wrh.20.2020.05.11.07.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 07:53:49 -0700 (PDT)
Date: Mon, 11 May 2020 15:53:47 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Geoffrey McRae <geoff@hostfission.com>
Subject: Re: [PATCH v8] audio/jack: add JACK client audiodev
Message-ID: <20200511145347.GD182627@stefanha-x1.localdomain>
References: <20200511042538.60E863A0386@moya.office.hostfission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline
In-Reply-To: <20200511042538.60E863A0386@moya.office.hostfission.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2020 at 03:53:58PM +1000, Geoffrey McRae wrote:
> This commit adds a new audiodev backend to allow QEMU to use JACK as
> both an audio sink and source.
>=20
> Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
> ---
>  audio/Makefile.objs    |   5 +
>  audio/audio.c          |   1 +
>  audio/audio_template.h |   2 +
>  audio/jackaudio.c      | 677 +++++++++++++++++++++++++++++++++++++++++
>  configure              |  17 ++
>  qapi/audio.json        |  56 +++-
>  6 files changed, 756 insertions(+), 2 deletions(-)
>  create mode 100644 audio/jackaudio.c

Cool! Out of interest, which emulated audio device do you use and have
you had issues with buffer sizes/latency?

I haven't reviewed in depth but in general this looks good.

> +typedef struct QJackBuffer {
> +    int          channels;
> +    int          frames;
> +    _Atomic(int) used;

stdatomic.h isn't used directly in QEMU. Can you use "qemu/atomic.h"
instead?

> +static inline int qjack_buffer_used(QJackBuffer *buffer)
> +{
> +    assert(buffer->data);
> +    return atomic_load_explicit(&buffer->used, memory_order_relaxed);
> +}

Is this function used?

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl65ZvsACgkQnKSrs4Gr
c8j9IwgAktEvu4hbpzGZ54pl2oML6IW7srMptRs/qEqJ8dbycPdTcoffIJG6IWAj
QFJzAFaWJGUp9pyi9DORJydOWESO4soWfD4CWRPt/Y6O+3xG/L/3cfnLuZdR/zGo
2j5v1/OdfEauiPn5YlxZJyqooR4I6nBxShII9DDXuep2kyRsJ3cizuMFRHLgo3Up
9HzIKOn3x41qqQX/Dv2P979dSLNkg2ZluS1I4mkGME1NQldDV840CP6TlDXHvYQS
Z8okFSzNWFi4+eBWf+FYZYOMGSPDIdOTVMTrGxh5tLWRWp0QUxIEXZjUJBYuQDBX
oClDbgpazI9uBV2v3HbojK09nRZYgA==
=Kvsh
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--

