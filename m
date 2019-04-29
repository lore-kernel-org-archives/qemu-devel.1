Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FEFC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2707B20656
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2707B20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56720 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL52U-0001Ps-BH
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 08:05:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hL51X-00015l-VP
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hL51V-0006TE-UE
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:04:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hL51T-0006Qu-SH
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:04:40 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3TC4WUV001004
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:04:35 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s5wub7nmn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:04:34 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 29 Apr 2019 13:04:22 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 29 Apr 2019 13:04:17 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
	(b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3TC4G9G52035694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 29 Apr 2019 12:04:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B888A4065;
	Mon, 29 Apr 2019 12:04:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2960A405B;
	Mon, 29 Apr 2019 12:04:15 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.96.198])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 29 Apr 2019 12:04:15 +0000 (GMT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190424103747.10173-1-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
	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
	syiRa+UVlsKmx1hsEg==
Date: Mon, 29 Apr 2019 14:04:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424103747.10173-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19042912-4275-0000-0000-0000032F8735
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042912-4276-0000-0000-0000383EDC93
Message-Id: <bde669dd-ba2d-cf93-be65-731d294b8a23@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-29_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=672 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904290088
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH 0/6] tests/qemu-iotests: Run basic iotests
 during "make check"
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429120415.QsdaZmTlkk131XQmdHepfKej4tBfrob926pkpI-sBA8@z>

On 24.04.19 12:37, Thomas Huth wrote:
> People often forget to run the iotests before submitting patches or
> pull requests - this is likely due to the fact that we do not run the
> tests during our mandatory "make check" tests yet.
> This patch series now introduces a new "ci" iotests group that should
> be safe to run in all CI environments (including FreeBSD and macOS!).
> Thus these iotests can now always be run during "make check" automati-
> cally, too.

Given that the iotests have been broken heavily immediately after the 4.0
release (e.g. by a qemu-io change) consider the series

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>


