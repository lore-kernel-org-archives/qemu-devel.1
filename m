Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49909C4CECD
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C522067D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="U0/GS2YT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C522067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9aEi-0003kZ-L3
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 15:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1i9a4R-0003bf-Se
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1i9a4Q-00012i-V7
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:20:27 -0400
Received: from mout.web.de ([212.227.15.14]:36371)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1i9a4Q-000112-M3
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1568575195;
 bh=ppWNVTe6sizP2ChzFyAocsWaZ00+Z0YbkfJfWzg8wOo=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=U0/GS2YTymIVp6kPrtVOF34Q9WBQWfIs1yuH5+hda9pLdZVTDS7RzV5wCSAiG0pW/
 I1aTuhP8wTY/g3wdCZV4fYxbZO/lpiaTDe3V+E2rNFtaFaTekyukbMmXkGvTs44rcp
 5071GXenibbNQqtx0FaoHIP1YfaOSMftSGkgMyF4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.53]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MN87U-1i2zPn17Oq-006jR5; Sun, 15
 Sep 2019 21:19:55 +0200
Date: Sun, 15 Sep 2019 21:19:50 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <cover.1568574478.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:afOcVmkcVjSwCj9QnuphNDfip6nfzVGKyItYe92gZ9RHEv7krDu
 3ugYjb9bOq4Yvl17Se1Jh5JFZzFHm5FUrvCjmXjk8Rr1h79Qhg7Coa5UYJOVA+NtW9C7aH9
 LEwdPj7Q33L9LTPPN0DHaWTNky3EZYdXjqGUOv9XMFWgvzBb1DSucamZH+KoLgSm3Sn0fiG
 bQmuQuSc3YOu+YLxzzNLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TNIdZaQIBzg=:tH0P0HyRgJGwCTNm+IStj2
 v0mIjOs/4OBpuSlkebczyYfARK3QTPraoL8N9dxB0LkSy3/P8bj6XSr33drhgfr8L2dz0wBbT
 QmGEddOGUXNxDBQAvc2VA/vOZSM1MGOlJECFv8K4L94xdzdDS6Man7xIbS7ORdpQ9Yj4KIdoP
 W2+qt4dTch9yXGrZqBYBO6uHHHppqM7Dvo0Ea3vV1dj7cqi1Wg3RLxEe4MTERf1LT9PFiDqSc
 SmT4jVIs/kg+1Z3O2x0ScS5oCeMv/q4EUhNwIqnko9m9X84nYaB3Gc3/i+Q8p/G5cVSmzgGn5
 P1MFomnISDQjXFzNiEQ7frvl+TzRmmf6XSf0hfewhksyYjd+EOWyRaM1WlXYF412x0uSOf9sm
 1xh7dS2vQ/D5mXvCCfaLRaDYWDMibBroKz7UdR/t+a3ELDpB0QI8XzPuPrpjNbMXhLxFcE2tn
 szdt4D30wiNavpaAfLip2g/1DRRqp8DdYq2BaQ/VN1qw/jU6+0PNCFrqbmY7PtlYY6/f63tkq
 Jqg6jhSIHRgVAFCg/d7uf4LifK2HS+AZn9QSa4K4rjFwWxkEbNl2oTK1FUECLtQVuSpvgPxZr
 qctotXic8/Y60DV3Tp++q/iwVM0ubYwgAVJFOdbMXnUxrjXYne0xxSsWRJmTlniaS2YwU2CTl
 otnJ5qMLDkkkiMmd7G5LZnwMMC/YI0Dw7UxfUiYQT4A4wy7rhoBkHuQeiE7S7diyEdi9/Hw2z
 E5mthjS037/65s1efPJP3VIH6javI0u5Ik3CIqCABrRJeYE/0CQmNrBx/DOhYuT+HQKxyJ3d+
 PY4SH7I1X6dNgVhxmAUQ0dmMrnNbhMauiRrXz0oMQx+MtTaVugekIC/FoTxE1rlSZigaiEdj0
 BCyOQO+imE0X1GSvzzlqaeGe9fVc6Itaw/V/Un1B9DK1eaml7vMcPEc162xfSEt0AnjgwlktY
 W0LzcLpdlRxuKzCRFip1iq6LeQLnBuBFPlyH61+TF7mWxKeERzgsQBOKY6Igv6CQp8iP/xoT2
 aFarAymM/Km0Mv4O9Wz/xyHD8O2/L4yjMRTAv573QulJi+gQGJfTo/AsFQfgcpDOA4HsyDx73
 7bcuhxjRjnFuKjXy1ID3Q+j2ayHvGsY6aM1i6c3ASpIBQtRFzCZR3Bw3yy9mI++Z1NglIUf09
 IEX3wgPlj9hhOyErqZz5wePuXeV0o1cbPinNLJ6hI9n9gziyd8nO2sSDJh3MfbAiObXj0+AjF
 t+B53FJV//8pPDIXJqs7tcNcIf/IyeK4JtVhwHejFTh0VTgjq3NDwogK/Mmc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.14
Subject: [Qemu-devel] [PATCH v5 0/4] colo: Add support for continuous
 replication
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
Cc: kwolf@redhat.com, Wen Congyang <wencongyang2@huawei.com>,
 Jason Wang <jasowang@redhat.com>, mreitz@redhat.com,
 Zhang Chen <chen.zhang@intel.com>, Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Everyone,
These Patches add support for continuous replication to colo. This means
that after the Primary fails and the Secondary did a failover, the Seconda=
ry
can then become Primary and resume replication to a new Secondary.

On a side note, I wrote a Pacemaker Resource Agent for colo which I will
post when its ready.
I have to say it's quite fun to randomly kill a Node, wait for resync
and repeat and see how the VM stays alive all the time. :)

Regards,
Lukas Straub

v5:
 - change syntax for the position=3D parameter
 - fix spelling mistake

v4:
 - fix checkpatch.pl warnings

v3:
 - add test for replication changes
 - check if the filter to be inserted before/behind belongs to the same in=
terface
 - fix the error message for the position=3D parameter
 - rename term "after" -> "behind" and variable "insert_before" -> "insert=
_before_flag"
 - document the quorum node on the secondary side
 - simplify quorum parameters in documentation
 - remove trailing spaces in documentation
 - clarify the testing procedure in documentation

v2:
 - fix email formating
 - fix checkpatch.pl warnings
 - fix patchew error
 - clearer commit messages


Lukas Straub (4):
  block/replication.c: Ignore requests after failover
  tests/test-replication.c: Add test for ignoring requests after
    failover
  net/filter.c: Add Options to insert filters anywhere in the filter
    list
  colo: Update Documentation for continuous replication

 block/replication.c        |  38 ++++++-
 docs/COLO-FT.txt           | 212 +++++++++++++++++++++++++++----------
 docs/block-replication.txt |  28 +++--
 include/net/filter.h       |   2 +
 net/filter.c               |  92 +++++++++++++++-
 qemu-options.hx            |  10 +-
 tests/test-replication.c   |  52 +++++++++
 7 files changed, 358 insertions(+), 76 deletions(-)

=2D-
2.20.1

