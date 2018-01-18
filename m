Received: from eggs.gnu.org ([2001:4830:134:3::10]:51850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ec8by-00064a-FS
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ec8bv-000288-EM
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:44:02 -0500
References: <20180118085628.40798-1-borntraeger@de.ibm.com>
	<20180118085628.40798-4-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5e7bcf0e-4ec4-931d-d2f6-8f4bc5cef50c@redhat.com>
Date: Thu, 18 Jan 2018 12:43:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180118085628.40798-4-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] s390x/kvm: provide stfle.81
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On 18.01.2018 09:56, Christian Borntraeger wrote:
> stfle.81 (ppa15) is a transparent facility that can be passed to the
> guest without the need to implement hypervisor support. As this feature
> can be provided by firmware we add it to all full models.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_features.c     | 1 +
>  target/s390x/cpu_features_def.h | 1 +
>  target/s390x/gen-features.c     | 1 +
>  3 files changed, 3 insertions(+)
>

Reviewed-by: Thomas Huth <thuth@redhat.com>
