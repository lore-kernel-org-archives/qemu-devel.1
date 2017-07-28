Received: from eggs.gnu.org ([2001:4830:134:3::10]:44582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1db3vL-0004VM-7g
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1db3vH-0002Hp-N8
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:59:19 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-6-f4bug@amsat.org>
	<a7fdc125-9a1b-bec3-915f-e8f764816b0d@redhat.com>
	<c44770f5-df9d-2340-5dba-2f5db7acd046@redhat.com>
	<20170728135614.3f14e3ad@gondolin>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3abbfa87-d882-39ab-b4ab-66f3e68a2fb4@redhat.com>
Date: Fri, 28 Jul 2017 13:59:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170728135614.3f14e3ad@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/47] MAINTAINERS: add missing KVM entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 28/07/2017 13:56, Cornelia Huck wrote:
> On Fri, 28 Jul 2017 13:51:14 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>> On 28/07/2017 09:00, Thomas Huth wrote:
>>> On 28.07.2017 07:35, Philippe Mathieu-Daud=C3=A9 wrote: =20
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> ---
>>>>  MAINTAINERS | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 3b472d7a09..ece02522be 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -278,6 +278,7 @@ S: Supported
>>>>  F: */kvm.*
>>>>  F: accel/kvm/
>>>>  F: include/sysemu/kvm*.h
>>>> +F: linux-headers/asm-*/kvm*.h =20
>>>
>>> The linux-headers are not really maintained by the QEMU project - so =
I
>>> guess we do not need an entry for these? =20
>>
>> Actually I agree with the patch.  I'd like to be CCed on
>> update-linux-headers patches, and this achieves it. :)
>=20
> But would it not a better idea to add an entry for all headers touched
> by update-linux-headers, then?

One thing doesn't exclude the other.  That entry would also list the
script itself and linux-headers.  KVM, VFIO and virtio patterns can only
list the files they care about.  Migration could list userfaultfd,
possibly.  And there's also include/standard-headers/, which includes
PCI and input subsystem files...  It has to be perfected, but it's a
good idea.

Paolo

Paolo
