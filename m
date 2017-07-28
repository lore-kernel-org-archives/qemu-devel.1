Received: from eggs.gnu.org ([2001:4830:134:3::10]:34753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dav9U-0004Ys-LS
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 22:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dav9R-0006em-IG
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 22:37:20 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:35285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dav9R-0006eP-Ci
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 22:37:17 -0400
Received: by mail-it0-x244.google.com with SMTP id v127so14765900itd.2
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 19:37:17 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <5c3214a0-196d-fa81-dbf8-237034b445de@redhat.com>
Date: Thu, 27 Jul 2017 22:37:15 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <CEC77EA1-ED7E-4D46-96DE-38A92DEF0F17@gmail.com>
References: <1920BE03-56F6-4E44-B9D2-0638A86FACB2@gmail.com>
	<5c3214a0-196d-fa81-dbf8-237034b445de@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] Add more function keys to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> On Jul 27, 2017, at 10:55 AM, Eric Blake <eblake@redhat.com> wrote:
>=20
> On 07/27/2017 09:51 AM, Programmingkid wrote:
>=20
> You forgot in-reply-to: and references: headers, meaning this was not
> threaded with your 0/2 patch.

Git send-email doesn't work for me. It complains about missing Perl =
modules.=20

>=20
>> There are now keyboards that have 19 function keys. This patch =
extends QEMU so these function keys can be used.=20
>>=20
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>> qapi-schema.json  | 6 +++++-
>> ui/input-keymap.c | 4 ++++
>> 2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> Conflicts with Gerd's pending UI pull; so you'll need to rebase.
> Furthermore, while Gerd added keys after softfreeze (necessary to fix =
a
> regression), your additions seem to be a new feature rather than a bug
> fix, and may therefore be more appropriate for 2.11.

Good idea. I will change the 'since' values to 2.11 in the next patch.
