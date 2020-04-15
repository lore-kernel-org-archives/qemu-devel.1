Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2B1C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 03:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E87206F9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 03:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="ROOMXU12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E87206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOYjf-0005Cf-Oa
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 23:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jOYic-0003qj-B3
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengli@smartx.com>) id 1jOYib-0003SD-3O
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:28:06 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fengli@smartx.com>) id 1jOYia-0003Rf-Mx
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:28:04 -0400
Received: by mail-pf1-x443.google.com with SMTP id m21so900679pff.13
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 20:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:to:cc:subject:date:message-id
 :content-transfer-encoding;
 bh=qdVfe2QUukV3BpLl1BRexPLCXtYN6LN/z+zHrtHIb5U=;
 b=ROOMXU12WqwarlXx/o/Aiz7FZdkHe92o09mtE6rhIZfkZK1E9kr6LZDQP1yoE0gNuN
 EP4UVNKCVyJED+6PliEej8Byiu+LtgK9lngEuwyTIRjaLXZLAsxwl0ilh2WZ7zl+JQ0v
 u+5NOo9KYVCpaMinxx5xgKSX7VasKdMifAuyWWOvmiIYVyh44S7YGS529LdROSyQmpzN
 kP67192KKjXYQFt6Zu3pvpclsadDHapQ+ASvGe5NeVkNMuRrtEs+/7ZZm5eJ1FBTam0E
 ePjcAtn4+MrNNYGOgazr3ST6mNrC7zXDAm+H5S2IjBT+Jn6xTxT4ET7A0UIRYea/vLJl
 Xn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :content-transfer-encoding;
 bh=qdVfe2QUukV3BpLl1BRexPLCXtYN6LN/z+zHrtHIb5U=;
 b=hmalRtZjvEQbxiNjoqYebMJ5qncT2yKtkOzt9bKQtOKfx3vJEGcQyzUd8qVCfUl90m
 CWGFDtusdlrhvnbfWEVDLh3sXrPtai8Wwk9ZQ05jM8dUA2higtu/pl8QPf73dUDJdBAA
 3f2WJzMvt1IKgiG+gTsBsZqvjetzq1x0iefmoCDsLjDKbkbGB5Q211vGmarVhAmYH/fm
 AKj4Rs4RrqdoA2Wt8LGkc3iu8b5ZIfKeU5icg0kDYLX2eT1IP5a3OnJuZIu8Rs/ppMw4
 Y7qaSqvumfxicg0VZFz8AEPrC48V3/4XyWi0LpU5JBdXpj/h6hV/3B4Ard4R2MdV2Qoa
 3PoQ==
MIME-Version: 1.0
X-Gm-Message-State: AGi0PuYGavoMpAVwXhLd3ipUnu8qVkXbXaTBLtwv9qF3jc/lzy93A4jo
 y7cK2Lr13EeQztkxKNd3/pxOiVz7VeqYsqogZEQM4T+J9abFowJB/HvV8jXayEnbLmp2BK64fQ0
 JP4lJnx0l
X-Google-Smtp-Source: APiQypJVbN9kez0cF++JkBTrjF/nWha0ybWyUqjQigyxByWx3hnYf7pX4pU7dEk0TN9/zv/S4Kle2A==
X-Received: by 2002:a65:6250:: with SMTP id q16mr25829502pgv.9.1586921282745; 
 Tue, 14 Apr 2020 20:28:02 -0700 (PDT)
Received: from 31_216.localdomain ([47.240.167.159])
 by smtp.gmail.com with ESMTPSA id d21sm5915061pjs.3.2020.04.14.20.27.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Apr 2020 20:28:02 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: kyle@smartx.com, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here),
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH 0/4] fix crashes when inject errors to vhost-user-blk chardev
Date: Wed, 15 Apr 2020 11:28:22 +0800
Message-Id: <20200415032826.16701-1-fengli@smartx.com>
X-Mailer: git-send-email 2.11.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Li Feng <fengli@smartx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following patches fix various crashes happened when injecting errors to
chardev unix domain socket.

The crashes are encountered when the socket is from connected to disconnect=
ed at
vhost-user-blk realize routine.

These crashes could be reproduced like this:
1. gdb break at vhost_user_write;
2. add a vhost-user-blk device through qmp;
3. when stop at vhost_user_write, kill the vhost-user-blk target;
3. let qemu continue running;
4. start vhost-user-blk;
5. see crash!

The 'CLOSE' event path is core trouble maker.

qemu_chr_fe_set_handlers
   -> vhost_user_blk_event(OPEN)
       -> vhost_user_blk_connect
            -> vhost_dev_init
                -> vhost_user_blk_event(CLOSE)
                -> vhost_dev_cleanup


Li Feng (4):
  vhost-user-blk: delay vhost_user_blk_disconnect
  vhost-user-blk: fix invalid memory access
  char-socket: avoid double call tcp_chr_free_connection
  vhost-user-blk: fix crash in realize process

 chardev/char-socket.c     |  5 ++++
 hw/block/vhost-user-blk.c | 75 ++++++++++++++++++++++++++++++++-----------=
----
 hw/virtio/vhost.c         |  2 +-
 3 files changed, 58 insertions(+), 24 deletions(-)

--=20
2.11.0


--=20
The SmartX email address is only for business purpose. Any sent message=20
that is not related to the business is not authorized or permitted by=20
SmartX.
=B1=BE=D3=CA=CF=E4=CE=AA=B1=B1=BE=A9=D6=BE=C1=E8=BA=A3=C4=C9=BF=C6=BC=BC=D3=
=D0=CF=DE=B9=AB=CB=BE=A3=A8SmartX=A3=A9=B9=A4=D7=F7=D3=CA=CF=E4. =C8=E7=B1=
=BE=D3=CA=CF=E4=B7=A2=B3=F6=B5=C4=D3=CA=BC=FE=D3=EB=B9=A4=D7=F7=CE=DE=B9=D8=
,=B8=C3=D3=CA=BC=FE=CE=B4=B5=C3=B5=BD=B1=BE=B9=AB=CB=BE=C8=CE=BA=CE=B5=C4=
=C3=F7=CA=BE=BB=F2=C4=AC=CA=BE=B5=C4=CA=DA=C8=A8.



