Received: from eggs.gnu.org ([209.51.188.92]:40275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h29k3-0005ws-GG
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h29k2-0004YM-Rk
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:16:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h29k2-0004Xa-If
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:16:26 -0500
References: <1551695576-13205-1-git-send-email-thuth@redhat.com>
	<a0b53ff0-1ded-2a6e-aa4d-b1f4fcc407c1@redhat.com>
	<b15343fd-7a0f-4fae-01c3-24b558c349d7@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6fe67e61-b9a1-b2ef-28e2-534730c5d093@redhat.com>
Date: Fri, 8 Mar 2019 08:16:17 +0100
MIME-Version: 1.0
In-Reply-To: <b15343fd-7a0f-4fae-01c3-24b558c349d7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cirrus.yml: Add macOS continuous
 integration task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 07/03/2019 22.10, Paolo Bonzini wrote:
> On 04/03/19 12:08, Philippe Mathieu-Daud=C3=A9 wrote:
>> +macos_task:
>> +  osx_instance:
>> +    image: high-sierra-base
>> +  env:
>> +    CIRRUS_CLONE_DEPTH: 1
>> +  install_script:
>> +    - brew install pkg-config glib pixman make sdl2
>=20
> Could you also install Python 3 ("python" in Homebrew is 3.7) and avoid
> Apple's obsolete /usr/bin/python (also needs something like
> --python=3D/usr/local/bin/python3 in ./configure below).

Yes, can do.

 Thomas
