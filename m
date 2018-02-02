Received: from eggs.gnu.org ([208.118.235.92]:38374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ehfPF-0001AS-8j
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ehfOB-0003nd-86
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:45:45 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:43116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ehfOA-0003mL-AO
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:44:38 -0500
Received: by mail-ua0-f193.google.com with SMTP id i5so14670281uai.10
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 09:44:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+v8B4STJS6v7ujGfu83oYFG6x9gcbu4D3T5VaDg382kg@mail.gmail.com>
References: <20180131053318.13109-1-famz@redhat.com>
	<CAJ+F1C+v8B4STJS6v7ujGfu83oYFG6x9gcbu4D3T5VaDg382kg@mail.gmail.com>
From: Fam Zheng <famz@redhat.com>
Date: Fri, 2 Feb 2018 14:29:29 +0800
Message-ID: <CAK1Eb9=o5MMrttK1+zG0oUOHd3z=UXLkaZeVomXODUDh1559DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Jan 31, 2018 at 6:06 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> Hi
>
> On Wed, Jan 31, 2018 at 6:33 AM, Fam Zheng <famz@redhat.com> wrote:
>> git-publish [1] is a convenient tool to send patches and has been
>> popular among QEMU developers.  Recently it has been made available in
>> Fedora official repo thanks to Stefan's work.
>>
>> One nice feature of the tool is a per-project configuration with
>> profiles, especially in which the cccmd option is a handy method to
>> create the Cc list.
>>
>> [1]: https://github.com/stefanha/git-publish
>
> It would be worth to update README "Submitting patches" with an example

Good idea. Thanks for reviewing!


>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
>>  .gitpublish | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
>>  1 file changed, 57 insertions(+)
>>  create mode 100644 .gitpublish
>>
>> diff --git a/.gitpublish b/.gitpublish
>> new file mode 100644
>> index 0000000000..2099c1520f
>> --- /dev/null
>> +++ b/.gitpublish
>> @@ -0,0 +1,57 @@
>> +#
>> +# Common git-publish profiles that can be used to send patches to QEMU =
upstream.
>> +#
>> +# See https://github.com/stefanha/git-publish for more information
>> +#
>> +[gitpublishprofile "qemu"]
>> +base =3D master
>> +prefix =3D PATCH
>> +to =3D qemu-devel@nongnu.org
>> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --n=
ogit-fallback 2>/dev/null
>> +
>> +[gitpublishprofile "qemu-rfc"]
>> +base =3D master
>> +prefix =3D RFC PATCH
>> +to =3D qemu-devel@nongnu.org
>> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --n=
ogit-fallback 2>/dev/null
>> +
>> +[gitpublishprofile "qemu-stable"]
>> +base =3D master
>> +prefix =3D PATCH
>> +to =3D qemu-devel@nongnu.org
>> +cc =3D qemu-stable@nongnu.org
>> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --n=
ogit-fallback 2>/dev/null
>> +
>> +[gitpublishprofile "qemu-trivial"]
>> +base =3D master
>> +prefix =3D PATCH
>> +to =3D qemu-devel@nongnu.org
>
> cc qemu-trivial@nongnu.org ?

Good catch, I must have deleted it by mistake.

Fam
