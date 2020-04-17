Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B0DC352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8CD207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8CD207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPPN9-0004Vp-JD
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 07:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jPPMW-0003mS-Q0
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jPPMV-0005Av-19
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:40:48 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:22905)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1jPPMS-00058l-2w
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:40:44 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 121BA747DFD;
 Fri, 17 Apr 2020 13:40:42 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E2EA0747DFB; Fri, 17 Apr 2020 13:40:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E1A3674637F;
 Fri, 17 Apr 2020 13:40:41 +0200 (CEST)
Date: Fri, 17 Apr 2020 13:40:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Randy Yates <yates@digitalsignallabs.com>
Subject: Re: QEMU Development Questions
In-Reply-To: <87mu7ac2ah.fsf@digitalsignallabs.com>
Message-ID: <alpine.BSF.2.22.395.2004171316240.20859@zero.eik.bme.hu>
References: <87mu7ac2ah.fsf@digitalsignallabs.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Apr 2020, Randy Yates wrote:
>    1.  Apparently the CPU has properties. What are the specific properties and their
>        defaults?  How do you change a property's default value?

Maybe look for DEFINE_PROP_ to find out, For example:

qemu/target/arm/cpu.c:2757:
static Property arm_cpu_properties[] = {
     DEFINE_PROP_BOOL("start-powered-off", ARMCPU, start_powered_off, false),
     DEFINE_PROP_UINT32("psci-conduit", ARMCPU, psci_conduit, 0),
     DEFINE_PROP_UINT32("midr", ARMCPU, midr, 0),
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
                         mp_affinity, ARM64_AFFINITY_INVALID),
     DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
     DEFINE_PROP_END_OF_LIST()
};

then qemu/hw/arm/bcm2836.c:138:
         /* start powered off if not enabled */
         object_property_set_bool(OBJECT(&s->cpu[n].core), n >= s->enabled_cpus,
                                  "start-powered-off", &err);


There's probably also a way to query and set these from monitor, info 
qtree command lists properties of instantiated devices I think. There's 
also some device_add option to get info on other devices but I don't know 
how that works. Maybe help device_add in monitor tells you.

>    2.  Ditto previous question for other machine components.

Same as above, but look for property definition in device model under 
qemu/hw.

>    5.  There may be custom hardware involved, e.g., GPIOs, I2Cs, etc.  How would
>        these be defined in the machine?

You need to find the appropriate device model or write it if does not 
exist then set it up in the board code to appear at the right addresses 
(or attach to right bus e.g. for i2c devices). The info mtree monitor 
command is useful to see what's mapped where and you can compare it to 
memory map of real hardware. For writing device models look at exising 
similar examples. Also enabling #define DEBUG_UNASSIGNED in qemu/memory.c 
is useful to get logs about guest attempting to access missing devices 
(although logged address can be relative to a memory region so may not be 
actual memory address in some cases). There's also a placeholder 
unimplemented device model that you can map over known unimplemented 
areas before you actually implement them, see for example 
hw/arm/xlnx-versal.c for how it's used.

>    6.  Documentation for routing the monitor to another place (e.g., a telnet termi-
>        nal) could be better.  pm215 gave me the following complex set of command-
>        line options:
>
>
>        -chardev  socket,id=monitor,host=127.0.0.1,port=4444,server,nowait,telnet  -mon  chardev=monitor,mode=readline

This works, for telnet I'm afraid that's the simplest way. There's 
-monitor stdio or -serial stdio that can be useful.

>    7.  Ditto above comment for the -d option.

I think there's -D logfile to specify log file, these are somewhat 
documented in --help.

Regards,
BALATON Zoltan

