Received: from eggs.gnu.org ([2001:4830:134:3::10]:34847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.poctavek@erigones.com>) id 1doqsL-0000tX-OL
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.poctavek@erigones.com>) id 1doqsG-0007Xu-PS
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:53:13 -0400
Received: from zimbra.entira.sk ([93.184.68.160]:55086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.poctavek@erigones.com>)
	id 1doqsG-0007RC-Dl
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:53:08 -0400
References: <8c62454c-828b-0f16-76dd-227d9c52af1d@erigones.com>
	<20170829100806.GO25960@stefanha-x1.localdomain>
From: =?UTF-8?Q?J=c3=a1n_Poctavek?= <jan.poctavek@erigones.com>
Message-ID: <2bfb1acd-cd69-a719-0c18-a5684367da04@erigones.com>
Date: Mon, 4 Sep 2017 14:52:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170829100806.GO25960@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] wrong ioctl error handling on dirty pages sync?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org


On 29. 8. 2017 12:08, Stefan Hajnoczi wrote:
> On Fri, Aug 25, 2017 at 01:42:55PM +0200, J=C3=A1n Poctavek wrote:
>> Hi guys,
>>
>> Maybe it is just my lack of understanding, this seems like a bug to me=
:
>>
>> To get list of dirty pages, qemu calls kvm_vm_ioctl() with
>> KVM_GET_DIRTY_LOG:
>> https://github.com/qemu/qemu/blob/v2.10.0-rc4/accel/kvm/kvm-all.c#L494
>>
>> and considers the ioctl call failed when -1 is returned.
>>
>> But the kvm_vm_ioctl() itself returns -errno, not the -1 on error:
>> https://github.com/qemu/qemu/blob/v2.10.0-rc4/accel/kvm/kvm-all.c#L214=
2
>>
>> Thanks in advance for sheding some light into this for me.
> Looks like a bug to me.  Do you want to send a patch?
>
> Guidelines on how to submit a patch are here:
> http://wiki.qemu.org/Contribute/SubmitAPatch
>
> Stefan

It seems that the patch has already been created a long time ago. But it=20
is still not included:

https://lists.nongnu.org/archive/html/qemu-devel/2014-03/msg03996.html

Can I help with this somehow?

Jan
