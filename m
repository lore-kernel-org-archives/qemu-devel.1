Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4013C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8F2208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8F2208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48817 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQYGu-0004HD-O2
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 10:19:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQYEk-0002qx-Lt
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQY4U-0005c5-TH
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:06:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQY4U-0005bQ-NN
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:06:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF1CD307EAA8;
	Tue, 14 May 2019 14:06:16 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F38CE63BA0;
	Tue, 14 May 2019 14:06:12 +0000 (UTC)
Date: Tue, 14 May 2019 15:06:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zhang Chen <chen.zhang@intel.com>
Message-ID: <20190514140610.GC9618@work-vm>
References: <20190426090730.2691-1-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426090730.2691-1-chen.zhang@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 14 May 2019 14:06:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] Optimize COLO related codes and
 description
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
	Juan Quintela <quintela@redhat.com>, qemu-dev <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zhang Chen (chen.zhang@intel.com) wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> In this series we optimize codes and fix some tiny issues.

Queued

> 
> Zhang Chen (3):
>   migration/colo.c: Remove redundant input parameter
>   migration/colo.h: Remove obsolete codes
>   qemu-option.hx: Update missed parameter for colo-compare
> 
>  include/migration/colo.h  | 4 +---
>  migration/colo-failover.c | 2 +-
>  migration/colo.c          | 2 +-
>  qemu-options.hx           | 9 ++++++---
>  4 files changed, 9 insertions(+), 8 deletions(-)
> 
> -- 
> 2.17.GIT
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

