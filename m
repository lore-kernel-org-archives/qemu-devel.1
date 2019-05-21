Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB63C04E87
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D39208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D39208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55923 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT73H-0000Zk-Qk
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 11:51:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hT72I-0008Sf-5U
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hT72H-0003bm-9l
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:50:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hT72H-00031N-45; Tue, 21 May 2019 11:50:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 898FF81E15;
	Tue, 21 May 2019 15:50:19 +0000 (UTC)
Received: from [10.36.116.113] (ovpn-116-113.ams2.redhat.com [10.36.116.113])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C96566013C;
	Tue, 21 May 2019 15:50:12 +0000 (UTC)
To: Li Qiang <liq3ea@163.com>, alex.williamson@redhat.com, lvivier@redhat.com
References: <20190521151543.92274-1-liq3ea@163.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <05fc7675-9935-4be7-b569-a1a6028d514e@redhat.com>
Date: Tue, 21 May 2019 17:50:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190521151543.92274-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 21 May 2019 15:50:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/4] hw: vfio: some trivial fix
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
Cc: qemu-trivial@nongnu.org, liq3ea@gmail.com, philmd@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
On 5/21/19 5:15 PM, Li Qiang wrote:
> These patchset fix some trivial issues,
> The first patch makes the code more QOMConventions.
> The second decouples VMStateDescription's name with
> QOM TypeInfo's name.
> The third fixes a typo.
> The fourth reduce duplicated code.
> 
> Change since v1:
> Add more commit message.

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> 
> Li Qiang (4):
>   vfio: pci: make "vfio-pci-nohotplug" as MACRO
>   hw: vfio: drop TYPE_FOO MACRO in VMStateDescription
>   vfio: platform: fix a typo
>   pci: msix: move 'MSIX_CAP_LENGTH' to header file
> 
>  hw/pci/msix.c           | 2 --
>  hw/vfio/amd-xgbe.c      | 2 +-
>  hw/vfio/ap.c            | 2 +-
>  hw/vfio/calxeda-xgmac.c | 2 +-
>  hw/vfio/ccw.c           | 2 +-
>  hw/vfio/pci.c           | 8 ++++----
>  hw/vfio/platform.c      | 6 +++---
>  include/hw/pci/msix.h   | 2 ++
>  8 files changed, 13 insertions(+), 13 deletions(-)
> 

