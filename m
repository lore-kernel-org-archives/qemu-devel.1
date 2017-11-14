Received: from eggs.gnu.org ([2001:4830:134:3::10]:35603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEbNY-0003WC-Tw
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEbNW-00083I-Af
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:35:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eEbNW-000822-4t
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:35:50 -0500
References: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
	<20171114081750.27640.53609.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf3d0f53-5b95-0432-8401-cf09d15e0b32@redhat.com>
Date: Tue, 14 Nov 2017 14:35:38 +0100
MIME-Version: 1.0
In-Reply-To: <20171114081750.27640.53609.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 14/26] replay/replay.c: bump
 REPLAY_VERSION again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

On 14/11/2017 09:17, Pavel Dovgalyuk wrote:
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> This time commit 802f045a5f61b781df55e4492d896b4d20503ba7 broke the
> replay file format. Also add a comment about this to
> replay-internal.h.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>=20
> ---
>  replay/replay-internal.h |    2 +-
>  replay/replay.c          |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/replay/replay-internal.h b/replay/replay-internal.h
> index be96d7e..8e4c701 100644
> --- a/replay/replay-internal.h
> +++ b/replay/replay-internal.h
> @@ -12,7 +12,7 @@
>   *
>   */
> =20
> -
> +/* Any changes to order/number of events will need to bump REPLAY_VERS=
ION */
>  enum ReplayEvents {
>      /* for instruction event */
>      EVENT_INSTRUCTION,
> diff --git a/replay/replay.c b/replay/replay.c
> index ff58a5a..4f24498 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -22,7 +22,7 @@
> =20
>  /* Current version of the replay mechanism.
>     Increase it when file format changes. */
> -#define REPLAY_VERSION              0xe02006
> +#define REPLAY_VERSION              0xe02007
>  /* Size of replay log header */
>  #define HEADER_SIZE                 (sizeof(uint32_t) + sizeof(uint64_=
t))
> =20
>=20

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
