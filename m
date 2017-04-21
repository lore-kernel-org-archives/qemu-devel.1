Received: from eggs.gnu.org ([2001:4830:134:3::10]:51184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1d1e2e-0000Hk-Kd
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 15:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1d1e2d-0003RY-KT
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 15:16:28 -0400
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:34715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1d1e2d-0003RI-Fs
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 15:16:27 -0400
Received: by mail-yw0-x244.google.com with SMTP id u70so9153379ywe.1
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 12:16:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161229100420.i66zeaxc4qbp3p3p@hawk.localdomain>
References: <20161229080217.16446.50840.malonedeb@wampee.canonical.com>
	<20161229100420.i66zeaxc4qbp3p3p@hawk.localdomain>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Fri, 21 Apr 2017 15:15:56 -0400
Message-ID: <CAJhHMCD4W39=7FR-uJBt1SpOR6UJCLwGgp4DPMDZ9AeJNRxDFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1653063] [NEW] qemu-system-arm hangs with
 -icount and -nodefaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Hansni Bu <1653063@bugs.launchpad.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

On Thu, Dec 29, 2016 at 5:04 AM, Andrew Jones <drjones@redhat.com> wrote:
> On Thu, Dec 29, 2016 at 08:02:16AM -0000, Hansni Bu wrote:
>> Public bug reported:
> ...
>> https://bugs.launchpad.net/bugs/1653063
> ...
>>   After console prints the message below:
>>   "Uncompressing Linux..................................................=
........................ done, booting the kernel."
>>   there's no further action noticed.
>>
>>   If "-icount" is not set, namely run as:
>>   qemu-system-arm -M integratorcp -kernel arm-test/zImage.integrator -in=
itrd arm-test/arm_root.img -nographic -nodefaults -chardev stdio,mux=3Don,i=
d=3Dchar0 -serial chardev:char0 --append "console=3DttyAMA0"
>>
>>   or if "-nodefaults" is not set, namely run as:
>>   qemu-system-arm -M integratorcp -kernel arm-test/zImage.integrator -in=
itrd arm-test/arm_root.img -nographic -icount 1 --append "console=3DttyAMA0=
"
>>
>>   The Linux boot procedure can finish successfully.
>
> Hi Hansni,
>
> The fact things work when you remove -nodefaults is a sign that with it
> your single cpu may just not be getting scheduled again. Does the patch
> from Alex Benn=C3=A9e here[*] help?
>
> [*] https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg01743.html
>

This bug is still reproducible with the latest git.

--
Pranith

--=20
Pranith
