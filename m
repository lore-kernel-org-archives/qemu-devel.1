Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05963C3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 03:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FB52087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 03:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6ol5bNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FB52087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iypNP-0001iF-T1
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 22:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iypMk-0001Bz-5C
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 22:59:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iypMi-0006zl-R0
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 22:59:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60154
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iypMi-0006yG-Mw
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 22:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580788748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a3a3DgC9e2TTiIoWEBqepsrOkAqxBoISHXu2+aoXUJc=;
 b=f6ol5bNa1LI9iL9rY+zS61DNs+GBsBWT1/uyxecJQ8r0BC3hHFO5HMB1QGKzGc7FC5j2a1
 S8VAsyGhFr9zNhMS0UzQchxAyoyPcWS5hKvZbv64N/txFmflB12m07G59KEbRKm+2J1opg
 wQdYY0VFMUtCwMzayZOyEpSqLmIA+Vg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-FproLVegPRiDFURcHwdLTQ-1; Mon, 03 Feb 2020 22:59:06 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DF378017DF;
 Tue,  4 Feb 2020 03:59:05 +0000 (UTC)
Received: from [10.72.12.170] (ovpn-12-170.pek2.redhat.com [10.72.12.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D16A60BF4;
 Tue,  4 Feb 2020 03:58:59 +0000 (UTC)
Subject: Re: [PATCH v4 00/14] Fixes for DP8393X SONIC device emulation
To: Finn Thain <fthain@telegraphics.com.au>, qemu-devel@nongnu.org
References: <cover.1580290069.git.fthain@telegraphics.com.au>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1b1e6027-b59b-939d-c0ad-791be60f18ae@redhat.com>
Date: Tue, 4 Feb 2020 11:58:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1580290069.git.fthain@telegraphics.com.au>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: FproLVegPRiDFURcHwdLTQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/1/29 =E4=B8=8B=E5=8D=885:27, Finn Thain wrote:
> Hi All,
>
> There are bugs in the emulated dp8393x device that can stop packet
> reception in a Linux/m68k guest (q800 machine).
>
> With a Linux/m68k v5.5 guest (q800), it's possible to remotely trigger
> an Oops by sending ping floods.
>
> With a Linux/mips guest (magnum machine), the driver fails to probe
> the dp8393x device.
>
> With a NetBSD/arc 5.1 guest (magnum), the bugs in the device can be
> fatal to the guest kernel.
>
> Whilst debugging the device, I found that the receiver algorithm
> differs from the one described in the National Semiconductor
> datasheet.
>
> This patch series resolves these bugs.
>
> AFAIK, all bugs in the Linux sonic driver were fixed in Linux v5.5.
> ---
> Changed since v1:
>   - Minor revisions as described beneath commit logs.
>   - Dropped patches 4/10 and 7/10.
>   - Added 5 new patches.
>
> Changed since v2:
>   - Minor revisions as described beneath commit logs.
>   - Dropped patch 13/13.
>   - Added 2 new patches.
>
> Changed since v3:
>   - Replaced patch 13/14 with patch suggested by Philippe Mathieu-Daud=C3=
=A9.
>
>
> Finn Thain (14):
>    dp8393x: Mask EOL bit from descriptor addresses
>    dp8393x: Always use 32-bit accesses
>    dp8393x: Clean up endianness hacks
>    dp8393x: Have dp8393x_receive() return the packet size
>    dp8393x: Update LLFA and CRDA registers from rx descriptor
>    dp8393x: Clear RRRA command register bit only when appropriate
>    dp8393x: Implement packet size limit and RBAE interrupt
>    dp8393x: Don't clobber packet checksum
>    dp8393x: Use long-word-aligned RRA pointers in 32-bit mode
>    dp8393x: Pad frames to word or long word boundary
>    dp8393x: Clear descriptor in_use field to release packet
>    dp8393x: Always update RRA pointers and sequence numbers
>    dp8393x: Don't reset Silicon Revision register
>    dp8393x: Don't stop reception upon RBE interrupt assertion
>
>   hw/net/dp8393x.c | 202 +++++++++++++++++++++++++++++++----------------
>   1 file changed, 134 insertions(+), 68 deletions(-)


Applied.

Thanks


