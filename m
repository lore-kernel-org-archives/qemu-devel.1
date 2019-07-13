Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED4CC31E40
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 17:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D15D20848
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 17:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D15D20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weilnetz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmM6Y-00023f-4I
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 13:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43361)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sw@weilnetz.de>) id 1hmM6M-0001ff-SS
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 13:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sw@weilnetz.de>) id 1hmM6L-0001FS-2f
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 13:46:26 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:59694
 helo=v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1hmM6K-0001Dk-O3
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 13:46:24 -0400
Received: from localhost (localhost [127.0.0.1])
 by v2201612906741603.powersrv.de (Postfix) with ESMTP id 5704ADB85E1;
 Sat, 13 Jul 2019 19:46:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at v2201612906741603.powersrv.de
Received: from v2201612906741603.powersrv.de ([127.0.0.1])
 by localhost (v2201612906741603.powersrv.de [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id DsZvG8toFtvE; Sat, 13 Jul 2019 19:46:18 +0200 (CEST)
Received: from edv-macbook-pro.fritz.box (p57B4293C.dip0.t-ipconnect.de
 [87.180.41.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by v2201612906741603.powersrv.de (Postfix) with ESMTPSA id 8A295DB7960;
 Sat, 13 Jul 2019 19:46:18 +0200 (CEST)
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 peter.maydell@linaro.org
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <030a439f-bb17-8232-bd1c-3585905e8feb@weilnetz.de>
Date: Sat, 13 Jul 2019 19:46:17 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 37.120.169.71
Subject: [Qemu-devel] [BUG] 216 Alerts reported by LGTM for QEMU (some might
 be release critical)
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

Hi,

LGTM reports 16 errors, 81 warnings and 119 recommendations:=20
https://lgtm.com/projects/g/qemu/qemu/alerts/?mode=3Dlist.

Some of them are already know (wrong format strings), others look like=20
real errors:

- several multiplication results which don't work as they should in=20
contrib/vhost-user-gpu, block/* (m->nb_clusters * s->cluster_size only=20
32 bit!),=C2=A0 target/i386/translate.c and other files

- potential buffer overflows in gdbstub.c and other files

I am afraid that the overflows in the block code are release critical,=20
maybe that in target/i386/translate.c and other errors, too.

About half of the alerts are issues which can be fixed later.

Regards

Stefan


