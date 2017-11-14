Received: from eggs.gnu.org ([2001:4830:134:3::10]:41691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEgeU-0006CE-HD
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 14:13:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEgeQ-0008VU-Ft
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 14:13:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1eEgeQ-0008VG-9b
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 14:13:38 -0500
References: <e1e3a1d3-da53-e46a-ce9b-7d1707e3a493@linux.intel.com>
	<81495d39-0026-dba2-10b9-86d7df5babd3@tuxfamily.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <4a983bfc-442c-c55f-e3eb-9cb58a0d9ba8@redhat.com>
Date: Tue, 14 Nov 2017 14:13:36 -0500
MIME-Version: 1.0
In-Reply-To: <81495d39-0026-dba2-10b9-86d7df5babd3@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] HAXM is now open source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>, Yu Ning <yu.ning@linux.intel.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Vincent Palatin <vpalatin@chromium.org>



On 11/14/2017 06:09 AM, Thomas Huth wrote:
> On 14.11.2017 09:54, Yu Ning wrote:
>> Hello,
>>
>> As some of you may have noticed, since QEMU 2.9.0, an accelerator know=
n
>> as =E2=80=9Chax=E2=80=9D has been available for Windows and macOS buil=
ds of QEMU, thanks
>> to the hard work of Vincent Palatin and help from this community (Paol=
o
>> Bonzini, Stefan Weil, et al.).
>>
>> The accelerator requires a host kernel module (driver) known as Intel
>> Hardware Accelerated Execution Manager (HAXM), i.e. intelhaxm.sys on
>> Windows or intelhaxm.kext on macOS, similar to how the KVM accelerator
>> depends on kvm.ko on Linux.
>>
>> Today, we released the source code of the HAXM kernel module under the
>> BSD 3-clause license:
>>
>> https://github.com/intel/haxm
>>
>> We look forward to working with the community to improve HAXM (both th=
e
>> kernel module and the accelerator). The code is accompanied by some
>> basic documentation (README.md and API.md), which is incomplete, but
>> hopefully helps people get started. If you have any questions or
>> suggestions, please create an issue or post a comment on GitHub.
>=20
> That's great news! I hope this all will help to promote QEMU on Windows
> and macOS quite a bit!
>=20
> However, during the past months, I noticed a couple of times that users
> ask on IRC or the qemu-discuss mailing list how they could accelerate
> their QEMU on Windows - and they are running only in TCG mode when you
> ask how they start QEMU. So it seems like there is not much knowledge
> about "--accel hax" in the public yet. Maybe you could write a nice blo=
g
> post for the QEMU blog or something similar that explains how to use
> HAXM with QEMU on Windows for the normal users? Or maybe make it more
> prominent in the QEMU wiki? (e.g. the main page only mentions KVM and
> Xen, but not HAXM)
>=20
>  Thomas
>=20

A blog post advertising this new development would be an absolute
miracle for linking to people who are just getting started with QEMU on
Windows.

(It would also be really good for idiots like me, who do not use Windows
for anything other than playing video games and sometimes forget that it
is capable of doing other things.)

--js
