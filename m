Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36537ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09CB620B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CB620B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIHx4-0007ya-Li
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iIEnL-0006qO-Te
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iIEnK-0001NU-Td
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:26:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51052)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1iIEnF-0001Lg-5V; Wed, 09 Oct 2019 12:26:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2250330BCBA2;
 Wed,  9 Oct 2019 16:26:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-151.rdu2.redhat.com
 [10.10.122.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C0995C1D6;
 Wed,  9 Oct 2019 16:26:25 +0000 (UTC)
Date: Wed, 9 Oct 2019 12:26:23 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/4] qemu-iotests: remove bash shebang from library files
Message-ID: <20191009162623.GG30349@localhost.localdomain>
References: <20190927141728.7137-1-crosa@redhat.com>
 <20190927141728.7137-2-crosa@redhat.com>
 <7ce7f9b7-a79e-21c5-18e2-f7f2ec85e575@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ce7f9b7-a79e-21c5-18e2-f7f2ec85e575@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 09 Oct 2019 16:26:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 27, 2019 at 11:37:52AM -0500, Eric Blake wrote:
> On 9/27/19 9:17 AM, Cleber Rosa wrote:
> > Due to not being able to find a reason to have shebangs on files that
> > are not executable.
> > 
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >   tests/qemu-iotests/common.config  | 2 --
> >   tests/qemu-iotests/common.filter  | 2 --
> >   tests/qemu-iotests/common.nbd     | 1 -
> >   tests/qemu-iotests/common.pattern | 2 --
> >   tests/qemu-iotests/common.qemu    | 2 --
> >   tests/qemu-iotests/common.rc      | 2 --
> >   tests/qemu-iotests/common.tls     | 2 --
> >   7 files changed, 13 deletions(-)
> > 
> 
> Loss of the shebang changes the mode in which emacs opens the files (from
> Shell-script[bash] to Conf[space] in my case).  I agree that a #! comment is
> not appropriate for a file that is not executable as a standalone file, but
> it becomes harder to edit the file correctly unless we replace it with some
> other way of letting editors realize that the contents of each file is still
> meant to be consumed by bash.
> 
> Something like this would work:
> 
> # hey emacs, this file will be sourced by bash: -*- sh -*-
>

Yes, good point.  Will send that on a v2.

- Cleber.

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org

