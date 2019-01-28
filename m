Received: from eggs.gnu.org ([209.51.188.92]:36602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1goCSr-0002O0-2n
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1goCSq-0001dm-57
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:21:00 -0500
References: <20190125203402.18904-1-philmd@redhat.com>
	<1c788b0e-6a4b-f04f-b413-e7211fc62e85@redhat.com>
	<20190128160830.GH5756@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <73afb8ac-aa0c-6095-82d4-f91afff36cb9@redhat.com>
Date: Mon, 28 Jan 2019 14:14:10 -0500
MIME-Version: 1.0
In-Reply-To: <20190128160830.GH5756@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] ahci-test: Add dependency to qemu-img
 tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>



On 1/28/19 11:08 AM, Kevin Wolf wrote:
> Am 25.01.2019 um 22:57 hat John Snow geschrieben:
>> On 1/25/19 3:34 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Since the ahci-test uses qemu-img, add a dependency to build it
>>> before using it.
>>> This fixes:
>>>
>>>   $ gmake check-qtest V=3D1
>>>   QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IM=
G=3Dqemu-img tests/ahci-test
>>>   Failed to execute child process "/tmp/qemu-test.19tMRF/qemu-img" (N=
o such file or directory)
>>>   ERROR:tests/libqos/libqos.c:192:mkimg: assertion failed: (ret && !e=
rr)
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>> RFC because while this dependency is valid, I don't think this is the
>>> clever way to solve this problem (which is, assuming the host
>>> distribution has the qemu-tools installed).
>>> I guess remember a thread about it (Eric, John?) where it was asked
>>> "What do we want to test, qemu-img or AHCI? Can we trust an unstable
>>> version of a tool to verify a device?"
>>>
>> [...]
>>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>=20
> Are you taking this through your tree, or through which tree should it
> be merged?
>=20
> Kevin
>=20

I can, but it'd be the only patch I have this week. If it's not a
burden, would you mind including it?
