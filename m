Received: from eggs.gnu.org ([2001:4830:134:3::10]:53727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ceLcX-0007tg-AN
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:57:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ceLcT-0001ga-EQ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:57:13 -0500
Received: from mail.genode-labs.com ([88.198.56.169]:53733)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ceLcT-0001gF-7w
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:57:09 -0500
References: <efb89578-ba8c-1f42-0ec3-79f769b3f1f1@genode-labs.com>
	<1266688981.22789860.1487246005187.JavaMail.zimbra@redhat.com>
From: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Message-ID: <f40048d0-23bc-a4c7-8b18-00d6d3fd04b5@genode-labs.com>
Date: Thu, 16 Feb 2017 13:57:07 +0100
MIME-Version: 1.0
In-Reply-To: <1266688981.22789860.1487246005187.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] x86 tlb_fill in memory_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, rth@twiddle.net

Hello Paolo,

On 16.02.2017 12:53, Paolo Bonzini wrote:
> As you noticed, the problem is that now cpu_vmexit is called without a
> cpu_restore_state before.
>=20
> The right fix is to pass the retaddr to cpu_vmexit (via
> cpu_svm_check_intercept_param); something like this untested patch:

...

>=20
> If it works for you we can include it.

thank you for the quick patch. It works like a charm.

Do you take care of adding the patch, please ? (I can of course also do.)

Thanks again,

Alex.

--=20
Alexander Boettcher
Genode Labs

http://www.genode-labs.com - http://www.genode.org

Genode Labs GmbH - Amtsgericht Dresden - HRB 28424 - Sitz Dresden
Gesch=C3=A4ftsf=C3=BChrer: Dr.-Ing. Norman Feske, Christian Helmuth
