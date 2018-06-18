Received: from eggs.gnu.org ([2001:4830:134:3::10]:37502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUnGM-0003XV-9l
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUnGI-0001R8-A1
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:03:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54796 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fUnGI-0001R3-5j
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:03:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180615141609.20749-1-berrange@redhat.com>
	<20180615185805.GE7451@localhost.localdomain>
Date: Mon, 18 Jun 2018 08:03:32 +0200
In-Reply-To: <20180615185805.GE7451@localhost.localdomain> (Eduardo Habkost's
	message of "Fri, 15 Jun 2018 15:58:05 -0300")
Message-ID: <878t7cskaz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: add guidance on configuring CPU
 models for x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Jun 15, 2018 at 03:16:09PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> With the recent set of CPU hardware vulnerabilities on x86, it is
>> increasingly difficult to understand which CPU configurations are
>> good to use and what flaws they might be vulnerable to.
>>=20
>> This doc attempts to help management applications and administrators in
>> picking sensible CPU configuration on x86 hosts. It outlines which of
>> the named CPU models are good choices, and describes which extra CPU
>> flags should be enabled to allow the guest to mitigate hardware flaws.
>>=20
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> Thank you very much.
>
> I wonder how we could reference this from the man page and
> qemu-doc.html without saying "look at the QEMU source tree".

Same way as the other contents there.

> (I'm not willing to rewrite this using texinfo to make that
> happen.)

Texinfo is simple.

If all else fails, ask for my help after soft freeze.
