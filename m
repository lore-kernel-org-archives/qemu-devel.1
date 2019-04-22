Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E430C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 12:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A93F2077C
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 12:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Qit/0hIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A93F2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36989 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIYLU-0005ks-DU
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 08:46:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIYJz-0004m0-Ld
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 08:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIY9R-0005Ji-Ss
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 08:34:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:38087)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nick.hudson@gmx.co.uk>)
	id 1hIY9R-00059c-KE
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 08:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1555936456;
	bh=VaMhRSxj+537iqqNgUhEHxLdK2XOhGoS1xig8vRc9BQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=Qit/0hIjmzVdw4R1bNTmX4QEUbl+/8vkREK5cPZ0jZE2hlaAIsr8Br/XnDIc3GecR
	awxDO2sUJ1bi/IPBzxQztsw1FRIXjWTo8sTcjUOadBR0GtHA8MNXBxfr+hWHJC9zHl
	tUtYOqgjtfu7UmLD408rFgsQgaxEvdRvWz+fSVzY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from zoom.local ([2.122.11.66]) by mail.gmx.com (mrgmx102
	[212.227.17.174]) with ESMTPSA (Nemesis) id 0LinyL-1gfe1q3jKP-00czsH;
	Mon, 22 Apr 2019 14:34:16 +0200
Received: by zoom.local (Postfix, from userid 1000)
	id 7F3C69C5570; Mon, 22 Apr 2019 13:34:13 +0100 (BST)
From: Nick Hudson <nick.hudson@gmx.co.uk>
To: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 Apr 2019 13:34:09 +0100
Message-Id: <20190422123411.5178-1-nick.hudson@gmx.co.uk>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:WCYgYxYwSHOJ+IWvHWsXV4M2cVdw+n4SDgJaGJHUrBb00eNjW/l
	K6AFcghs7vTUHwUnmOOVDHMFf5tRUcWNDgBFhUsN04D7ponKThco396GnuTT0ZfhuvK4tEt
	1yR7o0v+WcSXDHajaDoK3w8PySGXr8O7VIU0A7abIAdARUjQMNe9Pi01nkaIzoO1eM345os
	GXlpuwcg6U212NkA416PA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CG/ykNzVpKE=:WYkajCAEI7Sjne60IdY+tR
	cQIas/zS0GLfxgtjA2VnBUoobJMjRRx5KNRiKPm8xTbZEAMWlFb/eZx4nNdhm0EvLjKtpZ2hp
	4QOko/hAKy6BQeKS0oVpRnuBql23CaNBWIms+eHupoUZMDbgV5MQd289waa355WQfnsEKEri8
	4hmi3UbCUej80Vs0Opa6JrCWFKPHoEOR4DKNCnUzHwK4PTb7LjLlapCdVZ+XWz0KkyTD6ddLW
	0rRgTZYx4ZqJMz9Q9/b2SOzeh7BouLX2F9zC0xaRHPk4UBXW5ofRwVSoOjUEr5Q+CltYfkQ0u
	Qhjl75XW99w7ywnmaGCuUDi5b92Vu2S6jkcLoDdyFNB5jE0Il38H4afbVzD3rKEkPSGUrOyvD
	aS8ku2ZExKo66uU+0cY42RhUUeKg2in9PRcd+e5dSC3MrTY2VNxWLHSfJSE8OtsQLNi/NsvsL
	w4d6R1Xot7/x7i4SksJaK7/The2mouHtzifOinsW2Gp/l9SdP/vrDSY0yMwfZPp125B+7zV/d
	TpfvymmDiSA9IpjBinksmFRcDD3GH60zpQ7gfdpVuJvN/7xrYns6+iTYO6NJOW6QC+fy+3veL
	EkjeJm/flvCQ/cd5dBHOUmwp2rGBMKESPAw2qJeClsHtX9p4teQhvTqWIRc74jAcnl6Brz4Le
	BU2BcMieVBL72uwThye7AD9Op0jSdVqdJeBBQ6n9JC9zjR1oQ8S13Vr3t6wNFBEm2EhN4dbBU
	9WN51Vi9c7JvVHAR7C0Su3lUXLQbeeyyhmfPL9sM/BPcaDrkI1+UcI9TD0kRo1e8YWuqTjf9X
	qDtlPrnaFb4PQdPNYcH0XAZnQeB1jAr93XngpX+OEkyPp4zoRRuEIJqW7bQZ+mKoIj2+hLciv
	F3ERfDlJdkugkub1rK6qX/CGnYrGioWt7LrFlBmjrl0zSIKJjgHnsJgFw62Bun
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.22
Subject: [Qemu-devel] [PATCH v2 0/2] HPPA fixes for NetBSD/hppa emulation
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
Cc: Nick Hudson <skrll@netbsd.org>, Kamil Rytarowski <kamil@netbsd.org>,
	"open list:NETBSD" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422123409.nX5KANslIrcyom2Gyyf28AU4i4Bvir9tmmUyxy4Eyu8@z>

From: Nick Hudson <skrll@netbsd.org>

Here are the required changes to allow qemu to emulate NetBSD/hppa.

v2 changes:
 - remove old debug code

Nick Hudson (2):
  Implement the pcxl and pcxl2 Fast TLB Insert instructions as used by
    NetBSD (and OpenBSD)
  Always return EXCP_DMAR for protection id trap as EXCP_DMP is
    considered legacy.

 target/hppa/insns.decode |  3 +++
 target/hppa/mem_helper.c |  3 +--
 target/hppa/translate.c  | 52 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

=2D-
2.17.1


