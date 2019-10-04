Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D8AC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C28215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C28215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGIrB-0005SQ-J6
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 04:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iGIpl-0004gl-RT
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iGIpk-0002kt-GZ
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:21:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42962)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1iGIph-0002in-4x; Fri, 04 Oct 2019 04:21:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C62E77FDC9;
 Fri,  4 Oct 2019 08:20:59 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E787E5D772;
 Fri,  4 Oct 2019 08:20:53 +0000 (UTC)
Date: Fri, 4 Oct 2019 10:20:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Xiang Zheng <zhengxiang9@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v18 2/6] docs: APEI GHES generation and
 CPER record description
Message-ID: <20191004102051.4e45cbd2@redhat.com>
In-Reply-To: <20190906083152.25716-3-zhengxiang9@huawei.com>
References: <20190906083152.25716-1-zhengxiang9@huawei.com>
 <20190906083152.25716-3-zhengxiang9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 04 Oct 2019 08:21:00 +0000 (UTC)
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, wanghaibin.wang@huawei.com, mtosatti@redhat.com,
 linuxarm@huawei.com, qemu-devel@nongnu.org, gengdongjiu@huawei.com,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, james.morse@arm.com,
 xuwei5@huawei.com, jonathan.cameron@huawei.com, pbonzini@redhat.com,
 lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Sep 2019 16:31:48 +0800
Xiang Zheng <zhengxiang9@huawei.com> wrote:

> From: Dongjiu Geng <gengdongjiu@huawei.com>
> 
[...]
> +
> +(9) When QEMU gets SIGBUS from the kernel, QEMU formats the CPER right into
> +    guest memory, and then injects whatever interrupt (or assert whatever GPIO
s/whatever .../platform specific/

and add concrete impl info like:
  "in case of arm/virt machine it's ..."

> +    line) as a notification which is necessary for notifying the guest.
[...]

