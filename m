Received: from eggs.gnu.org ([2001:4830:134:3::10]:52822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dijg6-0008Fe-I0
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 11:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dijg1-0004rm-KC
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 11:59:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dijg1-0004rT-DK
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 11:59:13 -0400
References: <20170818114353.13455-1-david@redhat.com>
	<20170818114353.13455-5-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2974411d-698a-b5e4-e3d2-f74d36ec1339@redhat.com>
Date: Fri, 18 Aug 2017 17:59:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170818114353.13455-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 04/18] target/s390x: simplify
 gs_allowed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 18.08.2017 13:43, David Hildenbrand wrote:
> No need for kvm_enabled() as this function is only called from KVM and
> there is no reason why it shouldn't be allowed for tcg. It is simply not
> available under tcg.
> 
> Also, there is no need to check for the machine type anymore. Just like
> ri_enabled(), we can directly use the stored flag, which results in
> "true" for the "none" machine.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
