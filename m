Received: from eggs.gnu.org ([2001:4830:134:3::10]:50842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fsOwi-0003fp-4B
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fsOwc-0001lC-0c
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:56:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52468 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fsOwa-0001hd-G0
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:56:49 -0400
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
	<1534870966-9287-28-git-send-email-pbonzini@redhat.com>
	<CA+55aFyG=iDf3r3nj5Wav4xnKs1D8tUM9iejJd4M0xb2q-tZoQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <75208374-f02e-7df0-75d5-b4e44495f827@redhat.com>
Date: Wed, 22 Aug 2018 10:56:40 +0200
MIME-Version: 1.0
In-Reply-To: <CA+55aFyG=iDf3r3nj5Wav4xnKs1D8tUM9iejJd4M0xb2q-tZoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 27/74] checkpatch: allow space in more
 places before a bracket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: qemu-devel@nongnu.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Morton <akpm@linux-foundation.org>

On 21/08/2018 20:38, Linus Torvalds wrote:
> This is commit 38dca988bb20 ("checkpatch: allow space between colon
> and bracket") upstream, why is that not mentioned anywhere?

Trivially because I used "git commit -c" instead of "git cherry-pick" (I
don't remember exactly why, probably I did the patch quickly and only
later noticed that Linux had already fixed the same thing).  I did
mention Linux commit daebc534ac in the commit message, but not 38dca988bb=
20.

Paolo

> *Please* mention the upstream commits when back-porting things.
>=20
>                  Linus
>=20
>=20
> On Tue, Aug 21, 2018 at 10:03 AM Paolo Bonzini <pbonzini@redhat.com> wr=
ote:
>>
>> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>
>> Allow a space between a colon and subsequent opening bracket.  This
>> sequence may occur in inline assembler statements like
