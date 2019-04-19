Received: from eggs.gnu.org ([209.51.188.92]:57255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHMcG-0003gq-9v
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHMcE-0007Yz-FF
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:03:16 -0400
References: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
	<20190417220147.67648-2-stephen.checkoway@oberlin.edu>
	<3ffacb2c-2459-fb45-ca9c-7b59b10a1c76@redhat.com>
	<223E9F59-BF08-4441-B82F-1EC6B9FA8B85@oberlin.edu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2ed82112-afc0-ecd4-e8ae-358a7e1cdc4a@redhat.com>
Date: Fri, 19 Apr 2019 07:57:59 +0200
MIME-Version: 1.0
In-Reply-To: <223E9F59-BF08-4441-B82F-1EC6B9FA8B85@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/10] block/pflash_cfi02: Add test for
 supported commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

 Hi,

On 18/04/2019 22.43, Stephen Checkoway wrote:
[...]
> I'm new to contributing to QEMU and I have a two procedural questions:
>=20
> 1. When should I send version 4 of this patch series? I don't want to b=
ombard everyone with another 11 emails after fixing every review comment,=
 but I also don't want to let the patch linger without addressing comment=
s.

There is no hard rule ... I normally wait for a day or two before
sending another iteration, to see whether there are any further comments.

> 2. I'm not familiar with the "Acked-by" convention. I read <https://www=
.kernel.org/doc/html/v4.16/process/submitting-patches.html#when-to-use-ac=
ked-by-and-cc>. Am I supposed to add those to the commit messages or do t=
hose get added by whomever actually includes the patch in the main QEMU r=
epo?

I assume that the patches will go in via the block tree (or another
one), so I used Acked-by here to say that I've seen the patches and I'm
basically fine with them from the qtests perspective (since I'm listed
as qtests maintainer).

When you send another iteration, you should add the "Acked-by" lines on
your own, so that the information does not get lost in v4. (But when you
sent the final iteration, and there are more Acked-by/Reviewed-by reply
mails to that series, it's up to the maintainers to pick up these lines
when including the patches to their tree.)

  Thomas
