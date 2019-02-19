Received: from eggs.gnu.org ([209.51.188.92]:46166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw9dd-0004gP-6I
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw9dc-0003xM-3P
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:57:01 -0500
References: <20190219013106.17538-1-richardw.yang@linux.intel.com>
	<20190219013106.17538-3-richardw.yang@linux.intel.com>
	<ba83c335-c0f1-5190-33a9-f2f7f44c55f0@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <77cf32b1-6a4a-33c5-4b3c-8ba3245a4b23@redhat.com>
Date: Tue, 19 Feb 2019 11:56:43 -0600
MIME-Version: 1.0
In-Reply-To: <ba83c335-c0f1-5190-33a9-f2f7f44c55f0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] CODING_STYLE: indent example code as
 all others
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: imammedo@redhat.com, mjt@tls.msk.ru

On 2/19/19 11:38 AM, Philippe Mathieu-Daud=C3=A9 wrote:

>> +    if (a =3D=3D 1) {
>> +        /* Reads like: "If a equals 1" */
>=20
> I guess you found a bug in the documentation :)
>=20
> Since 8c06fbdf36bf4d the style asked is:
>=20
>     We now require Linux-kernel-style multiline comments:
>         /*
>          * line one
>          * line two
>          */
>=20
>> +        do_something();

We only require winged multiline comments when the comment is actually
multiline.  In this case, the comment is a one-liner, and is just fine
as written.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
