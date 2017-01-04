Received: from eggs.gnu.org ([2001:4830:134:3::10]:39094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cOppU-0007e7-4P
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cOppT-0001MB-8f
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:58:28 -0500
MIME-Version: 1.0
References: <20170104145210.31608-1-pbonzini@redhat.com>
In-Reply-To: <20170104145210.31608-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 04 Jan 2017 17:58:15 +0000
Message-ID: <CAJ+F1C+CUdR6tAC09iw4xGZY1xM_TB8x8MAS9bPyJd6YBwKmPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qga: fix erroneous argument to strerror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On Wed, Jan 4, 2017 at 3:54 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> process_command returns a negative value in case of error.  Make this
> clear in the "if" statement and fix the strerror argument to flip it
> to positive.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


---
>  qga/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index 6caf215..538e4ee 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -558,8 +558,8 @@ static void process_command(GAState *s, QDict *req)
>      rsp =3D qmp_dispatch(QOBJECT(req));
>      if (rsp) {
>          ret =3D send_response(s, rsp);
> -        if (ret) {
> -            g_warning("error sending response: %s", strerror(ret));
> +        if (ret < 0) {
> +            g_warning("error sending response: %s", strerror(-ret));
>          }
>          qobject_decref(rsp);
>      }
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
