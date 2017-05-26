Received: from eggs.gnu.org ([2001:4830:134:3::10]:39908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dED4r-0004x1-MU
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dED4q-00081o-TL
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:06:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dED4q-00081c-NE
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:06:40 -0400
References: <33183CC9F5247A488A2544077AF19020DA2B906D@DGGEMA505-MBX.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0d13548e-717d-b90b-7666-58ada1d3c549@redhat.com>
Date: Fri, 26 May 2017 13:06:35 +0200
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA2B906D@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] Is it useful to create a seperate address
 space for cpu-memory on x86 platform?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "peter.crosthwaite@xilinx.com" <peter.crosthwaite@xilinx.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "edgar.iglesias@xilinx.com" <edgar.iglesias@xilinx.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>



On 26/05/2017 11:59, Gonglei (Arei) wrote:
> The result before this commit:
> 
> linux-arei:/mnt/sdb/gonglei/opensource/qemu # ps aux|grep qemu
> root     12658 17.2  0.0 375996 21412 pts/1    Sl+  12:53   0:00 ./x86_64-softmmu/qemu-system-x86_64 -machine pc-i440fx-2.5,accel=kvm,usb=off -nodefaults
> 
> after the commit:
>  
> linux-arei:/mnt/sdb/gonglei/opensource/qemu # ps aux|grep qemu
> root     23201 17.2  0.0 384196 25736 pts/1    Sl+  12:54   0:00 ./x86_64-softmmu/qemu-system-x86_64 -machine pc-i440fx-2.5,accel=kvm,usb=off -nodefaults
> 
> I couldn't find any benefits on x86 platform (I'm not familiar with ARM), am I missing something?

Hi,

this was also reported by Anthony Xu.  I am working on reducing the time
and space cost of multiple address spaces by sharing the FlatView and
AddressSpaceDispatch.

Paolo
