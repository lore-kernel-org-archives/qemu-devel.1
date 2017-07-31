Received: from eggs.gnu.org ([2001:4830:134:3::10]:48557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dc49R-0005pq-FB
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 02:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dc49O-0007J6-Bo
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 02:26:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:34790 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1dc49O-0007HY-55
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 02:25:58 -0400
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20170730214231.GC16400@localhost.localdomain>
Date: Mon, 31 Jul 2017 08:25:53 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <B912EBFB-8995-4908-ADFA-CC1B131FEB35@suse.de>
References: <CAOMFOmXXRN02BT+8M+iKnrGmaTSR8uWoTYCu5A5gv+KTe9xAqg@mail.gmail.com>
	<20170730214231.GC16400@localhost.localdomain>
Subject: Re: [Qemu-devel] How to make ELF headers/symbol sections available
 for multiboot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>

Hi Anatol,

> Am 30.07.2017 um 23:42 schrieb Eduardo Habkost <ehabkost@redhat.com>:
>=20
>=20
> CCing Alex, the original author of load_multiboot(), and Kevin,
> who touched multiboot code recently.
>=20
>=20
>> On Fri, Jul 28, 2017 at 02:28:34PM -0700, Anatol Pomozov wrote:
>> Hi
>>=20
>> I am looking at x86 multiboot code and trying to add "ELF section
>> header" info feature. This will let target to

Do you have a pointer to what that feature does exactly?

>> learn more about booted
>> binary and its sections.
>=20
> Are there existing OSes that use that information?
>=20
>=20
>>=20
>> I have a draft here
>> https://github.com/anatol/qemu/commit/ad943a6eb78feee048b6bb2a1e5f49f5b68=
6e24c
>>=20
>> My understanding is that qemu multiboot loads only TEXT/BSS/DATA
>> sections. Other stuff like symbols sections and ELF headers are not
>> available for target.

Thes are not available inside the target, but they are available from the ho=
st (for example in -d in_asm).


Alex
