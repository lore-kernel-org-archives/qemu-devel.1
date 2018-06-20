Received: from eggs.gnu.org ([2001:4830:134:3::10]:59361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fVYL7-0007ER-U6
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fVYL3-0002it-RX
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:19:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54934 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fVYL3-0002ii-Me
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:19:37 -0400
References: <20180619132200.12320-1-sameeh@daynix.com>
	<20180619134933.GY20929@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <aa9ba67a-6bfe-4e98-987b-14506a18af32@redhat.com>
Date: Wed, 20 Jun 2018 16:19:26 +0800
MIME-Version: 1.0
In-Reply-To: <20180619134933.GY20929@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/1] Add BPF suuport to Qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Sameeh Jubran <sameeh@daynix.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Amnon Ilan <ailan@redhat.com>, qemu-devel@nongnu.org



On 2018=E5=B9=B406=E6=9C=8819=E6=97=A5 21:49, Daniel P. Berrang=C3=A9 wro=
te:
> On Tue, Jun 19, 2018 at 04:21:59PM +0300, Sameeh Jubran wrote:
>> From: Sameeh Jubran <sjubran@redhat.com>
>>
>> The Berkeley Packet Filter has been in the kernel for a while now and =
I
>> think it is time that it is introduced to Qemu. This patch is an
>> infrastructure for any future usage of the BPF in Qemu.
>>
>> It is important to note that the tun driver had started supporting usi=
ng
>> BPF programs through ioctls (TUNSETSTEERINGEBPF and TUNSETFILTEREBPF).
>>
>> At first, instead of adding the syscall wrappers, I wanted to integrat=
e libbpf
>> library which resides in the Linux source tree under tools/lib/bpf. It=
 appears
>> to be that by default it compiles to x64 on x64 arch - which can't be
>> integrated into Qemu  - and my attempts to compile the 32 bit versions=
 have
>> failed. What's more interesting is that the vendors don't provide this=
 library
>> in any package, which makes this library a nasty dependency.
>>
>> Please share your thoughts :)
> IMHO there should be example usage illustrated for some part of QEMU
> before we add any general infrastructure, as you can't really do a
> useful design evaluation without understanding its usage.
>
> It isn't clear that QEMU is neccessarily the best place to even do it, =
if
> the intended usage is to provide network traffic firewalling for guest
> NICs. eg libvirt already provides a firewalling system based on iptable=
s,
> that could have an BPFilter implementation added to it.

Is this just cBPF for filtering, or eBPF that can do e.g map operations?

I'm not sure doing eBPF for RSS in libvirt is the best place (receive=20
filtering is probably ok). It requires adding new notification=20
interfaces, and future extension become complex.

Thanks

>
> Regards,
> Daniel
