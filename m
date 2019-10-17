Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B381ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3778621A4C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="fYtLxZ95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3778621A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6t9-00045V-3F
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lekiravi@yandex-team.ru>) id 1iL6Dc-0001ss-9K
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lekiravi@yandex-team.ru>) id 1iL6DZ-0003l8-CV
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:53:30 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:35754)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lekiravi@yandex-team.ru>)
 id 1iL6DY-0003kK-Rm
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:53:29 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id BB97C2E143F;
 Thu, 17 Oct 2019 16:53:24 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 fanj4qpouM-rN6GjXDD; Thu, 17 Oct 2019 16:53:24 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1571320404; bh=dfZ50VIrRT1QeG7Z96DDir6/lzd+8JjM7vO2GO9klnY=;
 h=Date:Message-Id:Cc:Subject:To:From;
 b=fYtLxZ959FTXK4NwhmzcG+Pe+xa72Zc4Fsa4qCQfXHEMzpglaqcVejPacOmonJs86
 8lYz4NpAS9odgF3H59HAPzMK6Yq2QxXW99bkrDoebwrEnAEPQ2QTcauc2R+v8n35NA
 poQni+vBeiQP2ZRSNq/KTeyNW+qG7KSpzERbKRRA=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000161690
X-Yandex-Avir: 1
Received: from mxbackcorp2j.mail.yandex.net (localhost [::1])
 by mxbackcorp2j.mail.yandex.net with LMTP id F5jOwPoRyQ-rzgk2jqW
 for <lekiravi@yandex-team.ru>; Thu, 17 Oct 2019 16:53:12 +0300
Received: by iva8-147456c4bd40.qloud-c.yandex.net with HTTP;
 Thu, 17 Oct 2019 16:53:12 +0300
From: Alex Kirillov <lekiravi@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: QMP netdev_add multiple dnssearch values
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Thu, 17 Oct 2019 16:53:22 +0300
Message-Id: <713881571320392@iva8-147456c4bd40.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 95.108.205.193
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jasowang@redhat.com, armbru@redhat.com, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I'm trying to create a user (slirp) interface with several `dnssearch` va=
lues using QMP.
But every variant I pass can't do that.

According to the QAPI schema it should be like:

{
=C2=A0 =C2=A0 "execute": "netdev_add",
=C2=A0 =C2=A0 "arguments": {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 "id": "netdev0",
=C2=A0 =C2=A0 =C2=A0 =C2=A0 "type": "user",
=C2=A0 =C2=A0 =C2=A0 =C2=A0 "dnssearch": [
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "str": "8.8.8.8"
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "str": "8.8.4.4"
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]
=C2=A0 =C2=A0 }
}

I looked through code and find out that `dnssearch` is passing to the `sl=
irp_dnssearch` (net/slirp.c),
but the only way to execute this function correctly is to pass simply str=
ing (like "example.org") to `dnssearch` OR to use command line options.


What is the correct form of QMP command that I should use?


P.S. Looks like fields `hostfwd` and `guestfwd` has the same issue.

--=C2=A0
Alex Kirillov
Yandex.Cloud

