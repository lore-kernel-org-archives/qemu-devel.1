Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D161C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 00:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD6120693
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 00:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD6120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ1bQ-0000QA-35
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 20:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1jZ1am-0008LI-Ia; Wed, 13 May 2020 20:19:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1jZ1al-0000bi-C4; Wed, 13 May 2020 20:19:16 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04E0IAHL169617; Wed, 13 May 2020 20:19:07 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 310uayg0h1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 20:19:07 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04E0GcMR001096;
 Thu, 14 May 2020 00:19:06 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma02dal.us.ibm.com with ESMTP id 3100uc5au1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 00:19:06 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04E0J6m853019080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 May 2020 00:19:06 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAE42AE05C;
 Thu, 14 May 2020 00:19:05 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77CEFAE05F;
 Thu, 14 May 2020 00:19:05 +0000 (GMT)
Received: from arbab-vm.localdomain (unknown [9.160.124.64])
 by b01ledav005.gho.pok.ibm.com (Postfix) with SMTP;
 Thu, 14 May 2020 00:19:05 +0000 (GMT)
Received: from arbab-vm (localhost [IPv6:::1])
 by arbab-vm.localdomain (Postfix) with ESMTP id 1219910038C;
 Wed, 13 May 2020 19:19:03 -0500 (CDT)
Date: Wed, 13 May 2020 19:19:02 -0500
From: Reza Arbab <arbab@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr: Add a new level of NUMA for GPUs
Message-ID: <20200514001902.ohz5y7djovvablpn@arbab-vm>
Organization: IBM Linux Technology Center
References: <20200508175927.21791-1-arbab@linux.ibm.com>
 <20200511061745.GP2183@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200511061745.GP2183@umbus.fritz.box>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-13_09:2020-05-13,
 2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=1
 lowpriorityscore=0 spamscore=0 clxscore=1015 cotscore=-2147483648
 mlxlogscore=999 bulkscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130207
Received-SPF: pass client-ip=148.163.156.1; envelope-from=arbab@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 18:45:01
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Daniel Henrique Barboza <danielhb@linux.ibm.com>,
 Leonardo Augusto Guimaraes Garcia <lagarcia@linux.ibm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

Thanks for your quick response!

On Mon, May 11, 2020 at 04:17:45PM +1000, David Gibson wrote:
>1)
>
>This would all be much simpler, if PAPR's representation of NUMA
>distances weren't so awful.  Somehow it manages to be both so complex
>that it's very hard to understand, and yet very limited in that it
>has no way to represent distances in any absolute units, or even
>specific ratios between distances.
>
>Both qemu and the guest kernel can have an arbitrary set of nodes,
>with an arbitrary matrix of distances between each pair, which we then
>have to lossily encode into this PAPR nonsense.

Completely agree. I've revisited that section many times now and still=20
find the descriptions of these properties almost incomprehensible.

The only way I've been able to make sense of it comes from reading the=20
implementation, or experimentally tweaking the code/device tree to see=20
if distances behave the way I expect.

>2)
>
>Alas, I don't think we can simply change this information.  We'll have
>to do it conditionally on a new machine type.  This is guest visible
>information, which shouldn't change under a running guest across
>migration between different qemu versions.  At least for Linux guests
>we'd probably get away with it, since I think it only reads this info
>at boot, and across a migration we'd at worst get non-optimal
>behaviour, not actual breakage.

Sure, that makes sense. I'll try making the change conditional on a flag=20
that can be set on new machine types.

>3)
>
>I'm not sure that this version is totally correct w.r.t. PAPR.  But
>then, I'm also not really sure of that for the existing version.
>Specifically it's not at all clear from PAPR if the IDs used at each
>level of the ibm,associativity need to be:
>   a) globally unique
>   b) unique only within the associativity level they appear at
>or c) unique only within the "node" at the next higher level they
>      belong to

Again, I'm no authority but it seems to be (b):

   "To determine the associativity between any two resources, the OS
scans down the two resources associativity lists in all pair wise=20
combinations counting how many domains are the same until the first=20
domain where the two list do not agree."

FWIW, using the same number for id at multiple levels has been working=20
in practice.

>4)
>
>I'm not totally clear on the rationale for using the individual gpu's
>numa ID at all levels, rather than just one.  I'm guessing this is so
>that the gpu memory blocks are distant from each other as well as
>distant from main memory.  Is that right?

It's not necessary to use it at all levels--that was me trying to=20
completely replicate that old firmware change. Strictly speaking, since=20
only reference-points 4 (and now 2) are significant, that part could=20
just be:

@@ -362,7 +362,7 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sph=
b, void *fdt)
          uint32_t associativity[] =3D {
              cpu_to_be32(0x4),
              SPAPR_GPU_NUMA_ID,
-            SPAPR_GPU_NUMA_ID,
+            cpu_to_be32(nvslot->numa_id),
              SPAPR_GPU_NUMA_ID,
              cpu_to_be32(nvslot->numa_id)
          };

I think the rationale is that if those other levels got added to=20
reference-points in the future, you'd likely want the GPU to be distinct=20
there too.

--=20
Reza Arbab

