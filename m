Received: from eggs.gnu.org ([2001:4830:134:3::10]:59066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vincent@bernat.im>) id 1eYnxY-0002q9-Cx
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 02:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vincent@bernat.im>) id 1eYnxU-0000qF-Df
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 02:04:32 -0500
Received: from bart.luffy.cx ([78.47.78.131]:51073)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vincent@bernat.im>) id 1eYnxU-0000pJ-6H
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 02:04:28 -0500
From: Vincent Bernat <vincent@bernat.im>
References: <20180108205052.24385-1-vincent@bernat.im>
	<20180108211623.GJ6646@localhost.localdomain>
	<242287261.31733448.1515451036017.JavaMail.zimbra@redhat.com>
	<20180108225625.GP6646@localhost.localdomain>
	<848013447.31735187.1515452970885.JavaMail.zimbra@redhat.com>
	<20180108231917.GQ6646@localhost.localdomain>
Date: Tue, 09 Jan 2018 08:04:26 +0100
In-Reply-To: <20180108231917.GQ6646@localhost.localdomain> (Eduardo Habkost's
	message of "Mon, 8 Jan 2018 21:19:17 -0200")
Message-ID: <m3mv1n8qdh.fsf@luffy.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target-i386: add pcid to both Sandy Bridge
 and Ivy Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

 =E2=9D=A6  8 janvier 2018 21:19 -0200, Eduardo Habkost <ehabkost@redhat.co=
m>=C2=A0:

>> > GET_SUPPORTED_CPUID seems to still return PCID as supported
>> > without EPT, doesn't it?
>>=20
>> Indeed it is!  It will also be useful for KPTI performance without
>> INVPCID, but it won't be useful without EPT.
>
> Well, I can live with "not useful without EPT", as long as it
> doesn't mean "broken without EPT".  It looks like we can safely
> enable it, as long as:
>
> 2) we confirm if all Intel Westmere/SandyBridge/IvyBridge CPUs
>    have PCID;

I didn't find an authoritative information about that on Intel
website. Various sites indeed says the feature was introduced in
Westmere. And Greg KH mentions Westmere here too:
 https://mail-archive.com/linux-kernel@vger.kernel.org/msg1576774.html

> 1) QEMU documentation states that it requires Linux v3.6 or newer
>    for KVM.

I have updated the patch and sent it in a new thread. It's now based on
x86-next.
--=20
Clothes make the man.  Naked people have little or no influence on society.
		-- Mark Twain
