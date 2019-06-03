Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9763C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9426E2709F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9426E2709F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39406 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXrvN-0006Mk-NE
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:43:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hXrr8-0002fN-Qw
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hXri0-0002Mi-Ra
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:29:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>)
	id 1hXrhy-0002Gn-Of; Mon, 03 Jun 2019 14:29:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3172C30C0DDB;
	Mon,  3 Jun 2019 18:29:21 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-13.rdu2.redhat.com
	[10.10.121.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4168D2E16F;
	Mon,  3 Jun 2019 18:29:17 +0000 (UTC)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190603150120.29255-1-alex.bennee@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5f684c68-d2cd-90f7-3892-1c6245728042@redhat.com>
Date: Mon, 3 Jun 2019 20:29:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190603150120.29255-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 03 Jun 2019 18:29:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH] cputlb: use uint64_t for interim
 values for unaligned load
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
Cc: 1830872@bugs.launchpad.net, qemu-arm@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, randrianasulu@gmail.com,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190603182911.WXljjtLe-cUK0xc7e0t1M3QEkIbKGqryppdHNYfRo3I@z>

(+Igor)

On 06/03/19 17:01, Alex Benn=C3=A9e wrote:
> When running on 32 bit TCG backends a wide unaligned load ends up
> truncating data before returning to the guest. We specifically have
> the return type as uint64_t to avoid any premature truncation so we
> should use the same for the interim types.
>=20
> Hopefully fixes #1830872
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  accel/tcg/cputlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index cdcc3771020..b796ab1cbea 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1303,7 +1303,7 @@ load_helper(CPUArchState *env, target_ulong addr,=
 TCGMemOpIdx oi,
>          && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
>                      >=3D TARGET_PAGE_SIZE)) {
>          target_ulong addr1, addr2;
> -        tcg_target_ulong r1, r2;
> +        uint64_t r1, r2;
>          unsigned shift;
>      do_unaligned_access:
>          addr1 =3D addr & ~(size - 1);
>=20

Applied on top of commit ad88e4252f09c2956b99c90de39e95bab2e8e7af:

Tested-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo

