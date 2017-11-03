Received: from eggs.gnu.org ([2001:4830:134:3::10]:50807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eAbSn-0004I2-OL
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eAbSj-0005GR-QR
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:52:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eAbSj-0005GC-Jz
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:52:41 -0400
References: <20171027181740.32165-1-danielhb@linux.vnet.ibm.com>
	<CAJ+F1CJs7WtU+xYfMViYer9vfRAq3SAMQiEjPRRCGnTUBbsgGQ@mail.gmail.com>
	<f2457db3-b654-4956-165c-ef0962d9e923@redhat.com>
	<CAJ+F1CKUBp11zoy-sW6kO61q-tt=GhF1avz+4z5kOSgJTrgrzA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <67350d55-71f7-41ae-2d54-911d0079f5d9@redhat.com>
Date: Fri, 3 Nov 2017 13:52:32 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKUBp11zoy-sW6kO61q-tt=GhF1avz+4z5kOSgJTrgrzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts/device-crash-test: vmcoreinfo in
 error_whitelist for ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 03.11.2017 13:30, Marc-Andr=C3=A9 Lureau wrote:
> Hi Thomas
>=20
> On Fri, Nov 3, 2017 at 1:01 PM, Thomas Huth <thuth@redhat.com> wrote:
>> On 03.11.2017 12:49, Marc-Andr=C3=A9 Lureau wrote:
>>> Hi Daniel
>>>
>>> On Fri, Oct 27, 2017 at 8:17 PM, Daniel Henrique Barboza
>>> <danielhb@linux.vnet.ibm.com> wrote:
>>>> The device vmcoreinfo depends on the fw_cfg device to work, a device
>>>> that isn't available in most ppc64 machines. This makes device-crash=
-test
>>>> spams the following error when running with qemu-system-ppc64:
>>>>
>>>> "INFO: log: qemu-system-ppc64: -device vmcoreinfo: vmcoreinfo device
>>>> requires fw_cfg with DMA"
[...]
>> It's not only about ppc64 - this problem exists also on most other
>> targets, e.g.:
>>
>> $ m68k-softmmu/qemu-system-m68k -M none -device vmcoreinfo
>> qemu-system-m68k: -device vmcoreinfo: vmcoreinfo device requires fw_cf=
g
>> with DMA
>>
>> So for the device-crash-test script, I think it would make more sense =
to
>> add a generic, machine-independent entry for this.
>>
>> Additionally, I think it's also a bad idea to blindly add this
>> vmcoreinfo device to all targets! We should only add it to the targets
>> that actually feature the fw_cfg device with DMA, so we need a proper
>> CONFIG_xxx switch for this. Marc-Andr=C3=A9 or Daniel, do you have tim=
e to
>> work on such a patch? Otherwise, I can have a look at this, too.
>=20
> Ah the DMA interface is only available on x86 & arm virt apparently. I
> thought it would be more widely available.
>=20
> I can add a CONFIG_FW_CFG_DMA, set by x86)64-softmuu & arm-softmmu,
> and make vmcoreinfo depend on it. Would that be good enough?

Yes, that sounds good to me!

 Thanks,
  Thomas
