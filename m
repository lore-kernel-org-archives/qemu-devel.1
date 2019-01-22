Received: from eggs.gnu.org ([209.51.188.92]:53703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gltf5-00025Z-Qh
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gltf4-0006pp-Le
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:52:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gltf4-0006oh-FT
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:52:06 -0500
References: <20190118223400.24311-1-lersek@redhat.com>
	<20190118223400.24311-2-lersek@redhat.com>
	<9dc7319d-f383-e4e3-1750-115ae6c1d8eb@redhat.com>
	<ed365666-30c8-b532-dda2-469178dc09be@redhat.com>
	<c3e316fb-8242-5639-695c-9412c1aeddaf@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <24231a00-7d2e-3168-ec2c-b6e984477287@redhat.com>
Date: Tue, 22 Jan 2019 11:51:55 +0100
MIME-Version: 1.0
In-Reply-To: <c3e316fb-8242-5639-695c-9412c1aeddaf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] roms: add the edk2 project as a git
 submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu devel list <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 01/21/19 20:45, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/21/19 7:41 PM, Laszlo Ersek wrote:
>> On 01/21/19 12:25, Philippe Mathieu-Daud=C3=A9 wrote:

>>> I suggest the following change, Daniel/Alex what do you think?
>>>
>>> -- >8 --
>>> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
>>> index 98ca0f2737..5441fe3385 100755
>>> --- a/scripts/git-submodule.sh
>>> +++ b/scripts/git-submodule.sh
>>> @@ -71,7 +71,7 @@ update)
>>>          exit 0
>>>      fi
>>>
>>> -    $GIT submodule update --init $modules 1>/dev/null
>>> +    $GIT submodule update --init --recursive $modules 1>/dev/null
>>>      test $? -ne 0 && error "failed to update modules"
>>>
>>>      $GIT submodule status $modules > "${substat}"
>>> ---
>>
>> This shouldn't make a difference, as edk2 is not a nested submodule of
>> another submodule; it is a submodule directly under the main
>> superproject, i.e. QEMU.
>=20
> OK (as long as we don't want to build OVMF within QEMU to run QEMU test=
s).

I think if / whenever we bundle OVMF binaries with QEMU, there'll be a
two step process (like with other roms); maintainers will (re)build the
binaries and commit/merge them, and tests will use the bundled binaries
as they are.

Thanks
Laszlo
