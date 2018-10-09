Received: from eggs.gnu.org ([2001:4830:134:3::10]:46740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9rgp-0007I5-Kk
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9rgi-0003Fw-LS
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:04:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9rgf-00039n-Kj
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:04:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1539052760-11730-1-git-send-email-liq3ea@gmail.com>
	<7a26945a-d94f-98db-7ae2-0d4c089ab975@redhat.com>
	<CAKXe6SKqfm2qXuN4YNWQTOnrF9O2OFqg41vp6y-ANMgqLLXBLg@mail.gmail.com>
Date: Tue, 09 Oct 2018 15:04:26 +0200
In-Reply-To: <CAKXe6SKqfm2qXuN4YNWQTOnrF9O2OFqg41vp6y-ANMgqLLXBLg@mail.gmail.com>
	(Li Qiang's message of "Tue, 9 Oct 2018 13:58:21 +0800")
Message-ID: <87bm83uv8l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vl.c: print error message if load
 fw_cfg file failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: philmd@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, f4bug@amsat.org, Qemu Developers <qemu-devel@nongnu.org>

Li Qiang <liq3ea@gmail.com> writes:

> Hello  Philippe,
>
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2018=E5=B9=B410=
=E6=9C=889=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:52=E5=86=99=E9=81=
=93=EF=BC=9A
>
>> Hi Li,
>>
>> On 09/10/2018 04:39, Li Qiang wrote:
>> > It makes sense to print the error message while reading
>> > file failed.
[...]
>> > diff --git a/vl.c b/vl.c
>> > index 4e25c78..69fc77c 100644
>> > --- a/vl.c
>> > +++ b/vl.c
>> > @@ -2207,8 +2207,10 @@ static int parse_fw_cfg(void *opaque, QemuOpts =
*opts, Error **errp)
>> >          size =3D strlen(str); /* NUL terminator NOT included in fw_cf=
g blob */
>> >          buf =3D g_memdup(str, size);
>> >      } else {
>> > -        if (!g_file_get_contents(file, &buf, &size, NULL)) {
>> > -            error_report("can't load %s", file);
>> > +        GError *error =3D NULL;
>> > +        if (!g_file_get_contents(file, &buf, &size, &error)) {
>> > +            error_report("can't load %s, %s", file, error->message);
>>
>> If you ever respin, you can help Markus [1] effort using:
>>
>>             error_setg(errp, "can't load %s, %s", file, error->message);
>>
>> Else your patch will clash with [2].
>>
>
> OK, I will send out this patch based Markus' tree or later when his patch
> goes to upstream.

Appreciated!
