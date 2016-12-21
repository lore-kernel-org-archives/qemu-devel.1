Received: from eggs.gnu.org ([2001:4830:134:3::10]:38507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cJdu1-0005As-Bb
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 05:13:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cJdtv-0001T1-EL
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 05:13:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cJdtv-0001Sg-89
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 05:13:35 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9160F44F0
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 10:13:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20161206141343.28044-1-marcandre.lureau@redhat.com>
	<20161206141343.28044-4-marcandre.lureau@redhat.com>
Date: Wed, 21 Dec 2016 11:13:30 +0100
In-Reply-To: <20161206141343.28044-4-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 6 Dec 2016 17:13:29 +0300")
Message-ID: <871sx1k2t1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 03/17] qga/schema: improve
 guest-set-vcpus Returns: section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Itemize the possible return values of guest-set-vcpus.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/qapi-schema.json | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 94c03128fd..ad63737fce 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -697,21 +697,21 @@
>  # Returns: The length of the initial sublist that has been successfully
>  #          processed. The guest agent maximizes this value. Possible cas=
es:
>  #
> -#          0:                if the @vcpus list was empty on input. Gues=
t state
> +#          - 0:              if the @vcpus list was empty on input. Gues=
t state
>  #                            has not been changed. Otherwise,
>  #
> -#          Error:            processing the first node of @vcpus failed =
for the
> +#          - Error:          processing the first node of @vcpus failed =
for the
>  #                            reason returned. Guest state has not been c=
hanged.
>  #                            Otherwise,
>  #
> -#          < length(@vcpus): more than zero initial nodes have been proc=
essed,
> +#          - < length(@vcpus): more than zero initial nodes have been pr=
ocessed,
>  #                            but not the entire @vcpus list. Guest state=
 has
>  #                            changed accordingly. To retrieve the error
>  #                            (assuming it persists), repeat the call wit=
h the
>  #                            successfully processed initial sublist remo=
ved.
>  #                            Otherwise,
>  #
> -#          length(@vcpus):   call successful.
> +#          - length(@vcpus): call successful.
>  #
>  # Since: 1.5
>  ##

I'm fine with this as is, therefore
Reviewed-by: Markus Armbruster <armbru@redhat.com>

But do feel free to drop the blank lines for consistency with itemized
lists elsewhere.
