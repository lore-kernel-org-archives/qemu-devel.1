Received: from eggs.gnu.org ([2001:4830:134:3::10]:35922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermzu-0000M8-1G
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:53:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermzr-0001WO-0B
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:53:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55678 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ermzq-0001WJ-Rc
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:53:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C4AF4023112
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 15:53:22 +0000 (UTC)
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-4-peterx@redhat.com>
	<2c8bac11-9f90-f79b-7b08-77f94a196c3a@redhat.com>
	<20180302154424.GG26972@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d991abc-a37e-8e6f-68fc-6e3bd52bd98a@redhat.com>
Date: Fri, 2 Mar 2018 16:53:19 +0100
MIME-Version: 1.0
In-Reply-To: <20180302154424.GG26972@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/15] qio: introduce
 qio_channel_add_watch_{full|source}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 02/03/2018 16:44, Daniel P. Berrang=C3=A9 wrote:
>> Just a small thing, this is a bit inconsistent with the rest of the
>> GSource API, where the g_source_attach is usually left to the caller
>> when a function returns GSource *.
> The APIs which return a GSource in glib typically don't even set the
> callback function - we already cover that scenario with the
> qio_channel_create_watch APIs.
>=20
> GLib doesn't typically have APIs which return a GSource after the
> mix of creating the watch, setting callback & attaching to context.

True, on the other hand it's annoying for qio_channel_create_watch
because of the function pointer case.  So I suggested a mix of creating
the watch and setting the callback.

Having a function that takes a GMainContext and returns a tag is fine, to=
o.

Paolo

> They all just return the watch ID value.
>=20
> So I think this proposal is ok as it is as there's no real precedence.
>=20
> Alternatively we could simply do without this API entirely. It is
> trivial enough for the code that needs a GSource to get iuse the
> normal qio_channel_add_watch|watch_full APIs, and then lookup the
> GSource themselves - only one extra line of code in the callers.
