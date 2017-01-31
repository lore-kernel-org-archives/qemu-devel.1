Received: from eggs.gnu.org ([2001:4830:134:3::10]:41447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mfabian@redhat.com>) id 1cYavn-0001q6-Cv
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mfabian@redhat.com>) id 1cYavi-0005HP-FH
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:05:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mfabian@redhat.com>) id 1cYavi-0005HE-90
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:05:14 -0500
From: Mike FABIAN <mfabian@redhat.com>
References: <20170131100945.8189-1-kwolf@redhat.com>
	<w51mve7o4n1.fsf@maestria.local.igalia.com>
	<e4864049-0a56-bd97-4cd4-c71878a8477f@redhat.com>
Date: Tue, 31 Jan 2017 17:05:09 +0100
In-Reply-To: <e4864049-0a56-bd97-4cd4-c71878a8477f@redhat.com> (Eric Blake's
	message of "Tue, 31 Jan 2017 07:59:07 -0600")
Message-ID: <s9dy3xr6wqy.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] gtk: Hardcode LC_CTYPE as C.utf-8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, kraxel@redhat.com

Eric Blake <eblake@redhat.com> =E3=81=95=E3=82=93=E3=81=AF=E3=81=8B=E3=81=
=8D=E3=81=BE=E3=81=97=E3=81=9F:

> On 01/31/2017 05:22 AM, Alberto Garcia wrote:
>> On Tue 31 Jan 2017 11:09:45 AM CET, Kevin Wolf <kwolf@redhat.com> wrot=
e:
>>=20
>>> Recently, however, glibc introduced a new locale "C.utf-8" that just
>>> uses UTF-8 as its charset, but otherwise leaves the semantics alone.
>>> Just setting the right character set is enough for our use case, so w=
e
>>> can just hardcode this one without having to be afraid of nasty side
>>> effects.
>>=20
>>>     setlocale(LC_MESSAGES, "");
>>> +   setlocale(LC_CTYPE, "C.utf-8");
>>>     bindtextdomain("qemu", CONFIG_QEMU_LOCALEDIR);
>>=20
>> A couple of quick questions:
>>=20
>> - Is it C.utf-8 or C.UTF-8 ? 'locale -a' shows only the latter in my
>>   system.
>
> At least Cygwin has C.UTF-8, but not C.utf-8.  Furthermore, since my
> system defaults to en_US.UTF-8, I would expect the upper-case variant
> for the character set name across all locales.

Yes, I think it is more compatible to use the C.UTF-8 spelling because
it uses the =E2=80=9Cofficial=E2=80=9D spelling of =E2=80=9CUTF-8=E2=80=9D=
.

--=20
Mike FABIAN <mfabian@redhat.com>
=E7=9D=A1=E7=9C=A0=E4=B8=8D=E8=B6=B3=E3=81=AF=E3=81=84=E3=81=84=E4=BB=95=E4=
=BA=8B=E3=81=AE=E6=95=B5=E3=81=A0=E3=80=82
