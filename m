Received: from eggs.gnu.org ([2001:4830:134:3::10]:37488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@pond.sub.org>) id 1fToAy-0000kO-2Y
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@pond.sub.org>) id 1fToAt-0006TE-7M
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:50:00 -0400
Received: from oxygen.pond.sub.org ([144.76.244.19]:35520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@pond.sub.org>) id 1fToAt-0006SU-13
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:49:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180615014249.22730-1-peterx@redhat.com>
	<20180615014249.22730-2-peterx@redhat.com>
Date: Fri, 15 Jun 2018 14:49:52 +0200
Message-ID: <87efh81afj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/6] chardev: comment details for CLOSED
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Auger <eric.auger@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Dr
	. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?M?= =?utf-8?Q?arc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> It was unclear before on what does the CLOSED event mean.  Meanwhile we
> add a TODO to fix up the CLOSED event in the future when the in/out
> ports are different for a chardev.
>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/chardev/char.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 04de45795e..6f0576e214 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -22,7 +22,16 @@ typedef enum {
>      CHR_EVENT_OPENED, /* new connection established */
>      CHR_EVENT_MUX_IN, /* mux-focus was set to this terminal */
>      CHR_EVENT_MUX_OUT, /* mux-focus will move on */
> -    CHR_EVENT_CLOSED /* connection closed */
> +    CHR_EVENT_CLOSED /* connection closed.  NOTE: currently this event
> +                      * is only bound to the read port of the chardev.
> +                      * Normally the read port and write port of a
> +                      * chardev should be the same, but it can be
> +                      * different, e.g., for fd chardevs, when the two
> +                      * fds are different.  So when we received the
> +                      * CLOSED event it's still possible that the out
> +                      * port is still open.  TODO: we should only send
> +                      * the CLOSED event when both ports are closed.
> +                      */
>  } QEMUChrEvent;
>=20=20
>  #define CHR_READ_BUF_LEN 4096

Undefined terms "read port" and "write port".  But the header is full of
undefined terms, like "front end", "back end", "data channel", "chardev
peer", ...  It could use a file comment to tie things together.  Clearly
out of scope for this series.
