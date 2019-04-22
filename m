Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2516C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 21:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA385206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 21:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA385206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44676 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIgk4-000563-Eu
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 17:44:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIgij-00043a-Sf
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIgV8-0004cp-A0
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:29:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hIgV8-0004c1-3o
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:29:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5289E83F3D;
	Mon, 22 Apr 2019 21:29:21 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E0C6160C64;
	Mon, 22 Apr 2019 21:29:18 +0000 (UTC)
Date: Mon, 22 Apr 2019 18:29:17 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Gary R Hook <ghook@redhat.com>
Message-ID: <20190422212917.GA5131@habkost.net>
References: <20190410000803.1744-1-ghook@redhat.com>
	<20190410000803.1744-3-ghook@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190410000803.1744-3-ghook@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 22 Apr 2019 21:29:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RHEL-8.1 virt 2/2] target/i386: sev: Do not pin
 the ram device memory region
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, rhvirt-patches@redhat.com,
	qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422212917.TN89PS0BlvsS2G00mRxaFobX1N4vD-xH0Lde0l4ceZk@z>

On Tue, Apr 09, 2019 at 08:08:03PM -0400, Gary R Hook wrote:
> BZ: 1667249
> Branch: rhel-8.1.0
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1667249
> Upstream Status: 4.0.0-rc1
> Build Info: https://brewweb.engineering.redhat.com/brew/taskinfo?taskID=20980582
> Conflicts: None
> 
> commit cedc0ad539afbbb669dba9e73dfad2915bc1c25b
> Author: Singh, Brijesh <brijesh.singh@amd.com>
> Date:   Mon Feb 4 22:23:40 2019 +0000
> 
>     target/i386: sev: Do not pin the ram device memory region
> 
>     The RAM device presents a memory region that should be handled
>     as an IO region and should not be pinned.
> 
>     In the case of the vfio-pci, RAM device represents a MMIO BAR
>     and the memory region is not backed by pages hence
>     KVM_MEMORY_ENCRYPT_REG_REGION fails to lock the memory range.
> 
>     Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1667249
>     Cc: Alex Williamson <alex.williamson@redhat.com>
>     Cc: Paolo Bonzini <pbonzini@redhat.com>
>     Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>     Message-Id: <20190204222322.26766-3-brijesh.singh@amd.com>
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com> 
> Cc: Richard Henderson <rth@twiddle.net> 
> Cc: Eduardo Habkost <ehabkost@redhat.com> 
> Cc: qemu-devel@nongnu.org 

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo

