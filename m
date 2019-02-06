Received: from eggs.gnu.org ([209.51.188.92]:46939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grRnZ-0006KX-Cv
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grRnX-00035L-GU
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:19:49 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1grRnX-00033n-9Y
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:19:47 -0500
Received: by mail-wr1-x443.google.com with SMTP id z18so7939544wrh.2
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 10:19:43 -0800 (PST)
MIME-Version: 1.0
References: <20190206181725.14337-1-armbru@redhat.com>
	<20190206181725.14337-3-armbru@redhat.com>
In-Reply-To: <20190206181725.14337-3-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Feb 2019 19:19:29 +0100
Message-ID: <CAJ+F1CJ6xG7V3xfQ3DABRNEaGYFtGozfZ0NA8D_h+SUU57uTkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 02/17] qapi: Fix up documentation for
 recent commit a95291007b2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Wed, Feb 6, 2019 at 7:18 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  docs/devel/qapi-code-gen.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index b91bde647c..c9ba8ddb2e 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -1410,6 +1410,8 @@ Example:
>
>      extern const QEnumLookup example_QAPIEvent_lookup;
>
> +    void example_qapi_event_emit(example_QAPIEvent event, QDict *qdict);
> +
>      #endif /* EXAMPLE_QAPI_EVENTS_H */
>      $ cat qapi-generated/example-qapi-events.c
>  [Uninteresting stuff omitted...]
> --
> 2.17.2
>
>


--=20
Marc-Andr=C3=A9 Lureau
