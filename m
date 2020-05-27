Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81F5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:30:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79040207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+ik8TaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79040207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdoeS-0005rf-6i
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 01:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdodf-0005Ge-8Y
 for qemu-devel@nongnu.org; Wed, 27 May 2020 01:30:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30687
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdode-00079W-FT
 for qemu-devel@nongnu.org; Wed, 27 May 2020 01:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590557401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=tJsNjsmaqQZ4BUorC3LNkSefPwh8UwF+jZGK04g0f9Y=;
 b=d+ik8TaZf1IoZhefbYEnCUKbymbDfHJLVdScrZ90u6bHa0HGxAYulXieMzsa9m4TyroCV8
 u5UuqOnlPQZ4CujiN6+/TQCtp2HEL6AQdhSfhViCbD9QMsGpJj3G88pkF9MLLAb93hK1p4
 U2CFq/WgPVBhdM2Hj9ewLIkVUhuTAcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-TcKEsffhN6-_5DHoTkd7BQ-1; Wed, 27 May 2020 01:29:57 -0400
X-MC-Unique: TcKEsffhN6-_5DHoTkd7BQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A40CA800688;
 Wed, 27 May 2020 05:29:56 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-170.ams2.redhat.com [10.36.112.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C37D05D9C9;
 Wed, 27 May 2020 05:29:54 +0000 (UTC)
Subject: Re: [PATCH] or1k: Fix compilation hiccup
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200526185132.1652355-1-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <946e5bfa-d819-22af-ac24-9141afec3a86@redhat.com>
Date: Wed, 27 May 2020 07:29:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200526185132.1652355-1-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:49:35
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
 Jia Liu <proljc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/05/2020 20.51, Eric Blake wrote:
> On my Fedora 32 machine, gcc 10.1.1 at -O2 (the default for a bare
> './configure') has a false-positive complaint:
> 
>   CC      or1k-softmmu/hw/openrisc/openrisc_sim.o
> /home/eblake/qemu/hw/openrisc/openrisc_sim.c: In function ‘openrisc_sim_init’:
> /home/eblake/qemu/hw/openrisc/openrisc_sim.c:87:42: error: ‘cpu_irqs[0]’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
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
>      const char *kernel_filename = machine->kernel_filename;
>      OpenRISCCPU *cpu = NULL;
>      MemoryRegion *ram;
> -    qemu_irq *cpu_irqs[2];
> +    qemu_irq *cpu_irqs[2] = {};
>      qemu_irq serial_irq;
>      int n;
>      unsigned int smp_cpus = machine->smp.cpus;
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


