Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B846DC31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 23:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CABA20B1F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 23:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CABA20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv8g0-00056C-8s
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 19:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56474)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <daniel@linux.ibm.com>) id 1hv8fa-0004cg-CA
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 19:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <daniel@linux.ibm.com>) id 1hv8fZ-0000rk-2l
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 19:15:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34176
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <daniel@linux.ibm.com>)
 id 1hv8fY-0000ow-TH
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 19:15:05 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x76NCGw0011640
 for <qemu-devel@nongnu.org>; Tue, 6 Aug 2019 19:15:03 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2u7geyn0vj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 19:15:03 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <daniel@linux.ibm.com>;
 Wed, 7 Aug 2019 00:15:01 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 7 Aug 2019 00:14:57 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x76NEu8l51904658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Aug 2019 23:14:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4CC4A4060;
 Tue,  6 Aug 2019 23:14:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 282B1A405F;
 Tue,  6 Aug 2019 23:14:56 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  6 Aug 2019 23:14:56 +0000 (GMT)
Received: from volution.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 80C8AA01B5;
 Wed,  7 Aug 2019 09:14:52 +1000 (AEST)
Date: Wed, 7 Aug 2019 09:14:49 +1000
From: Daniel Black <daniel@linux.ibm.com>
To: Tao Xu <tao3.xu@intel.com>, jingqi.liu@intel.com
In-Reply-To: <20190731011209.22538-10-tao3.xu@intel.com>
References: <20190731011209.22538-1-tao3.xu@intel.com>
 <20190731011209.22538-10-tao3.xu@intel.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19080623-0008-0000-0000-000003060A0A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080623-0009-0000-0000-00004A240A2A
Message-Id: <20190807091449.2e88b175@volution.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-06_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=975 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908060201
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH RESEND v8 09/11] numa: Extend the CLI to
 provide memory latency and bandwidth information
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
Cc: ehabkost@redhat.com, fan.du@intel.com, qemu-devel@nongnu.org,
 jonathan.cameron@huawei.com, imammedo@redhat.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Liu Jingqi, Tao Xu,

Apologies to the late response on a patch on what is already a v8 patch.

The specification of latency and bandwidth is very much following the
ACPI specification.

For a qemu interface I think this should be in more human measurements
(time for latency and a bandwidth rate for the bandwidth).

e.g rather than
 -object memory-backend-ram,size=64M,id=m0
 -object memory-backend-ram,size=64M,id=m1geosync
 -numa node,nodeid=0,memdev=m0
 -numa node,nodeid=1,memdev=m1geosync,initiator=0
 -numa cpu,node-id=0,socket-id=0
 -numa cpu,node-id=0,socket-id=1
 -numa
hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,base-lat=1000,latency=5
 -numa
hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=5
 -numa
hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,base-lat=100,latency=10
 -numa
 hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=10


Suggest a form like:

 -numa
hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=NUM[fpnm[s]]
 -numa
hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=NUM[KMGP][Bb[ps]]

So:

 -numa
hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=5ns
 -numa
hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=5Gb


So this would remove the base-[lt,bw] settings and compute those internally in qemu based on latency/bandwidth specified with real units.

Also note the linux kernel HMAT latency display doesn't match up with the parameters passed in this patch series. Not sure which is at fault.

Test and results:

x86_64-softmmu/qemu-system-x86_64 -machine pc -nographic   -smp
2,sockets=2 -m 128M,slots=2,maxmem=1G
-kernel /home/dan/repos/linux/vmlinux  -append "console=ttyS0"
-object memory-backend-ram,size=64M,id=m0 -object
memory-backend-ram,size=64M,id=m1geosync -numa node,nodeid=0,memdev=m0
-numa node,nodeid=1,memdev=m1geosync,initiator=0 -numa
cpu,node-id=0,socket-id=0 -numa cpu,node-id=0,socket-id=1 -numa
hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,base-lat=1000,latency=5
-numa
hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=5
-numa
hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,base-lat=100,latency=10
-numa
hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=10

The Booting from ROM..[    0.000000] Linux version 5.3.0-rc2+
(dan@volution) (gcc version 9.1.1 20190503 (Red Hat 9.1.1-1) (GCC)) #21
SMP Tue Aug 6 17:15:49 AEST 2019


[    0.419303] HMAT: Memory Flags:0001 Processor Domain:0 Memory Domain:0
[    0.419648] HMAT: Memory Flags:0001 Processor Domain:0 Memory Domain:1
[    0.419956] HMAT: Locality: Flags:00 Type:Access Latency Initiator Domains:1 Target Domains:2 Base:1000
[    0.420527]   Initiator-Target[0-0]:5 nsec
[    0.420791]   Initiator-Target[0-1]:10 nsec
[    0.421068] HMAT: Locality: Flags:00 Type:Access Bandwidth Initiator Domains:1 Target Domains:2 Base:20
[    0.421447]   Initiator-Target[0-0]:100 MB/s
[    0.421635]   Initiator-Target[0-1]:200 MB/s



