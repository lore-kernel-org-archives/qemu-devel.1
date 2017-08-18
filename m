Received: from eggs.gnu.org ([2001:4830:134:3::10]:49138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dijPL-0007VO-Iz
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 11:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dijPI-0004bD-F2
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 11:41:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dijPI-0004b4-8a
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 11:41:56 -0400
References: <20170818114353.13455-1-david@redhat.com>
	<20170818114353.13455-6-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e7d02885-dc1f-8480-b78f-bc38da68084c@redhat.com>
Date: Fri, 18 Aug 2017 17:41:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170818114353.13455-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 05/18] target/s390x: no need to
 pass kvm_state to savevm_gtod handlers
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
> Let's avoid any KVM stuff in s390-virtio-ccw.c. This parameter is simply
> ignored.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 3e9b455..f19fab5 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -161,7 +161,7 @@ static void ccw_init(MachineState *machine)
>      s390_create_virtio_net(BUS(css_bus), "virtio-net-ccw");
>  
>      /* Register savevm handler for guest TOD clock */
> -    register_savevm_live(NULL, "todclock", 0, 1, &savevm_gtod, kvm_state);
> +    register_savevm_live(NULL, "todclock", 0, 1, &savevm_gtod, NULL);
>  }
>  

Reviewed-by: Thomas Huth <thuth@redhat.com>
