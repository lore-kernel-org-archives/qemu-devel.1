Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E33BC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD5120656
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD5120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyBd-0007VE-K1
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schnelle@linux.ibm.com>)
 id 1jyuI0-0000ls-5H; Fri, 24 Jul 2020 05:46:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59742
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schnelle@linux.ibm.com>)
 id 1jyuHx-0001Sx-F1; Fri, 24 Jul 2020 05:46:51 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06O9VMgf193871; Fri, 24 Jul 2020 05:46:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32fat2p2ar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 05:46:46 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06O9VYvi194729;
 Fri, 24 Jul 2020 05:46:45 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32fat2p2a2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 05:46:45 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06O9kVGH028894;
 Fri, 24 Jul 2020 09:46:43 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma03fra.de.ibm.com with ESMTP id 32brq83wv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 09:46:43 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06O9keM662128238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2020 09:46:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B664052054;
 Fri, 24 Jul 2020 09:46:40 +0000 (GMT)
Received: from oc5500677777.ibm.com (unknown [9.145.155.57])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C990D52051;
 Fri, 24 Jul 2020 09:46:39 +0000 (GMT)
Subject: Re: [RFC PATCH] s390x/pci: vfio-pci breakage with disabled mem
 enforcement
To: Matthew Rosato <mjrosato@linux.ibm.com>, alex.williamson@redhat.com,
 pmorel@linux.ibm.com
References: <1595517236-17823-1-git-send-email-mjrosato@linux.ibm.com>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <050f39c7-a670-7592-ee50-fef6ea4bdb0f@linux.ibm.com>
Date: Fri, 24 Jul 2020 11:46:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1595517236-17823-1-git-send-email-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-24_02:2020-07-24,
 2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240068
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=schnelle@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 05:46:46
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2020 09:54:21 -0400
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
Cc: david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/23/20 5:13 PM, Matthew Rosato wrote:
> I noticed that after kernel commit abafbc55 'vfio-pci: Invalidate mmaps
> and block MMIO access on disabled memory' vfio-pci via qemu on s390x
> fails spectacularly, with errors in qemu like:
> 
> qemu-system-s390x: vfio_region_read(0001:00:00.0:region0+0x0, 4) failed: Input/output error
> 
> From read to bar 0 originating out of hw/s390x/s390-pci-inst.c:zpci_read_bar().
> 
> So, I'm trying to figure out how to get vfio-pci happy again on s390x.  From
> a bit of tracing, we seem to be triggering the new trap in
> __vfio_pci_memory_enabled().  Sure enough, if I just force this function to
> return 'true' as a test case, things work again.
> The included patch attempts to enforce the setting, which restores everything
> to working order but also triggers vfio_bar_restore() in the process....  So
> this isn't the right answer, more of a proof-of-concept.
> 
> @Alex: Any guidance on what needs to happen to make qemu-s390x happy with this
> recent kernel change?
> 
> @Nilkas/@Pierre: I wonder if this might be related to host device is_virtfn?
> I note that my host device lspci output looks like:
> 
> 0000:00:00.0 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx Virtual Function]
> 
> But the device is not marked as is_virtfn..  Otherwise, Alex's fix
> from htps://lkml.org/lkml/2020/6/25/628 should cover the case.
With commit e5794cf1a270 ("s390/pci: create links between PFs and VFs") I introduced
the is_physfn field to struct zpci_dev which gets set through the
CLP Query PCI Function. Also with that commit this being 0 will set
is_virtfn to 1.
Interestingly looking at s390-pci-inst.c in QEMU I'd think that
on QEMU this should already be 0 and thus is_virtfn should be set
with Linux >5.8-rc1 and the missing case is actually for passing through
a PF where it would wrongly be 0 too. 
Note: If the Linux instance does not see the
parent PF however the only way I know to test if it is a VF from userspace
is checking if /sys/bus/pci/devices/<dev>/vfn is non-zero which is platform
specific and currently wrongly set 0 on QEMU for VFs.
If the PF is known the mentioned commit will also create the
/sys/bus/pci/devices/<dev>/physfn symlink as on other platforms.
> Matthew Rosato (1):
>   s390x/pci: Enforce PCI_COMMAND_MEMORY for vfio-pci
> 
>  hw/s390x/s390-pci-inst.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

