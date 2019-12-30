Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659E4C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 12:02:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30689206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 12:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAHixCHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30689206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iltkP-0006Hl-97
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 07:02:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1iltjo-0005r8-DB
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 07:01:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1iltjm-0006QG-8I
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 07:01:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20994
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1iltjl-0006Pc-Q9
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 07:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577707288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NQPDixKpJBDGFc0SS8WFPo6VB8rQ5DPuYqTHsZamALE=;
 b=iAHixCHQUvuaHBK2TY9RrVBsVP4OOODvYlLeMFQ+qITv69gyRqAKDFknyLabsTIa1Swmcy
 oKtrexMM6ICxfOsIinsqtYBvuSkFbmB77z6+nqXEr++mCEYIc7WyGCWQIjH7PRdxhMpMRH
 X1TqqLd3K0sDLbtMeXiK/vHZvOpJkm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-8TH2HdMAO0-e0bDhc_Qbjg-1; Mon, 30 Dec 2019 07:01:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F1EE800D48;
 Mon, 30 Dec 2019 12:01:26 +0000 (UTC)
Received: from [10.40.204.31] (ovpn-204-31.brq.redhat.com [10.40.204.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDCB4381;
 Mon, 30 Dec 2019 12:01:24 +0000 (UTC)
Subject: Re: [PATCH v2] accel/kvm: Make "kernel_irqchip" default on
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20191228104326.21732-1-xiaoyao.li@intel.com>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Message-ID: <39a6be44-fd9a-60cd-6268-5dcd8f460bb4@redhat.com>
Date: Mon, 30 Dec 2019 13:01:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191228104326.21732-1-xiaoyao.li@intel.com>
Content-Language: sk-SK
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 8TH2HdMAO0-e0bDhc_Qbjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/28/19 11:43 AM, Xiaoyao Li wrote:
> Commit 11bc4a13d1f4 ("kvm: convert "-machine kernel_irqchip" to an
> accelerator property") moves kernel_irqchip property from "-machine" to
> "-accel kvm", but it forgets to set the default value of
> kernel_irqchip_allowed and kernel_irqchip_split.
>=20
> Also cleaning up the three useless members (kernel_irqchip_allowed,
> kernel_irqchip_required, kernel_irqchip_split) in struct MachineState.
>=20
> Fixes: 11bc4a13d1f4 ("kvm: convert "-machine kernel_irqchip" to an accele=
rator property")
> Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v2:
>   - Add Reported-by tag;
>   - Initialize kernel_irqchip_split in init_machine();
> ---
>  accel/kvm/kvm-all.c | 3 +++
>  include/hw/boards.h | 3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)

Huh, I've just converged to the same patch.

Tested-by: Michal Pr=EDvozn=EDk <mprivozn@redhat.com>

Michal


