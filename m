Received: from eggs.gnu.org ([2001:4830:134:3::10]:37984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dIydZ-0006FI-FM
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dIydV-000565-IN
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:42:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32911
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dIydV-00055j-Bk
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:42:09 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v58EdGaL194837
	for <qemu-devel@nongnu.org>; Thu, 8 Jun 2017 10:42:08 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2axv36h0g3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 10:42:08 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 8 Jun 2017 08:42:07 -0600
References: <1496927940-13301-1-git-send-email-borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 8 Jun 2017 16:42:01 +0200
MIME-Version: 1.0
In-Reply-To: <1496927940-13301-1-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <c57bdb58-67a2-0f35-c8f8-d83e54fc72b3@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL 0/5] s390x/kvm: various fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@gmail.com>

On 06/08/2017 03:18 PM, Christian Borntraeger wrote:
> Peter,
> 
> The following changes since commit 0748b3526e8cb78b9cd64208426bfc3d54a72b04:
> 
>   Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging (2017-05-30 14:15:15 +0100)
> 
> are available in the git repository at:
> 
>   ssh://git@github.com/borntraeger/qemu.git tags/s390x-20170608

This address is certainly better

  git://github.com/borntraeger/qemu.git tags/s390x-20170608



> 
> for you to fetch changes up to fbe8202ea81519a42855830059ccc8e10b58dfa5:
> 
>   s390x/cpumodel: improve defintion search without an IBC (2017-06-06 10:50:40 +0200)
> 
> ----------------------------------------------------------------
> s390x: misc fixes
> 
> bunch of fixes
> - reject MIDA accesses for CCWs
> - cpumodel fixes
> - cross-build fix for bios
> - migration improvements
> 
> ----------------------------------------------------------------
> Cornelia Huck (1):
>       s390x/css: fence off MIDA
> 
> David Hildenbrand (2):
>       s390x/cpumodel: take care of the cpuid format bit for KVM
>       s390x/cpumodel: improve defintion search without an IBC
> 
> Greg Kurz (1):
>       pc-bios/s390-ccw: use STRIP variable in Makefile
> 
> Halil Pasic (1):
>       s390x/css: catch section mismatch on load
> 
>  hw/s390x/css.c            | 19 +++++++++++++++++++
>  hw/s390x/virtio-ccw.c     |  6 +++++-
>  include/hw/s390x/ioinst.h |  1 +
>  pc-bios/s390-ccw/Makefile |  4 +++-
>  target/s390x/cpu_models.c | 10 ++++++++++
>  target/s390x/cpu_models.h | 10 +++++++---
>  target/s390x/ioinst.c     |  4 ++++
>  target/s390x/kvm.c        |  1 +
>  8 files changed, 50 insertions(+), 5 deletions(-)
> 
