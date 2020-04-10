Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A77C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 12:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18C820769
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 12:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18C820769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMtBT-0007P9-Sd
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 08:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jMtAr-0006z1-NO
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jMtAp-0005wN-RU
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:54:20 -0400
Received: from [192.146.155.5] (port=21134 helo=mcp02.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jMtAp-0005tm-LH
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:54:19 -0400
Received: from localhost.localdomain (unknown [10.22.39.231])
 by mcp02.nutanix.com (Postfix) with ESMTP id 4E50E10061FA;
 Fri, 10 Apr 2020 12:54:18 +0000 (UTC)
Date: Thu, 9 Apr 2020 20:41:15 -0400
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: mst@redhat.com
Subject: Feature and message numbers missing in vhost-user.c
Message-ID: <20200410004115.GA7738@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 192.146.155.5
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi MST,

I see that a new feature, VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS
(https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/interop/vhost-user.=
rst;h=3D3b1b6602c77932101e1e3b098e35c2497f5b0260;hb=3DHEAD#l817),
and corresponding VHOST_USER_VRING_KICK
(https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/interop/vhost-user.=
rst;h=3D3b1b6602c77932101e1e3b098e35c2497f5b0260;hb=3DHEAD#l1252)
message has been added to the documentation for the vhost-user protocol
and seem to be added in libvhost-user. However I don=E2=80=99t see the fe=
ature
or message number reserved in the core vhost-user code
(https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/virtio/vhost-user.c;h=
=3D08e7e63790e5bcfae6cd31bf9ccd32c3a7347f4e;hb=3DHEAD#l47)

I understand these features are mostly for simulation, but surely
the numbers for these features should at least be reserved as more
features and messages are frequently being added.

Is this an oversight? With the aim of preventing future confusion should
I send a patch to add them in /hw/virtio/vhost-user.c?

Thanks,
Raphael

