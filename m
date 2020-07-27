Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1982BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3D82075A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLF9sAVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3D82075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k084w-0007fG-6N
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 14:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k083s-0006sZ-ES
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 14:41:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46989
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k083p-0004eE-L0
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 14:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595875275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bSS+/cYqzq+8Z0Yw+3PxKyW5l84oLi4qWOyEWNgGQic=;
 b=dLF9sAVFds5ijh9w8R2cU2bawUfBKQ0K/WVWnwnWX1LdSaUg9lFs99NhxeaEU/lkMN/rfP
 LO0Yn6um9KzEdtRDtVTHWzA6vbYaHF4jvDNVzAxlj2pVfgt/DAbYm/O2rMLgBqes6z7CZr
 U6s2FyQ9E3bB1qKeOv6YULv3kp7DDGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-_48GyIxIM4aS6yyUJ1czGg-1; Mon, 27 Jul 2020 14:41:11 -0400
X-MC-Unique: _48GyIxIM4aS6yyUJ1czGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9DF7100AA21
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 18:41:10 +0000 (UTC)
Received: from localhost (ovpn-120-33.rdu2.redhat.com [10.10.120.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D39672699;
 Mon, 27 Jul 2020 18:41:10 +0000 (UTC)
Date: Mon, 27 Jul 2020 14:41:09 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH v2 0/2] qmp: Expose MachineClass::default_ram_id
Message-ID: <20200727184109.GB225270@habkost.net>
References: <cover.1590481402.git.mprivozn@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1590481402.git.mprivozn@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: imammedo@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michal,

It looks like this has fallen through the cracks, my apologies.

I'm queueing this for 5.2.  I assume this is the latest version,
correct?


On Tue, May 26, 2020 at 10:25:33AM +0200, Michal Privoznik wrote:
> v2 of:
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg07103.html
> 
> diff to v1:
> - in 2/2 I made the default-ram-id optional, because as it turns out,
>     not every machine type has it set.
> 
> Michal Privoznik (2):
>   qapi: Fix comment format for @CpuInstanceProperties
>   qmp: Expose MachineClass::default_ram_id
> 
>  hw/core/machine-qmp-cmds.c | 4 ++++
>  qapi/machine.json          | 8 ++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> -- 
> 2.26.2
> 

-- 
Eduardo


