Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F21C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 21:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9011E20708
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 21:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9011E20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXXsC-0002Hz-Kv
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 16:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cheloha@linux.vnet.ibm.com>) id 1iXXq8-0000kX-Mg
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 16:48:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cheloha@linux.vnet.ibm.com>) id 1iXXq7-0006mT-GQ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 16:48:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44994)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cheloha@linux.vnet.ibm.com>)
 id 1iXXq6-0006kX-LV
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 16:48:43 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAKLh0sB070381; Wed, 20 Nov 2019 16:48:30 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf57yb3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Nov 2019 16:48:30 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xAKLiSpq077029;
 Wed, 20 Nov 2019 16:48:30 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf57yb3f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Nov 2019 16:48:30 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAKLjJPD027629;
 Wed, 20 Nov 2019 21:48:29 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma02dal.us.ibm.com with ESMTP id 2wa8r6tkgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Nov 2019 21:48:29 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAKLmSeV11469284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Nov 2019 21:48:28 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B09DBE053;
 Wed, 20 Nov 2019 21:48:28 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C698BE051;
 Wed, 20 Nov 2019 21:48:28 +0000 (GMT)
Received: from localhost (unknown [9.41.179.32])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 20 Nov 2019 21:48:28 +0000 (GMT)
Date: Wed, 20 Nov 2019 15:48:27 -0600
From: Scott Cheloha <cheloha@linux.vnet.ibm.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 2/2] migration: savevm_state_handler_insert:
 constant-time element insertion
Message-ID: <20191120214827.iui5rtwyls3r62ns@rascal.austin.ibm.com>
References: <20191017205953.13122-1-cheloha@linux.vnet.ibm.com>
 <20191017205953.13122-3-cheloha@linux.vnet.ibm.com>
 <20191018081625.GA2990@work-vm>
 <351dca8e-e77c-c450-845b-d78ba621156a@redhat.com>
 <20191018094352.GC2990@work-vm>
 <20191019101223.GD1960@umbus.fritz.box>
 <20191021081444.GA2934@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021081444.GA2934@work-vm>
User-Agent: NeoMutt/20180716
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_07:2019-11-20,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911200183
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 21, 2019 at 09:14:44AM +0100, Dr. David Alan Gilbert wrote:
> * David Gibson (david@gibson.dropbear.id.au) wrote:
> > On Fri, Oct 18, 2019 at 10:43:52AM +0100, Dr. David Alan Gilbert wrote:
> > > * Laurent Vivier (lvivier@redhat.com) wrote:
> > > > On 18/10/2019 10:16, Dr. David Alan Gilbert wrote:
> > > > > * Scott Cheloha (cheloha@linux.vnet.ibm.com) wrote:
> > > > >> savevm_state's SaveStateEntry TAILQ is a priority queue.  Priority
> > > > >> sorting is maintained by searching from head to tail for a suitable
> > > > >> insertion spot.  Insertion is thus an O(n) operation.
> > > > >>
> > > > >> If we instead keep track of the head of each priority's subqueue
> > > > >> within that larger queue we can reduce this operation to O(1) time.
> > > > >>
> > > > >> savevm_state_handler_remove() becomes slightly more complex to
> > > > >> accomodate these gains: we need to replace the head of a priority's
> > > > >> subqueue when removing it.
> > > > >>
> > > > >> With O(1) insertion, booting VMs with many SaveStateEntry objects is
> > > > >> more plausible.  For example, a ppc64 VM with maxmem=8T has 40000 such
> > > > >> objects to insert.
> > > > > 
> > > > > Separate from reviewing this patch, I'd like to understand why you've
> > > > > got 40000 objects.  This feels very very wrong and is likely to cause
> > > > > problems to random other bits of qemu as well.
> > > > 
> > > > I think the 40000 objects are the "dr-connectors" that are used to plug
> > > > peripherals (memory, pci card, cpus, ...).
> > > 
> > > Yes, Scott confirmed that in the reply to the previous version.
> > > IMHO nothing in qemu is designed to deal with that many devices/objects
> > > - I'm sure that something other than the migration code is going to
> > > get upset.
> > 
> > It kind of did.  Particularly when there was n^2 and n^3 cubed
> > behaviour in the property stuff we had some ludicrously long startup
> > times (hours) with large maxmem values.
> > 
> > Fwiw, the DRCs for PCI slots, DRCs and PHBs aren't really a problem.
> > The problem is the memory DRCs, there's one for each LMB - each 256MiB
> > chunk of memory (or possible memory).
> > 
> > > Is perhaps the structure wrong somewhere - should there be a single DRC
> > > device that knows about all DRCs?
> > 
> > Maybe.  The tricky bit is how to get there from here without breaking
> > migration or something else along the way.
> 
> Switch on the next machine type version - it doesn't matter if migration
> is incompatible then.

1mo bump.

Is there anything I need to do with this patch in particular to make it suitable
for merging?

