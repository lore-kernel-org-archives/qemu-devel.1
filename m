Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6A7C04AA9
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 06:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AEF721479
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 06:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AEF721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46065 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM5QX-0007Tg-OF
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 02:42:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hM5Po-0007Ai-JT
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hM5Pn-00036j-Nx
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:41:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hM5Pn-0002wD-Eb
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:41:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 742F6307D935;
	Thu,  2 May 2019 06:41:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 16E71379D;
	Thu,  2 May 2019 06:41:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id ADDDD11AAF; Thu,  2 May 2019 08:41:29 +0200 (CEST)
Date: Thu, 2 May 2019 08:41:29 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Message-ID: <20190502064129.tklft35yvgaj6pq3@sirius.home.kraxel.org>
References: <1556605301-44112-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1556605301-44112-1-git-send-email-longpeng2@huawei.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 02 May 2019 06:41:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] usb/xchi: avoid trigger assertion if
 guest write wrong epid
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
Cc: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502064129.W5-UgQodpog_xYOTevrMun51dpBc97pkxWc3d2BySqM@z>

On Tue, Apr 30, 2019 at 02:21:41PM +0800, Longpeng(Mike) wrote:
> From: Longpeng <longpeng2@huawei.com>
>=20
> we found the following core in our environment:
> 0  0x00007fc6b06c2237 in raise ()
> 1  0x00007fc6b06c3928 in abort ()
> 2  0x00007fc6b06bb056 in __assert_fail_base ()
> 3  0x00007fc6b06bb102 in __assert_fail ()
> 4  0x0000000000702e36 in xhci_kick_ep (...)
> 5  0x000000000047897a in memory_region_write_accessor (...)
> 6  0x000000000047767f in access_with_adjusted_size (...)
> 7  0x000000000047944d in memory_region_dispatch_write (...)
> (mr=3Dmr@entry=3D0x7fc6a0138df0, addr=3Daddr@entry=3D156, data=3D164889=
2416,
> size=3Dsize@entry=3D4, attrs=3Dattrs@entry=3D...)
> 8  0x000000000042df17 in address_space_write_continue (...)
> 10 0x000000000043084d in address_space_rw (...)
> 11 0x000000000047451b in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x1ab11b0)
> 12 0x000000000045dcf5 in qemu_kvm_cpu_thread_fn (arg=3D0x1ab11b0)
> 13 0x0000000000870631 in qemu_thread_start (args=3Dargs@entry=3D0x1acfb=
50)
> 14 0x00000000008959a7 in thread_entry_for_hotfix (pthread_cb=3D<optimiz=
ed out>)
> 15 0x00007fc6b0a60dd5 in start_thread ()
> 16 0x00007fc6b078a59d in clone ()
>=20
> (gdb) f 5
> 5  0x000000000047897a in memory_region_write_accessor (...)
> 529	    mr->ops->write(mr->opaque, addr, tmp, size);
> (gdb) p /x tmp
> $9 =3D 0x62481a00 <-- last byte 0x00 is @epid
>=20
> xhci_doorbell_write() already check the upper bound of @slotid an @epid=
,
> it also need to check the lower bound.
>=20
> Cc: Gonglei <arei.gonglei@huawei.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Signed-off-by: Longpeng <longpeng2@huawei.com>

Added to usb queue.

thanks,
  Gerd


