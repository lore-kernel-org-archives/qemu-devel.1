Received: from eggs.gnu.org ([2001:4830:134:3::10]:53411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epfCU-0006T0-98
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 14:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epfCQ-0008IB-Ad
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 14:09:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41150 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1epfCQ-00086g-5z
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 14:09:34 -0500
References: <1519372288-20791-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<c5009934-13c3-6e86-2618-9935837d3b8d@redhat.com>
	<12b54434-c992-d882-9ce7-0f658d067a7c@redhat.com>
	<1a2f136b.13907.161c7e33cc9.Coremail.suhang16@mails.ucas.ac.cn>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9c7db768-622d-dd31-b222-9fe8206617ff@redhat.com>
Date: Sat, 24 Feb 2018 13:09:22 -0600
MIME-Version: 1.0
In-Reply-To: <1a2f136b.13907.161c7e33cc9.Coremail.suhang16@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] util/uri.c: add brackets to `if`
 statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?6IuP6Iiq?= <suhang16@mails.ucas.ac.cn>
Cc: Thomas Huth <thuth@redhat.com>, stefanha@redhat.com, qemu-devel@nongnu.org

On 02/24/2018 06:56 AM, =E8=8B=8F=E8=88=AA wrote:
> Hi, when I try to change
> `while (cond) ;`
> to
> `while (cond) {
> }`
> checkpatch.pl complains about this:
> '''
> ERROR: suspect code indent for conditional statements (8, 8)
> #1506: FILE: uri.c:1506:
> +        while ((*tmp++ =3D *segp++) !=3D 0) {
> [...]
> +        }
>=20
> ERROR: suspect code indent for conditional statements (8, 8)
> #1512: FILE: uri.c:1512:
> +        while ((segp > path) && ((--segp)[0] =3D=3D '/')) {
> [...]
> +        }
> '''
>=20
> When I add a semicolon, checkpatch.pl stop complaining.
> `while (cond) {
>      ;
> }`
> What should I do now?

Keeping a semicolon is one option, another is a well-placed comment:

while (cond) {
     /* No further work */
}


And in general, we try to avoid top-posting on this list.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
