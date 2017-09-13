Received: from eggs.gnu.org ([2001:4830:134:3::10]:33247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds1SZ-00031h-1L
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 02:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds1SY-0005Bw-6U
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 02:47:43 -0400
References: <20170912144459.11359-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <83c3006b-d62e-441b-57f1-dea64b141c11@redhat.com>
Date: Wed, 13 Sep 2017 08:47:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170912144459.11359-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/10] cleanup qemu-iotests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

On 12.09.2017 16:44, Paolo Bonzini wrote:
> The purpose of this series is to separate the "check" sources from
> the tests.  After these patches, common.config is reduced to simple
> shell initialization, and common.rc is only included by the tests.
> 
> Along the way, a lot of dead code is removed too.
> 
> In v2, the following patches:
> 
>   qemu-iotests: do not do useless search for QEMU_*_PROG
>   qemu-iotests: do not search for binaries in the current directory
>   qemu-iotests: include common.env and common.config early
> 
> have been replaced by "qemu-iotests: cleanup and fix search for programs",
> which also preserves the behavior of searching for programs as symlinks
> in the current directory.
> 
> Paolo
> 
> Paolo Bonzini (10):
>   qemu-iotests: remove dead code
>   qemu-iotests: get rid of AWK_PROG
>   qemu-iotests: move "check" code out of common.rc
>   qemu-iotests: cleanup and fix search for programs
>   qemu-iotests: limit non-_PROG-suffixed variables to common.rc
>   qemu-iotests: do not include common.rc in "check"
>   qemu-iotests: disintegrate more parts of common.config
>   qemu-iotests: fix uninitialized variable
>   qemu-iotests: get rid of $iam
>   qemu-iotests: merge "check" and "common"
> 
>  tests/qemu-iotests/039.out       |  10 +-
>  tests/qemu-iotests/061.out       |   4 +-
>  tests/qemu-iotests/137.out       |   2 +-
>  tests/qemu-iotests/check         | 575 ++++++++++++++++++++++++++++++++++-----
>  tests/qemu-iotests/common        | 459 -------------------------------
>  tests/qemu-iotests/common.config | 206 +-------------
>  tests/qemu-iotests/common.qemu   |   1 +
>  tests/qemu-iotests/common.rc     | 205 +++++++-------

Meta comment: Could we maybe also rename "tests/qemu-iotests" to
"tests/iotests" ? The "qemu" prefix sounds always very superfluous to me
here...

 Thomas
