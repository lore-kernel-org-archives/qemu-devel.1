Received: from eggs.gnu.org ([2001:4830:134:3::10]:39055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dp9z4-0007am-4d
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dp9yu-0006r1-E8
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:17:26 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dp9yu-0006oV-67
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:17:16 -0400
Received: by mail-wm0-x244.google.com with SMTP id p17so2429182wmd.3
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 02:17:14 -0700 (PDT)
Date: Tue, 5 Sep 2017 10:17:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170905091712.GC17449@stefanha-x1.localdomain>
References: <20170905025614.579-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170905025614.579-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/6] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kchamart@redhat.com, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Tue, Sep 05, 2017 at 10:56:08AM +0800, Fam Zheng wrote:
> Based-on: 20170905021201.25684-1-famz@redhat.com
> ([PATCH v6 00/12] tests: Add VM based build tests (for non-x86_64 and/or
> non-Linux))
> 
> A few tweaks to the docker images and running commands allow us to run
> qemu-iotests in the fedora container. This will be added to the patchew test
> cases later.
> 
> v4: Don't use 'set -e'. [Eric]
>     Add Kashyap's rev-by to unchanged patches.
> 
> v3: Add nbd, luks and limit to quick group.
> 
> v2: Add nettle-devel because a few iotest cases blindly assumes the support is
> there.
> 
> Fam Zheng (6):
>   docker: Fix return code of build_qemu()
>   docker: Add test_fail and prep_fail
>   docker: Use unconfined security profile
>   docker: Add nettle-devel to fedora image
>   docker: Add test-block
>   docker: Drop 'set -e' from run script
> 
>  tests/docker/Makefile.include          |  1 +
>  tests/docker/common.rc                 | 15 +++++++++++++--
>  tests/docker/dockerfiles/fedora.docker |  1 +
>  tests/docker/run                       |  8 +++-----
>  tests/docker/test-block                | 22 ++++++++++++++++++++++
>  5 files changed, 40 insertions(+), 7 deletions(-)
>  create mode 100755 tests/docker/test-block
> 
> -- 
> 2.13.5
> 
> 

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
