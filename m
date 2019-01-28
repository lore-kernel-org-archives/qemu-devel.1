Received: from eggs.gnu.org ([209.51.188.92]:55498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1go4hV-0001rV-J7
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1go4hP-0003Eb-Bv
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:03:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1go4hP-0003Dt-4F
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:03:31 -0500
References: <20190125192719.15339-1-philmd@redhat.com>
	<20190125192719.15339-3-philmd@redhat.com> <874l9tnmev.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8f1c2854-fb0a-b8cd-14aa-1b30924f11bf@redhat.com>
Date: Mon, 28 Jan 2019 12:03:12 +0100
MIME-Version: 1.0
In-Reply-To: <874l9tnmev.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] XXX oslib-posix: Ignore
 fcntl("/dev/null", F_SETFL, O_NONBLOCK) failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Kamil Rytarowski <kamil@netbsd.org>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@163.com>

On 28/01/19 10:47, Alex Benn=C3=A9e wrote:
>>
>> [1] The fix seems https://github.com/openbsd/src/commit/c2a35b387f9d3c
>>   "fcntl(F_SETFL) invokes the FIONBIO and FIOASYNC ioctls internally, =
so
>>   the memory devices (/dev/null, /dev/zero, etc) need to permit them."
> I assume set_nonblock is called on more than just these special devices=
?
> Is there anyway to check this on OpenBSD or is it just an anonymous fd
> at this point?
>=20

Perhaps on OpenBSD we should just assert that we don't get EBADF?

Paolo
