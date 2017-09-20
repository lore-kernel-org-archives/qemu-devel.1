Received: from eggs.gnu.org ([2001:4830:134:3::10]:57873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duhaf-0000OL-Ux
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duhab-0006kW-Pi
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:11:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1duhaZ-0006gH-KU
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:11:04 -0400
From: Thomas Huth <thuth@redhat.com>
References: <1505811353-29151-1-git-send-email-thuth@redhat.com>
	<84d1e5a0-141f-cd91-f62c-14fe58e73b4b@redhat.com>
	<CAFEAcA_morPirUBzbpX1tHKfSCX+vAEcWX+KmUZKdnNm3O3vhA@mail.gmail.com>
	<54a1ab1c-4da0-ded1-c225-f50d4756b773@redhat.com>
	<99dd133d-239e-b53e-d258-7b1bde8639df@redhat.com>
Message-ID: <05454839-2216-ee27-1cce-7d9899563806@redhat.com>
Date: Wed, 20 Sep 2017 18:10:48 +0200
MIME-Version: 1.0
In-Reply-To: <99dd133d-239e-b53e-d258-7b1bde8639df@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>

On 20.09.2017 13:17, Thomas Huth wrote:
> On 20.09.2017 12:57, Marcel Apfelbaum wrote:
>> On 20/09/2017 13:07, Peter Maydell wrote:
[...]
>>> Is it possible to hack together some kind of test code that
>>> can give us a list of the devices compiled in that have
>>> hotpluggable enabled? Then we could compare before and
>>> after to see which devices we've changed.
>>>
>>
>> Eduardo came up with some cool automated tests not long ago.
>> Eduardo, can your tests help?
>=20
> You mean the scripts/device-crash-test script? That's only for
> cold-plugging ... but I could maybe use the device_add HMP test (see
> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg00817.html ) t=
o
> exercise the hotplugging of all devices and add some debug code to
> qdev_device_add() to see which devices are dc->hotpluggable and have a
> hotplug handler at the same time... I'll give it a try.

Ok, done that now, and it looks like I missed devices of type
TYPE_X86_CPU and TYPE_S390_CPU at least... Unlike the ppc64 CPUs, they
are not derived from TYPE_CPU_CORE, but from TYPE_CPU ... is that on
purpose? I thought hot-pluggable CPUs would need to be derived from
TYPE_CPU_CORE... well, maybe I just understood that wrong.
I'll send a new version of my patch.

 Thomas
