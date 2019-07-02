Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88551C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2505821721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2505821721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiNmw-000480-5j
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 14:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59866)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hiMRY-0000Qd-E0
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hiMRW-0004OB-EI
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:19:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hiMRS-0003t8-7y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:19:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 11C86307D848
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2019 17:19:04 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 969C91992E;
 Tue,  2 Jul 2019 17:19:03 +0000 (UTC)
Date: Tue, 2 Jul 2019 14:19:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190702171901.GQ5198@habkost.net>
References: <CAFEAcA8Jnh=tu8s08Fu6n0sSmJJuVOx7YxyTR_ni5yW3DdMFkQ@mail.gmail.com>
 <20190702140745.27767-1-imammedo@redhat.com>
 <20190702140745.27767-3-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702140745.27767-3-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 02 Jul 2019 17:19:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: use -numa memdev option in
 tests instead of legacy 'mem' option
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 02, 2019 at 10:07:45AM -0400, Igor Mammedov wrote:
> it will test preferred memdev option more extensively and remove
> undesired deprecation warnings during 'make check'
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
[...]
> diff --git a/tests/numa-test.c b/tests/numa-test.c
> index 8de8581231..902e8de4d1 100644
> --- a/tests/numa-test.c
> +++ b/tests/numa-test.c
> @@ -26,8 +26,10 @@ static void test_mon_explicit(const void *data)
>      QTestState *qts;
>  
>      cli = make_cli(data, "-smp 8 "
> -                   "-numa node,nodeid=0,cpus=0-3 "
> -                   "-numa node,nodeid=1,cpus=4-7 ");
> +                   "-object memory-backend-ram,id=ram0,size=64M "
> +                   "-object memory-backend-ram,id=ram1,size=64M "
> +                   "-numa node,nodeid=0,cpus=0-3,memdev=ram0 "
> +                   "-numa node,nodeid=1,cpus=4-7,memdev=ram1 ");

These changes break on ppc64, where default RAM size is 512 MiB
and it has to be a multiple of 256 MiB.

Can't we just make the warnings be conditional on
!qtest_enabled(), like we already do elsewhere?

>      qts = qtest_init(cli);
>  
>      s = qtest_hmp(qts, "info numa");
> @@ -45,7 +47,10 @@ static void test_mon_default(const void *data)
>      char *cli;
>      QTestState *qts;
>  
> -    cli = make_cli(data, "-smp 8 -numa node -numa node");
> +    cli = make_cli(data, "-smp 8 "
> +                   "-object memory-backend-ram,id=ram0,size=64M "
> +                   "-object memory-backend-ram,id=ram1,size=64M "
> +                   "-numa node,memdev=ram0 -numa node,memdev=ram1");
>      qts = qtest_init(cli);
>  
>      s = qtest_hmp(qts, "info numa");
> @@ -64,8 +69,10 @@ static void test_mon_partial(const void *data)
>      QTestState *qts;
>  
>      cli = make_cli(data, "-smp 8 "
> -                   "-numa node,nodeid=0,cpus=0-1 "
> -                   "-numa node,nodeid=1,cpus=4-5 ");
> +                   "-object memory-backend-ram,id=ram0,size=64M "
> +                   "-object memory-backend-ram,id=ram1,size=64M "
> +                   "-numa node,nodeid=0,cpus=0-1,memdev=ram0 "
> +                   "-numa node,nodeid=1,cpus=4-5,memdev=ram1");
>      qts = qtest_init(cli);
>  
>      s = qtest_hmp(qts, "info numa");
> @@ -93,7 +100,11 @@ static void test_query_cpus(const void *data)
>      QObject *e;
>      QTestState *qts;
>  
> -    cli = make_cli(data, "-smp 8 -numa node,cpus=0-3 -numa node,cpus=4-7");
> +    cli = make_cli(data, "-smp 8 "
> +                   "-object memory-backend-ram,id=ram0,size=64M "
> +                   "-object memory-backend-ram,id=ram1,size=64M "
> +                   "-numa node,cpus=0-3,memdev=ram0 "
> +                   "-numa node,cpus=4-7,memdev=ram1");
>      qts = qtest_init(cli);
>      cpus = get_cpus(qts, &resp);
>      g_assert(cpus);
> @@ -132,7 +143,9 @@ static void pc_numa_cpu(const void *data)
>      QTestState *qts;
>  
>      cli = make_cli(data, "-cpu pentium -smp 8,sockets=2,cores=2,threads=2 "
> -        "-numa node,nodeid=0 -numa node,nodeid=1 "
> +        "-object memory-backend-ram,id=ram0,size=64M "
> +        "-object memory-backend-ram,id=ram1,size=64M "
> +        "-numa node,nodeid=0,memdev=ram0 -numa node,nodeid=1,memdev=ram1 "
>          "-numa cpu,node-id=1,socket-id=0 "
>          "-numa cpu,node-id=0,socket-id=1,core-id=0 "
>          "-numa cpu,node-id=0,socket-id=1,core-id=1,thread-id=0 "
> @@ -186,7 +199,9 @@ static void spapr_numa_cpu(const void *data)
>      QTestState *qts;
>  
>      cli = make_cli(data, "-smp 4,cores=4 "
> -        "-numa node,nodeid=0 -numa node,nodeid=1 "
> +        "-object memory-backend-ram,id=ram0,size=64M "
> +        "-object memory-backend-ram,id=ram1,size=64M "
> +        "-numa node,nodeid=0,memdev=ram0 -numa node,nodeid=1,memdev=ram1 "
>          "-numa cpu,node-id=0,core-id=0 "
>          "-numa cpu,node-id=0,core-id=1 "
>          "-numa cpu,node-id=0,core-id=2 "
> @@ -232,7 +247,9 @@ static void aarch64_numa_cpu(const void *data)
>      QTestState *qts;
>  
>      cli = make_cli(data, "-smp 2 "
> -        "-numa node,nodeid=0 -numa node,nodeid=1 "
> +        "-object memory-backend-ram,id=ram0,size=64M "
> +        "-object memory-backend-ram,id=ram1,size=64M "
> +        "-numa node,nodeid=0,memdev=ram0 -numa node,nodeid=1,memdev=ram1 "
>          "-numa cpu,node-id=1,thread-id=0 "
>          "-numa cpu,node-id=0,thread-id=1");
>      qts = qtest_init(cli);
> @@ -274,14 +291,16 @@ static void pc_dynamic_cpu_cfg(const void *data)
>      QList *cpus;
>      QTestState *qs;
>  
> -    qs = qtest_initf("%s -nodefaults --preconfig -smp 2",
> +    qs = qtest_initf("%s -nodefaults --preconfig -smp 2 "
> +                     "-object memory-backend-ram,id=ram0,size=64M "
> +                     "-object memory-backend-ram,id=ram1,size=64M",
>                       data ? (char *)data : "");
>  
>      /* create 2 numa nodes */
>      g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> -        " 'arguments': { 'type': 'node', 'nodeid': 0 } }")));
> +        " 'arguments': { 'type': 'node', 'nodeid': 0, 'memdev': 'ram0' } }")));
>      g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> -        " 'arguments': { 'type': 'node', 'nodeid': 1 } }")));
> +        " 'arguments': { 'type': 'node', 'nodeid': 1, 'memdev': 'ram1' } }")));
>  
>      /* map 2 cpus in non default reverse order
>       * i.e socket1->node0, socket0->node1
> -- 
> 2.18.1
> 

-- 
Eduardo

