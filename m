Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BF9C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE8320CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE8320CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQZon-0003ov-Vb
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 13:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56016 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1jQZnl-0003Ln-MH
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:01:45 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1jQZnk-0003Xs-QG
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:01:45 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55746
 helo=outgoing.mit.edu)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tytso@mit.edu>) id 1jQZnk-0003Wv-8y
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:01:44 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net
 [100.0.195.244]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03KH1WTK016582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2020 13:01:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id CF88242013B; Mon, 20 Apr 2020 13:01:31 -0400 (EDT)
Date: Mon, 20 Apr 2020 13:01:31 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
Message-ID: <20200420170131.GD1080594@mit.edu>
References: <20200331133536.3328-1-linus.walleij@linaro.org>
 <20200420151344.GC1080594@mit.edu>
 <d3fb73a3-ecf6-6371-783f-24a94eb66c59@redhat.com>
 <CAFEAcA9BQQah2vVfnwO4-3m4eHv9QtfvjvDpTdw+SmqicsDOMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9BQQah2vVfnwO4-3m4eHv9QtfvjvDpTdw+SmqicsDOMA@mail.gmail.com>
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
Cc: Linux API <linux-api@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Florian Weimer <fw@deneb.enyo.de>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Andy Lutomirski <luto@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 20, 2020 at 04:29:32PM +0100, Peter Maydell wrote:
> On Mon, 20 Apr 2020 at 16:24, Eric Blake <eblake@redhat.com> wrote:
> > It will be interesting to find how much code (wrongly) assumes it can
> > use a blind assignment of fcntl(fd, F_SETFD, 1) and thereby accidentally
> > wipes out other existing flags, when it should have instead been doing a
> > read-modify-write to protect flags other than FD_CLOEXEC.
> 
> For instance, a quick grep shows 4 instances of this in QEMU :-)

Fortunately, most applications aren't going to be interested in
forcing 32-bit mode for 64-bit applications, QEMU being the notable
exception.  We do need to make sure that for 32-bit applications, we
either make FD_32BIT_MODE a no-op (don't set the bit, and ignore the
bit).  We could allow the bit to be visible for 32-bit applications,
but we would want to disallow clearing the the bit for 32-bit
applications if it was visible.

If we did that, then blind assignments of fcntl(fd, F_SETFD, 1) should
be mostly harmless with respect to the FD_32BIT_MODE bit.

   	      	 	  	       - Ted

