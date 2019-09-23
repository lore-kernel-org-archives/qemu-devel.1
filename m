Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38EAC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 10:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B1F20835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 10:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B1F20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCLpF-0003Zq-Mo
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 06:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iCLnx-00030p-PJ
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 06:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iCLnv-00027x-2B
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 06:42:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56338)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iCLnu-00027H-TC
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 06:42:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 27D7C3175288;
 Mon, 23 Sep 2019 10:42:49 +0000 (UTC)
Received: from work-vm (ovpn-117-213.ams2.redhat.com [10.36.117.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F5F160605;
 Mon, 23 Sep 2019 10:42:48 +0000 (UTC)
Date: Mon, 23 Sep 2019 11:42:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jintack Lim <incredible.tack@gmail.com>, pbonzini@redhat.com
Subject: Re: Migration failure when running nested VMs
Message-ID: <20190923104245.GA2866@work-vm>
References: <CAHyh4xhYrUbK0aEJmKp3_kOJG2E+AQLMUjyf7_pXVJgbqgv5JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHyh4xhYrUbK0aEJmKp3_kOJG2E+AQLMUjyf7_pXVJgbqgv5JA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 23 Sep 2019 10:42:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jintack Lim (incredible.tack@gmail.com) wrote:
> Hi,

Copying in Paolo, since he recently did work to fix nested migration -
it was expected to be broken until pretty recently; but 4.1.0 qemu on
5.3 kernel is pretty new, so I think I'd expected it to work.

> I'm seeing VM live migration failure when a VM is running a nested VM.
> I'm using latest Linux kernel (v5.3) and QEMU (v4.1.0). I also tried
> v5.2, but the result was the same. Kernel versions in L1 and L2 VM are
> v4.18, but I don't think that matters.
> 
> The symptom is that L2 VM kernel crashes in different places after
> migration but the call stack is mostly related to memory management
> like [1] and [2]. The kernel crash happens almost all the time. While
> L2 VM gets kernel panic, L1 VM runs fine after the migration. Both L1
> and L2 VM were doing nothing during migration.
> 
> I found a few clues about this issue.
> 1) It happens with a relatively large memory for L1 (24G), but it does
> not with a smaller size (3G).
> 
> 2) Dead migration worked; when I ran "stop" command in the qemu
> monitor for L1 first and did migration, migration worked always. It
> also worked when I only stopped L2 VM and kept L1 live during the
> migration.
> 
> With those two clues, I guess maybe some dirty pages made by L2 are
> not transferred to the destination correctly, but I'm not really sure.
> 
> 3) It happens on Intel(R) Xeon(R) Silver 4114 CPU, but it does not on
> Intel(R) Xeon(R) CPU E5-2630 v3 CPU.
> 
> This makes me confused because I thought migrating nested state
> doesn't depend on the underlying hardware.. Anyways, L1-only migration
> with the large memory size (24G) works on both CPUs without any
> problem.
> 
> I would appreciate any comments/suggestions to fix this problem.

Can you share the qemu command lines you're using for both L1 and L2
please ?
Are there any dmesg entries around the time of the migration on either
the hosts or the L1 VMs?
What guest OS are you running in L1 and L2?

Dave

> Thanks,
> Jintack
> 
> 
> [1]https://paste.ubuntu.com/p/XGDKH45yt4/
> [2]https://paste.ubuntu.com/p/CpbVTXJCyc/
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

