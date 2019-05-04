Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F7FC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4598206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4598206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56109 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMtxM-0007J1-9D
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 08:39:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hMtwV-000702-GQ
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hMtwU-0003Cf-Jb
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:39:03 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:38114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hMtwU-0003Aq-Ct
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:39:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by hera.aquilenet.fr (Postfix) with ESMTP id 7FD4B6C5A;
	Sat,  4 May 2019 14:38:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
	by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10lgAxd7cKQa; Sat,  4 May 2019 14:38:58 +0200 (CEST)
Received: from function (105.251.129.77.rev.sfr.net [77.129.251.105])
	by hera.aquilenet.fr (Postfix) with ESMTPSA id 2E92169EA;
	Sat,  4 May 2019 14:38:58 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hMtwP-0003Fg-8G; Sat, 04 May 2019 14:38:57 +0200
Date: Sat, 4 May 2019 14:38:57 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Cao Jiaxi <driver1998@foxmail.com>
Message-ID: <20190504123857.5e3xscijgezftaib@function>
References: <20190430181009.1066-1-driver1998@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190430181009.1066-1-driver1998@foxmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.233.100.1
Subject: Re: [Qemu-devel] [PATCH v2 1/4] Initial Windows on ARM (AArch64
 64-Bit) host support
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504123857.di5ytiNlDyPTB00kSZh1SfqIPdw-AYDiI3TFeT-JqCw@z>

Hello,

Cao Jiaxi, le mer. 01 mai 2019 02:10:09 +0800, a ecrit:
> This series of patches is for initial support of Windows 10 on ARM as a QEMU host.
> Currently only TCG intepreter is working correctly, it crashes when TCG JIT is enabled.
> For now we assume it is built using the clang aarch64-w64-mingw32 toolchain, you can get a prebuilt toolchain at https://github.com/mstorsjo/llvm-mingw.
> 
> QEMU_PACKED: Remove gcc_struct attribute in Windows non x86 targets
> This attribute is for x86 only, and it generates an warning on ARM64 Clang/MinGW targets.

I have applied it to the libslirp repo, thanks!

I'll submit a pull request to get it updated on qemu.

Samuel

