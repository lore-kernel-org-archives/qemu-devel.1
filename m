Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD2FC32757
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB182083B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB182083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxs3Y-0003g9-Vt
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 08:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1hxs2p-0003GE-G7
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hxs2n-00076b-KT
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:06:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53518)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hxs2n-00076F-FV
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:06:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A6AAE693D6
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 12:06:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com
 [10.36.116.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 270E6891B0;
 Wed, 14 Aug 2019 12:06:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C549616E08; Wed, 14 Aug 2019 14:06:15 +0200 (CEST)
Date: Wed, 14 Aug 2019 14:06:15 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190814120615.mmsvamz7d3bjgz3z@sirius.home.kraxel.org>
References: <20190807084048.4258-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190807084048.4258-1-marcandre.lureau@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 14 Aug 2019 12:06:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] usbredir: fix buffer-overflow on vmload
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 07, 2019 at 12:40:48PM +0400, Marc-Andr=E9 Lureau wrote:
> If interface_count is NO_INTERFACE_INFO, let's not access the arrays
> out-of-bounds.
>=20
> =3D=3D994=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address=
 0x625000243930 at pc 0x5642068086a8 bp 0x7f0b6f9ffa50 sp 0x7f0b6f9ffa40
> READ of size 1 at 0x625000243930 thread T0
>     #0 0x5642068086a7 in usbredir_check_bulk_receiving /home/elmarco/sr=
c/qemu/hw/usb/redirect.c:1503
>     #1 0x56420681301c in usbredir_post_load /home/elmarco/src/qemu/hw/u=
sb/redirect.c:2154
>     #2 0x5642068a56c2 in vmstate_load_state /home/elmarco/src/qemu/migr=
ation/vmstate.c:168
>     #3 0x56420688e2ac in vmstate_load /home/elmarco/src/qemu/migration/=
savevm.c:829
>     #4 0x5642068980cb in qemu_loadvm_section_start_full /home/elmarco/s=
rc/qemu/migration/savevm.c:2211
>     #5 0x564206899645 in qemu_loadvm_state_main /home/elmarco/src/qemu/=
migration/savevm.c:2395
>     #6 0x5642068998cf in qemu_loadvm_state /home/elmarco/src/qemu/migra=
tion/savevm.c:2467
>     #7 0x56420685f3e9 in process_incoming_migration_co /home/elmarco/sr=
c/qemu/migration/migration.c:449
>     #8 0x564207106c47 in coroutine_trampoline /home/elmarco/src/qemu/ut=
il/coroutine-ucontext.c:115
>     #9 0x7f0c0604e37f  (/lib64/libc.so.6+0x4d37f)
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Added to usb queue.

thanks,
  Gerd


