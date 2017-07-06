Received: from eggs.gnu.org ([2001:4830:134:3::10]:47929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dT4Ws-0005sq-Bi
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 07:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dT4Wp-0006Nb-5S
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 07:01:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dT4Wo-0006L1-Un
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 07:00:59 -0400
References: <1499237876.3041.4.camel@linux.intel.com>
	<20170705110431.GE22008@redhat.com> <20170705114411.GE29382@lemon.lan>
	<c1f43fc3-7db8-50af-ee8c-331895721bd6@redhat.com>
	<20170705122200.GH29382@lemon.lan> <20170706104940.GJ3988@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bc77d893-8489-b38d-00e5-12456321ad9b@redhat.com>
Date: Thu, 6 Jul 2017 13:00:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170706104940.GJ3988@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Chao Peng <chao.p.peng@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, qemu-devel@nongnu.org

On 06.07.2017 12:49, Daniel P. Berrange wrote:
[...]
> This avoids the user having problems with guest ABI silently changing
> behind their back, or migration suddenly failing to load vm state,

For proper migration, you've got to specify the right versioned machine
type anyway, so that should not be an issue here.

 Thomas
