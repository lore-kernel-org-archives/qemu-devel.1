Received: from eggs.gnu.org ([2001:4830:134:3::10]:43861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6XuN-00033i-KT
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6XuK-0000DW-I2
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:44:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6XuK-0000DJ-Bk
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:44:08 -0400
References: <20170505032340.26467-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <03beb071-ebbc-4328-3530-37b9856476cc@redhat.com>
Date: Fri, 5 May 2017 09:44:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170505032340.26467-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>



On 05/05/2017 05:23, Fam Zheng wrote:
> A few tweaks to the docker images and running commands allow us to run
> qemu-iotests in the fedora container. This will be added to the patchew test
> cases later.
> 
> Fam Zheng (5):
>   docker: Run tests with current user
>   docker: Add bzip2 and hostname to fedora image
>   docker: Use unconfined security profile
>   docker: Add libaio to fedora image
>   docker: Add test-block
> 
>  tests/docker/Makefile.include          |  3 ++-
>  tests/docker/dockerfiles/fedora.docker |  4 ++--
>  tests/docker/test-block                | 21 +++++++++++++++++++++
>  3 files changed, 25 insertions(+), 3 deletions(-)
>  create mode 100755 tests/docker/test-block
> 

Patches 1-4:

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

For patch 5, I think we should revive the "quick" qemu-iotests group
(maybe we can have support for skipping groups, and have a "slow" group
with the very few tests that take >30 seconds?) and add the quick tests
to "make check".

Paolo
