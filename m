Received: from eggs.gnu.org ([2001:4830:134:3::10]:36059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ebischoff@suse.com>) id 1ciIqz-0000TT-TD
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:48:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ebischoff@suse.com>) id 1ciIqw-0008Rs-Rm
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:48:29 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:51661)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ebischoff@suse.com>) id 1ciIqw-0008RV-I2
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:48:26 -0500
From: =?ISO-8859-1?Q?=C9ric?= Bischoff <ebischoff@suse.com>
Date: Mon, 27 Feb 2017 11:48:20 +0100
Message-ID: <5892639.vTNTnRjPkV@eric>
In-Reply-To: <1599197.qxnXlczcy2@eric>
References: <20170223115805.16688-1-ebischoff@suse.com>
	<a26cf735-bbb6-5be7-7575-198ec55a3ecc@twiddle.net>
	<1599197.qxnXlczcy2@eric>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Subject: Re: [Qemu-devel] [PATCH] Adding support for LPD and LPDG
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Alexander Graf <agraf@suse.de>, Michal Marek <mmarek@suse.cz>, Miroslav Benes <mbenes@suse.cz>, QEmu developers <qemu-devel@nongnu.org>

Le samedi 25 f=E9vrier 2017, 10:42:43 CET Richard Henderson a =E9crit :
> On 02/23/2017 10:58 PM, Eric Bischoff wrote:
> > +/* LOAD PAIR DISJOINT */
> > +    C(0xc804, LPD,     SSF,   ILA, m1_32s, m2_32s, 0, r3_P32, movx, 0)
> > +    C(0xc805, LPDG,    SSF,   ILA, m1_64, m2_64, 0, r3_P64, movx, 0)
>=20
> Missing is the update to the condition codes.
> I think just setting CC =3D 3 (not loaded interlocked) is probably fine.

I tested and 0 at the end of C macro means "do nothing with CC".

I indeed need to set CC (but to 0, not to 3). New patch coming.


=2D-=20
Eric Bischoff - SUSE Manager QA Engineer
SUSE Linux GmbH, GF: Felix Imend=F6rffer, Jane Smithard, Jennifer Guild, Di=
lip=20
Upmanyu, Graham Norton, HRB 21284 (AG N=FCrnberg)Le dimanche 26 f=E9vrier 2=
017,=20
