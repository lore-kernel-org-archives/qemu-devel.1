Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AECEC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 19:40:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0772075C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 19:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0772075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48894 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYbmC-0007oa-QB
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 15:40:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxiwell@linux.ibm.com>) id 1hYblL-0007N6-7J
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 15:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxiwell@linux.ibm.com>) id 1hYblJ-0000tt-9D
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 15:39:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50694
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxiwell@linux.ibm.com>)
	id 1hYblJ-0000bn-3Z
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 15:39:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x55JbqnG025174
	for <qemu-devel@nongnu.org>; Wed, 5 Jun 2019 15:39:38 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2sxhttnpy9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 15:39:37 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <maxiwell@linux.ibm.com>;
	Wed, 5 Jun 2019 20:39:37 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
	by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 5 Jun 2019 20:39:33 +0100
Received: from b03ledav004.gho.boulder.ibm.com
	(b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x55JdWA320054436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Wed, 5 Jun 2019 19:39:32 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91AE178064;
	Wed,  5 Jun 2019 19:39:32 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E52D7805E;
	Wed,  5 Jun 2019 19:39:31 +0000 (GMT)
Received: from maxibm (unknown [9.85.186.195])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
	Wed,  5 Jun 2019 19:39:30 +0000 (GMT)
Date: Wed, 5 Jun 2019 16:39:27 -0300
From: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190520204340.832-1-maxiwell@linux.ibm.com>
	<20190520204340.832-2-maxiwell@linux.ibm.com>
	<20190522232952.GN30423@umbus.fritz.box>
	<20190523201851.llsufz6dfs3gzyc6@maxibm>
	<20190530011341.GB2017@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530011341.GB2017@umbus.fritz.box>
User-Agent: NeoMutt/20180716
X-TM-AS-GCONF: 00
x-cbid: 19060519-0004-0000-0000-00001518ACAA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011220; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000286; SDB=6.01213719; UDB=6.00637941;
	IPR=6.00994793; 
	MB=3.00027198; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-05 19:39:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060519-0005-0000-0000-00008BF412FF
Message-Id: <20190605193927.3lek4voay5stxtqt@maxibm>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-06-05_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1906050123
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/1] spapr: Do not re-read the
 clock on pre_save handler on migration
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 30, 2019 at 11:13:41AM +1000, David Gibson wrote:
> On Thu, May 23, 2019 at 05:18:51PM -0300, Maxiwell S. Garcia wrote:
> > On Thu, May 23, 2019 at 09:29:52AM +1000, David Gibson wrote:
> > > On Mon, May 20, 2019 at 05:43:40PM -0300, Maxiwell S. Garcia wrote:
> > > > This handler was added in the commit:
> > > >   42043e4f1241: spapr: clock should count only if vm is running
> > > > 
> > > > In a scenario without migration, this pre_save handler is not
> > > > triggered, so the 'stop/cont' commands save and restore the clock
> > > > in the function 'cpu_ppc_clock_vm_state_change.' The SW clock
> > > > in the guest doesn't know about this pause.
> > > > 
> > > > If the command 'migrate' is called between 'stop' and 'cont',
> > > > the pre_save handler re-read the clock, and the SW clock in the
> > > > guest will know about the pause between 'stop' and 'migrate.'
> > > > If the guest is running a workload like HTC, a side-effect of
> > > > this is a lot of process stall messages (with call traces) in
> > > > the kernel guest.
> > > > 
> > > > Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
> > > 
> > > What affect will this have on the clock for the case of migrations
> > > without a stop/cont around?
> > 
> > The guest timebase is saved when the VM stop running and restored when
> > the VM starts running again (cpu_ppc_clock_vm_state_change handler).
> > Migrations without stop/cont save the clock when the VM go to the
> > FINISH_MIGRATE state.
> 
> Right... which means the clock is effectively stopped for the
> migration downtime window while we transfer the final state.  That
> means the guest clock will drift from wall clock by a couple of
> hundred ms across the migration which is not correct.
> 
> > > The complicated thing here is that for
> > > *explicit* stops/continues we want to freeze the clock, however for
> > > the implicit stop/continue during migration downtime, we want to keep
> > > the clock running (logically), so that the guest time of day doesn't
> > > get out of sync on migration.
> > > 
> > 
> > Not sure if the *implicit* word here is about commands from the libvirt
> > or any other orchestrator.
> 
> By implicit I mean the stopping of the VM which qemu does to transfer
> the final part of the state, rather than because of an explicit
> stop/cont command.
> 
> > QEMU itself doesn't know the intent behind the
> > command stop/cont. So, If we are using a guest to process a workload and
> > the manager tool decide to migrate our VM transparently, it's unpleasant
> > to see a lot of process stalls with call traces in the kernel log.
> 
> If you have a lot of process stalls across a migration, that suggests
> your permitted downtime window is *way* too long.
> 

I see a difference between live migration and 'cold' migration. In
a cold migration scenario (where a user 'stop' the machine, wait an
arbitrary time, move it to another server, and run it), the behavior
should be the same as executing 'stop/cont' in a guest without migration.

This problem also emerges when the 'timeout' flag is used with 'virsh'
tool to live-migrate a guest. After the 'timeout', the libvirt sends a
'stop' command to QEMU to suspend the guest before migrate. If the NFS
is slow, for example, this guest will wait many minutes to run again.

Maybe a solution is to modify the timebase_pre_save handler to know the
current vm_state and only save the timebase again when vm_state is not
in 'stop' state. What do you think?


> > The high-level tools could sync the SW clock with the HW clock if this
> > behavior is required, keeping the QEMU stop/cont and stop/migrate/cont
> > consistent.
> > 
> > > > ---
> > > >  hw/ppc/ppc.c | 24 ------------------------
> > > >  1 file changed, 24 deletions(-)
> > > > 
> > > > diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> > > > index ad20584f26..3fb50cbeee 100644
> > > > --- a/hw/ppc/ppc.c
> > > > +++ b/hw/ppc/ppc.c
> > > > @@ -1056,35 +1056,11 @@ void cpu_ppc_clock_vm_state_change(void *opaque, int running,
> > > >      }
> > > >  }
> > > >  
> > > > -/*
> > > > - * When migrating, read the clock just before migration,
> > > > - * so that the guest clock counts during the events
> > > > - * between:
> > > > - *
> > > > - *  * vm_stop()
> > > > - *  *
> > > > - *  * pre_save()
> > > > - *
> > > > - *  This reduces clock difference on migration from 5s
> > > > - *  to 0.1s (when max_downtime == 5s), because sending the
> > > > - *  final pages of memory (which happens between vm_stop()
> > > > - *  and pre_save()) takes max_downtime.
> > > 
> > > Urgh.. this comment is confusing - 5s would be a ludicrously long
> > > max_downtime by modern standards.
> > > 
> > > > - */
> > > > -static int timebase_pre_save(void *opaque)
> > > > -{
> > > > -    PPCTimebase *tb = opaque;
> > > > -
> > > > -    timebase_save(tb);
> > > > -
> > > > -    return 0;
> > > > -}
> > > > -
> > > >  const VMStateDescription vmstate_ppc_timebase = {
> > > >      .name = "timebase",
> > > >      .version_id = 1,
> > > >      .minimum_version_id = 1,
> > > >      .minimum_version_id_old = 1,
> > > > -    .pre_save = timebase_pre_save,
> > > >      .fields      = (VMStateField []) {
> > > >          VMSTATE_UINT64(guest_timebase, PPCTimebase),
> > > >          VMSTATE_INT64(time_of_the_day_ns, PPCTimebase),
> > > 
> > 
> > 
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



