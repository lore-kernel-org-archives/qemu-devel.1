Received: from eggs.gnu.org ([2001:4830:134:3::10]:46880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSijE-0001ip-2M
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSij9-0007Nh-5t
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:44:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSij8-0007Kb-W6
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:44:15 -0400
Date: Wed, 5 Jul 2017 19:44:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170705114411.GE29382@lemon.lan>
References: <1499237876.3041.4.camel@linux.intel.com>
	<20170705110431.GE22008@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170705110431.GE22008@redhat.com>
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Chao Peng <chao.p.peng@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, qemu-devel@nongnu.org

On Wed, 07/05 12:04, Daniel P. Berrange wrote:
> While you can say people should just add '-M pc' that isn't a nice
> user experiance, because it makes the assumption that people actually
> understand what caused their breakage. When the incompatibilities
> arise the error messages are unlikely to give any hint to users that
> the problems are caused by the machine type change. So unless someone
> is very familiar with debugging QEMU, they're not going to realize
> that '-M pc' will fix their problem.

While we change the default, can we start to print a message like 'machine type
("-M" option) not specified, default to Q35. If you find compatibility issues,
try "-M pc"'?

Fam
