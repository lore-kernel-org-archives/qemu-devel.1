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
References: <20190424103747.10173-1-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 29 Apr 2019 14:04:15 +0200
MIME-Version: 1.0
In-Reply-To: <20190424103747.10173-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <bde669dd-ba2d-cf93-be65-731d294b8a23@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] tests/qemu-iotests: Run basic iotests
 during "make check"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>

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
