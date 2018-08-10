Received: from eggs.gnu.org ([2001:4830:134:3::10]:50228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fny9o-00042y-Ln
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 23:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fny9n-0007Oq-Q3
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 23:32:08 -0400
Date: Fri, 10 Aug 2018 00:32:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180810033200.GA8773@localhost.localdomain>
References: <20180808123934.17450-1-alex.bennee@linaro.org>
	<20180808123934.17450-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180808123934.17450-2-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/4] scripts/decodetree.py: add a
 disassembly generator (HACK!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org, Cleber Rosa <crosa@redhat.com>

On Wed, Aug 08, 2018 at 01:39:31PM +0100, Alex Benn=E9e wrote:
> Given our issues with failing disassembly we could try and re-use the
> decode tree data to output what instruction is being decoded. This
> will be used if registered as a fall-back for when the "proper"
> disassembler fails to decode an instruction.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

I don't have an opinion on the approach you are taking, but the
Python code you are adding is consistent with the existing style
of the script.

That said, I find the existing code full of output() calls very
hard to read.  If anybody wants to volunteer to improve the
readability of the output generation, it would be welcome.

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
