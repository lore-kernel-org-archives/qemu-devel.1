Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB815C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD17E206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD17E206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnQMi-0008JP-G8
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 12:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53192)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hnQME-0006jq-8N
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hnQMD-0002M1-1i
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:31:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33384
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hnQMC-0002Ka-Rc
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:31:12 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6GGUxve079830
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 12:31:09 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tsgbrws2k-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 12:31:06 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Tue, 16 Jul 2019 17:30:37 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Jul 2019 17:30:34 +0100
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6GGUXAW46268742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2019 16:30:33 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F8F6136055;
 Tue, 16 Jul 2019 16:30:33 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87882136059;
 Tue, 16 Jul 2019 16:30:33 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jul 2019 16:30:33 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: David Gibson <david@gibson.dropbear.id.au>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190715022555.GB3440@umbus.fritz.box>
References: <20190712011934.29863-1-mdroth@linux.vnet.ibm.com>
 <20190712011934.29863-2-mdroth@linux.vnet.ibm.com>
 <20190712064027.GF2561@umbus.fritz.box>
 <156294442813.22588.13951961791159970871@sif>
 <20190715022555.GB3440@umbus.fritz.box>
User-Agent: alot/0.7
Date: Tue, 16 Jul 2019 11:25:34 -0500
X-TM-AS-GCONF: 00
x-cbid: 19071616-0016-0000-0000-000009CE47EE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011439; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01233065; UDB=6.00649693; IPR=6.01014376; 
 MB=3.00027745; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-16 16:30:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071616-0017-0000-0000-000044097943
Message-Id: <156329433410.5171.6918528130179183618@sif>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-16_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907160202
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH 1/2] docs/specs: initial spec summary for
 Ultravisor-related hcalls
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
Cc: linuxram@us.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting David Gibson (2019-07-14 21:25:55)
> On Fri, Jul 12, 2019 at 10:13:48AM -0500, Michael Roth wrote:
> > Quoting David Gibson (2019-07-12 01:40:27)
> > > On Thu, Jul 11, 2019 at 08:19:33PM -0500, Michael Roth wrote:
> > > > For now this only covers hcalls relating to TPM communication since
> > > > it's the only one particularly important from a QEMU perspective at=
m,
> > > > but others can be added here where it makes sense.
> > > > =

> > > > The full specification for all hcalls/ucalls will eventually be made
> > > > available in the public/OpenPower version of the PAPR specification.
> > > > =

> > > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > =

> > > Thanks for adding this documentation.  Is there a PAPR extension
> > > proposal which covers this, which we could cite as the source?
> > =

> > We have an internal document/repo that serves as a catch-all for the Ul=
travisor
> > related spec changes. We could make that available publically via githu=
b and
> > cite it here until it hits the full spec. Would that work?
> =

> Yes, that sounds good.

Ok, we're working on getting that posted externally. If it's not up in
time for next submission I will send a follow-up patch to add a
reference.

> =

> -- =

> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _othe=
r_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson


