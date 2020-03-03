Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCA9C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 13:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A354420842
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 13:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A354420842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tarent.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j97MC-0003dY-Jq
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 08:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <t.glaser@tarent.de>) id 1j97LF-0003E4-QU
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 08:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <t.glaser@tarent.de>) id 1j97LE-000846-Jt
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 08:12:09 -0500
Received: from lixid.tarent.de ([193.107.123.118]:42918 helo=mail.lixid.net)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <t.glaser@tarent.de>) id 1j97LD-0007ul-57
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 08:12:08 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.lixid.net (MTA) with ESMTP id C3643140C1E;
 Tue,  3 Mar 2020 14:12:04 +0100 (CET)
Received: from mail.lixid.net ([127.0.0.1])
 by localhost (mail.lixid.net [127.0.0.1]) (MFA, port 10024) with LMTP
 id 1HAAvd8im_XG; Tue,  3 Mar 2020 14:12:04 +0100 (CET)
Received: from tglase.lan.tarent.de (tglase.lan.tarent.de [172.26.3.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.lixid.net (MTA) with ESMTPS id A91461403F7;
 Tue,  3 Mar 2020 14:12:04 +0100 (CET)
Received: by tglase.lan.tarent.de (Postfix, from userid 2339)
 id 5EC63220D95; Tue,  3 Mar 2020 14:12:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by tglase.lan.tarent.de (Postfix) with ESMTP id 4356E220AE3;
 Tue,  3 Mar 2020 14:12:04 +0100 (CET)
Date: Tue, 3 Mar 2020 14:12:04 +0100 (CET)
From: Thorsten Glaser <t.glaser@tarent.de>
X-X-Sender: tglase@tglase.lan.tarent.de
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: qemu-system-x86_64: warning: Unknown X11 keycode mapping '<null>'.
In-Reply-To: <20200303104431.GB1773352@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2003031410520.18659@tglase.lan.tarent.de>
References: <alpine.DEB.2.22.394.2003020002570.23029@tglase.lan.tarent.de>
 <20200302102841.GD1679990@redhat.com>
 <alpine.DEB.2.22.394.2003021336010.14371@tglase.lan.tarent.de>
 <20200303104431.GB1773352@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Content-Language: de-DE-1901
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 193.107.123.118
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

On Tue, 3 Mar 2020, Daniel P. Berrang=C3=A9 wrote:

> AFAICT, this is not the case. On both my Fedora & Debian installs,
> x11vnc is just a binary that attaches to an existing X11 server

Huh, weird. Perhaps this changed over the years and distro releases.

>   $ ls -al /usr/bin/vncserver

$ realpath $(which vncserver)
/usr/bin/tightvncserver

This does surprise me, because I also have x11vnc installed and
vaguely remember using it in standalone server mode for a while.

But, yes, tightvncserver 1:1.3.9-9.1 is also installed, so I=E2=80=99m
apparently using that.

bye,
//mirabilos
--=20
tarent solutions GmbH
Rochusstra=C3=9Fe 2-4, D-53123 Bonn =E2=80=A2 http://www.tarent.de/
Tel: +49 228 54881-393 =E2=80=A2 Fax: +49 228 54881-235
HRB 5168 (AG Bonn) =E2=80=A2 USt-ID (VAT): DE122264941
Gesch=C3=A4ftsf=C3=BChrer: Dr. Stefan Barth, Kai Ebenrett, Boris Esser, Ale=
xander Steeg

**********

Mit der tarent Academy bieten wir auch Trainings und Schulungen in den
Bereichen Softwareentwicklung, Agiles Arbeiten und Zukunftstechnologien an.

Besuchen Sie uns auf www.tarent.de/academy. Wir freuen uns auf Ihren Kontak=
t.

**********

