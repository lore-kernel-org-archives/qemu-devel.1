Received: from eggs.gnu.org ([2001:4830:134:3::10]:43612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dax3k-0003oZ-B7
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dax3g-0007Fi-B5
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:39:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dax3g-0007Ep-5x
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:39:28 -0400
Date: Fri, 28 Jul 2017 12:39:22 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170728043922.GN5117@lemon.lan>
References: <20170725094026.5376-1-cohuck@redhat.com>
	<150097670624.105.11799417719809984169@5d477a5b5989>
	<20170725121918.7c3f1d56@gondolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170725121918.7c3f1d56@gondolin>
Subject: Re: [Qemu-devel] [PULL for-2.10 00/14] A set of s390x patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: no-reply@patchew.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, david@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, rth@twiddle.net

On Tue, 07/25 12:19, Cornelia Huck wrote:
> > Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> > fatal: unable to access 'https://github.com/patchew-project/qemu/': OpenSSL SSL_connect: SSL_ERROR_SYSCALL in connection to github.com:443 
> 
> Hm... connection issues?

Yes, patchew still doesn't have the ability to distinguish env/network issue
from real failures. This one should be easy to add because it happens in the
preparation phase, maybe it's a good idea for the next thing to work on.

Fam
