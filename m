Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD88C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87ED206B9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87ED206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQY8E-00077D-02
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57628 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1jQY7U-0006gl-92
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:14:00 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1jQY7T-0000Bg-GL
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:13:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38073
 helo=outgoing.mit.edu)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tytso@mit.edu>) id 1jQY7T-00005u-27
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:13:59 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net
 [100.0.195.244]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03KFDigW013296
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2020 11:13:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id 6BF1342013B; Mon, 20 Apr 2020 11:13:44 -0400 (EDT)
Date: Mon, 20 Apr 2020 11:13:44 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
Message-ID: <20200420151344.GC1080594@mit.edu>
References: <20200331133536.3328-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331133536.3328-1-linus.walleij@linaro.org>
Received-SPF: pass client-ip=18.9.28.11; envelope-from=tytso@mit.edu;
 helo=outgoing.mit.edu
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 11:13:55
X-ACL-Warn: Detected OS   = ???
X-Received-From: 18.9.28.11
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
Cc: Peter Maydell <peter.maydell@linaro.org>, linux-api@vger.kernel.org,
 qemu-devel@nongnu.org, Florian Weimer <fw@deneb.enyo.de>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Andy Lutomirski <luto@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 03:35:36PM +0200, Linus Walleij wrote:
> It was brought to my attention that this bug from 2018 was
> still unresolved: 32 bit emulators like QEMU were given
> 64 bit hashes when running 32 bit emulation on 64 bit systems.
> 
> This adds a fcntl() operation to set the underlying filesystem
> into 32bit mode even if the file hanle was opened using 64bit
> mode without the compat syscalls.

s/hanle/handle/

The API that you've proposed as a way to set the 32-bit mode, but
there is no way to clear the 32-bit mode, nor there is a way to get
the current status mode.

My suggestion is to add a flag bit for F_GETFD and F_SETFD (set and
get file descriptor flags).  Currently the only file descriptor flag
is FD_CLOEXEC, so why not add a FD_32BIT_MODE bit?

Cheers,

						- Ted

