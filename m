Received: from eggs.gnu.org ([2001:4830:134:3::10]:39215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e94ww-0006Zo-5p
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 03:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e94wt-0000vJ-5F
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 03:57:34 -0400
References: <20171030030553.21259-1-f4bug@amsat.org>
	<20171030030553.21259-4-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7d2da182-be14-d690-bd90-836158811b4f@redhat.com>
Date: Mon, 30 Oct 2017 08:57:24 +0100
MIME-Version: 1.0
In-Reply-To: <20171030030553.21259-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/5] target/s390x: tcg stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On 30.10.2017 04:05, Philippe Mathieu-Daud=C3=A9 wrote:
> missing since 55c3ceef61:
>=20
>     LINK    s390x-softmmu/qemu-system-s390x
>   target/s390x/cpu.o: In function `s390_cpu_class_init':
>   target/s390x/cpu.c:500: undefined reference to `s390x_translate_init'
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

This is fixed already by 74d7fc7f6385158b8a5c524c61baaef1b66f3dac
("tcg: Avoid setting tcg_initialize if !CONFIG_TCG"), so please drop
this patch.

 Thomas
