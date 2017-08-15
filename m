Received: from eggs.gnu.org ([2001:4830:134:3::10]:37532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dhTze-0002Gw-Le
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 01:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dhTzb-0007Px-Kb
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 01:02:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dhTzb-0007PX-ET
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 01:02:15 -0400
References: <20170814204450.24118-1-farman@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f637c206-266c-d76f-852e-4800422838bb@redhat.com>
Date: Tue, 15 Aug 2017 07:02:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170814204450.24118-1-farman@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/1] Fix "make clean" for s390
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>, cohuck@redhat.com
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org

On 14.08.2017 22:44, Eric Farman wrote:
> How often does one really do a "make clean" ?  Rather infrequently,
> as I only stumbled on this today.
>=20
> Perhaps I have missed the RM variable somewhere, as I see similar synta=
x
> in some of the tests/tcg/ Makefiles, but I don't see it being set here.
> My configure statement isn't terribly interesting, just enabling debug
> for an s390x target, and as such there's no RM variable in its output.
> I'll trust that Thomas will chime in with where it should have been.
> In the meantime, this does the trick for me.

RM is one of the variables that should be pre-initialized by Make, and
AFAIK should be used to increase portability (well, it's likely not
important for QEMU since we require a posix-shell like built environment
anyway).

According to the info page of Make, chapter "10.3 Variables Used by
Implicit Rules":

`RM'
     Command to remove a file; default `rm -f'.

I've also checked it again and "make clean" works fine here (using GNU
Make 3.82). Which version of Make (and Linux distro) are you using?

Anyway, maybe I also simply missed something, so I'm certainly also fine
with the patch to revert it to "rm -f".

 Thomas
