Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F2EC606C1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 15:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C5C21734
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 15:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C5C21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=drs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkVPn-0001oO-Ll
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 11:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43975)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Matthew.Intriago@drs.com>) id 1hkUkB-0002ct-U3
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Matthew.Intriago@drs.com>) id 1hkUkA-00025p-8V
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:35:51 -0400
Received: from mx0a-00218c01.pphosted.com ([148.163.148.181]:57396
 helo=mx0b-00218c01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Matthew.Intriago@drs.com>)
 id 1hkUk9-0001tk-Q4
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:35:50 -0400
Received: from pps.filterd (m0095895.ppops.net [127.0.0.1])
 by mx0a-00218c01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x68EXIbt011976
 for <qemu-devel@nongnu.org>; Mon, 8 Jul 2019 10:35:37 -0400
Received: from mx-edge.drs.com ([12.216.216.141])
 by mx0a-00218c01.pphosted.com with ESMTP id 2tjpsvaa0a-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 10:35:37 -0400
From: "Intriago, Matthew" <Matthew.Intriago@drs.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: Running an Edk2 based bios
Thread-Index: AdU1mRlJt0gvi13XTGqgeehyDCp+6w==
Date: Mon, 8 Jul 2019 14:35:34 +0000
Message-ID: <78fea246552d454895967f9037d051ce@drs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.204.221.249]
Content-Type: multipart/related;
 boundary="_004_78fea246552d454895967f9037d051cedrscom_";
 type="multipart/alternative"
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-08_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080182
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.148.181
X-Mailman-Approved-At: Mon, 08 Jul 2019 11:17:16 -0400
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] Running an Edk2 based bios
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_004_78fea246552d454895967f9037d051cedrscom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Good morning to all,

I am currently working on using QEMU  to run a BIOS my company has develope=
d. In order to see if the software was working correctly, I was able to suc=
cessfully run the edk2 bios using the following command:

qemu-system-x86_64.exe -bios "C:\Users\matthew.intriago\Desktop\ovmf.fd" -n=
et none

However, when running the same command using  our personalized bios, QEMU l=
aunches stating that "guest has not initialized display". Theoretically, QE=
MU should be able to run the bios since it is edk2 based, the only differen=
ce between the two is that our bios has more features.

If anyone has any insight on what the issue might be I would greatly apprec=
iate any help.

Thank you,

[Leonardo-DRS-logo_red]
            Matthew Intriago
            Software Engineering Intern

            100 Babcock St, Melbourne, FL 32935 USA
            Mobile +1 407 452 7951
            matthew.intriago@drs.com<mailto:matthew.intriago@drs.com>
            leonardodrs.com<http://www.drs.com>


--_004_78fea246552d454895967f9037d051cedrscom_
Content-Type: image/png; name="image003.png"
Content-Description: image003.png
Content-Disposition: inline; filename="image003.png"; size=10452;
	creation-date="Mon, 08 Jul 2019 14:35:34 GMT";
	modification-date="Mon, 08 Jul 2019 14:35:34 GMT"
Content-ID: <image003.png@01D53578.DF39C330>
Content-Transfer-Encoding: base64

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
F1q4bHhXi/O5AAAAAElFTkSuQmCC

--_004_78fea246552d454895967f9037d051cedrscom_--

