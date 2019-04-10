Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC34C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 14:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3279120850
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 14:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="jU5eqyvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3279120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60701 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEEJ2-0005c9-HE
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 10:34:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hEEIH-0005Ii-E3
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hEEIG-0000sg-HB
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:33:41 -0400
Received: from m12-14.163.com ([220.181.12.14]:43735)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hEEIF-0000ga-Ac
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=MIME-Version:From:Subject:Date:Message-Id; bh=YYEtr
	Q+nRtTmfMrq9b1KloF6mg9gx0zEIPJTZassw9M=; b=jU5eqyvWf8uHqCb/be9Ws
	JrCT+LuvYK1oafvgdAU2xdKiNaCMfjw1FBxedzAnTzGj5SHwiZZ4OHAqQunfyXzQ
	RoCuDHAxReEWVI7gczAw2phLQT+dZO8FtU2rw7TA5rWoF7DO2H3vMfQXak9Di2Py
	opVeMz46ZXL/E79XsTGe4w=
Received: from [IPv6:::ffff:192.168.0.5] (unknown [183.157.98.195])
	by smtp10 (Coremail) with SMTP id DsCowAAXjzu2_q1cSvbmAQ--.55128S3;
	Wed, 10 Apr 2019 22:33:26 +0800 (CST)
MIME-Version: 1.0
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"mst@redhat.com" <mst@redhat.com>
From: Li Qiang <liq3ea@163.com>
Date: Wed, 10 Apr 2019 22:33:24 +0800
Importance: normal
X-Priority: 3
X-CM-TRANSID: DsCowAAXjzu2_q1cSvbmAQ--.55128S3
Message-Id: <5CADFEB7.01C57B.25694@m12-14.163.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIXdbUUUUU
X-Originating-IP: [183.157.98.195]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiFBeSbVaD0Hv15wAAsQ
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.14
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] =?utf-8?q?Questions_about_acpi_interrupt_link_device?=
 =?utf-8?b?J3Mg4oCYX1BSUycgZmllbGQ=?=
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
Cc: "liq3ea@gmail.com" <liq3ea@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410143324.FFt0JHGULDszaGodcZwpn7fSfx_qZMg33h9s2Bwf-N8@z>

Hi all,

I see the link device =E2=80=98_PRS=E2=80=99  uses irq line 5, 10, 11 in =
=E2=80=98build_link_dev=E2=80=99 function.
But I never see the 5 lines uses in the guest, just uses 10 and 11.=20
Why this happen?  Maybe related with the guest?

Thanks,
Li Qiang



