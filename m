Received: from eggs.gnu.org ([2001:4830:134:3::10]:34915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eu2S6-00052Q-O7
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eu2S1-0001AP-Ib
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:47:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eu2S1-0001A3-Dp
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:47:45 -0500
References: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
	<90ba320e-2a05-8962-dc6b-252b3e15d1b7@redhat.com>
	<20180308154730.GZ4718@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c455f46b-dc25-fe7e-acc8-140f4a703e94@redhat.com>
Date: Thu, 8 Mar 2018 21:47:27 +0100
MIME-Version: 1.0
In-Reply-To: <20180308154730.GZ4718@redhat.com>
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
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, kraxel@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On 03/08/18 16:47, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Mar 08, 2018 at 12:10:30PM +0100, Laszlo Ersek wrote:

>> I suggest (or agree) that the property list be composed of free-form
>> name=3Dvalue pairs (at least conceptually). I understand Gerd is propo=
sing
>> a QAPI schema for this, so maybe do { property_name : "foo",
>> property_value : "bar" }, or similar. The registry of properties (name=
s,
>> possible values, meanings) should be kept separate (although possibly
>> still under QEMU).
>>
>> For OVMF (x86), I guess the initial set of properties should come from
>> the "-D FOO[=3DBAR]" build flags that OVMF currently supports. (The li=
st
>> might grow or change incompatibly over time, so this is just a raw
>> starter idea.)
>=20
> I really don't want to see us using firmware implementation specific
> property names in these files. It means libvirt will require knowledge
> of what each different firmware's property names mean.
>=20
> We need to have some core standardized set of property names that can
> be provided by any firmware implementation using the same terminology.
>=20
> If we want to /also/ provide some extra firmeware-specific property
> names that would be ok for informative purposes, but when lbivirt is
> picking which firmware file to use, it would only ever look at the
> standardized property names/values.

This is a reasonable requirement from the libvirt side.

Unfortunately (or not), it requires someone (or a tight group of people)
to collect the features of all virtual firmwares in existence, and
extract a common set of properties that maps back to each firmware one
way or another. This is not unusual (basically this is how all standards
bodies work that intend to codify existing practice), it just needs a
bunch of work and coordination. We'll have to maintain a registry.

Personally I can't comment on anything else than OVMF and the ArmVirt
firmwares.

Thanks,
Laszlo
