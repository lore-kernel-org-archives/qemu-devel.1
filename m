Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359E8C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 07:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D1B218A4
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 07:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D1B218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsirz-0003Qz-70
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 03:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60161)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sathnaga@linux.vnet.ibm.com>) id 1hsirN-0002tA-AS
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 03:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sathnaga@linux.vnet.ibm.com>) id 1hsirM-0007tA-22
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 03:17:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14308
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sathnaga@linux.vnet.ibm.com>)
 id 1hsirL-0007oN-Rp
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 03:17:16 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6V77s0N080685
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 03:17:13 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u33fkxt78-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 03:17:13 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sathnaga@linux.vnet.ibm.com>;
 Wed, 31 Jul 2019 08:17:11 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 31 Jul 2019 08:17:08 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6V7H7bn33816702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jul 2019 07:17:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 919B2A4054;
 Wed, 31 Jul 2019 07:17:07 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 057CCA405F;
 Wed, 31 Jul 2019 07:17:06 +0000 (GMT)
Received: from sathnaga86.in.ibm.com (unknown [9.193.110.61])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 31 Jul 2019 07:17:05 +0000 (GMT)
Date: Wed, 31 Jul 2019 12:47:03 +0530
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To: Greg Kurz <groug@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
X-TM-AS-GCONF: 00
x-cbid: 19073107-0028-0000-0000-0000038987CC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19073107-0029-0000-0000-00002449D773
Message-Id: <20190731071703.GA2914@sathnaga86.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-31_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310075
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] RESEND Re: [Qemu-ppc] [PATCH 1/2]
 tests.acceptance.avocado_qemu: Add support for powerpc
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
Cc: qemu-ppc@nongnu.org, sathnaga@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

----- Forwarded message from Satheesh Rajendran <sathnaga@linux.vnet.ibm.com> -----

Date: Mon, 29 Jul 2019 11:22:50 +0530
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To: Greg Kurz <groug@kaod.org>
Cc: sathnaga@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Subject: Re: [Qemu-ppc] [Qemu-devel][PATCH 1/2] tests.acceptance.avocado_qemu: Add support for powerpc
User-Agent: Mutt/1.12.0 (2019-05-25)

On Fri, Jul 26, 2019 at 01:49:00PM +0200, Greg Kurz wrote:
> On Fri, 26 Jul 2019 12:48:09 +0530
> sathnaga@linux.vnet.ibm.com wrote:
> 
> > From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > 
> > Current acceptance test will not run in powerpc Little endian
> > environment due the arch name does not match the qemu binary path,
> > let's handle it.
> > 
> 
> They do not match because "arch" as returned by uname() is
> something different from the "target" in QEMU. This usually
> matches, except with bi-endian architectures like ppc64.
> Uname "arch" may be ppc64 or ppc64le but "target" is always
> ppc64.

Yes, instead I would reword the commit message to sound like that.
Thanks!

> 
> > Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > ---
> >  tests/acceptance/avocado_qemu/__init__.py | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> > index aee5d820ed..a05f0bb530 100644
> > --- a/tests/acceptance/avocado_qemu/__init__.py
> > +++ b/tests/acceptance/avocado_qemu/__init__.py
> > @@ -19,6 +19,7 @@ sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
> >  
> >  from qemu.machine import QEMUMachine
> >  
> > +
> 
> empty line damage
> 
Sure, I did as pylint complained about, probably can be sent
as seperate commit.
> >  def is_readable_executable_file(path):
> >      return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
> >  
> > @@ -39,6 +40,9 @@ def pick_default_qemu_bin(arch=None):
> >      """
> >      if arch is None:
> >          arch = os.uname()[4]
> > +    # qemu binary path does not match arch for powerpc, handle it
> > +    if 'ppc64le' in arch:
> > +        arch = 'ppc64'
> 
> We also have other bi-endian targets (arm and aarch64). I'm not
> sure teaching pick_default_qemu_bin() about all of them is the
> way to go.
> 
It is good for the tests where have explicit arch mentioned
but it will not work for platform generic tests like below one
for example,

avocado run version.py 
JOB ID     : ef3d99cf0232d38e5eb34c1552a8ab44ac77c45c
JOB LOG    : /home/sath/tests/results/job-2019-07-29T01.45-ef3d99c/job.log
 (1/1) version.py:Version.test_qmp_human_info_version: CANCEL: No QEMU binary defined or found in the source tree (0.00 s)
RESULTS    : PASS 0 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 1
JOB TIME   : 0.35 s

and more over we can preserve arch:ppc64 to run Big Endian guest
image.

> What about passing the right target in the first place ?
>

> ie, this in patch 2:
> 
> +    def test_ppc64le_pseries(self):
> +        """
> +        :avocado: tags=arch:ppc64
> 
> >      qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
> >                                            "qemu-system-%s" % arch)

> >      if is_readable_executable_file(qemu_bin_relative_path):
> 
> 

----- End forwarded message -----


