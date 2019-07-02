Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346ACC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF4C32146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4C32146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi9fl-0004gp-Cd
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 23:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45114)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hi86f-00075K-Lv
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hi86e-0000bX-Ng
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:01:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38906)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hi86U-0000WC-RA
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:01:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D216CC07410F;
 Tue,  2 Jul 2019 02:00:41 +0000 (UTC)
Received: from [10.72.12.183] (ovpn-12-183.pek2.redhat.com [10.72.12.183])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8BF15D977;
 Tue,  2 Jul 2019 02:00:34 +0000 (UTC)
To: Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, 
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 qemu-dev <qemu-devel@nongnu.org>, Stefano Stabellini
 <sstabellini@kernel.org>, Paul Durrant <paul.durrant@citrix.com>
References: <20190609164433.5866-1-chen.zhang@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f6e8af13-7ffa-3889-dd9e-a973a0c6295c@redhat.com>
Date: Tue, 2 Jul 2019 10:00:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190609164433.5866-1-chen.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 02 Jul 2019 02:00:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V2 0/5] Add Xen COLO support
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/6/10 =E4=B8=8A=E5=8D=8812:44, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
>
> Xen COLO based on KVM COLO architecture, it shared COLO proxy and block
> replication with KVM COLO. The only differece is Xen COLO have own
> COLO-frame to handle live migration related function, so we need this
> series make Xen COLO frame can communicate with other COLO modules in
> qemu. Xen side related patches have been merged.
>
> V2:
>   - Rebase on upstream code.
>   - Optimize code by Zhijian's comments in patch 4/5.
>   - Remove origin 5/6 patch.
>
> V1:
>   - Initial patch.
>
> Zhang Chen (5):
>    COLO-compare: Add new parameter to communicate with remote colo-fram=
e
>    COLO-compare: Add remote notification chardev handler frame
>    COLO-compare: Make the compare_chr_send() can send notification
>      message.
>    COLO-compare: Add colo-compare remote notify support
>    migration/colo.c: Add missed filter notify for Xen COLO.
>
>   migration/colo.c   |   2 +
>   net/colo-compare.c | 155 +++++++++++++++++++++++++++++++++++++++-----=
-
>   qemu-options.hx    |  33 +++++++++-
>   3 files changed, 171 insertions(+), 19 deletions(-)


Applied.

Thanks

>

