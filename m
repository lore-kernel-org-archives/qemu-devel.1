Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF9DC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB3F720879
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3F720879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50249 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU4Ok-0005Ow-9U
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 03:13:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hU4O3-00058Z-D1
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hU4O2-0004Pi-D5
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:13:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hU4O2-0004Oc-7g
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:13:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F02D719CBF6;
	Fri, 24 May 2019 07:12:59 +0000 (UTC)
Received: from gondolin (ovpn-116-212.ams2.redhat.com [10.36.116.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C211119C4F;
	Fri, 24 May 2019 07:12:54 +0000 (UTC)
Date: Fri, 24 May 2019 09:12:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190524091251.66d34d5a.cohuck@redhat.com>
In-Reply-To: <20190523175413.14448-1-laurent@vivier.eu>
References: <20190523175413.14448-1-laurent@vivier.eu>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 24 May 2019 07:13:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix __NR_semtimedop undeclared
 error
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
	Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 May 2019 19:54:13 +0200
Laurent Vivier <laurent@vivier.eu> wrote:

> In current code, __NR_msgrcv and__NR_semtimedop are supposed to be
> defined if __NR_msgsnd is defined.
>=20
> But linux headers 5.2-rc1 for MIPS define __NR_msgsnd without defining
> __NR_semtimedop and it breaks the QEMU build.
>=20
> __NR_semtimedop is defined in asm-mips/unistd_n64.h and asm-mips/unistd_n=
32.h
> but not in asm-mips/unistd_o32.h.
>=20
> Commit d9cb4336159a ("linux headers: update against Linux 5.2-rc1") has
> updated asm-mips/unistd_o32.h and added __NR_msgsnd but not __NR_semtimed=
op.
> It introduces __NR_semtimedop_time64 instead.

Thanks for looking into this! I still wonder whether something's b0rken
in the kernel, though. But that needs to be followed up by the mips
folks.

>=20
> This patch fixes the problem by checking for each __NR_XXX symbol
> before defining the corresponding syscall.

This looks safe in any case.

>=20
> Fixes: d9cb4336159a ("linux headers: update against Linux 5.2-rc1")
> Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

