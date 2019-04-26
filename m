Received: from eggs.gnu.org ([209.51.188.92]:39420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hK3x3-0001XR-Q7
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hK3x2-0004on-Mw
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:43:53 -0400
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-5-thuth@redhat.com>
	<f9dc291b-7ba2-c6b8-33aa-c8fa3c6d4950@redhat.com>
	<0300c8cc-d73c-b919-13f7-59f3218a609f@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <13ecf357-d43c-ecc6-012e-bed62008677d@redhat.com>
Date: Fri, 26 Apr 2019 18:43:36 +0200
MIME-Version: 1.0
In-Reply-To: <0300c8cc-d73c-b919-13f7-59f3218a609f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/6] cirrus / travis: Add gnu-sed and bash
 for macOS and FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

(+Dan)

On 04/25/19 08:00, Thomas Huth wrote:
> On 24/04/2019 23.29, Wainer dos Santos Moschetta wrote:
>> Hello Thomas,
>>
>> On 04/24/2019 07:37 AM, Thomas Huth wrote:
>>> We are going to enable the qemu-iotests during "make check" again,
>>> and for running the iotests, we need bash and gnu-sed.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>> =C2=A0 .cirrus.yml | 4 ++--
>>> =C2=A0 .travis.yml | 1 +
>>> =C2=A0 2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> It needs to get the Freebsd image [1] updated too, in order to `make
>> BUILD_TARGET=3Dcheck vm-build-freebsd` passes. Here it failed with:
>> ---
>> env: bash: No such file or directory
>> gmake: *** [/var/tmp/qemu-test.6OlDFH/tests/Makefile.include:1101:
>> check-tests/qemu-iotests-quick.sh] Error 1
>> gmake: *** Waiting for unfinished jobs....
>> ---
>>
>> I'm not sure about the netbsd and openbsd images, they might need bash
>> and gnu-sed as well.
>=20
> D'oh! Does anybody know what are the correct steps to update these imag=
es?

(1) make the OPENBSD subsystem maintainer care

(2) update <https://wiki.qemu.org/Hosts/BSD>

(3) download the image from download.patchew.org, boot it and update it

(4) upload the image to download.patchew.org

(5) update the "tests/vm/openbsd" script in the QEMU tree in sync
(checksums, commands etc)


I'm fairly sure (1) is necessary; the rest is more or less guesswork on
my part.

Thanks
Laszlo
