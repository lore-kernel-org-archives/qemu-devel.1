Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4E1C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF96F2166E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF96F2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqvr1-0001QJ-0a
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 04:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54553)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sathnaga@linux.vnet.ibm.com>) id 1hqvqk-0000qk-EI
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sathnaga@linux.vnet.ibm.com>) id 1hqvqe-0003KS-8E
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:45:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sathnaga@linux.vnet.ibm.com>)
 id 1hqvqd-0003E0-SB
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:45:08 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6Q8g6In063283
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 04:45:06 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tyvx8bk50-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 04:45:05 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sathnaga@linux.vnet.ibm.com>;
 Fri, 26 Jul 2019 09:45:03 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 26 Jul 2019 09:45:01 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6Q8j06T38994032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jul 2019 08:45:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 259E0A405C;
 Fri, 26 Jul 2019 08:45:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E2AEA4054;
 Fri, 26 Jul 2019 08:44:58 +0000 (GMT)
Received: from sathnaga86 (unknown [9.193.110.61])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Jul 2019 08:44:58 +0000 (GMT)
Date: Fri, 26 Jul 2019 14:14:55 +0530
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
References: <20190726071737.32298-1-sathnaga@linux.vnet.ibm.com>
 <e18f2889-38ff-5ff9-6411-cf8c5f77d549@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e18f2889-38ff-5ff9-6411-cf8c5f77d549@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-TM-AS-GCONF: 00
x-cbid: 19072608-0008-0000-0000-0000030104A6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072608-0009-0000-0000-0000226E9BBF
Message-Id: <20190726084455.GA4465@sathnaga86>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-26_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=965 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907260112
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x6Q8g6In063283
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH 0/2] Add support for powerpc acceptance test
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
Reply-To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: Joel Stanley <joel@jms.id.au>, qemu-ppc@nongnu.org,
 sathnaga@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 26, 2019 at 10:37:35AM +0200, C=E9dric Le Goater wrote:
> On 26/07/2019 09:17, sathnaga@linux.vnet.ibm.com wrote:
> > From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> >=20
> > This series attempt to add support for avocado acceptance
> > test for powerpc and adds linux console boot test.
> >=20
> > avocado run boot_linux_console.py:BootLinuxConsole.test_ppc64le_pseri=
es version.py vnc.py=20
> > JOB ID     : 918ed65e5e8bc1370c84c166a2c41936a700571e
> > JOB LOG    : /home/sath/tests/results/job-2019-07-26T03.08-918ed65/jo=
b.log
> >  (1/6) boot_linux_console.py:BootLinuxConsole.test_ppc64le_pseries: P=
ASS (3.98 s)
> >  (2/6) version.py:Version.test_qmp_human_info_version: PASS (0.15 s)
> >  (3/6) vnc.py:Vnc.test_no_vnc: PASS (0.14 s)
> >  (4/6) vnc.py:Vnc.test_no_vnc_change_password: PASS (0.13 s)
> >  (5/6) vnc.py:Vnc.test_vnc_change_password_requires_a_password: PASS =
(0.14 s)
> >  (6/6) vnc.py:Vnc.test_vnc_change_password: PASS (0.14 s)
> > RESULTS    : PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT =
0 | CANCEL 0
> > JOB TIME   : 5.68 s
> >=20
> >=20
> > Satheesh Rajendran (2):
> >   tests.acceptance.avocado_qemu: Add support for powerpc
> >   tests.acceptance.boot_linux_console: Add pseries linux boot console
> >     test
> >=20
> >  tests/acceptance/avocado_qemu/__init__.py |  4 ++++
> >  tests/acceptance/boot_linux_console.py    | 20 ++++++++++++++++++++
> >  2 files changed, 24 insertions(+)
> >=20
>=20
> Nice. Do you think we could do something similar for the PowerNV machin=
e ?=20
Thanks, yes it must be possible, will try out and add those in later patc=
hes as
applicable.

Regards,
-Satheesh
>=20
> Thanks,
>=20
> C.=20
>=20


