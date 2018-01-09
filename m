Received: from eggs.gnu.org ([2001:4830:134:3::10]:51709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vincent@bernat.im>) id 1eYnaM-0003uy-Bv
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 01:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vincent@bernat.im>) id 1eYnaI-0006nX-Pb
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 01:40:34 -0500
Received: from bart.luffy.cx ([78.47.78.131]:50954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vincent@bernat.im>) id 1eYnaI-0006nE-6f
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 01:40:30 -0500
From: Vincent Bernat <vincent@bernat.im>
References: <20180108205052.24385-1-vincent@bernat.im>
	<20180108211623.GJ6646@localhost.localdomain>
	<242287261.31733448.1515451036017.JavaMail.zimbra@redhat.com>
Date: Tue, 09 Jan 2018 07:40:26 +0100
In-Reply-To: <242287261.31733448.1515451036017.JavaMail.zimbra@redhat.com>
	(Paolo Bonzini's message of "Mon, 8 Jan 2018 17:37:16 -0500 (EST)")
Message-ID: <m34lnva61x.fsf@luffy.cx>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

 =E2=9D=A6  8 janvier 2018 17:37 -0500, Paolo Bonzini <pbonzini@redhat.com>=
=C2=A0:

>> One possible way to work around this problem is to declare that
>> QEMU 2.12 with KVM will require Linux v3.6 and newer (because we
>> need Linux kernel commit ad756a1603c5 "KVM: VMX: Implement
>> PCID/INVPCID for guests with EPT").
>
> Note that PCID is still not supported for guests without EPT, so
> this would break ept=3D0 with recent "-cpu" models.  I'm not sure of
> a way to fix it; probably it just has to be documented.

>From the above patch, it seems only INVPCID needs EPT. KVM exposes PCID
whenever it is present on the host.
--=20
When you are about to die, a wombat is better than no company at all.
		-- Roger Zelazny, "Doorways in the Sand"
