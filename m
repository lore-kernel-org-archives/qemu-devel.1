Received: from eggs.gnu.org ([2001:4830:134:3::10]:34928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ffyUE-0000GO-6T
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 22:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ffyUA-0000Na-3x
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 22:16:10 -0400
Received: from mail-sn1nam01on0062.outbound.protection.outlook.com
	([104.47.32.62]:11906
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1ffyU9-0000NC-JB
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 22:16:06 -0400
References: <CANhJxzwZny93TOTKTpEoThN8bnw1tXENPH_S60wczUAQodBMNw@mail.gmail.com>
	<20180718095034.GJ9812@redhat.com>
	<20180718101844.GB22954@antique-laptop>
	<20180718134902.GY31657@localhost.localdomain>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <48b727f1-6410-4140-13bc-8b9c75215c93@amd.com>
Date: Wed, 18 Jul 2018 21:15:50 -0500
MIME-Version: 1.0
In-Reply-To: <20180718134902.GY31657@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [libvirt] CPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Pavel Hrdina <phrdina@redhat.com>
Cc: brijesh.singh@amd.com, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Hetz Ben Hamo <hetz@hetz.biz>, qemu-devel@nongnu.org, libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Babu Moger <babu.moger@amd.com>



On 7/18/18 8:49 AM, Eduardo Habkost wrote:
> CCing the AMD people who worked on this.
>
> On Wed, Jul 18, 2018 at 12:18:45PM +0200, Pavel Hrdina wrote:
>> On Wed, Jul 18, 2018 at 10:50:34AM +0100, Daniel P. Berrang=C3=A9 wrote:
>>> On Wed, Jul 18, 2018 at 12:41:48PM +0300, Hetz Ben Hamo wrote:
>>>> Hi,
>>>>
>>>> I've been looking at the CPU list and although I see lots of CPU's, I
>>>> cannot find 2 CPU families:
>>>>
>>>> * AMD Ryzen
>>>> * AMD Threadripper
>>>>
>>>> Although EPYC has been added recently.
>>>>
>>>> Are there any missing details which preventing adding those CPU's to t=
he
>>>> list?
>>> Libvirt adds CPU models based on what QEMU supports. So from libvirt si=
de the
>>> answer is simply that QEMU doesn't expose any models for Ryzen/Threadri=
pper,
>>> but I'm not clear why it doesn't...

EPYC model should work just fine on Ryzen/Threadripper. Are we seeing
some issues?

>>> For a while I thought Ryzen/Threadripper would have same feature set as
>>> EPYC, but I've seen bugs recently suggesting that is not in fact the
>>> case. So it does look like having those models exposed by QEMU might
>>> be useful.
>>>
>>> Copy'ing QEMU devel & the CPU model maintainers for opinions.
>> I think that QEMU should figure out some pattern for naming CPU models
>> because it's one big mess.  EPYC and Ryzen are bad names for QEMU as
>> Core/Xeon would be for Intel CPUs.  It's the name of a model families
>> and it will probably remain the same but with different
>> microarchitecture.
>> Better name would be similarly like for the latest Inter CPUs,
>> Skylake-Client and Skylake-Server.  Currently AMD has already two
>> microarchitectures, Zen and Zen+ and there is third one Zen 2 planned.
>>
>> Zen has AMD Ryzen, AMD Ryzen Threadripper and AMD Epyc.
>> Zen+ has AMD Ryzen, AMD Ryzen Threadripper
>>
>> And I bet that Zen 2 will follow the same model families.


My guess is same as your :) I hope sales/marketing does not come up with
different names for Soc's based Zen 2 core.


>> We probably cannot rename EPYC now, but before we introduce Ryzen and
>> Threadripper let's thing about it and come up with better names, for
>> example Zen-Client/Zen-Server Zen+-Client or something like that.

Zen-Client/Zen-Server naming convention looks better.
