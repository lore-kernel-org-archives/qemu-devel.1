Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53012C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA7621E6E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA7621E6E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvH7V-0000zy-FV
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 04:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41764)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hvH76-0000XA-9Y
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hvH75-0002a7-1X
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:16:04 -0400
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:34791)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hvH74-0002ZG-Rs
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:16:02 -0400
Received: from player716.ha.ovh.net (unknown [10.109.146.1])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id F4163189DF8
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2019 10:15:59 +0200 (CEST)
Received: from kaod.org (bad36-1-78-202-132-1.fbx.proxad.net [78.202.132.1])
 (Authenticated sender: clg@kaod.org)
 by player716.ha.ovh.net (Postfix) with ESMTPSA id 433AE89CCDCE;
 Wed,  7 Aug 2019 08:15:50 +0000 (UTC)
To: Balamuruhan S <bala24@linux.ibm.com>, qemu-devel@nongnu.org
References: <20190807071445.4109-1-bala24@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9cbb8079-d606-ab69-a5b3-93226888108a@kaod.org>
Date: Wed, 7 Aug 2019 10:15:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807071445.4109-1-bala24@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9853594511436843793
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudduvddgtddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.127.22
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] Enhancing Qemu MMIO emulation with
 scripting interface
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
Cc: Peter Maydell <peter.maydell@linaro.org>, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, hari@linux.vnet.ibm.com, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/2019 09:14, Balamuruhan S wrote:
> Hi All,
> 
> This is a proposal to extend mmio callbacks in Qemu with scripting interface
> that is prototyped with python in this implementation. It gives ability to
> feed runtime data through callbacks without recompiling Qemu in generic way.
> This patchset adds library that provides APIs for Qemu to talk with python
> scripts placed in path -module-path and how existing xscom can be extended
> with python interface infrastructure.
> 
> We have also added an hacky emulation for memory region (OCC common area and HOMER)
> which is shared between core and un-core engine (ideally this should be via
> sram device) to showcase the effectiveness of having the scripting interface
> (uncore engine taken for discussion here is powerpc specificed called OCC).

We should try to merge this part first. It is useful as it is after some
cleanups.

> Having scripting interface helps to emulate/test different uncore-core
> interactions including uncore engine failure or hang. It also helps in feeding
> randomized data at byte level access. This patchset is primarily to extend mmio
> callbacks with scripting interface and to demonstrate effectiveness it.

It is already possible to feed device models with external data using QMP or
external agents using a chardev backend transport. What are the benefits
of using the embedded python approach ?  

> Some changes are required in PowerPC skiboot tree to test these changes since
> the memory region is disabled currently for Qemu emulated PowerNV host,
> https://github.com/balamuruhans/skiboot/commit/a655514d2a730e0372a2faee277d1cf01f71a524

You should send that patch.

Thanks,

C. 

> Qemu commandline used to test,
> 
> ```
> # qemu/ppc64-softmmu/qemu-system-ppc64 \
> -M powernv \
> -cpu POWER9 \
> -m 16G \
> -kernel vmlinux \
> -initrd debug_homer.cpio \
> -nographic -bios skiboot/skiboot.lid \
> -module-path /home/bala/homer/python-modules/,xscom_module=homer,xscom_read=xscom_read,xscom_write=xscom_write,homer_module=homer,homer=homer_read,occ_module=homer,occ=occ_read
> ```
> 
> Script used to feed data can be something like,
> https://github.com/balamuruhans/python-modules/blob/master/script.py
> 
> It could uncover couple of firmware bugs,
> https://github.com/balamuruhans/skiboot/commit/fd3d93d92ec66a7494346d6d24ced7b48264c9a0
> https://github.com/balamuruhans/skiboot/commit/165b3829a93bc177c18133945a8cca3a2d701173
> 
> Code changes:
> Patch 1: adds library to provide python interface APIs
> Patch 2: extend existing xscom to adopt this python interface
> Patch 3 - 6: emulate uncore/core shared memory region with mmio callbacks and
> add support with this infrastructure.
> 
> I request for comments, suggestions, ideas on getting a scripting interface
> like python added in qemu.
> 
> Balamuruhan S (6):
>   utils/python_api: add scripting interface for Qemu with python lib
>   hw/ppc/pnv_xscom: extend xscom to use python interface
>   hw/ppc/pnv_homer: add homer/occ common area emulation for PowerNV
>   hw/ppc/pnv: initialize and realize homer/occ common area
>   hw/ppc/pnv_xscom: retrieve homer/occ base address from PBA BARs
>   hw/ppc/pnv_homer: add python interface support for homer/occ common
>     area
> 
>  configure                   |  10 +++
>  hw/ppc/Makefile.objs        |   2 +-
>  hw/ppc/pnv.c                |  49 ++++++++++-
>  hw/ppc/pnv_homer.c          | 205 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/ppc/pnv_xscom.c          |  59 +++++++++++--
>  include/hw/ppc/pnv.h        |  15 ++++
>  include/hw/ppc/pnv_homer.h  |  41 +++++++++
>  include/sysemu/python_api.h |  30 +++++++
>  include/sysemu/sysemu.h     |   8 ++
>  qemu-options.hx             |  14 +++
>  util/Makefile.objs          |   1 +
>  util/python_api.c           | 100 +++++++++++++++++++++
>  vl.c                        |  66 ++++++++++++++
>  13 files changed, 588 insertions(+), 12 deletions(-)
>  create mode 100644 hw/ppc/pnv_homer.c
>  create mode 100644 include/hw/ppc/pnv_homer.h
>  create mode 100644 include/sysemu/python_api.h
>  create mode 100644 util/python_api.c
> 


