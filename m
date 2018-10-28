Received: from eggs.gnu.org ([2001:4830:134:3::10]:49294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gGmPA-0005da-Hz
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 10:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gGmP8-0005DQ-Uu
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 10:51:04 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:45414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gGmP8-00058m-Nl
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 10:51:02 -0400
Received: by mail-ot1-x335.google.com with SMTP id q25so5228413otn.12
	for <qemu-devel@nongnu.org>; Sun, 28 Oct 2018 07:50:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87d0ruiq27.fsf@dusky.pond.sub.org>
References: <87mur0ls8o.fsf@dusky.pond.sub.org>
	<20181026142216.GB493@redhat.com>
	<87d0ruiq27.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 28 Oct 2018 14:50:37 +0000
Message-ID: <CAFEAcA905T8aYVgWfAvDM7W13rW1tUndQ9WSXSAbzVu3pcOQAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Minutes of KVM Forum BoF on deprecating stuff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christophe de Dinechin <cdupontd@redhat.com>, Pino Toscano <ptoscano@redhat.com>, Laine Stump <laine@redhat.com>, Andrea Bolognani <abologna@redhat.com>

On 28 October 2018 at 05:43, Markus Armbruster <armbru@redhat.com> wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> Something I meant to bring up but forgot is about the classification
>> of devices, especially with a view towards security. It is not directly
>> about deprecation, but it is somewhat related as it is related  to the
>> state of maintainence and quality level
>>
>> We've got alot of devices, but only a subset are written and maintained
>> to a level where we'd consider them robust wrt malcious guests. Other
>> devices are only suitable for friendly guest environments. We should
>> clearly document which are the devices that we consider to provide
>> a secure boundary to guests, so users can make suitably informed choices=
.
>> I'd guess this means all virtio devices, and then few of the emulated
>> devices that are commonly used & maintained in a KVM environment.
>
> A machine whose mandatory devices don't all provide a security boundary
> also doesn't provide one.  Thus, classification of devices leads to a
> classification of machines.

We've generally done it the other way around -- we define the
small set of machines whose security boundary we care about
(ie the ones we can run with KVM), and then classify the
devices accordingly (mandatory in a machine where we care about
the security boundary =3D> we need to care about the security
of the device; pluggable in a machine we care about =3D> care;
mandatory or pluggable in a machine we don't care about the
security of =3D> don't care about the device either).

I think doing it that way fits (a) the way we've defined the
boundary of our security policy as "with KVM" (b) the way
users probably care more about machines rather than the
specifics of which devices they happen to include and (c)
the way there are fewer machines than devices.

thanks
-- PMM
