Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAFEFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D0620872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D0620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7jJ-0004bK-Qq
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1iL72Q-0008IW-WF
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1iL72P-0007ab-Ia
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:46:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42078)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1iL72P-0007Zh-CY
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:46:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B19781129
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 14:45:59 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5411B60852;
 Thu, 17 Oct 2019 14:45:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id DA8A22202E5; Thu, 17 Oct 2019 10:45:53 -0400 (EDT)
Date: Thu, 17 Oct 2019 10:45:53 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 2/2] virtiofsd: move to a new pid namespace
Message-ID: <20191017144553.GA12588@redhat.com>
References: <20191016160157.12414-1-stefanha@redhat.com>
 <20191016160157.12414-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016160157.12414-3-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 17 Oct 2019 14:45:59 +0000 (UTC)
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 05:01:57PM +0100, Stefan Hajnoczi wrote:

[..]
> +	/*
> +	 * If the mounts have shared propagation then we want to opt out so our
> +	 * mount changes don't affect the parent mount namespace.
> +	 */
> +	if (mount(NULL, "/", NULL, MS_REC|MS_SLAVE, NULL) < 0) {
> +		fuse_log(FUSE_LOG_ERR, "mount(/, MS_REC|MS_SLAVE): %m\n");
> +		exit(1);
> +	}

So we will get mount propogation form parent but our mounts will not
propagate back. Sounds reasonable.

Can we take away CAP_SYS_ADMIN from virtiofsd? That way it will not be 
able to do mount at all. 

I am wondering are we dependent on daemon having CAP_SYS_ADMIN. 

Thanks
Vivek

