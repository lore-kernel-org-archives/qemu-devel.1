Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87B1C34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 03:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82ADF2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 03:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXxBArf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82ADF2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Foy-0007Kn-Od
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 22:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j4FoG-0006U0-Rw
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 22:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j4FoF-0006lo-Ba
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 22:14:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38516
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j4FoF-0006lC-7b
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 22:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582082038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K68bzRWkjMQ8X9981AvaO8qqmYygws9IJtyzfw/yNUY=;
 b=AXxBArf0OGPNdcUK7w9UqwE114b6jYOgdqtnx+wQC9Z9KO3v//kefDSgPJOslYF0i0xDzA
 ThFbdsa43Fb95x+cbeFmgtLPGDB9+xJiXqiYCJsZDL/KEw0qOk03/y21iKM8zYI4zK3Psh
 bPuZ0giNlg586HT8Qc9jiHQV5pnEUTc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-UCoh7dAZPkWPGhlaJBfsbQ-1; Tue, 18 Feb 2020 22:13:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A36F1107ACC7;
 Wed, 19 Feb 2020 03:13:53 +0000 (UTC)
Received: from [10.72.13.212] (ovpn-13-212.pek2.redhat.com [10.72.13.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F4BE196AE;
 Wed, 19 Feb 2020 03:13:45 +0000 (UTC)
Subject: Re: [PATCH v4 00/14] Fixes for DP8393X SONIC device emulation
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <cover.1580290069.git.fthain@telegraphics.com.au>
 <1b1e6027-b59b-939d-c0ad-791be60f18ae@redhat.com>
 <CAL1e-=iCY9FaPdDHB4ms37dckQp+YKoWniA22jQ7eOq__jobpA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a9647bed-2bfa-9215-e70f-f6cf04ec46cc@redhat.com>
Date: Wed, 19 Feb 2020 11:13:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iCY9FaPdDHB4ms37dckQp+YKoWniA22jQ7eOq__jobpA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: UCoh7dAZPkWPGhlaJBfsbQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Finn Thain <fthain@telegraphics.com.au>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/19 =E4=B8=8A=E5=8D=882:30, Aleksandar Markovic wrote:
>
>
> On Tuesday, February 4, 2020, Jason Wang <jasowang@redhat.com=20
> <mailto:jasowang@redhat.com>> wrote:
>
>
>     On 2020/1/29 =E4=B8=8B=E5=8D=885:27, Finn Thain wrote:
>
>         Hi All,
>
>         There are bugs in the emulated dp8393x device that can stop packe=
t
>         reception in a Linux/m68k guest (q800 machine).
>
>         With a Linux/m68k v5.5 guest (q800), it's possible to remotely
>         trigger
>         an Oops by sending ping floods.
>
>         With a Linux/mips guest (magnum machine), the driver fails to
>         probe
>         the dp8393x device.
>
>         With a NetBSD/arc 5.1 guest (magnum), the bugs in the device
>         can be
>         fatal to the guest kernel.
>
>         Whilst debugging the device, I found that the receiver algorithm
>         differs from the one described in the National Semiconductor
>         datasheet.
>
>         This patch series resolves these bugs.
>
>         AFAIK, all bugs in the Linux sonic driver were fixed in Linux
>         v5.5.
>         ---
>         Changed since v1:
>         =C2=A0 - Minor revisions as described beneath commit logs.
>         =C2=A0 - Dropped patches 4/10 and 7/10.
>         =C2=A0 - Added 5 new patches.
>
>         Changed since v2:
>         =C2=A0 - Minor revisions as described beneath commit logs.
>         =C2=A0 - Dropped patch 13/13.
>         =C2=A0 - Added 2 new patches.
>
>         Changed since v3:
>         =C2=A0 - Replaced patch 13/14 with patch suggested by Philippe
>         Mathieu-Daud=C3=A9.
>
>
>         Finn Thain (14):
>         =C2=A0 =C2=A0dp8393x: Mask EOL bit from descriptor addresses
>         =C2=A0 =C2=A0dp8393x: Always use 32-bit accesses
>         =C2=A0 =C2=A0dp8393x: Clean up endianness hacks
>         =C2=A0 =C2=A0dp8393x: Have dp8393x_receive() return the packet si=
ze
>         =C2=A0 =C2=A0dp8393x: Update LLFA and CRDA registers from rx desc=
riptor
>         =C2=A0 =C2=A0dp8393x: Clear RRRA command register bit only when a=
ppropriate
>         =C2=A0 =C2=A0dp8393x: Implement packet size limit and RBAE interr=
upt
>         =C2=A0 =C2=A0dp8393x: Don't clobber packet checksum
>         =C2=A0 =C2=A0dp8393x: Use long-word-aligned RRA pointers in 32-bi=
t mode
>         =C2=A0 =C2=A0dp8393x: Pad frames to word or long word boundary
>         =C2=A0 =C2=A0dp8393x: Clear descriptor in_use field to release pa=
cket
>         =C2=A0 =C2=A0dp8393x: Always update RRA pointers and sequence num=
bers
>         =C2=A0 =C2=A0dp8393x: Don't reset Silicon Revision register
>         =C2=A0 =C2=A0dp8393x: Don't stop reception upon RBE interrupt ass=
ertion
>
>         =C2=A0 hw/net/dp8393x.c | 202
>         +++++++++++++++++++++++++++++++----------------
>         =C2=A0 1 file changed, 134 insertions(+), 68 deletions(-)
>
>
>
>     Applied.
>
>
> Hi, Jason,
>
> I generally have some reservations towards patches that did not=20
> receive any R-bs. I think we should hear from Herve in this case, to=20
> confirm that this change doesn't cause other problems while solving=20
> the original ones.


That's fine but if it's agreed that we should hear from somebody for a=20
specific part of the code, it's better to have the one as=20
maintainer/reviewer in MAINTAINERS.

Thanks


>
> I hope this is not the case.
>
> Regards,
> Aleksandar
>
>


