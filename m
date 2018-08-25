Received: from eggs.gnu.org ([2001:4830:134:3::10]:39764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fti05-00011h-Pw
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 19:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fti00-0003Hy-Rb
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 19:29:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fti00-0003GM-Es
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 19:29:44 -0400
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <1535199590-68475-5-git-send-email-peng.hao2@zte.com.cn>
Date: Sun, 26 Aug 2018 02:29:35 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <04A4CBE9-18A2-45FA-8530-F2EB658DE2F0@oracle.com>
References: <1535199590-68475-1-git-send-email-peng.hao2@zte.com.cn>
	<1535199590-68475-5-git-send-email-peng.hao2@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH V4 4/4] target-i386: add i440fx 0xcf8 port
 as coalesced_pio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, ehabkost@redhat.com, rkrcmar@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, zhong.weidong@zte.com.cn



> On 25 Aug 2018, at 15:19, Peng Hao <peng.hao2@zte.com.cn> wrote:
>=20
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 0e60834..da73743 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -327,6 +327,10 @@ static void i440fx_pcihost_realize(DeviceState =
*dev, Error **errp)
>=20
>     sysbus_add_io(sbd, 0xcfc, &s->data_mem);
>     sysbus_init_ioports(sbd, 0xcfc, 4);
> +
> +    /* register i440fx 0xcf8 port as coalesced pio */
> +    memory_region_set_flush_coalesced(&s->data_mem);
> +    memory_region_add_coalescing(&s->conf_mem, 0, 4);
> }
>=20

Is there a reason to not register this port as coalesced PIO also for =
Q35?
In q35_host_realize()?
If not, I would do that as an extra patch as part of this series.

-Liran
