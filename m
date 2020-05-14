Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688A7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E51206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="icnWIY4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E51206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZC24-0000xC-EI
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 07:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jZC1N-0008Ui-Gs
 for qemu-devel@nongnu.org; Thu, 14 May 2020 07:27:25 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929]:44866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jZC1L-0006jO-CY
 for qemu-devel@nongnu.org; Thu, 14 May 2020 07:27:25 -0400
Received: by mail-ua1-x929.google.com with SMTP id z16so970519uae.11
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 04:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=ioCj5tSwTzttUSIorgGedTJUfQMRN/bX5v+Q989TeO4=;
 b=icnWIY4W9xZ9J38iidLRqC9jPizwdPqs/s3ePRg1Gox+OMqoJfLqsnUp/LdtygvEUO
 W7daCgWV0NCaSIUBj29stL4GddzzWI8+b4pqXPXr79dQSnFD6g+1PRjqKR2b9wqrpyhi
 JQikQKPV0psM4BC6twVA+zxF8q/dfO8gz4KpW4HSnb4mT6KUXfvIMvLspdhedXUY8MvO
 jjqn/cn+BcrL1R2RYgszTs+L/c/NhmGlcPhzHsx8oPRlIwnD+wO+MTC0+lya9kO3iEEd
 QAWji+UYuA1zSSX9k7lxhvSqR8EfilHJplrsO4p7xSuRDFa7raB6554051UpHMsGmr4s
 DG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=ioCj5tSwTzttUSIorgGedTJUfQMRN/bX5v+Q989TeO4=;
 b=mXHkeQJJ1b9JJG3nFWqCoAfFj1F23r3Bs4odDAX7VgwefRkTWtpgHzHcshaMhTeMX3
 Sv0f66dGbYuaEFXJVxVleXuzxsqgI4Tz5iQr2IMSqkI8i1fsuxiGUnhHFyn6+D3fd73c
 V6fCdRjCdB+N1FRUz6sYjkZR8v49GKSuA5bfAxnxK9CiBqRglkREXrerXVyRArh9aJXj
 jteHfkEh3WuM3n+eics0vj5GpMWJSSThJxs6lfDQZWHP0kOve7PbkCY9+GDrlCSrGpGY
 U3bZEvl8Tgdo0M/Vol/yMPtkMs1NsEU5u4c4895Gsa0BxIM30BUO9uwxe44iAUL/FU0O
 BQtg==
X-Gm-Message-State: AOAM532z98kZhYgGq+7x5HfgAx7ybhda5ErFOeon+QaiXSj+RuClBzrq
 mdnQ7IUqzXnkG/r1oM9v7BKjxyBi5fUN+RtEVDzLKyI8aFjV4g==
X-Google-Smtp-Source: ABdhPJx4pkCLM3p50w7WcN7zit8rL3/5+08kxJp59aB1PHaHceSYgTbq9Vjo/ZmgmWj9yr+6MLkE/PCFTAunctBrKd8=
X-Received: by 2002:ab0:b13:: with SMTP id b19mr3389415uak.91.1589455639852;
 Thu, 14 May 2020 04:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHckoCymFfuVd=tKV-hk+PHn2fk6ydWjSxwKVorj9Qe5KV6nGQ@mail.gmail.com>
In-Reply-To: <CAHckoCymFfuVd=tKV-hk+PHn2fk6ydWjSxwKVorj9Qe5KV6nGQ@mail.gmail.com>
From: Li Feng <fengli@smartx.com>
Date: Thu, 14 May 2020 19:27:08 +0800
Message-ID: <CAHckoCzWmN4oedOHMvR_TbbBcbYqSjg1fUr2RjJkh-iuZO-Jng@mail.gmail.com>
Subject: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
To: "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2607:f8b0:4864:20::929;
 envelope-from=fengli@smartx.com; helo=mail-ua1-x929.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

Dear all,

I have encountered a weird crash.
I remember before a few days it works well and I rebase my code from upstream.

This is the command:
/root/qemu-master/x86_64-softmmu/qemu-system-x86_64 -enable-kvm
-device virtio-balloon -cpu host -smp 4 -m 2G -drive
file=/root/html/fedora-10g.img,format=raw,cache=none,aio=native,if=none,id=drive-virtio-disk1
-device virtio-blk-pci,scsi=off,drive=drive-virtio-disk1,id=virtio-disk1,bootindex=1
-device virtio-net,netdev=nw1,mac=00:11:22:EE:EE:10 -netdev
tap,id=nw1,script=no,downscript=no,ifname=tap0 -serial mon:stdio
-nographic -object
memory-backend-file,id=mem0,size=2G,mem-path=/dev/hugepages,share=on
-numa node,memdev=mem0 -vnc 0.0.0.0:100 -machine usb=on,nvdimm -device
usb-tablet -monitor unix:///tmp/a.socket,server,nowait -device
virtio-serial-pci,id=virtio-serial0,max_ports=16 -chardev
socket,id=channel1,path=/tmp/helloworld1,server,nowait -device
virtserialport,chardev=channel1,name=com.redhat.rhevm.vdsm1,bus=virtio-serial0.0,id=port1
-qmp tcp:0.0.0.0:2234,server,nowait
qemu-system-x86_64: error: failed to set MSR 0x48f to 0x7fefff00036dfb
qemu-system-x86_64: /root/qemu-master/target/i386/kvm.c:2695:
kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.

This is the commit record:
*   c88f1ffc19 - (origin/master, origin/HEAD) Merge remote-tracking
branch 'remotes/kevin/tags/for-upstream' into staging (3 days ago)
<Peter Maydell>
|\
| * 47e0b38a13 - block: Drop unused .bdrv_has_zero_init_truncate (3
days ago) <Eric Blake>
| * dbc636e791 - vhdx: Rework truncation logic (3 days ago) <Eric Blake>
| * bda4cdcbb9 - parallels: Rework truncation logic (3 days ago) <Eric Blake>
| * be9c9404db - ssh: Support BDRV_REQ_ZERO_WRITE for truncate (3 days
ago) <Eric Blake>
| * fec00559e7 - sheepdog: Support BDRV_REQ_ZERO_WRITE for truncate (3
days ago) <Eric Blake>
| * 2f98910d5b - rbd: Support BDRV_REQ_ZERO_WRITE for truncate (3 days
ago) <Eric Blake>

I run this qemu in a VM base on EXSi.

Does anyone have the same issue?

Thanks,

Feng Li

