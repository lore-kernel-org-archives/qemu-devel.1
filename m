Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297F9C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 09:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE46120656
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 09:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE46120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47207 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFxsR-0007FQ-8p
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 05:26:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hFxrd-0006tb-Qs
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hFxrc-0007M1-Pq
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:25:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hFxra-0007Jn-7S
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:25:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D88A5330247;
	Mon, 15 Apr 2019 09:25:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B8705C220;
	Mon, 15 Apr 2019 09:25:02 +0000 (UTC)
Date: Mon, 15 Apr 2019 10:25:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pu Wen <puwen@hygon.cn>
Message-ID: <20190415092500.GD5718@redhat.com>
References: <1555124080-27089-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1555124080-27089-1-git-send-email-puwen@hygon.cn>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Mon, 15 Apr 2019 09:25:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] i386: Add new Hygon 'Dhyana' CPU model
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
	pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415092500.KyW0g7kBOujIGENjPnSBupldE57pGhG1a_ldT3zHTw0@z>

On Sat, Apr 13, 2019 at 10:54:40AM +0800, Pu Wen wrote:
> Add a new base CPU model called 'Dhyana' to model processors from Hygon
> Dhyana(family 18h), which derived from AMD EPYC(family 17h).
> 
> The following features bits have been removed compare to AMD EPYC:
> aes, pclmulqdq, sha_ni
> 
> The Hygon Dhyana support to KVM in Linux is already accepted upstream[1].
> So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
> CPU model.
> 
> Reference:
> [1] https://git.kernel.org/tip/fec98069fb72fb656304a3e52265e0c2fc9adf87
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
> v1->v2:
>   - Remove CPU model 'Dhyana' and rename the CPU model 'Dhyana-IBPB' to
>     'Dhyana' because Dhyana CPUs already have the IBPB feature.
> 
>  hw/i386/pc.c      |  3 +++
>  target/i386/cpu.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/i386/cpu.h |  2 ++
>  3 files changed, 55 insertions(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f2c15bf..551bec9 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -128,6 +128,8 @@ GlobalProperty pc_compat_3_1[] = {
>      { "EPYC" "-" TYPE_X86_CPU, "nrip-save", "off" },
>      { "EPYC-IBPB" "-" TYPE_X86_CPU, "npt", "off" },
>      { "EPYC-IBPB" "-" TYPE_X86_CPU, "nrip-save", "off" },
> +    { "Dhyana" "-" TYPE_X86_CPU, "npt", "off" },
> +    { "Dhyana" "-" TYPE_X86_CPU, "nrip-save", "off" },
>      { "Skylake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
>      { "Skylake-Client-IBRS" "-" TYPE_X86_CPU, "mpx", "on" },
>      { "Skylake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
> @@ -152,6 +154,7 @@ GlobalProperty pc_compat_2_12[] = {
>      { TYPE_X86_CPU, "topoext", "off" },
>      { "EPYC-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>      { "EPYC-IBPB-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
> +    { "Dhyana-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>  };
>  const size_t pc_compat_2_12_len = G_N_ELEMENTS(pc_compat_2_12);

You can drop the changes in this file. This CPU model didn't exist
in any older QEMU releases, so there's no machine type backcompat
required, at least from upstream QEMU POV.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

