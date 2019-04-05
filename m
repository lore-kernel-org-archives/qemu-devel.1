Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BACC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE37821726
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE37821726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43577 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCQss-0006hh-43
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 11:36:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCQrJ-0005i5-Nm
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCQrI-0003a0-Oa
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:34:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCQrD-0002kp-3L
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:34:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C5912CD7E7;
	Fri,  5 Apr 2019 15:33:27 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.179])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 953955D707;
	Fri,  5 Apr 2019 15:33:17 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
	Olaf Hering <olaf@aepfle.de>
Date: Fri,  5 Apr 2019 17:33:12 +0200
Message-Id: <20190405153314.2068-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 05 Apr 2019 15:33:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.0 v2 0/2] roms: Rename the EFIROM
 variable and let it be overridable
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
Cc: Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405153312.eQA3ncSdaXWtpSvwNwEWtzHruBK_SSNaoC-aXMnPNJM@z>

Hi,

Two trivial fixes to avoid the latest EDK2 testing series to
cause trouble to downstream distributions (in particular if
they have PIE enforced).

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (2):
  roms: Rename the EFIROM variable to avoid clashing with iPXE
  roms: Allow the EDK2_EFIROM variable to be overridden

 roms/Makefile | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--=20
2.20.1


