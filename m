Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F721C43219
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 16:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79A2206A3
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 16:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79A2206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34126 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKQPv-0005bX-3Y
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 12:43:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hKQKj-0001C0-UL
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 12:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hKQDZ-0004zN-8B
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 12:30:27 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:47158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hKQDT-0004TM-F3
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 12:30:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by hera.aquilenet.fr (Postfix) with ESMTP id 7FF9C3DA3;
	Sat, 27 Apr 2019 18:30:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
	by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 30eFL6wCaQF1; Sat, 27 Apr 2019 18:30:10 +0200 (CEST)
Received: from function (105.251.129.77.rev.sfr.net [77.129.251.105])
	by hera.aquilenet.fr (Postfix) with ESMTPSA id CE8E33D59;
	Sat, 27 Apr 2019 18:30:10 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hKQDI-0001LE-Ct; Sat, 27 Apr 2019 18:30:08 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org
Date: Sat, 27 Apr 2019 18:30:04 +0200
Message-Id: <20190427163007.5113-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a0c:e300::1
Subject: [Qemu-devel] [PATCHv3 0/2] ui/curses: BSD portability fixes
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, kamil@netbsd.org,
	kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190427163004.ltUalvzoGzAF6MS_1UXC30iKSsIJoSmqgE_Plkz5zpw@z>

BSD needs a few fixes for wide character manipulations.

Difference with v1:
- Fix unitialized value in error message

Difference with v2:
- Add cchar_t manipulation fix

Samuel Thibault (2):
  ui/curses: do not assume wchar_t contains unicode
  ui/curses: manipulate cchar_t with standard curses functions

 ui/curses.c | 188 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 120 insertions(+), 68 deletions(-)

--=20
2.20.1


