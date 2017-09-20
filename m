Received: from eggs.gnu.org ([2001:4830:134:3::10]:36106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1duYqn-0007uO-3Y
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1duYqi-0006HD-49
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:51:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1duYqh-0006GL-Sc
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:51:08 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8K6mwC3029110
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 02:51:06 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3cmre1b8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 02:51:06 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 20 Sep 2017 16:51:04 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <87vakdhnyn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
References: <20170913073519.GK7550@umbus.fritz.box>
	<8760clsw17.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170915064830.GI5250@umbus.fritz.box>
	<87377omkuk.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170915085115.GN5250@umbus.fritz.box>
	<87y3pgl45f.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170919082421.GU27153@umbus>
	<871sn2hugn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920045524.GH5520@umbus.fritz.box>
	<87y3pagdg0.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920061756.GJ5520@umbus.fritz.box>
	<87vakdhnyn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Date: Wed, 20 Sep 2017 12:20:51 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87shfhhnhw.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix cores per chip for multiple
 cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org

Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:

>> >> 
>>> >> I think the current approach is the simplest and less intrusive, as we
>>> >> are handling a case where user has not bothered to provide a detailed
>>> >> topology, the best we can do is create single threaded cores equal to
>>> >> number of cores.
>>> >
>>> > No, sorry.  Having smp_cores not correspond to the number of cores per
>>> > chip in all cases is just not ok.  Add an error message if the
>>> > topology isn't workable for powernv by all means.  But users having to
>>> > use a longer command line is better than breaking basic assumptions
>>> > about what numbers reflect what topology.
>>> 
>>> Sorry to ask again, as I am still not convinced, we do similar
>>> adjustment in spapr where the user did not provide the number of cores,
>>> but qemu assumes them as single threaded cores and created
>>> cores(boot_cores_nr) that were not same as smp_cores ?
>>
>> What?  boot_cores_nr has absolutely nothing to do with adjusting the
>> topology, and it certainly doesn't assume they're single threaded.
>
> When we start a TCG guest and user provides following commandline,
> e.g. "-smp 4", smt_threads is set to 1 by default in vl.c.

I meant smp_threads here.

> So the guest boots with 4 cores, each having 1 thread.
>
> Regards
> Nikunj
