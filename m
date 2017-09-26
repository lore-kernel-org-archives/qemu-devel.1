Received: from eggs.gnu.org ([2001:4830:134:3::10]:36131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwpT5-0000NV-NJ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:00:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwpSz-0003zx-Uu
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:00:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dwpSz-0003zD-Pv
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:00:01 -0400
Date: Tue, 26 Sep 2017 14:59:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170926145958.05c8ef01.cohuck@redhat.com>
In-Reply-To: <20170921180841.24490-1-pasic@linux.vnet.ibm.com>
References: <20170921180841.24490-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/5] add CCW indirect data access support
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

On Thu, 21 Sep 2017 20:08:36 +0200
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
> 
> The focus of this patch set is introducing IDA support. There seems to be
> a potential for further  improvements based on the introduced
> infrastructure, but such improvements are intended to be discusses
> separately and realized as patches on top of this series.

Thanks, applied.