> 
> Thomas Huth (6):
>   tests/qemu-iotests/check: Pick a default machine if necessary
>   tests/qemu-iotests/group: Introduce a new "ci" group for CI pipelines
>   tests/qemu-iotests: Do not hard-code the path to bash
>   cirrus / travis: Add gnu-sed and bash for macOS and FreeBSD
>   tests: Run the iotests during "make check" again
>   tests/qemu-iotests: Remove the "_supported_os Linux" line from many
>     tests
> 
>  .cirrus.yml                 |   4 +-
>  .travis.yml                 |   1 +
>  tests/Makefile.include      |   2 +-
>  tests/qemu-iotests-quick.sh |  17 +++-
>  tests/qemu-iotests/001      |   1 -
>  tests/qemu-iotests/002      |   1 -
>  tests/qemu-iotests/003      |   1 -
>  tests/qemu-iotests/004      |   1 -
>  tests/qemu-iotests/005      |   1 -
>  tests/qemu-iotests/007      |   1 -
>  tests/qemu-iotests/008      |   1 -
>  tests/qemu-iotests/009      |   1 -
>  tests/qemu-iotests/010      |   1 -
>  tests/qemu-iotests/011      |   1 -
>  tests/qemu-iotests/012      |   1 -
>  tests/qemu-iotests/013      |   1 -
>  tests/qemu-iotests/014      |   1 -
>  tests/qemu-iotests/015      |   1 -
>  tests/qemu-iotests/017      |   1 -
>  tests/qemu-iotests/020      |   1 -
>  tests/qemu-iotests/021      |   1 -
>  tests/qemu-iotests/022      |   1 -
>  tests/qemu-iotests/023      |   1 -
>  tests/qemu-iotests/025      |   1 -
>  tests/qemu-iotests/026      |   1 -
>  tests/qemu-iotests/027      |   1 -
>  tests/qemu-iotests/028      |   1 -
>  tests/qemu-iotests/029      |   1 -
>  tests/qemu-iotests/031      |   1 -
>  tests/qemu-iotests/032      |   1 -
>  tests/qemu-iotests/033      |   1 -
>  tests/qemu-iotests/035      |   1 -
>  tests/qemu-iotests/036      |   1 -
>  tests/qemu-iotests/037      |   1 -
>  tests/qemu-iotests/042      |   1 -
>  tests/qemu-iotests/043      |   1 -
>  tests/qemu-iotests/046      |   1 -
>  tests/qemu-iotests/047      |   1 -
>  tests/qemu-iotests/049      |   1 -
>  tests/qemu-iotests/050      |   1 -
>  tests/qemu-iotests/051      |   1 -
>  tests/qemu-iotests/052      |   1 -
>  tests/qemu-iotests/053      |   1 -
>  tests/qemu-iotests/054      |   1 -
>  tests/qemu-iotests/060      |   1 -
>  tests/qemu-iotests/061      |   1 -
>  tests/qemu-iotests/062      |   1 -
>  tests/qemu-iotests/063      |   1 -
>  tests/qemu-iotests/066      |   1 -
>  tests/qemu-iotests/067      |   1 -
>  tests/qemu-iotests/068      |   1 -
>  tests/qemu-iotests/069      |   1 -
>  tests/qemu-iotests/071      |   1 -
>  tests/qemu-iotests/072      |   1 -
>  tests/qemu-iotests/073      |   1 -
>  tests/qemu-iotests/079      |   1 -
>  tests/qemu-iotests/080      |   1 -
>  tests/qemu-iotests/082      |   1 -
>  tests/qemu-iotests/085      |   1 -
>  tests/qemu-iotests/089      |   1 -
>  tests/qemu-iotests/090      |   1 -
>  tests/qemu-iotests/091      |   1 -
>  tests/qemu-iotests/094      |   1 -
>  tests/qemu-iotests/095      |   1 -
>  tests/qemu-iotests/097      |   1 -
>  tests/qemu-iotests/098      |   1 -
>  tests/qemu-iotests/102      |   1 -
>  tests/qemu-iotests/103      |   1 -
>  tests/qemu-iotests/104      |   1 -
>  tests/qemu-iotests/105      |   1 -
>  tests/qemu-iotests/107      |   1 -
>  tests/qemu-iotests/110      |   1 -
>  tests/qemu-iotests/111      |   1 -
>  tests/qemu-iotests/112      |   1 -
>  tests/qemu-iotests/114      |   1 -
>  tests/qemu-iotests/115      |   1 -
>  tests/qemu-iotests/117      |   1 -
>  tests/qemu-iotests/120      |   1 -
>  tests/qemu-iotests/121      |   1 -
>  tests/qemu-iotests/122      |   1 -
>  tests/qemu-iotests/125      |   1 -
>  tests/qemu-iotests/126      |   1 -
>  tests/qemu-iotests/127      |   1 -
>  tests/qemu-iotests/130      |   1 -
>  tests/qemu-iotests/133      |   1 -
>  tests/qemu-iotests/134      |   1 -
>  tests/qemu-iotests/137      |   1 -
>  tests/qemu-iotests/138      |   1 -
>  tests/qemu-iotests/141      |   1 -
>  tests/qemu-iotests/142      |   1 -
>  tests/qemu-iotests/143      |   1 -
>  tests/qemu-iotests/144      |   1 -
>  tests/qemu-iotests/145      |   1 -
>  tests/qemu-iotests/153      |   1 -
>  tests/qemu-iotests/156      |   1 -
>  tests/qemu-iotests/157      |   1 -
>  tests/qemu-iotests/158      |   1 -
>  tests/qemu-iotests/159      |   1 -
>  tests/qemu-iotests/161      |   1 -
>  tests/qemu-iotests/162      |   1 -
>  tests/qemu-iotests/170      |   1 -
>  tests/qemu-iotests/172      |   1 -
>  tests/qemu-iotests/173      |   1 -
>  tests/qemu-iotests/176      |   1 -
>  tests/qemu-iotests/178      |   1 -
>  tests/qemu-iotests/181      |   1 -
>  tests/qemu-iotests/182      |   1 -
>  tests/qemu-iotests/183      |   1 -
>  tests/qemu-iotests/185      |   1 -
>  tests/qemu-iotests/186      |   1 -
>  tests/qemu-iotests/187      |   1 -
>  tests/qemu-iotests/189      |   1 -
>  tests/qemu-iotests/190      |   1 -
>  tests/qemu-iotests/191      |   1 -
>  tests/qemu-iotests/192      |   1 -
>  tests/qemu-iotests/195      |   1 -
>  tests/qemu-iotests/197      |   1 -
>  tests/qemu-iotests/198      |   1 -
>  tests/qemu-iotests/200      |   1 -
>  tests/qemu-iotests/201      |   1 -
>  tests/qemu-iotests/214      |   1 -
>  tests/qemu-iotests/215      |   1 -
>  tests/qemu-iotests/217      |   1 -
>  tests/qemu-iotests/220      |   1 -
>  tests/qemu-iotests/227      |   1 -
>  tests/qemu-iotests/229      |   1 -
>  tests/qemu-iotests/231      |   1 -
>  tests/qemu-iotests/232      |   1 -
>  tests/qemu-iotests/233      |   1 -
>  tests/qemu-iotests/239      |   2 +-
>  tests/qemu-iotests/240      |   3 +-
>  tests/qemu-iotests/241      |   2 +-
>  tests/qemu-iotests/243      |   2 +-
>  tests/qemu-iotests/244      |   2 +-
>  tests/qemu-iotests/247      |   1 -
>  tests/qemu-iotests/check    |  13 ++-
>  tests/qemu-iotests/group    | 194 +++++++++++++++++++-----------------
>  137 files changed, 139 insertions(+), 229 deletions(-)
> 


