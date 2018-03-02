Received: from eggs.gnu.org ([2001:4830:134:3::10]:39739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eriHA-0004xk-Cb
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eriH7-0004ea-AH
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:50:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60912 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eriH7-0004dG-5l
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:50:53 -0500
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-3-marcandre.lureau@redhat.com>
	<080742f0-0f3c-bf8e-83d7-e473417cc172@redhat.com>
	<CAJ+F1CKnX8+wXPzV0wOr54VKLb+A2y6iVkrtOckpmzdqujmk1Q@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <600f47ce-751a-4dcb-fee0-2b05b953e5cb@redhat.com>
Date: Fri, 2 Mar 2018 11:50:45 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKnX8+wXPzV0wOr54VKLb+A2y6iVkrtOckpmzdqujmk1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 2/7] ovmf: link with Tcg2ConfigPei
 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: edk2-devel@lists.01.org, Peter Jones <pjones@redhat.com>, Jiewen Yao <jiewen.yao@intel.com>, QEMU <qemu-devel@nongnu.org>, Javier Martinez Canillas <javierm@redhat.com>

On 03/01/18 15:59, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Feb 23, 2018 at 6:31 PM, Laszlo Ersek <lersek@redhat.com> wrote=
:

>> (6) Now, I realize Tcg2Pei *apparently* depends on
>> gEfiPeiReadOnlyVariable2PpiGuid (i.e., read-only variable access in th=
e
>> PEI phase) as well. That's a bug in the INF file (the [depex] section)=
.
>> If you grep the Tcg2Pei module source for the GUID, the [depex] sectio=
n
>> is the only hit. Can you please submit a separate patch that removes i=
t
>> from the depex?
>=20
> I don't get how you came to that conclusion, both
> SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c and
> SecurityPkg/Tcg/Tcg2Config/TpmDetection.c match. Apparently, the
> variable is used in s3 mode, in DetectTpmDevice().

In my point (6) above, I was  talking about Tcg2Pei, not Tcg2ConfigPei.

If you grep "SecurityPkg/Tcg/Tcg2Pei" for
"gEfiPeiReadOnlyVariable2PpiGuid", the only hit is the depex section in
the INF file.

I think that's a bug in "SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf", and the
PPI GUID should removed from there, as a separate patch.

>>> ---
>>>  OvmfPkg/OvmfPkgX64.dsc | 20 ++++++++++++++++++++
>>>  OvmfPkg/OvmfPkgX64.fdf |  3 +++
>>>  2 files changed, 23 insertions(+)
>>
>> Is there any particular reason to exclude the Ia32 and Ia32X64 builds?
>>
>> If not, then please modify all three sets of dsc/fdf files identically=
.
>=20
> I'd rather keep this as a TODO item for now, since we are not close to
> a final version, and it's annoying to have to fix each files etc..

OK.

Thanks!
Laszlo
