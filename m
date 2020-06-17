Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F6AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF5720888
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AU2CWSMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF5720888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZG5-0004eg-Dr
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1jlZFS-00044q-Oj
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:41:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51022
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1jlZFQ-0000Pp-3h
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592404861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GifFRq1YyWVeUgLD4qr0dDdIHq2a46eAMqJSFBJdG+o=;
 b=AU2CWSMh2CJlL2j9n7i8WNIAAZtkq53TM/V30Fxvr6IWqwY1Xl5ptLUQhFDMnt3aQhCyO+
 MP/DYOQsUEf3R8XZqzT4d3164zYT3AUu7Ms56cKA2sG1zy3bH+c288zY25TOJe5H4wGWQM
 9tFhca8WNQlQDp73I/n8/IOmso+fGmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-WZhSFOokN4OonPyj9zL_lw-1; Wed, 17 Jun 2020 10:39:43 -0400
X-MC-Unique: WZhSFOokN4OonPyj9zL_lw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1429318A0763;
 Wed, 17 Jun 2020 14:39:42 +0000 (UTC)
Received: from [10.10.118.17] (ovpn-118-17.rdu2.redhat.com [10.10.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABAFF6E9F3;
 Wed, 17 Jun 2020 14:39:41 +0000 (UTC)
Subject: Re: [PATCH 00/78] Patch Round-up for stable 4.2.1, freeze on
 2020-06-22
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <272ae6a4-c6ba-5a47-0edd-11c0f592e4fd@redhat.com>
Date: Wed, 17 Jun 2020 10:39:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=crobinso@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 10:14 AM, Michael Roth wrote:
> Hi everyone,
> 
> The following new patches are queued for QEMU stable v4.2.1:
> 
>   https://github.com/mdroth/qemu/commits/stable-4.2-staging
> 
> The release is planned for 2020-06-25:
> 
>   https://wiki.qemu.org/Planning/4.2
> 
> Due to delays on my part this release is going out beyond the normal
> ~4 month support window. v5.0.1 is scheduled to be released as normal.
> 
> Please respond here or CC qemu-stable@nongnu.org on any additional patches
> you think should be included in the release.
> 
> Thanks!

A few bug fixes we are carrying in Fedora 32:

commit eca3a945234a5f0a499860dd11df64b5f1a2e0a5
Author: Cole Robinson <crobinso@redhat.com>
Date:   Wed Nov 13 16:09:35 2019 -0500

    tests: fix modules-test 'duplicate test case' error

commit 8deb8019d696c75e6ecaee7545026b62aba2f1bb
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Fri Oct 18 15:19:31 2019 +1100

    spapr: Don't trigger a CAS reboot for XICS/XIVE mode changeover

commit bb8136df698bd565ee4f6c18d26c50dee320bfe4
Author: Pan Nengyuan <pannengyuan@huawei.com>
Date:   Tue Dec 10 15:14:37 2019 +0800

    riscv/sifive_u: fix a memory leak in soc_realize()

commit a37f21c27d3e2342c2080aafd4cfe7e949612428
Author: Yiting Wang <yiting.wang@windriver.com>
Date:   Fri Jan 3 11:53:42 2020 +0800

    riscv: Set xPIE to 1 after xRET

commit 613fa160e19abe8e1fe44423fcfa8ec73d3d48e5
Author: ShihPo Hung <shihpo.hung@sifive.com>
Date:   Tue Jan 14 22:17:31 2020 -0800

    target/riscv: Fix tb->flags FS status

commit a59796eb6d59bbd74ce28ddbddb1b83e60674e96
Author: ShihPo Hung <shihpo.hung@sifive.com>
Date:   Tue Jan 14 22:17:32 2020 -0800

    target/riscv: fsd/fsw doesn't dirty FP state

commit 82f014671cf057de51c4a577c9e2ad637dcec6f9
Author: ShihPo Hung <shihpo.hung@sifive.com>
Date:   Tue Jan 14 22:17:33 2020 -0800

    target/riscv: update mstatus.SD when FS is set dirty


Thanks,
Cole


