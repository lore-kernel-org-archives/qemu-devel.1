Received: from eggs.gnu.org ([2001:4830:134:3::10]:53830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1frh2g-0005ng-Qt
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1frgvt-0002e4-7g
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:57:14 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180818025653.21192-1-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri,
	17 Aug 2018 23:56:53 -0300")
References: <20180818025653.21192-1-f4bug@amsat.org>
Reply-To: quintela@redhat.com
Date: Mon, 20 Aug 2018 11:57:01 +0200
Message-ID: <87lg91e4ya.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> Fedora 29 comes with GCC 8.1 which added the 'stringop-truncation' checks.
>
> Replace the strncpy() calls by g_strlcpy() to avoid the following warning:
>
>   migration/global_state.c: In function 'global_state_store_running':
>   migration/global_state.c:45:5: error: 'strncpy' specified bound 100 equ=
als destination size [-Werror=3Dstringop-truncation]
>        strncpy((char *)global_state.runstate,
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>               state, sizeof(global_state.runstate));
>               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>

will be in next pull, thanks.

> ---
> See http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg03723.html
>
>  migration/global_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
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
