Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A7CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AF822CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="a/Dgma1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AF822CF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i552c-0001U0-At
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 05:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1i54zU-00081Y-4i
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1i54zS-0002NX-Vn
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:20:44 -0400
Received: from mout.web.de ([212.227.15.3]:37479)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1i54zS-0002MX-JK
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1567502419;
 bh=+LLNjVW6G5lvrZbMtDNdr8Ub+UdOtixoID9Yia6Hj80=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=a/Dgma1N1B0PBriVobYWKtHy50QjUgBGP+0BReYbC5KkWqrM5rDrbiGO8dUkwDa8A
 MWheTr56Ci8MEAoW4FrP08KpdSNu2ZQPku84DOPY5GQ3aFKreHeXJa7jaHBx6vc/GB
 V8dpZnfC7GSKeOduAa8od1WX2h4Hcz0pfEdnxQDU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.78]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lw189-1iFQH13JFd-017n4s; Tue, 03
 Sep 2019 11:20:18 +0200
Date: Tue, 3 Sep 2019 11:20:16 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <cover.1567500411.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gkGyd9mgMUEtyXMJb3+DMrGasPQzSdshnH61ddm1XlJssDJ+Z7/
 C58G/mqTEOv6UwSFZh8W+nLFUIHVHkLbJUHdr5T6heFJoookrpggZjuwtSD+6KnepaxuFXB
 3E0038ZIHRMLuK/ZfkxKraeenC/MtmGxQkGo5U5GRabAHya0JUh9PYVMgL5z59INZyEIPmG
 Bzbv8xg4RgD/WtrD+7ikg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vNeMjFUnX3o=:LTpdA/IkqVeRkiKo0ozvNJ
 aSZ+56DvBM4H0teMAq4BeIAFDAxhCDuJSMo2vTXqRav8qOCNJ4dDVRepxKVY16X2UJpft+O4J
 1/XFQzmTtY8jsKwBYIHVZwonUjE5RJHNdvkt3hDHuceJ4sjAinF+PbQRkTzdWIA9R5G/uvW5p
 QRHmKwE4i+2USs7WJrg5dZTF9tKAN9G9EahODuRYcXshz/nUzD5AqWo3ZgsE/CSM553gdzbro
 HfAIIHAW64m0ezqs2rd6o+XGLeMJFBhLIRMxGpK0xsF70yFfktK4+IgyoL7gAaWPzmelBkZuZ
 6NIugfUYtja0PJe1DQ1ezfH1B46K3IzQAWD+029oeYU4C07A6UWhdnkparscolXuQRXc836Tb
 POdFZd/9zDJU2OQ2HCFxX9rxXCFH5nqgRyHPT2WEQpd6O2cf+EzOR3zlll2SfuMvcz3PDMqv+
 MnrUqMBMiZGldTb0ZVVNwTOK8GorKnzwJPb21g5cAhibzMvs5obrBSL3KRvhwo9FGEG2DH0Zn
 g8xLBMUqgJFv6Aq7KdlmovXKH+TrsB6PbRZyri4HbjavrXvVqi0OUffTr4IrXyY6zTmAMI6xd
 TKIwdw6CVpGq/FcH8dBl+tIE90byYURyoJuZBIoDl7d6uufMsgjyweProuqCgMEhKnCbWMkiY
 KzxBxgUXPd0B3U0kTXKKy02s5L3cnfysmhIp4oqfjwj2Ly8JfpxfPVQRn+bkOexxi1RqwfzV7
 bXXfVoiYOKt4jPJZSSv40U3grbr9n07Bzk7ZBFomNhNbFPMe2TRhh6zgWSAlXR3x6lWWyoSQO
 7V+zBcsC05/2Thlua35DqLNpZDhTYN7sbxEXa9hdmAmDY2qcKwpBess4a9KzAcZckoHhBFEL5
 UUjeUsQvK6ZNCs6rLGcCKzfJM5ixCx1vdFrCm7rXLjHJ6xmmSapQ/ZfLccBfDp2DnVHEVLUAa
 ZKYx0dXuLFHFhnCdc/ZyMBr8o8lFyBnzf64Chevhfjzy9Jvg8R6VvNJhBU1IwGyZqy/3MRUq1
 KXFB8ZVVwF4YxNTWthLqgTUfqCf4RianIbjbozYBDuOOCbyfUjTA39tvJLYsZifpk40XaIvRS
 zhR6QLRheKQcKNDiBchLo9bM6smq6N4KaJG6xXPSTmQu5/Cq8la8BJImwkxKRivXbS+yRDoxo
 cUcsTIn9hry9NY7XNMXnzQ4yGQila2F/KBed6MV1StxXCqLw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.3
Subject: [Qemu-devel] [PATCH v3 0/4] colo: Add support for continious
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
These Patches add support for continious replication to colo. This means
that after the Primary fails and the Secondary did a failover, the Seconda=
ry
can then become Primary and resume replication to a new Secondary.

On a side note, I wrote a Pacemaker Resource Agent for colo which I will
post when its ready.
I have to say it's quite fun to randomly kill a Node, wait for resync
and repeat and see how the VM stays alive all the time. :)

Regards,
Lukas Straub

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
  colo: Update Documentation for continious replication

 block/replication.c        |  38 ++++++-
 docs/COLO-FT.txt           | 212 +++++++++++++++++++++++++++----------
 docs/block-replication.txt |  26 +++--
 include/net/filter.h       |   2 +
 net/filter.c               |  78 +++++++++++++-
 qemu-options.hx            |  10 +-
 tests/test-replication.c   |  52 +++++++++
 7 files changed, 343 insertions(+), 75 deletions(-)

=2D-
2.20.1

