Received: from eggs.gnu.org ([2001:4830:134:3::10]:50659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f4UWe-0001tp-B5
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 12:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f4UWa-0005wF-Ed
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 12:47:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f4UWa-0005w4-8u
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 12:47:40 -0400
References: <20180404025201.11921-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a9d557d7-b6d3-3137-69d0-cd0f63e9b107@redhat.com>
Date: Fri, 6 Apr 2018 18:47:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180404025201.11921-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] Add a CentOS test image to run docker
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 04/04/2018 04:51, Fam Zheng wrote:
> Docker testing on patchew has long suffered from 'make check' hangings. The
> cleanness of VM testing is the cure. Now let's add a CentOS 7 image to run the
> tests.  It's purely ad-hoc, but hopefully still easy to understand and use for
> everyone.
> 
> The first patch makes passing source code from host to the container in VM
> working, and is a nice clean up.
> 
> The second patch makes caches work, to speed up repetitive runs like on
> patchew.
> 
> The last patch adds the new image that does the job. Two out of three docker
> tests running on patchew.org are added to the image. I'll wait for Peter to fix
> the 'docker-test-quick@centos6' hanging (oob test) before adding it too.

I think it's a good idea.  The tests are the same as before, only the
environment is more self-contained.

Paolo

> Fam
> 
> Fam Zheng (3):
>   archive-source.sh: Drop submodule code
>   tests: Add an option for snapshot (default: off)
>   tests: Add centos VM testing
> 
>  scripts/archive-source.sh | 47 +++------------------------
>  tests/vm/basevm.py        |  7 +++-
>  tests/vm/centos           | 82 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 92 insertions(+), 44 deletions(-)
>  create mode 100755 tests/vm/centos
> 
