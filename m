Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E08C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5157E21D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="BMsFNbc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5157E21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDWcT-0001la-FZ
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iDWLs-0007n5-GK
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iDWLo-0001eT-R7
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:10:42 -0400
Received: from mout.web.de ([212.227.15.3]:57589)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1iDWLl-0001bO-Lr
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569514200;
 bh=ntdPFKlLlWF0Oehmz0zzi6cXik6YGFULs1o1Dh1W0VI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=BMsFNbc10REMNj/OdG9nsj7aUv+FedGCBwS2llHMVKIF5IzG//nwigBVJJKE+Cihf
 BbzuZrPKO7LoZ1V4kmezkQikaAJqcq0v5iPGfbvtbIhiXykDhNoqRDBexnND84KFbp
 m5uiTJ0O9VlbELqx+lep1pHwDSeR3UeQLkpjarQQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.190]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LwlY0-1i6hnc0G76-016Sl6; Thu, 26
 Sep 2019 18:10:00 +0200
Date: Thu, 26 Sep 2019 18:09:56 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 0/4] colo: Add support for continuous replication
Message-ID: <20190926180956.731f3c6f@luklap>
In-Reply-To: <cover.1568574478.git.lukasstraub2@web.de>
References: <cover.1568574478.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zZ4FW5xEdlHY3+ulZJ0XpFlpbRgL6/QWwoOYxkfwiVKTs3V/SOc
 lxOvbEmzkGh1NSjIhJr7OP/t/DZM0HfOFE4oCrKQTSYFvDzDEImuY/qthP9CD+nfF14Luja
 tZdIS/6mEq/WhcO7WlwgPgOoIozQq7MqqX2R3F758zqZNGmvbddy5z/Yz9CYgLaPTtofdRM
 uNJc/VsEuLRirMSiSMUpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E1ktlcym92M=:MHxgv3l37knYe85ROGlESd
 9SK8FgtQCuBuvZDKKDp7MDFsTT4f/Y8o7Yz9NWDDqXoQImy5SZEK01cJFLlp2MmXHLo/CY32V
 4prClQRimGdT3v/2qE4rF3pT0izf3UoCANCNqd9689qzEuR4dUGQ/GstJTXbezLP3hTxjvnKb
 ye/UeO4lEl10OF9AHWcaZetxdw2LkDFZwVjqQ+wg/Vlo5VR+b5keAO2BYXQSt/iYdDXtAIMbN
 mhRwj9rJTBesev3bvxr4te4bfWOhsLzGA4lul9fBTl1k9iM/YqJCXEDeBGDEjkEndi5rdpylw
 gJdm/gRQ3x7dscUlS5HJCf/i80zoce4kiTiuZ/jRjzDfbnrytKg39fOPEhQEY1yKDulKI/GUD
 1TcVvUhTzIZBTCkz8A1C1qI+y8YdM2ee622FBZBCbbnwf81N6jhUuuyaZ79e/ues/Ydvjgrjw
 X5ZPlGK4GzVdLIi6YZ67RJuLMkEqeLM0cb6DZVKO8FtqyssHlowGso73HSADlr7y5/5qXov5G
 KNR3MqYqDT7/doKJjK8cBYOEI+Ko76RyQPmSBkWve1cddebBbPP38zK3HSuP3wzKjQomZJrqm
 ZEKRubO9KJDC1BbE8oA0Z1NWd3SU9UJsk+pKrZ0Z1NrSnsyrBZZCJRkRy4jO5bgVYdJutABOF
 Q/LKYS2ZghBM1fH8ss8oyRz+PJEQOxi2rQXlwaxOpg1ThsRdfcTRGMmNq8LvQr1QqScqDayPN
 bgJSiqxMA0vBqPtx6zQY76Pftd0PLY+0o9R/1QgeDdez4NDDbVSXv9UxgRzsdiVrvDkDcBYIp
 /V4W+FgXfbe/PBsJ6AAPjlYEDWQvfrF1AMBoOrXnPIqaRCZl5KntZ4/YlTi66JTXcrXqnbGos
 YV57i90urvim4YIExVgGIvTmBdJzWdQrh/O6ZZWh7S9miTYWChj4CSO4rDLmOLDSldtR1QUAK
 /0jmDzIPgGrvPB+1M1ab6K+gTattBewKW490J5qWXtm5ZZrlwPu+qQk3Z6MBGE76GtIwpnDlH
 x3Gi722nlYCGyVTFepqDwjZPBCyAEr3YEIgn5cOZm5cIRRkw1MYBuQDmTxUP60hSchzCW2RFN
 9WnT41ZBQJK73OKB/74QuTUz1eAJXq5CRV/Qb8x/3DfTVkGrv5GzKdo3eQEOvlN/t/R6n2C0i
 c4njNDJxPh3keqmtZHYtakQXHfe41hhZ6ZtqGiAV5REA3M9viMjqjwYJmQMn38Rs+0oPmmk1d
 Rm2WmmPk7+cKJwTqSnKPX9PqHl+EcciVzvBI/lL3a0471qcWMqnVGTJjFMsI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.3
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

On Sun, 15 Sep 2019 21:19:50 +0200
Lukas Straub <lukasstraub2@web.de> wrote:

> Hello Everyone,
> These Patches add support for continuous replication to colo. This means
> that after the Primary fails and the Secondary did a failover, the Secon=
dary
> can then become Primary and resume replication to a new Secondary.
>
> On a side note, I wrote a Pacemaker Resource Agent for colo which I will
> post when its ready.
> I have to say it's quite fun to randomly kill a Node, wait for resync
> and repeat and see how the VM stays alive all the time. :)
>
> Regards,
> Lukas Straub
>
> v5:
>  - change syntax for the position=3D parameter
>  - fix spelling mistake
>
> v4:
>  - fix checkpatch.pl warnings
>
> v3:
>  - add test for replication changes
>  - check if the filter to be inserted before/behind belongs to the same =
interface
>  - fix the error message for the position=3D parameter
>  - rename term "after" -> "behind" and variable "insert_before" -> "inse=
rt_before_flag"
>  - document the quorum node on the secondary side
>  - simplify quorum parameters in documentation
>  - remove trailing spaces in documentation
>  - clarify the testing procedure in documentation
>
> v2:
>  - fix email formating
>  - fix checkpatch.pl warnings
>  - fix patchew error
>  - clearer commit messages
>
>
> Lukas Straub (4):
>   block/replication.c: Ignore requests after failover
>   tests/test-replication.c: Add test for ignoring requests after
>     failover
>   net/filter.c: Add Options to insert filters anywhere in the filter
>     list
>   colo: Update Documentation for continuous replication
>
>  block/replication.c        |  38 ++++++-
>  docs/COLO-FT.txt           | 212 +++++++++++++++++++++++++++----------
>  docs/block-replication.txt |  28 +++--
>  include/net/filter.h       |   2 +
>  net/filter.c               |  92 +++++++++++++++-
>  qemu-options.hx            |  10 +-
>  tests/test-replication.c   |  52 +++++++++
>  7 files changed, 358 insertions(+), 76 deletions(-)
>

Hello Everyone,
Ping.

Regards,
Lukas Straub

