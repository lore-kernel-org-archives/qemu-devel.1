Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5FBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1CC207F9
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6pE4ysC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1CC207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jehmp-0003DE-2x
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 12:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jehmA-0002ee-23
 for qemu-devel@nongnu.org; Fri, 29 May 2020 12:22:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22161
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jehm7-0005P5-Iw
 for qemu-devel@nongnu.org; Fri, 29 May 2020 12:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590769345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LiA7IcTgcwXaLS54JAhevAXGEaouaGh4rapnm2otjE=;
 b=a6pE4ysCfLixFskzodb1e/BOsBeTe60Sucz5+c5+0UNPAloBFAT0DFlbXndOddXDkUctJr
 zBaUkhAoKZhyQpo6guBaJGqCZsaVlgjv3Lw4qO1KT109fk1kC+pD/jiS+x/Nqnta0M6Ad8
 GHqw4EZSr6pDzOzLTGNIfCYe8xfLfIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-IhMZgKo8P2CG_A5usDDPnA-1; Fri, 29 May 2020 12:22:22 -0400
X-MC-Unique: IhMZgKo8P2CG_A5usDDPnA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0F3D1902EA0;
 Fri, 29 May 2020 16:22:20 +0000 (UTC)
Received: from ptitpuce (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EB555D9EF;
 Fri, 29 May 2020 16:22:03 +0000 (UTC)
References: <20200526185132.1652355-1-eblake@redhat.com>
User-agent: mu4e 1.3.9; emacs 26.2
From: Christophe de Dinechin <dinechin@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] or1k: Fix compilation hiccup
In-reply-to: <20200526185132.1652355-1-eblake@redhat.com>
Date: Fri, 29 May 2020 18:21:54 +0200
Message-ID: <m1d06msod9.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Jia Liu <proljc@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-05-26 at 20:51 CEST, Eric Blake wrote...
> On my Fedora 32 machine, gcc 10.1.1 at -O2 (the default for a bare
> './configure') has a false-positive complaint:
>
>   CC      or1k-softmmu/hw/openrisc/openrisc_sim.o
> /home/eblake/qemu/hw/openrisc/openrisc_sim.c: In function =E2=80=98openri=
sc_sim_init=E2=80=99:
> /home/eblake/qemu/hw/openrisc/openrisc_sim.c:87:42: error: =E2=80=98cpu_i=
rqs[0]=E2=80=99 may be used uninitialized in this function [-Werror=3Dmaybe=
-uninitialized]
>    87 |         sysbus_connect_irq(s, i, cpu_irqs[i][irq_pin]);
>       |                                  ~~~~~~~~^~~
>
> Initializing both pointers of cpu_irqs[] to NULL is sufficient to shut
> up the compiler, even though they are definitely assigned in
> openrisc_sim_init() prior to the inlined call to
> openrisc_sim_ompic_init() containing the line in question.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  hw/openrisc/openrisc_sim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index d08ce6181199..95011a8015b4 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -129,7 +129,7 @@ static void openrisc_sim_init(MachineState *machine)
>      const char *kernel_filename =3D machine->kernel_filename;
>      OpenRISCCPU *cpu =3D NULL;
>      MemoryRegion *ram;
> -    qemu_irq *cpu_irqs[2];
> +    qemu_irq *cpu_irqs[2] =3D {};

Why is the value [2] correct here? The loop that initializes loops over
machine->smp.cpus. Is it always less than 2 on this machine?


>      qemu_irq serial_irq;
>      int n;
>      unsigned int smp_cpus =3D machine->smp.cpus;


--
Cheers,
Christophe de Dinechin (IRC c3d)


