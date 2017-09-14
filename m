Received: from eggs.gnu.org ([2001:4830:134:3::10]:60928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsUwy-0006u1-Ts
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsUwv-0001W4-Mt
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:17:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42303)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dsUwv-0001Uk-HC
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:17:01 -0400
Date: Thu, 14 Sep 2017 16:16:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170914161655.46d1c37f.cohuck@redhat.com>
In-Reply-To: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] add CCW indirect data access support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed, 13 Sep 2017 13:50:25 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Abstract
> --------
> 
> The objective of this series is introducing CCW IDA (indirect data
> access) support to our virtual channel subsystem implementation. Briefly
> CCW IDA can be thought of as a kind of a scatter gather support for a
> single CCW. If certain flags are set, the cda is to be interpreted as an
> address to a list which in turn holds further addresses designating the
> actual data.  Thus the scheme which we are currently using for accessing
> CCW payload does not work in general case. Currently there is no
> immediate need for proper IDA handling (no use case), but since it IDA is
> a non-optional part of the architecture, the only way towards AR
> compliance is actually implementing IDA.

Thanks, applied.
