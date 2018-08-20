Received: from eggs.gnu.org ([2001:4830:134:3::10]:42695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1frjVp-0006Oo-TO
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1frjVm-0006jk-FR
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:42:25 -0400
References: <20180818025653.21192-1-f4bug@amsat.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <63f44c17-2804-0cc9-c3df-f3e738c3a670@redhat.com>
Date: Mon, 20 Aug 2018 14:42:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180818025653.21192-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: Replace strncpy() by g_strlcpy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 18.08.2018 04:56, Philippe Mathieu-Daud=C3=A9 wrote:
> Fedora 29 comes with GCC 8.1 which added the 'stringop-truncation' chec=
ks.
>=20
> Replace the strncpy() calls by g_strlcpy() to avoid the following warni=
ng:
>=20
>   migration/global_state.c: In function 'global_state_store_running':
>   migration/global_state.c:45:5: error: 'strncpy' specified bound 100 e=
quals destination size [-Werror=3Dstringop-truncation]
>        strncpy((char *)global_state.runstate,
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>               state, sizeof(global_state.runstate));
>               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> See http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg03723.ht=
ml
>=20
>  migration/global_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 8e8ab5c51e..d5df502cd5 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -42,7 +42,7 @@ int global_state_store(void)
>  void global_state_store_running(void)
>  {
>      const char *state =3D RunState_str(RUN_STATE_RUNNING);
> -    strncpy((char *)global_state.runstate,
> +    g_strlcpy((char *)global_state.runstate,
>             state, sizeof(global_state.runstate));
>  }
> =20
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb
