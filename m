Received: from eggs.gnu.org ([209.51.188.92]:45519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjf0q-0006J5-QT
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:49:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjf0n-0006AP-OD
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:49:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjf0k-00065o-NR
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:49:15 -0500
References: <20190115184229.73688-1-emaste@freefall.freebsd.org>
	<CAJ+F1CKEhb0hKSvbwYfjEojqJ9K8Jbtit5oW8CTBmcSHSjVrNg@mail.gmail.com>
	<CAPyFy2C9RDsq21h-b8w+QULzr3H-GSFE80LkkS_g7WHs6BcPdQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6951bda1-61d8-84f6-152a-8a7029227a2f@redhat.com>
Date: Wed, 16 Jan 2019 07:49:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAPyFy2C9RDsq21h-b8w+QULzr3H-GSFE80LkkS_g7WHs6BcPdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Maste <emaste@freebsd.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>

On 2019-01-15 20:14, Ed Maste wrote:
> On Tue, 15 Jan 2019 at 13:59, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
>>
>> Hi
>>
>> On Tue, Jan 15, 2019 at 10:42 PM Ed Maste <emaste@freefall.freebsd.org=
> wrote:
>>>
>>> From: Ed Maste <emaste@freebsd.org>
>>>
>>> Cirrus-CI (https://cirrus-ci.org) is a hosted CI service which suppor=
ts
>>> several platforms, including FreeBSD.  Later on we could build for ot=
her
>>> hosts in Cirrus-CI, but I'm starting with only FreeBSD as it is not
>>> supported by other CI services.
>>
>> Although I have never tested it, gitlab CI supports FreeBSD, macosx, w=
indows...
>=20
> I haven't looked into it in great detail. As far as I can tell it
> supports running tests on a provided FreeBSD instance via
> gitlab-runner, and is not a fully hosted CI service like Cirrus-CI,
> Travis, etc.

I'm using gitlab CI for my own tests before I send PULL requests, and as
far as I understood the system, you only get a hosted Ubuntu- or
Debian-based hosted CI on gitlab.com, see e.g.:

 https://gitlab.com/huth/qemu/pipelines/43295916

For other environments, you've got to provide your own infrastructure
with the appropriate runner scripts.

So yes, I think supporting Cirrus-CI makes sense indeed if we get
FreeBSD coverage this way.

 Thomas
