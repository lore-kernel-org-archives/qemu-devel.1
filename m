Received: from eggs.gnu.org ([2001:4830:134:3::10]:33059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emHRh-0003kT-4w
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 06:11:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emHRd-0001T4-3C
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 06:11:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50944 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1emHRc-0001So-Up
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 06:11:17 -0500
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-2-f4bug@amsat.org>
	<CAJ+F1CKPuytP6YDeVNP+duKcfyJGtA1bVY7efN8rJuo7bB2qgQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c31b48bb-06cc-03aa-facf-30104b73fb4f@redhat.com>
Date: Thu, 15 Feb 2018 12:11:13 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKPuytP6YDeVNP+duKcfyJGtA1bVY7efN8rJuo7bB2qgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/30] util/cutils: extract byte-based
 definitions into a new header: "qemu/cunits.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: QEMU <qemu-devel@nongnu.org>

On 15.02.2018 10:55, Marc-Andr=C3=A9 Lureau wrote:
> On Thu, Feb 15, 2018 at 5:28 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@ams=
at.org> wrote:
>> (added in 076b35b5a56)
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> Or osdep.h?

No, osdep.h is for "OS includes and handling of OS dependencies", not
for declaring constants like this.

 Thomas
