Received: from eggs.gnu.org ([2001:4830:134:3::10]:42017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euJeh-0004wJ-GT
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:10:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euJec-0000ux-Hk
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:09:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1euJec-0000uc-Cn
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:09:54 -0500
References: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
	<90ba320e-2a05-8962-dc6b-252b3e15d1b7@redhat.com>
	<20180308154730.GZ4718@redhat.com>
	<c455f46b-dc25-fe7e-acc8-140f4a703e94@redhat.com>
	<20180309112723.deci6fc2k66pbwdj@eukaryote>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <12282811-f874-471c-91cd-4d6315d35ae8@redhat.com>
Date: Fri, 9 Mar 2018 16:09:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180309112723.deci6fc2k66pbwdj@eukaryote>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Defining firmware (OVMF,
 et al) metadata format & file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, kraxel@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On 03/09/18 12:27, Kashyap Chamarthy wrote:
> On Thu, Mar 08, 2018 at 09:47:27PM +0100, Laszlo Ersek wrote:
>> On 03/08/18 16:47, Daniel P. Berrang=C3=A9 wrote:
>>> On Thu, Mar 08, 2018 at 12:10:30PM +0100, Laszlo Ersek wrote:
>=20
> [...]
>=20
>>>> For OVMF (x86), I guess the initial set of properties should come fr=
om
>>>> the "-D FOO[=3DBAR]" build flags that OVMF currently supports. (The =
list
>>>> might grow or change incompatibly over time, so this is just a raw
>>>> starter idea.)
>>>
>>> I really don't want to see us using firmware implementation specific
>>> property names in these files. It means libvirt will require knowledg=
e
>>> of what each different firmware's property names mean.
>>>
>>> We need to have some core standardized set of property names that can
>>> be provided by any firmware implementation using the same terminology=
.
>>>
>>> If we want to /also/ provide some extra firmeware-specific property
>>> names that would be ok for informative purposes, but when lbivirt is
>>> picking which firmware file to use, it would only ever look at the
>>> standardized property names/values.
>>
>> This is a reasonable requirement from the libvirt side.
>>
>> Unfortunately (or not), it requires someone (or a tight group of peopl=
e)
>> to collect the features of all virtual firmwares in existence, and
>> extract a common set of properties that maps back to each firmware one
>> way or another.=20
>=20
> Hmm, if people consider the above worthwhile (no clue how much time &
> investigation it takes to arrive at a common set of properties) maybe
> slowly we should start collecting such a page?  From a quick look up,
> list of open source firmware implementations I found so (besides OVMF &
> ArmVirt):
>=20
>   - OpenBIOS
>   - SmartFirmware
>   - OpenBoot
>   - CoreBoot
>   - U-Boot
>   - SLOF
>   - ...
>=20
> Source: https://en.wikipedia.org/wiki/OpenBIOS
>=20
> I notice you said "virtual firmwares".  I couldn't find such a list fro=
m
> my look up.
>=20
> Hmm, I also wonder if the "arriving at a common set of properties acros=
s
> existing virtual firmwares" is an absolute blocker.

That's for Daniel to decide. I can't sensibly generalize from OVMF &
ArmVirt to other firmwares, without knowing them.

Thanks
Laszlo

>=20
>> This is not unusual (basically this is how all standards
>> bodies work that intend to codify existing practice), it just needs a
>> bunch of work and coordination. We'll have to maintain a registry.
>>
>> Personally I can't comment on anything else than OVMF and the ArmVirt
>> firmwares.
>>
>> Thanks,
>> Laszlo
>=20
