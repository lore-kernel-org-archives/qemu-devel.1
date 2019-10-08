Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C42C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C575206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C575206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHt3C-0005Qk-Jn
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vmaffione@freebsd.org>) id 1iHt19-0004pn-0R
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vmaffione@freebsd.org>) id 1iHt18-00067u-3N
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:11:22 -0400
Received: from mx2.freebsd.org ([2610:1c1:1:606c::19:2]:37408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vmaffione@freebsd.org>)
 id 1iHt17-00062v-WE; Tue, 08 Oct 2019 13:11:22 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client CN "mx1.freebsd.org",
 Issuer "Let's Encrypt Authority X3" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id A5EEE9027D;
 Tue,  8 Oct 2019 17:11:19 +0000 (UTC)
 (envelope-from vmaffione@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org",
 Issuer "Let's Encrypt Authority X3" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 46nkQb3FJVz4GZB;
 Tue,  8 Oct 2019 17:11:19 +0000 (UTC)
 (envelope-from vmaffione@freebsd.org)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "GTS CA 1O1" (verified OK))
 (Authenticated sender: vmaffione)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 47020BA25;
 Tue,  8 Oct 2019 17:11:19 +0000 (UTC)
 (envelope-from vmaffione@freebsd.org)
Received: by mail-qk1-f175.google.com with SMTP id f16so17464175qkl.9;
 Tue, 08 Oct 2019 10:11:19 -0700 (PDT)
X-Gm-Message-State: APjAAAXAFT8BkTqp79f6YSH36dSXC6HwvK8OH8Plbup/KtC9o3y+GzFx
 OXWcK2GH8BGDOttReaiAgPFBbPwz2LCd5ZuYB2M=
X-Google-Smtp-Source: APXvYqz0Bn+t9FBT+MEV3ALW9sUtxgR4sGROAgLsHePoXwxOOO1njyySW9fmVpa5bF/aG+FZJF5xIyGSEuH0P+ZIkl4=
X-Received: by 2002:a37:d84:: with SMTP id 126mr27982718qkn.407.1570554678968; 
 Tue, 08 Oct 2019 10:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191008084931.12753-1-thuth@redhat.com>
 <CAGxU2F61+TjSy_GJ_2673--VLstVyJjNoqqPdZw+ej22xbzk=Q@mail.gmail.com>
 <CAKBkRUwiNV7qUhcDYak9s65bbb5PzzZWp3x6-pKCn5H0cJFrFg@mail.gmail.com>
In-Reply-To: <CAKBkRUwiNV7qUhcDYak9s65bbb5PzzZWp3x6-pKCn5H0cJFrFg@mail.gmail.com>
From: Vincenzo Maffione <vmaffione@freebsd.org>
Date: Tue, 8 Oct 2019 19:12:41 +0200
X-Gmail-Original-Message-ID: <CA+_eA9h-LwGntePuGHwXxJFaje3mW5f=T1FczSCzK-+pVkm4=w@mail.gmail.com>
Message-ID: <CA+_eA9h-LwGntePuGHwXxJFaje3mW5f=T1FczSCzK-+pVkm4=w@mail.gmail.com>
Subject: Re: [PATCH] Test netmap on FreeBSD
To: Li-Wen Hsu <lwhsu@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000bd857b0594694182"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2610:1c1:1:606c::19:2
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
Cc: Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-trivial@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bd857b0594694182
Content-Type: text/plain; charset="UTF-8"

This is an example command line for a qemu VM with a vtnet interface
connected to a port of a VALE switch called 'vale1':

qemu-system-x86_64 fbsd-head.qcow2 -smp 2 -m 2G -vga std -device
e1000,netdev=mgmt,mac=00:AA:BB:CC:0a:99 -netdev
user,id=mgmt,hostfwd=tcp::20010-:22 -device
virtio-net-pci,netdev=data10,mac=00:AA:BB:CC:0a:0a,ioeventfd=on,mrg_rxbuf=on
-netdev netmap,ifname=vale1:10,id=data10

Cheers,
  Vincenzo

--000000000000bd857b0594694182
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This is an example command line for a qemu VM with a vtnet=
 interface connected to a port of a VALE switch called &#39;vale1&#39;:<br>=
<br>qemu-system-x86_64 fbsd-head.qcow2 -smp 2 -m 2G -vga std -device e1000,=
netdev=3Dmgmt,mac=3D00:AA:BB:CC:0a:99 -netdev user,id=3Dmgmt,hostfwd=3Dtcp:=
:20010-:22 -device virtio-net-pci,netdev=3Ddata10,mac=3D00:AA:BB:CC:0a:0a,i=
oeventfd=3Don,mrg_rxbuf=3Don -netdev netmap,ifname=3Dvale1:10,id=3Ddata10<b=
r><br>Cheers,<br>=C2=A0 Vincenzo</div>

--000000000000bd857b0594694182--

