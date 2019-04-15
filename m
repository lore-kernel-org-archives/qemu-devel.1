Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F7AC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD4F2077C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1T/y/2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD4F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50226 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG1ei-0005Bg-3Y
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 09:28:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fengyd81@gmail.com>) id 1hFxJx-0001wd-P1
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fengyd81@gmail.com>) id 1hFxJv-0002yP-VA
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:50:33 -0400
Received: from mail-it1-x12f.google.com ([2607:f8b0:4864:20::12f]:37350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fengyd81@gmail.com>) id 1hFxJu-0002uv-Co
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:50:30 -0400
Received: by mail-it1-x12f.google.com with SMTP id u65so25409208itc.2
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 01:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=pwJczkHJf5dylMpf7qQKSRS9xAoxuZvn6hdjNg8s+x8=;
	b=N1T/y/2qMskO6HpJLazVwg8anm7ahY02zKigANu4Oyf6TXGz/ZQAaJs20GfRX+ed+E
	STHCQw61yBNVBgXBiTxZZLDfhbiIXwPl4wgnKY4TPXFNSoY5Erlkt7pNwT+nIwIMXA26
	2bbVzZuKIJzejljm652zDK6UFnBMV4Azc/meaAZ1GnygV0C4R5giUxTXXNmQXlDJLE2m
	NuonqtwFhBrUY+swinjMngiY9JEZOxL8+Zn21Fk8EySr84XqI6WBvFv4+sAaX53/FyFV
	evzHCslBsMgA6C9R6fFufO1hXaftXXEu0GjkPd4M0y348LiMVbs2p4O+nfiTmjuy9/9E
	cQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=pwJczkHJf5dylMpf7qQKSRS9xAoxuZvn6hdjNg8s+x8=;
	b=NXb8HhKBgfnLUR1ZswnftF5Xlvf8Yro7ZHMN9n4pu98lhWkRPCtzEkqQCr/OKTr9tJ
	oQxf0L5hHYtBpSH/Bruv41bKdDlVdbcgriQYj1fvxd3AoytGHA2sFoqr/N/QyvuVJOmw
	4BarhDI/14ltuNyV8ahS6PCaMiCmKQyAmcgCvuHjq3xr2VxaPL9zbjE1b4JQ7hFOR/gZ
	NR0Gc+QjP0zcbCGPBcaSoXRj9cGJsvgcsrAJVab6CFnwHpK9iDhOZ4vrCX+Pu5ch9zKe
	YipvdM9cTQ/noMvp6koMKgX5Zhm7qqkZYRVs3epHCoocl4MKs7RQXVGIYDHVvb1G4w6A
	E2Bg==
X-Gm-Message-State: APjAAAXkG16JZvfzB4Sx9rIEXV9b8oyD1oEh6JkT/2mxp7iRyOfghKyu
	81n3h/GCKk2QJuphSi9HY5l+PqXiUYPPPfrHeT9qk2k5
X-Google-Smtp-Source: APXvYqx/uctiyLLGhbZzGc9loWa3InRQj6ftEybkPpJi7MAPOtpNzBFL+yJAw2kTpDlfH5T1PcdoCAPBS99fPC8e4og=
X-Received: by 2002:a02:9f19:: with SMTP id z25mr51119321jal.2.1555318227433; 
	Mon, 15 Apr 2019 01:50:27 -0700 (PDT)
MIME-Version: 1.0
From: fengyd <fengyd81@gmail.com>
Date: Mon, 15 Apr 2019 16:50:16 +0800
Message-ID:
 <CACnvu8YKqaZA7XSD41=SQrUL7h9YafJMgKPe5cJZd3XZ3zrSNw@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::12f
X-Mailman-Approved-At: Mon, 15 Apr 2019 09:23:38 -0400
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] How live migration work for vhost-user
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415085016.63UsOUb8RymnQpNwHmYlwiN3vPVtTRSxAlNYa6Xno2w@z>

Hi,

During live migration,  the folloing log can see in nova-compute.log in my
environment:
 ERROR nova.virt.libvirt.driver [req-039a85e1-e7a1-4a63-bc6d-c4b9a044aab6
0cdab20dc79f4bc6ae5790e7b4a898ac 3363c319773549178acc67f32c78310e - default
default] [instance: 5ec719f4-1865-4afe-a207-3d9fae22c410] Live Migration
failure: internal error: qemu unexpectedly closed the monitor:
2019-04-15T02:58:22.213897Z qemu-kvm: VQ 0
size 0x100 < last_avail_idx 0x1e - used_idx 0x23

It's OK for standard Linux VM, but not OK for our VM where virtio is
implemented by ourself.
KVM version as follow:
qemu-kvm-common-ev-2.12.0-18.el7_6.3.1.x86_64
qemu-kvm-ev-2.12.0-18.el7_6.3.1.x86_64
libvirt-daemon-kvm-3.9.0-14.2.el7.centos.ncir.8.x86_64

Do you know what's the difference between virtio and vhost-user during
migration?
The function virtio_load in Qemu is called for virtio and vhost-user during
migration.
For virtio,  last_avail_idx  and used_idx are stored in Qemu, Qemu is
responsible for updating their values accordingly
For vhost-user, last_avail_idx  and used_idx are stored in vhost-user app,
eg. DPDK, not in Qemu?
How does migration work for vhost-user?

Thanks in advance
Yafeng
