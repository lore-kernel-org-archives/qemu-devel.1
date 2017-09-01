Received: from eggs.gnu.org ([2001:4830:134:3::10]:52872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dno4L-00011p-2j
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dno4G-0006cF-EP
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:41:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1dno4G-0006Xh-8Y
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:41:12 -0400
Date: Fri, 1 Sep 2017 17:41:00 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170901154100.25eieahmv5lse55u@eukaryote>
References: <20170901152200.5953-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901152200.5953-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, eblake@redhat.com

On Fri, Sep 01, 2017 at 11:21:57PM +0800, Fam Zheng wrote:
> A few tweaks to the docker images and running commands allow us to run
> qemu-iotests in the fedora container. This will be added to the patchew test
> cases later.
> 
> v3: Add nbd, luks and limit to quick group.
> 
> v2: Add nettle-devel because a few iotest cases blindly assumes the support is
> there.
> 
> Fam Zheng (3):
>   docker: Use unconfined security profile
>   docker: Add nettle-devel to fedora image
>   docker: Add test-block

All three of the patches look good to me.  FWIW:

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>


>  tests/docker/Makefile.include          |  1 +
>  tests/docker/dockerfiles/fedora.docker |  1 +
>  tests/docker/test-block                | 22 ++++++++++++++++++++++
>  3 files changed, 24 insertions(+)
>  create mode 100755 tests/docker/test-block
> 
> -- 
> 2.13.5
> 

-- 
/kashyap
