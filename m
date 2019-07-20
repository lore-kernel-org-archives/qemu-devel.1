Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AA7C76186
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 23:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F4D20823
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 23:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPcOnIjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F4D20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoz5P-0003xq-Sn
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 19:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35423)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <skrtbhtngr@gmail.com>) id 1hoz5C-0003T1-EF
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 19:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <skrtbhtngr@gmail.com>) id 1hoz5B-0002oq-AV
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 19:48:06 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:42189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
 id 1hoz5B-0002lW-2f
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 19:48:05 -0400
Received: by mail-pf1-x42a.google.com with SMTP id q10so15683894pff.9
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 16:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n8MNLXF6T+cIbWNxt3i5DSbSO8zPbkUNoZ71DH9WcCc=;
 b=WPcOnIjokaJRw8RZJz2X71EMh4TcAH43coVh4Yd51/ohtmfDzKkXwTn77SH/eXV/aG
 6xQ5n/pA9GmtfAXa7/z1yyjjptgoguERQ+uAve6NEYZrzRchMTJujfVd96uX7Cx3yhnr
 afHGgO/cD+cPnSCGrECZEl61m5DvuJL5chv86AZObpryXLK/xtwT1lvLyDD1QjLf6pnZ
 /Eq517PuTQXtuvC9DTny81Uq9Y577UooJ9NMHMx4rQP2Q8qQAXWJMSiENp7NDdx5G4nH
 +kplrDrXnZblU67qgrLwVOYSjmV2Ltqa8lTdVfj9dA55ozCwgM2EUSQTFwsamt/qrnfC
 246Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n8MNLXF6T+cIbWNxt3i5DSbSO8zPbkUNoZ71DH9WcCc=;
 b=JtiF5Ok/QTSE9TJJoYb9pT7RuHqTYgUqDOjIyuaogw4BzKAlL1KLUge5HqGSnzqsV6
 yfnNsqyo0LHI506TpILoKuiRWwm5oA48hpPDmWGXsUEATZVME638m9Q3sDkDSezqob2U
 wGtZLkPks0zzhS6Vb4z9r+tMgEukWLBpCcLkXd/rH5zC+FOiSUrQMISseoEOzl692IZR
 qwGaZKd3eh30EEFnV/niQnqdLjagEh5oMFUFJrxA+d3Ey0eAte504RKljQd6nmuHK0zN
 qFy6gpeTtgTIYw4wS7KrSiCkeyDQ30ef7Kl4p7CCyEwGMG4ar7g4yiUqZzQ3gyvvuJXS
 uhcg==
X-Gm-Message-State: APjAAAVhrXL2BHFEasicDaFQLUPI7dJqCWaRXvTgpHRBBgo57bsyHpWw
 k4Vt8QHlUHVgA5f8O4+enPDbY0nw
X-Google-Smtp-Source: APXvYqxqkuNzqBeW1xXYy4rWMGIODhXuScu1QIt9FcLmmprFXC0NOl0u5LN0NpR20W7XBObVd2waFw==
X-Received: by 2002:a17:90b:95:: with SMTP id
 bb21mr67983617pjb.8.1563666482020; 
 Sat, 20 Jul 2019 16:48:02 -0700 (PDT)
Received: from beta.cse.iitb.ac.in ([2405:204:20e:f16f:2a5b:d596:9ab:8e05])
 by smtp.gmail.com with ESMTPSA id b6sm31229151pgq.26.2019.07.20.16.47.59
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 20 Jul 2019 16:48:01 -0700 (PDT)
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 21 Jul 2019 05:18:01 +0530
Message-Id: <20190720234803.18938-1-skrtbhtngr@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42a
Subject: [Qemu-devel] [RFC v3 0/2] Add live migration support in the PVRDMA
 device
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
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In v2, we had successful migration of PCI and MSIX states as well as
various DMA addresses and ring page information.
This series enables the migration of various GIDs used by the device.

We have switched to a setup having two hosts and two VMs running atop them.
Migrations are now performed over the local network. This has settled the
same-host issue with libvirt.

We also have performed various ping-pong tests (ibv_rc_pingpong) in the
guest(s) after adding GID migration support and this is the current status:
- ping-pong to localhost succeeds, when performed before starting the
  migration and after the completion of migration.
- ping-pong to a peer succeeds, both before and after migration as above,
  provided that both VMs are running on/migrated to the same host.
  So, if two VMs were started on two different hosts, and one of them
  was migrated to the other host, the ping-pong was successful.
  Similarly, if two VMs are migrated to the same host, then after migration,
  the ping-pong was successful.
- ping-pong to a peer on the remote host is not working as of now.

Our next goal is to achieve successful migration with live traffic.

This series can be also found at:
https://github.com/skrtbhtngr/qemu/tree/gsoc19


History:

v2 -> v3:
- remove struct PVRDMAMigTmp and VMSTATE_WITH_TMP
- use predefined PVRDMA_HW_NAME for the vmsd name
- add vmsd for gids and a gid table field in pvrdma_state
- perform gid registration in pvrdma_post_load
- define pvrdma_post_save to unregister gids in the source host

v1 -> v2:
- modify load_dsr() to make it idempotent
- switch to VMStateDescription
- add fields for PCI and MSIX state
- define a temporary struct PVRDMAMigTmp to use WITH_TMP macro
- perform mappings to CQ and event notification rings at load
- vmxnet3 issue solved by Marcel's patch
- BounceBuffer issue solved automatically by switching to VMStateDescription


Link(s) to v2:
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01848.html
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01849.html
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01850.html

Link(s) to v1:
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04924.html
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04923.html

Sukrit Bhatnagar (2):
  hw/pvrdma: make DSR mapping idempotent in load_dsr()
  hw/pvrdma: add live migration support

 hw/rdma/vmw/pvrdma_main.c | 94 +++++++++++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 8 deletions(-)

-- 
2.21.0


