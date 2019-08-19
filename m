Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3E9C3A59D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 09:34:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9230B2087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 09:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9230B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hze3U-0003Dn-KT
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 05:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1hze23-0001XO-3w
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 05:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hze21-0006n3-Sy
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 05:32:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25263)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hze21-0006m3-NM
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 05:32:53 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8A9CC0546F1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 09:32:52 +0000 (UTC)
Received: by mail-pl1-f199.google.com with SMTP id ci3so1704627plb.8
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 02:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QaYFXYISsEym+ZyotU5Tbn4aFvGKk9vxBUkkmwiP9O8=;
 b=mleJsvpwJQnpae8WX6y939M6bB+9HsBXTjyPqKbRJ7r6hUq5Mm43OkHuZ1HGUJWIbB
 Gf3WqpTd+mHi2Hxfrd7YYoVdIdZ8BCVtLUP8Z0IWx7fw0W9bKJ8KOErItAHT8GQr8+z3
 d5+TYcV+DsrLKDdqWMpYdiUjLoQASWU2VeMZuZG3BIBVWzCQdnHA/IN4Rv5eewNTfMJ4
 VZ7d53T/Z8wYICmc4cJ0dbAYvWX4EY1C9GF98evIasG93Row2oAWpm+33y2zxdqPmev5
 o3XCvFGcATjSsCl1B0EhDD//uxhzltPCmIA8bXWwijOSe8OVGB3rCJ9LSbK4uQLJvmxt
 QxqA==
X-Gm-Message-State: APjAAAWPvziKRzmXxjOBfTODIC/G61poWPYfcyBBtYa/ktxb1N930nfi
 ke1PXzxUDPwUIcFH5JwAd5h77Xmj1V2oJVPwZiFuDYT9xHipVeX10MHPo8pOkagvZuxbp69W6Oz
 xjkvUEOGveQvtD+w=
X-Received: by 2002:aa7:8202:: with SMTP id k2mr23609501pfi.31.1566207171998; 
 Mon, 19 Aug 2019 02:32:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzpURLHR6krsN44bnpGoeg9R49Hv9YdjMi7WPa9b1oaXTv5ubxNcitSXYvALfcZsry051Ym3A==
X-Received: by 2002:aa7:8202:: with SMTP id k2mr23609481pfi.31.1566207171765; 
 Mon, 19 Aug 2019 02:32:51 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j187sm19973867pfg.178.2019.08.19.02.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 02:32:51 -0700 (PDT)
Date: Mon, 19 Aug 2019 17:32:42 +0800
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190819093242.GC13560@xz-x1>
References: <20190817093237.27967-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190817093237.27967-1-peterx@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] memory: Fix up coalesced_io_del not
 working for KVM
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 17, 2019 at 05:32:35PM +0800, Peter Xu wrote:
> I can easily crash QEMU as long as KVM is used with e1000 and reboot
> many times, then I hit this and QEMU aborts [1]:
> 
>   kvm_mem_ioeventfd_add: error adding ioeventfd: No space left on device (28)

Reproducer:

bin=x86_64-softmmu/qemu-system-x86_64
$bin -M q35,accel=kvm,kernel-irqchip=on -smp 8 -m 2G -cpu host \
     -device e1000,netdev=net0 \
     -netdev user,id=net0,hostfwd=tcp::5555-:22 \
     -device e1000,netdev=net1 \
     -netdev user,id=net1 \
     -device e1000,netdev=net2 \
     -netdev user,id=net2 \
     -device e1000,netdev=net3 \
     -netdev user,id=net3 \
     -drive file=/images/default.qcow2,if=none,cache=none,id=drive0 \
     -device virtio-blk-pci,drive=drive0

This should crash for no more than 2-3 reboots.  The more e1000, the
faster.

Regards,

-- 
Peter Xu

