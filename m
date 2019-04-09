Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC780C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCBC32070D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBC32070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41972 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDr63-0006VG-I9
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 09:47:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDr4Q-0005bH-Bl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDr4P-00012v-Bd
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:45:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDr4P-00012L-3F
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:45:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CE5B19CF25;
	Tue,  9 Apr 2019 13:45:48 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ED96E5D9C9;
	Tue,  9 Apr 2019 13:45:38 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
	Olaf Hering <olaf@aepfle.de>
Date: Tue,  9 Apr 2019 15:45:34 +0200
Message-Id: <20190409134536.15548-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Tue, 09 Apr 2019 13:45:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.0 v3 0/2] roms: Avoid iPXE/EDK2 EFIROM
 variable clash, pass CFLAGS to EDK2 build tools
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409134534.wkrIZrEd-3QbhpjG_z1jxDXkUuffUBDK5T95DYnLmbI@z>

Hi,

Two trivial fixes to avoid the latest EDK2 testing series to
cause trouble to downstream distributions (in particular if
they have PIE enforced).

Since v2:
- addressed Laszlo's suggestion
- reworded patch description

v2: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01033.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01006.html
error report: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg00=
992.html

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (2):
  roms: Rename the EFIROM variable to avoid clashing with iPXE
  roms: Allow passing configure options to the EDK2 build tools

 roms/Makefile | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

--=20
2.20.1


