Received: from eggs.gnu.org ([2001:4830:134:3::10]:39598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dyztm-0007Y3-OS
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dyztg-0001rI-Tc
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:32:38 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:45742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dyztg-0001qM-Ms
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:32:32 -0400
Received: by mail-wm0-f54.google.com with SMTP id q124so10292073wmb.0
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 05:32:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20170912144459.11359-1-pbonzini@redhat.com>
Message-ID: <8315593b-4ae8-b034-01d6-d6f66925b6bb@redhat.com>
Date: Mon, 2 Oct 2017 14:32:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170912144459.11359-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 00/10] cleanup qemu-iotests
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On 12/09/2017 16:44, Paolo Bonzini wrote:
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

Kevin,

ping?

Paolo

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
>  8 files changed, 621 insertions(+), 841 deletions(-)
>  delete mode 100644 tests/qemu-iotests/common
> 
