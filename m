Received: from eggs.gnu.org ([2001:4830:134:3::10]:57596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gZKq8-0003v8-I4
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gZKfa-0005nt-0e
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:04:45 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gZKfZ-0005i6-Qn
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:04:41 -0500
Received: by mail-qt1-f196.google.com with SMTP id t33so16695931qtt.4
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 11:04:40 -0800 (PST)
MIME-Version: 1.0
References: <20181218182234.28876-1-armbru@redhat.com>
	<20181218182234.28876-2-armbru@redhat.com>
In-Reply-To: <20181218182234.28876-2-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Dec 2018 23:04:28 +0400
Message-ID: <CAMxuvazx+va_pyKOirYzvSZZHaNn2NnGcP4n04U-XH4S6Rf2jA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 01/15] qapi: Belatedly update docs
 for commit 9c2f56e9f9d
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Armbruster, Markus" <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Tue, Dec 18, 2018 at 10:22 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  docs/devel/qapi-code-gen.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index 43bd853e69..418a607842 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -1369,8 +1369,8 @@ Example:
>      void qapi_event_send_my_event(void);
>
>      typedef enum example_QAPIEvent {
> -        EXAMPLE_QAPI_EVENT_MY_EVENT =3D 0,
> -        EXAMPLE_QAPI_EVENT__MAX =3D 1,
> +        EXAMPLE_QAPI_EVENT_MY_EVENT,
> +        EXAMPLE_QAPI_EVENT__MAX,
>      } example_QAPIEvent;
>
>      #define example_QAPIEvent_str(val) \
> --
> 2.17.2
>
