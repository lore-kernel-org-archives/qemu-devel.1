Received: from eggs.gnu.org ([209.51.188.92]:44966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqrN3-00030e-6O
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqrN2-0003GX-IE
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:26:01 -0500
References: <20190204204517.23698-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <db084f78-35f8-cc5f-4bf6-ffdcdce326bc@redhat.com>
Date: Tue, 5 Feb 2019 04:25:50 +0100
MIME-Version: 1.0
In-Reply-To: <20190204204517.23698-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/input/tsc210x: Fix building with no
 verbosity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

On 2019-02-04 21:45, Philippe Mathieu-Daud=C3=A9 wrote:
> When building with TSC_VERBOSE not defined, we get:
>       CC      arm-softmmu/hw/input/tsc210x.o
>     hw/input/tsc210x.c: In function =E2=80=98tsc2102_data_register_writ=
e=E2=80=99:
>     hw/input/tsc210x.c:554:5: error: label at end of compound statement
>          default:
>          ^~~~~~~
>     hw/input/tsc210x.c: In function =E2=80=98tsc2102_control_register_w=
rite=E2=80=99:
>     hw/input/tsc210x.c:638:5: error: label at end of compound statement
>          bad_reg:
>          ^~~~~~~
>     hw/input/tsc210x.c: In function =E2=80=98tsc2102_audio_register_wri=
te=E2=80=99:
>     hw/input/tsc210x.c:766:5: error: label at end of compound statement
>          default:
>          ^~~~~~~
>     make[1]: *** [rules.mak:69: hw/input/tsc210x.o] Error 1
>=20
> Fix this by replacing the culprit fprintf(stderr) calls by a more
> recent API: qemu_log_mask(LOG_GUEST_ERROR). Other fprintf() calls
> are left untouched.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/input/tsc210x.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
