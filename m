Received: from eggs.gnu.org ([2001:4830:134:3::10]:34686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fBm3K-0007yi-Lz
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fBm3J-00005V-Pq
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:55:34 -0400
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:45351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fBm3J-000058-Kx
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:55:33 -0400
Received: by mail-yw0-x243.google.com with SMTP id g9-v6so7912589ywb.12
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 11:55:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2f69532c-8651-ef67-0910-1fad91808608@redhat.com>
References: <20180425153343.24023-1-alex.bennee@linaro.org>
	<cb41b3a5-0e3b-f30b-a02c-1cc333d38ab1@redhat.com>
	<87604ekl0c.fsf@linaro.org>
	<2f69532c-8651-ef67-0910-1fad91808608@redhat.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 26 Apr 2018 11:55:32 -0700
Message-ID: <CAMo8BfKJwZOCaQrSCnFMVNy=L8Z0yo7sAw3q5Sfaof-ko_+NjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] hw/core: expand description of
 null-machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, Apr 26, 2018 at 11:18 AM, Thomas Huth <thuth@redhat.com> wrote:
> On 26.04.2018 18:09, Alex Benn=C3=A9e wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>> Actually, with certain CPUs, you can really use the "none" machine as a
>>> pure instruction set testing system. For example, on m68k, there used t=
o
>>> be an explicit "dummy" machine for this job, and we removed it in favou=
r
>>> of the "none" machine:
>>>
>>> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D22f2dbe7eaf3e12e3=
8c9c210
>>
>> Ahh OK. Do you know what other CPUs can be used in this way?
>
> I think it should be possible with at least all the boards that have a
> "sim" machine, e.g. xtensa, mips, moxie and openrisc.

xtensa sim machine is a bit more than just instruction simulator:
it instantiates CPU-configuration-specific local memories. It is meant
to be compatible with Xtensa ISS from Xtensa development tools.

--=20
Thanks.
-- Max
