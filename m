Received: from eggs.gnu.org ([2001:4830:134:3::10]:58111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dSOl2-00062t-5l
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dSOkw-0005B9-NJ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:24:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dSOkw-0005Ai-GJ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:24:46 -0400
Date: Tue, 4 Jul 2017 16:24:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170704162441.0f68b2c0@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499177279-131407-3-git-send-email-borntraeger@de.ibm.com>
References: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
	<1499177279-131407-3-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] s390x/3270: fix instruction
 interception handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

On Tue,  4 Jul 2017 16:07:54 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> 
> Commit bab482d7405f ("s390x/css: ccw translation infrastructure")
> introduced instruction interception handler for different types of
> subchannels. For emulated 3270 devices, we should assign the virtual
> subchannel handler to them during device realization process, or 3270
> will not work.
> 
> Fixes: bab482d7405f ("s390x/css: ccw translation infrastructure")
> 
> Reviewed-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/3270-ccw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
> index 6e6eee4..1554aa2 100644
> --- a/hw/s390x/3270-ccw.c
> +++ b/hw/s390x/3270-ccw.c
> @@ -126,6 +126,7 @@ static void emulated_ccw_3270_realize(DeviceState *ds, Error **errp)
>      sch->id.cu_type = EMULATED_CCW_3270_CU_TYPE;
>      css_sch_build_virtual_schib(sch, (uint8_t)chpid,
>                                  EMULATED_CCW_3270_CHPID_TYPE);
> +    sch->do_subchannel_work = do_subchannel_work_virtual;
>      sch->ccw_cb = emulated_ccw_3270_cb;
>  
>      ck->init(dev, &err);

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
