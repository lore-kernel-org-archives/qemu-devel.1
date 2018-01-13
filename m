Received: from eggs.gnu.org ([2001:4830:134:3::10]:42422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vincent@bernat.im>) id 1eaG9H-0004Up-SQ
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 02:22:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vincent@bernat.im>) id 1eaG9D-0006Pu-Uj
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 02:22:39 -0500
Received: from bart.luffy.cx ([78.47.78.131]:54223)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vincent@bernat.im>) id 1eaG9D-0006OE-LM
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 02:22:35 -0500
From: Vincent Bernat <vincent@bernat.im>
References: <20180109070112.30806-1-vincent@bernat.im>
	<20180112184727.GJ6646@localhost.localdomain>
Date: Sat, 13 Jan 2018 08:22:31 +0100
In-Reply-To: <20180112184727.GJ6646@localhost.localdomain> (Eduardo Habkost's
	message of "Fri, 12 Jan 2018 16:47:27 -0200")
Message-ID: <87zi5ite88.fsf@luffy.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH x86-next v2] target-i386: add PCID flag to
 Westmere, Sandy Bridge and Ivy Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>

 =E2=9D=A6 12 janvier 2018 16:47 -0200, Eduardo Habkost <ehabkost@redhat.co=
m>=C2=A0:

> Adding Westmere-PCID would require adding a Westmere-PCID-IBRS
> CPU model too, so this is starting to look a bit ridiculous.
> Sane VM management systems would know how to use
> "-cpu Westmere,+pcid" without requiring new CPU model entries in
> QEMU.  What's missing in existing management stacks to allow that
> to happen?

That's what I actually do. So, I am fine with the solution of doing
nothing. However, it would be nice for unaware people to get the speedup
of pcid without knowing about it. Maybe we can just forget about
Westmere and still apply it to Sandy Bridge and Ivy Bridge.
--=20
Avoid unnecessary branches.
            - The Elements of Programming Style (Kernighan & Plauger)
