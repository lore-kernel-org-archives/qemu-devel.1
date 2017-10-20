Received: from eggs.gnu.org ([2001:4830:134:3::10]:34517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e5cev-0001Ci-PH
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e5cer-0003nb-OP
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:08:41 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:40064
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1e5cer-0003nD-DR
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:08:37 -0400
References: <1508443483-5429-1-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA-R-3F8US1RGJVNyVnC81z9+1dd3Liq0tmVSNz1eDszbA@mail.gmail.com>
	<3d46d0f4463f337593b7347812f2de7e@codeaurora.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <ae32fdee-2233-a99a-1fc9-0da58cf4d846@weilnetz.de>
Date: Fri, 20 Oct 2017 21:08:35 +0200
MIME-Version: 1.0
In-Reply-To: <3d46d0f4463f337593b7347812f2de7e@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] build: Don't force preserving permissions
 on config-devices.mak.old
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alindsay@codeaurora.org, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paul Brook <paul@codesourcery.com>

Am 20.10.2017 um 20:24 schrieb alindsay@codeaurora.org:
> On 2017-10-20 05:27, Peter Maydell wrote:
>> On 19 October 2017 at 21:04, Aaron Lindsay <alindsay@codeaurora.org>
>> wrote:
>>> I get the following error when building on an NFSv3 filesystem:
>>>
>>> % make -j8
>>> =C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/config-devices.mak=
.tmp
>>> =C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0 config-host.h
>>> [snip]
>>> =C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0 qmp-marshal.c
>>> =C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/config-devices.mak
>>> cp: preserving permissions for
>>> =E2=80=98aarch64-softmmu/config-devices.mak.old=E2=80=99: Operation n=
ot supported
>>> make: *** Deleting file `aarch64-softmmu/config-devices.mak'
>>> =C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0 qapi-types.c
>>> [snip]
>>> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scsi/qemu-pr-helper.o
>>> make: *** No rule to make target `config-all-devices.mak', needed by
>>> `subdir-aarch64-softmmu'.=C2=A0 Stop.
>>> make: *** Waiting for unfinished jobs....
>>>
>>> Ideally you would only build on a filesystem with proper support, but
>>> I haven't
>>> been able to find a reason why preserving exact permissions is
>>> important in
>>> this case.
>>
>> Do we even need this code at all? As far as I can tell from
>> the git logs, the idea is to support users who hand-modify
>> config-devices.mak. But do we want to support that? I would
>> think of config-devices.mak as an internal part of the build
>> machinery, and the bit you can edit as a user is the stuff
>> in default-configs/.

It's a long time since I wrote that code, but when I look at
the commit message for my commit 012f0879234, it was written
for users who do _not_ hand-modify config-devices.mak. They
had a problem when they updated the code from git and the
new version had changed some of the device configurations
which were used to build config-devices.mak.

So maybe that code is still needed because device configurations
change sometimes.

Regards,
Stefan


> I haven't ever found a reason to modify config-devices.mak and
> just assumed others had. Its existence doesn't bother me, but I
> can also see the argument to simplify if it's unused. Would you
> prefer I resubmit a patch removing it instead?
>=20
> -Aaron
>=20
