Received: from eggs.gnu.org ([2001:4830:134:3::10]:33256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1csNQG-0002zA-Ex
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 01:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1csNQD-0004wv-91
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 01:42:32 -0400
Received: from mail.ispras.ru ([83.149.199.45]:50042)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1csNQD-0004wm-0d
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 01:42:29 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170324152607.6604-1-alex.bennee@linaro.org>
In-Reply-To: <20170324152607.6604-1-alex.bennee@linaro.org>
Date: Mon, 27 Mar 2017 08:42:28 +0300
Message-ID: <004901d2a6bc$ebbf9730$c33ec590$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH-for-2.9] replay/replay.c: bump
 REPLAY_VERSION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, pavel.dovgaluk@ispras.ru
Cc: qemu-devel@nongnu.org

Reviewed-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>


> -----Original Message-----
> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Sent: Friday, March 24, 2017 6:26 PM
> To: pavel.dovgaluk@ispras.ru
> Cc: qemu-devel@nongnu.org; Alex Benn=C3=A9e
> Subject: [PATCH-for-2.9] replay/replay.c: bump REPLAY_VERSION
>=20
> A previous commit (3d4d16f4) added support for audio record/playback.
> However this breaks the logfile ABI due to the re-ordering of the
> ReplayEvents enum. The REPLAY_VERSION check is meant to prevent you
> from using old log files in newer QEMUs but this is currently broken.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  replay/replay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/replay/replay.c b/replay/replay.c
> index 78e2a7e570..9e0724e756 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -22,7 +22,7 @@
>=20
>  /* Current version of the replay mechanism.
>     Increase it when file format changes. */
> -#define REPLAY_VERSION              0xe02005
> +#define REPLAY_VERSION              0xe02006
>  /* Size of replay log header */
>  #define HEADER_SIZE                 (sizeof(uint32_t) + =
sizeof(uint64_t))
>=20
> --
> 2.11.0
