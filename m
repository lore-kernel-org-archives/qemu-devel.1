Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B827C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 18:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE7F217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 18:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE7F217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=unixzen.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0xK-00026e-L5
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 14:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kallisti5@unixzen.com>) id 1iB0vV-00017G-Al
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 14:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kallisti5@unixzen.com>) id 1iB0vT-0001jR-C1
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 14:13:08 -0400
Received: from mx.dal1.terarocket.io ([108.61.222.170]:52166)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <kallisti5@unixzen.com>) id 1iB0vS-0001ie-Dc
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 14:13:06 -0400
Received: by mx.dal1.terarocket.io (Postfix, from userid 1001)
 id B68175E567; Thu, 19 Sep 2019 18:13:04 +0000 (UTC)
Received: from mx.dal1.terarocket.io (localhost [IPv6:::1])
 by mx.dal1.terarocket.io (Postfix) with ESMTPSA id 682895E4B8;
 Thu, 19 Sep 2019 18:13:03 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 19 Sep 2019 18:13:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From: "Alexander von Gluck IV" <kallisti5@unixzen.com>
Message-ID: <e5ceb0f98be5950a98af459716d76332@unixzen.com>
Subject: Re: Will the qemu-devel prefix in the mails come back?
To: "=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=" <philmd@redhat.com>,
 "Martin Schrodt" <martin@schrodt.org>, "QEMU Developers"
 <qemu-devel@nongnu.org>
In-Reply-To: <41127b88-93af-a1ea-232b-ed5290102396@redhat.com>
References: <41127b88-93af-a1ea-232b-ed5290102396@redhat.com>
 <9c6bf92a-0869-cf5d-222b-305e55393ebb@schrodt.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 108.61.222.170
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

September 19, 2019 12:58 PM, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat=
.com> wrote:=0A=0A> Hi Martin,=0A> =0A> On 9/19/19 7:04 PM, Martin Schrod=
t wrote:=0A> =0A>> Does anybody know?=0A> =0A> This change has been annou=
nced here:=0A> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg0=
1645.html=0A> =0A>> My mail filter would appreciate :)=0A> =0A> In the pr=
evious link there is a hint about updating your mail filter :)=0A=0AGroan=
.. No wonder my inbox has been such a mess.=0A=0AHere's catching + sortin=
g this ML in procmail...=0A=0A:0:=0A* ^(List-Id).*qemu-devel.nongnu.org.*=
=0A.Lists.Qemu/=0A=0A=0A -- Alex

