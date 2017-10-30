Received: from eggs.gnu.org ([2001:4830:134:3::10]:40750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e954q-0008L3-3B
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 04:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e954l-0004rF-5C
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 04:05:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e954k-0004qR-UD
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 04:05:39 -0400
References: <20171030030553.21259-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8051c92f-3e4d-c5b7-7fc3-3ee0816084a1@redhat.com>
Date: Mon, 30 Oct 2017 09:05:33 +0100
MIME-Version: 1.0
In-Reply-To: <20171030030553.21259-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] build fixes for --disable-tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org

On 30.10.2017 04:05, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> This series add missing stubs (as suggested by Eduardo in [1]) to build
> the i386/s390x targets with --disable-tcg (the only targets building wi=
thout
> TCG so far).

Compiling with --disable-tcg works fine for me with the latest master
branch as of today, on both x86 and s390x. Are you sure that these
patches are still required?

 Thomas
