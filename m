Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BB5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AD152084C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVTvRbUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD152084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdWtX-0006LD-Qr
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jdWst-0005tk-PT
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:32:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29992
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jdWsr-0007J9-C9
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590489152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xZm8/axOKUXxnQrMV3tSDqDdTy//8U0heLgkHtYz8nc=;
 b=TVTvRbUXxlClfddU5xyOaxdjQFhnHNsYLGFpkJ5iXfY69OB40ZGyd1g+N8usFSO/hRQhqw
 A74YJ4cyw+0erXKIX8Vsb1RkfrDwtAXH5y3OWQAURpX3476Dn1Tc8GX+hEZkKFquvL+Mkk
 Acs+7O+4HN7QpEdlJapkWvCP62V7Ufg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-qMDp5mchNkCXD50yvuHVow-1; Tue, 26 May 2020 06:32:28 -0400
X-MC-Unique: qMDp5mchNkCXD50yvuHVow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C4F38B7D14;
 Tue, 26 May 2020 10:32:21 +0000 (UTC)
Received: from localhost (ovpn-113-132.ams2.redhat.com [10.36.113.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 625026FEF8;
 Tue, 26 May 2020 10:32:20 +0000 (UTC)
Date: Tue, 26 May 2020 11:32:18 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 14/19] util/async: Fixed tsan warnings
Message-ID: <20200526103218.GB3189@stefanha-x1.localdomain>
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-15-robert.foley@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200522160755.886-15-robert.foley@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, peter.puhov@linaro.org, cota@braap.org,
 alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2020 at 12:07:50PM -0400, Robert Foley wrote:
> For example:
>   Atomic write of size 8 at 0x7b4800113c28 by main thread (mutexes: write=
 M30):
>     #0 __tsan_atomic64_exchange <null> (qemu-system-aarch64+0x386f85)
>     #1 aio_bh_poll util/async.c:146:5 (qemu-system-aarch64+0xcd1f61)
>     #2 aio_dispatch util/aio-posix.c:380:5 (qemu-system-aarch64+0xcd8abb)
>     #3 aio_ctx_dispatch util/async.c:298:5 (qemu-system-aarch64+0xcd31b0)
>     #4 g_main_context_dispatch <null> (libglib-2.0.so.0+0x4c416)
>     #5 qemu_main_loop softmmu/vl.c:1664:9 (qemu-system-aarch64+0x5cc6d6)
>     #6 main softmmu/main.c:49:5 (qemu-system-aarch64+0xc62857)
>=20
>   Previous read of size 8 at 0x7b4800113c28 by thread T3 (mutexes: write =
M81):
>     #0 aio_bh_enqueue util/async.c:81:9 (qemu-system-aarch64+0xcd2267)
>     #1 qemu_bh_schedule util/async.c:181:5 (qemu-system-aarch64+0xcd2267)
>     #2 worker_thread util/thread-pool.c:113:9 (qemu-system-aarch64+0xcd47=
3c)
>     #3 qemu_thread_start util/qemu-thread-posix.c:519:9 (qemu-system-aarc=
h64+0xcde280)
>=20
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  util/async.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Please explain why these warnings should be ignored in the commit
description. I have been CCed on this patch, am unfamiliar with TSAN
annotations, and now need to figure out:
1. Is ignoring the warning safe or should async.c be fixed somehow?
2. How do the annotation macros work and are they being used correectly?

It's likely that people coming across this commit in the future would
also benefit from information in the commit description that makes these
things clear.

Thanks,
Stefan

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7M8DIACgkQnKSrs4Gr
c8iiWgf/eNh8znTyT+SYp6Ktkc0sp6xRyXyIuNW5xotKbANTPuR5uv3sP8g7URoo
nv9P9X/+v4ePfhl/ICUQxcnxosIP57J9/AMZSPpAsAU8cmCEnl6WiaUkLFXewN2q
zgMZ6dv2zSWUuHtKXtTsE61O7PMKDTjt9h2reW3JbbZp/T/ZFrEsJTneEep4IHi/
EWbuc7pPYkVI+tJbfPHcAQ/noEFJT8eyuZ4/OygHmL75J/96hm2+qc/PYEmbu8pI
8DPzUsoJ/dQja0kBv6CwmuxKnLtSfwlQ7F6G/3DOR6VnAuXe9Y1m6Yo7h3sD2FKt
zivwGIChz/5WZEHGycSeBkTxZjW5cg==
=DGLA
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--


