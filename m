Received: from eggs.gnu.org ([2001:4830:134:3::10]:55130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1f8McB-0000VH-Cz
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1f8Mc6-0002UH-J4
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:09:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1f8Mc6-0002NX-27
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:09:22 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3H99KQh123811
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 05:09:20 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hdbpupxpj-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 05:09:20 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Tue, 17 Apr 2018 10:09:17 +0100
Date: Tue, 17 Apr 2018 14:39:09 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <20180416085512.4011-1-bharata@linux.vnet.ibm.com>
	<20180417011427.GE20551@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417011427.GE20551@umbus.fritz.box>
Message-Id: <20180417090909.GB3942@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] spapr: Support ibm,
 dynamic-memory-v2 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, imammedo@redhat.com

On Tue, Apr 17, 2018 at 11:14:27AM +1000, David Gibson wrote:
> >  static void spapr_machine_2_12_class_options(MachineClass *mc)
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index d60b7c6d7a..5e044c44af 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -149,6 +149,7 @@ struct sPAPRMachineState {
> >      sPAPROptionVector *ov5;         /* QEMU-supported option vectors */
> >      sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vectors */
> >      uint32_t max_compat_pvr;
> > +    bool use_ibm_dynamic_memory_v2;
> 
> TBH, I'm not really sure we even need to adjust this by machine type.

There are other similar features controlled by ov5 bits that
are also determined by machine type version:

Memory hotplug support -- sPAPRMachineClass.dr_lmb_enabled
Dedicated HP event support -- sPAPRMachineState.use_hotplug_event_source

Are you saying that presence of ibm,dynamic-memory-v2 probably shouldn't
be dependent on machine type ?

Regards,
Bharata.
