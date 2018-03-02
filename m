Received: from eggs.gnu.org ([2001:4830:134:3::10]:44451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.engraf@sysgo.com>) id 1eriao-0006xR-H7
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:11:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.engraf@sysgo.com>) id 1eriak-0006Ic-F7
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:11:14 -0500
References: <20180213102258.26145-1-david.engraf@sysgo.com>
	<20180215093600.18505-1-david.engraf@sysgo.com>
	<20180302014546.GD13135@umbus.fritz.box>
	<be9b719c-b1cf-8e82-3799-fca9e5fe896e@sysgo.com>
	<93d89925-b0c9-e974-f45e-064598b507c0@ilande.co.uk>
From: David Engraf <david.engraf@sysgo.com>
Message-ID: <460e409f-a587-129f-cdeb-1fd84e8f5a38@sysgo.com>
Date: Fri, 2 Mar 2018 12:11:07 +0100
MIME-Version: 1.0
In-Reply-To: <93d89925-b0c9-e974-f45e-064598b507c0@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3] PPC: e500: Fix duplicate
 kernel load and device tree overlap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Am 02.03.2018 um 10:11 schrieb Mark Cave-Ayland:
> On 02/03/18 08:53, David Engraf wrote:
>=20
>> Am 02.03.2018 um 02:45 schrieb David Gibson:
>>> On Thu, Feb 15, 2018 at 10:36:00AM +0100, David Engraf wrote:
>>>> This patch fixes an incorrect behavior when the -kernel argument has=
=20
>>>> been
>>>> specified without -bios. In this case the kernel was loaded twice.=20
>>>> At address
>>>> 32M as a raw image and afterwards by load_elf/load_uimage at the
>>>> corresponding load address. In this case the region for the device=20
>>>> tree and
>>>> the raw kernel image may overlap.
>>>>
>>>> The patch fixes the behavior by loading the kernel image once with
>>>> load_elf/load_uimage and skips loading the raw image.
>>>>
>>>> When here do not use bios_name/size for the kernel and use a more=20
>>>> generic
>>>> name called payload_name/size.
>>>>
>>>> New in v3: dtb must be stored between kernel and initrd because=20
>>>> Linux can
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 handle the dtb only within the fir=
st 64MB. Add a comment to
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clarify the behavior.
>>>>
>>>> Signed-off-by: David Engraf <david.engraf@sysgo.com>
>>>
>>> Sorry I've taken so long to reply to this.=A0 It looks fine to me,
>>> however, other changes mean it longer quite applies to the
>>> ppc-for-2.12 tree.=A0 Can you fix that up and repost please.
>>
>> What other changes do you mean? In v3 I just restored the old behavior=
=20
>> by putting the dtb right after the kernel image. This behavior has=20
>> been changed by mistake in v1/v2. v3 now uses the correct storage=20
>> location again.
>=20
> Hi David,
>=20
> I think what David means is that when he tried to apply your v3 patch t=
o=20
> his ppc-for-2.12 tree at=20
> https://github.com/dgibson/qemu/commits/ppc-for-2.12 using git-am then=20
> it failed - presumably because someone else has made other changes to=20
> that code since you submitted your v3 patch.
>=20
> Please can you submit a v4 rebased on top of the current ppc-for-2.12=20
> branch?

Hi Mark,

thanks for the info. I will provide an updated version.

Best regards
- David
