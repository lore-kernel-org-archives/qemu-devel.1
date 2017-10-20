Received: from eggs.gnu.org ([2001:4830:134:3::10]:54443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1e5bxr-0004cI-Rd
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 14:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1e5bxn-0007b0-BM
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 14:24:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alindsay@codeaurora.org>)
	id 1e5bxn-0007Zq-1R
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 14:24:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 20 Oct 2017 14:24:05 -0400
From: alindsay@codeaurora.org
In-Reply-To: <CAFEAcA-R-3F8US1RGJVNyVnC81z9+1dd3Liq0tmVSNz1eDszbA@mail.gmail.com>
References: <1508443483-5429-1-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA-R-3F8US1RGJVNyVnC81z9+1dd3Liq0tmVSNz1eDszbA@mail.gmail.com>
Message-ID: <3d46d0f4463f337593b7347812f2de7e@codeaurora.org>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, Paul Brook <paul@codesourcery.com>

On 2017-10-20 05:27, Peter Maydell wrote:
> On 19 October 2017 at 21:04, Aaron Lindsay <alindsay@codeaurora.org>=20
> wrote:
>> I get the following error when building on an NFSv3 filesystem:
>>=20
>> % make -j8
>>   GEN     aarch64-softmmu/config-devices.mak.tmp
>>   GEN     config-host.h
>> [snip]
>>   GEN     qmp-marshal.c
>>   GEN     aarch64-softmmu/config-devices.mak
>> cp: preserving permissions for=20
>> =E2=80=98aarch64-softmmu/config-devices.mak.old=E2=80=99: Operation no=
t supported
>> make: *** Deleting file `aarch64-softmmu/config-devices.mak'
>>   GEN     qapi-types.c
>> [snip]
>>   CC      scsi/qemu-pr-helper.o
>> make: *** No rule to make target `config-all-devices.mak', needed by=20
>> `subdir-aarch64-softmmu'.  Stop.
>> make: *** Waiting for unfinished jobs....
>>=20
>> Ideally you would only build on a filesystem with proper support, but=20
>> I haven't
>> been able to find a reason why preserving exact permissions is=20
>> important in
>> this case.
>=20
> Do we even need this code at all? As far as I can tell from
> the git logs, the idea is to support users who hand-modify
> config-devices.mak. But do we want to support that? I would
> think of config-devices.mak as an internal part of the build
> machinery, and the bit you can edit as a user is the stuff
> in default-configs/.

I haven't ever found a reason to modify config-devices.mak and
just assumed others had. Its existence doesn't bother me, but I
can also see the argument to simplify if it's unused. Would you
prefer I resubmit a patch removing it instead?

-Aaron

--=20
Qualcomm Datacenter Technologies as an affiliate of Qualcomm=20
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
