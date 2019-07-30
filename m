Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42C6C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 21:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4BD2067D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 21:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4BD2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsZQg-0004tj-9w
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 17:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45734)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hsZQ2-0004SE-Lz
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 17:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hsZQ1-0005wm-QM
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 17:12:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58887)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1hsZPz-0005vw-M3; Tue, 30 Jul 2019 17:12:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BF35985540;
 Tue, 30 Jul 2019 21:12:22 +0000 (UTC)
Received: from localhost (ovpn-116-22.gru2.redhat.com [10.97.116.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 523CF605A8;
 Tue, 30 Jul 2019 21:12:17 +0000 (UTC)
Date: Tue, 30 Jul 2019 18:12:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190730211216.GV4313@habkost.net>
References: <20190729063127.2801-1-tao3.xu@intel.com>
 <20190729063127.2801-3-tao3.xu@intel.com>
 <20190729150957.157a7c03@redhat.com>
 <04ce7f87-815c-924b-e1df-6a4028750926@intel.com>
 <20190730111120.63de67ae@Igors-MacBook-Pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730111120.63de67ae@Igors-MacBook-Pro>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 30 Jul 2019 21:12:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 02/11] numa: move numa global variable
 nb_numa_nodes into MachineState
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
Cc: aik@ozlabs.ru, jingqi.liu@intel.com, Tao Xu <tao3.xu@intel.com>,
 fan.du@intel.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 jonathan.cameron@huawei.com, David Gibson <dgibson@redhat.com>,
 dan.j.williams@intel.com, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 30, 2019 at 11:11:20AM +0200, Igor Mammedov wrote:
[...]
> PS:
> we already have an implicit node creation in generic numa code (when memory hotplug
> is enabled), so we probably could reuse that and a node should be created from there
> instead of fixing up from the code deep within the board.

I like that.  We can add a MachineClass::auto_enable_numa field
to indicate when a NUMA node is expected to be created
implicitly.

-- 
Eduardo

