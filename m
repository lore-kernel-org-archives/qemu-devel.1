Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE43AC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9833C208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLFl2Bxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9833C208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43vu-0006lE-Mj
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j43qw-0006Zn-3E
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j43qv-0001mQ-1a
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:27:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26263
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j43qu-0001mG-Tp
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582036076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LOaUcZy+trFgczZ2ML/e/z/TNzZ8JS8ig1LhXZ/Pbc8=;
 b=CLFl2Bxixqr9bksHb5uaVCYHfpFOg1dmxyN2fbtNZKWYb15NXn8pwdJ3lbUqF5g40TIoJP
 V5W+qBzR6AEnY8kALcgWCYHKGk47GSccu1ayTJM0ucrOdErt4ivi0+MybFv6r3ppOg5u/1
 Z8HYdEP5cAd1NYPja02TjJipPRF82CU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-cB0YnA-qPx6S5avfKS2Gpw-1; Tue, 18 Feb 2020 09:27:54 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 170AA8010F1;
 Tue, 18 Feb 2020 14:27:53 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73A425DA60;
 Tue, 18 Feb 2020 14:27:51 +0000 (UTC)
Date: Tue, 18 Feb 2020 15:27:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 00/22] linux-user: generate syscall_nr.sh
Message-ID: <20200218152748.63d608af.cohuck@redhat.com>
In-Reply-To: <20200217223558.863199-1-laurent@vivier.eu>
References: <20200217223558.863199-1-laurent@vivier.eu>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: cB0YnA-qPx6S5avfKS2Gpw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 23:35:36 +0100
Laurent Vivier <laurent@vivier.eu> wrote:

> This series copies the files syscall.tbl from linux v5.5 and generates
> the file syscall_nr.h from them.
> 
> This is done for all the QEMU targets that have a syscall.tbl
> in the linux source tree: mips, mips64, i386, x86_64, sparc, s390x,
> ppc, arm, microblaze, sh4, xtensa, m68k, hppa and alpha.
> 
> tilegx and cris are depecrated in linux (tilegx has no maintainer in QEMU)
> 
> aarch64, nios2, openrisc and riscv have no syscall.tbl in linux.
> 
> It seems there is a bug in QEMU that forces to disable manually arch_prctl
> with i386 target: do_arch_prctl() is only defined with TARGET_ABI32 but
> TARGET_ABI32 is never defined with TARGET_I386 (nor TARGET_X86_64).
> 
> I have also removed all syscalls in s390x/syscall_nr.h defined for
> !defined(TARGET_S390X).
> 
> I have added a script to copy all these files from linux and updated
> them at the end of the series with their latest version for today.
> 
> The two last patches manage the special case for mips O32 that needs
> to know the number of arguments. We find them in strace sources.

I like the idea of generating those files, but I wonder if that should
interact with linux-headers updates.

I plan to do a linux-headers update to 5.6-rc?, and I noticed that this
will drag in two new syscalls (openat2 and pidfd_getfd). Now, just
having the new #defines in the headers doesn't do anything, but should
it be a trigger to update the syscall.tbl files as well? Or does that
need manual inspection/updating?


