Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F217C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0797C21897
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0797C21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5ChK-00058I-35
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 13:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i5Cff-00045m-HP
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i5Cfe-0007CB-Fp
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:32:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58456)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i5Cfe-0007Bi-9y
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:32:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B215DC055673
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 17:32:45 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AAE7A19C78;
 Tue,  3 Sep 2019 17:32:33 +0000 (UTC)
Date: Tue, 3 Sep 2019 18:32:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190903173231.GV2744@work-vm>
References: <20190827095437.18819-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827095437.18819-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 03 Sep 2019 17:32:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/4] virtiofsd: implement vhost-user.rst
 "Backend program conventions"
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
Cc: virtio-fs@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> This series implements the conventions for vhost-user backend programs
> described in vhost-user.rst:
> 1. Run in the foreground by default.
> 2. Show vhost-user.json capabilities when --print-capabilities is given.
> 3. Ship a vhost-user.json file so the program can be discovered.
> 
> No command-line options or VHostUserBackendCapabilities are defined for the
> 'fs' backend type yet.  Let's until it becomes clear what should be standard
> for all 'fs' backends and what is specific to virtiofsd.

1,3,4 merged; 2 waiting on reivew from someone who understands the json
requirement.

> 
> Stefan Hajnoczi (4):
>   virtiofsd: make -f (foreground) the default
>   virtiofsd: add --print-capabilities option
>   virtiofsd: install virtiofsd in libexec
>   virtiofsd: add vhost-user.json file
> 
>  docs/interop/vhost-user.json                |  4 +++-
>  Makefile                                    |  3 +++
>  contrib/virtiofsd/fuse_lowlevel.h           |  1 +
>  contrib/virtiofsd/helper.c                  |  5 +++++
>  contrib/virtiofsd/passthrough_ll.c          | 12 ++++++++++++
>  .gitignore                                  |  1 +
>  contrib/virtiofsd/50-qemu-virtiofsd.json.in |  5 +++++
>  7 files changed, 30 insertions(+), 1 deletion(-)
>  create mode 100644 contrib/virtiofsd/50-qemu-virtiofsd.json.in
> 
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

