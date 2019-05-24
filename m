Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0092CC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A0120851
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A0120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56521 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCQQ-0006ol-H4
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 11:48:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hUCPS-0006Sv-KD
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hUCPR-0003fD-09
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:47:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hUCPQ-0003ew-R4
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:47:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 48E44D77F2;
	Fri, 24 May 2019 15:46:48 +0000 (UTC)
Received: from [10.40.205.56] (unknown [10.40.205.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A06BD100200A;
	Fri, 24 May 2019 15:46:39 +0000 (UTC)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190521141133.27380-1-lvivier@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <74a70577-f63d-3137-c957-af914ae81090@redhat.com>
Date: Fri, 24 May 2019 17:46:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190521141133.27380-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Fri, 24 May 2019 15:46:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 0/4] rng-builtin: add an RNG backend
 that uses qemu_guest_getrandom()
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
Cc: "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>,
	Amit Shah <amit@kernel.org>, Markus Armbruster <armbru@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Richard W . M . Jones" <rjones@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michael,

the series seems ready to be merged, and the one from Richard is now 
part of master. Could you add it to one of your future virtio pull requests?

Thanks,
Laurent

On 21/05/2019 16:11, Laurent Vivier wrote:
> Add a new RNG backend using QEMU builtin getrandom function.
> 
> This patch applies on top of
>      "[PATCH v8 00/24] Add qemu_getrandom and ARMv8.5-RNG etc"
> Based-on: 20190517023924.1686-1-richard.henderson@linaro.org
> 
> v6: remove "sysemu/rng-random.h" from virtio-rng.c
>      rebase on qemu_getrandom v8
> 
> v5: PATCH 1 s/linux/Linux/
>      remove superfluous includes from rng-builtin.c
>      don't update rng-random documentation
>      add a patch from Markus to keep the default backend out of VirtIORNGConf
>      move TYPE_RNG_BUILTIN to sysemu/rng.h and remove sysemu/rng-builtin.h
> 
> v4: update PATCH 1 commit message
> 
> v3: Include Kashyap's patch in the series
>      Add a patch to change virtio-rng default backend to rng-builtin
> 
> v2: Update qemu-options.hx
>      describe the new backend and specify virtio-rng uses the
>      rng-random by default
> 
> Kashyap Chamarthy (1):
>    VirtIO-RNG: Update default entropy source to `/dev/urandom`
> 
> Laurent Vivier (2):
>    rng-builtin: add an RNG backend that uses qemu_guest_getrandom()
>    virtio-rng: change default backend to rng-builtin
> 
> Markus Armbruster (1):
>    virtio-rng: Keep the default backend out of VirtIORNGConf
> 
>   backends/Makefile.objs         |  2 +-
>   backends/rng-builtin.c         | 53 ++++++++++++++++++++++++++++++++++
>   backends/rng-random.c          |  2 +-
>   hw/virtio/virtio-rng.c         | 19 +++++-------
>   include/hw/virtio/virtio-rng.h |  2 --
>   include/sysemu/rng.h           |  2 ++
>   qemu-options.hx                |  9 +++++-
>   7 files changed, 73 insertions(+), 16 deletions(-)
>   create mode 100644 backends/rng-builtin.c
> 


