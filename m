Received: from eggs.gnu.org ([2001:4830:134:3::10]:50535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dYUNo-0004rY-46
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dYUNk-0001RV-7V
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:38:04 -0400
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-3-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <98e1b6a7-7af5-7b8b-23c8-159572c83eb4@redhat.com>
Date: Fri, 21 Jul 2017 11:37:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170720150426.12393-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 02/23] fpu: import SoftFloat3c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net

On 20.07.2017 17:04, Alex Benn=C3=A9e wrote:
> SoftFloat3c is a re-write of the BSD softfloat library which includes
> a number of new features. It has been written with libraries in mind
> and has a new API so hopefully we can use both side-by-side as we
> migrate.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  fpu/softfloat3c/8086-SSE/extF80M_isSignalingNaN.c |   57 +

I'd maybe rather name the folder "softfloat3" instead of "softfloat3c"
... otherwise it does not match anymore if we ever want to update to
version 3d (which is likely just a minor release with some few bug
fixes, so we likely don't want to maintain that in a separate folder)

 Thomas
