Received: from eggs.gnu.org ([2001:4830:134:3::10]:50983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJBO-0003L9-8n
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJBN-0001jM-31
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:40:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gVJBM-0001hG-PZ
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:40:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2CF6B307D981
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 16:40:52 +0000 (UTC)
References: <20181207151636.8123-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b9998045-614b-fb45-2369-e48f77d29ad4@redhat.com>
Date: Fri, 7 Dec 2018 10:40:50 -0600
MIME-Version: 1.0
In-Reply-To: <20181207151636.8123-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add license files for GPLv2+ and
 CC-BY-SA-4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 12/7/18 9:16 AM, Daniel P. Berrang=C3=A9 wrote:
> The intent is that from this point onwards, content for this repository
> is dual-licensed under the GPLv2+ and CC-BY-SA-4.0
>=20
> With git HEAD at d06ee0a788da27a2f24ab46928bc03eea019fb44, we have
> authors:
>=20
>    $ git log | grep Author | sed -e 's/Author: //' | sort | uniq -c

You're reinventing:
$ git shortlog -e -s

>        1 Alex Benn=C3=A9e <alex.bennee@linaro.org>
>        2 Daniel P. Berrange <berrange@redhat.com>
>        3 Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Looks like a separate patch introducing .mailmap is in order :)

>        3 Eric Blake <eblake@redhat.com>
>        1 Fam Zheng <famz@redhat.com>
>        2 Jeff Cody <jcody@redhat.com>
>       50 Michael Roth <mdroth@linux.vnet.ibm.com>
>       47 Paolo Bonzini <pbonzini@redhat.com>
>        1 Rainer M=C3=BCller <raimue@macports.org>
>        1 Stefan Hajnoczi <stefanha@gmail.com>
>       14 Thomas Huth <thuth@redhat.com>
>        1 Yu Ning <yu.ning@intel.com>
>=20
> This patch constitutes approval for all Red Hat copyright content (all
> @redhat.com addrs & Stefan Hajnoczi) to be placed under these licenses.
> For non-Red Hat copyright holders approval was given on the
> qemu-devel@nongnu.org mailing list with the following Message-IDs:
>=20
>   - Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
>     <CAHDbmO2Gt+5RWaJ8Ka3LpB8o4Anq+evtKDO1oc6+X8gF7LZsOw@mail.gmail.com=
>
>=20
>   - Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
>     <154411651930.28165.5754119001430373065@sif>
>=20
>   - Rainer M=C3=BCller <raimue@macports.org>
>=20
>     <a6ad246f-b674-56d9-8c82-bb80880932a8@macports.org>
>=20
>   - Yu Ning <yu.ning@intel.com>
>=20
>     <C29659EAAA3E0143B583467412621C605E3E6CFF@SHSMSX101.ccr.corp.intel.=
com>
>=20
> Note core basic site template/layout design is derived from a pre-built
> template already under the CC-by-3.0 license, and will not change.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

> +++ b/_includes/copyright.html
> @@ -1,8 +1,7 @@
>   <div id=3D"copyright">
>   	<div id=3D"copyright-inner">
> -	<div class=3D"container">
> -		Design: <a href=3D"http://templated.co">TEMPLATED</a> &mdash;
> -		available under CC-BY 3.0
> -	</div>
> +	  <div class=3D"container">
> +	    This site is made available under the terms of <a href=3D"/licens=
e">a number of licenses</a>.

Does Jekyll auto-create a /license file from the various LICENSE-*=20
additions, or did you forget to 'git add' yet another file?  I'm=20
assuming that this _includes/copyright.html is merely a footer appended=20
on each page.

Is it worth being specific that the TEMPLATED portion is still=20
CC-BY-3.0, while all other contributions are dual-licensed=20
GPLv2+/CC-BY-SA-4.0?  Or, if we don't want that much details in the=20
footer, should README at least mention the distinctions?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
