Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2B0C433F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:16:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2142063A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2142063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyUe-0000Ec-2O
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schnelle@linux.ibm.com>)
 id 1jyyU1-00088u-RI; Fri, 24 Jul 2020 10:15:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1510
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schnelle@linux.ibm.com>)
 id 1jyyU0-00020c-1S; Fri, 24 Jul 2020 10:15:33 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06OE0iUI158380; Fri, 24 Jul 2020 10:15:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32fadg5vvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 10:15:30 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06OE0vLd159820;
 Fri, 24 Jul 2020 10:15:30 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32fadg5vum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 10:15:29 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06OEC6BQ028026;
 Fri, 24 Jul 2020 14:15:28 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma06fra.de.ibm.com with ESMTP id 32brbgv0cq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 14:15:28 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 06OEE0NW197374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2020 14:14:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A9A452059;
 Fri, 24 Jul 2020 14:15:25 +0000 (GMT)
Received: from oc5500677777.ibm.com (unknown [9.145.155.57])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 821045204F;
 Fri, 24 Jul 2020 14:15:24 +0000 (GMT)
Subject: Re: [RFC PATCH] s390x/pci: vfio-pci breakage with disabled mem
 enforcement
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, alex.williamson@redhat.com,
 pmorel@linux.ibm.com
References: <1595517236-17823-1-git-send-email-mjrosato@linux.ibm.com>
 <050f39c7-a670-7592-ee50-fef6ea4bdb0f@linux.ibm.com>
Message-ID: <5a273401-95b1-0933-55d0-0438e9bee628@linux.ibm.com>
Date: Fri, 24 Jul 2020 16:15:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <050f39c7-a670-7592-ee50-fef6ea4bdb0f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-24_04:2020-07-24,
 2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007240105
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=schnelle@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 10:11:31
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/24/20 11:46 AM, Niklas Schnelle wrote:
> 
> 
> On 7/23/20 5:13 PM, Matthew Rosato wrote:
>> I noticed that after kernel commit abafbc55 'vfio-pci: Invalidate mmaps
>> and block MMIO access on disabled memory' vfio-pci via qemu on s390x
>> fails spectacularly, with errors in qemu like:
>>
>> qemu-system-s390x: vfio_region_read(0001:00:00.0:region0+0x0, 4) failed: Input/output error
>>
>> From read to bar 0 originating out of hw/s390x/s390-pci-inst.c:zpci_read_bar().
>>
>> So, I'm trying to figure out how to get vfio-pci happy again on s390x.  From
>> a bit of tracing, we seem to be triggering the new trap in
>> __vfio_pci_memory_enabled().  Sure enough, if I just force this function to
>> return 'true' as a test case, things work again.
>> The included patch attempts to enforce the setting, which restores everything
>> to working order but also triggers vfio_bar_restore() in the process....  So
>> this isn't the right answer, more of a proof-of-concept.
>>
>> @Alex: Any guidance on what needs to happen to make qemu-s390x happy with this
>> recent kernel change?
>>
>> @Nilkas/@Pierre: I wonder if this might be related to host device is_virtfn?
>> I note that my host device lspci output looks like:
>>
>> 0000:00:00.0 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx Virtual Function]
>>
>> But the device is not marked as is_virtfn..  Otherwise, Alex's fix
>> from htps://lkml.org/lkml/2020/6/25/628 should cover the case.
> With commit e5794cf1a270 ("s390/pci: create links between PFs and VFs") I introduced
> the is_physfn field to struct zpci_dev which gets set through the
> CLP Query PCI Function. Also with that commit this being 0 will set
> is_virtfn to 1.
> Interestingly looking at s390-pci-inst.c in QEMU I'd think that
> on QEMU this should already be 0 and thus is_virtfn should be set
> with Linux >5.8-rc1 and the missing case is actually for passing through
> a PF where it would wrongly be 0 too. 
> Note: If the Linux instance does not see the
> parent PF however the only way I know to test if it is a VF from userspace
> is checking if /sys/bus/pci/devices/<dev>/vfn is non-zero which is platform
> specific and currently wrongly set 0 on QEMU for VFs.
> If the PF is known the mentioned commit will also create the
> /sys/bus/pci/devices/<dev>/physfn symlink as on other platforms.
Ok I've been looking into this more and is_physfn is correctly set
to 0 on RoCE VFs, there is just a Bug in zPCI preventing the
is_virtfn from beeing set when the device is found in
CLP List PCI devices (equivalent too boot time bus probing
on other architectures) instead of beeing hot plugged later
which is the case for sriov_numvfs.
I'm working on a fix for a bug with PF/VF linking anyway so
should get that fixed then.
>> Matthew Rosato (1):
>>   s390x/pci: Enforce PCI_COMMAND_MEMORY for vfio-pci
>>
>>  hw/s390x/s390-pci-inst.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>

