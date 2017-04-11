Received: from eggs.gnu.org ([2001:4830:134:3::10]:42038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cy0Rp-0004d5-9C
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 14:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cy0Rm-0003AF-0p
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 14:23:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:60250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1cy0Rl-00039q-QS
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 14:23:21 -0400
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <CALMp9eT220btgiw7S-0cLswr1j=-OCuMwOAWuWS51EmNYYRuJw@mail.gmail.com>
Date: Tue, 11 Apr 2017 20:23:18 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <4622E361-52AB-40F2-9915-45C48F0DBCD2@suse.de>
References: <1491911135-216950-1-git-send-email-agraf@suse.de>
	<CALMp9eT220btgiw7S-0cLswr1j=-OCuMwOAWuWS51EmNYYRuJw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6] kvm: better MWAIT emulation for guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jim Mattson <jmattson@google.com>
Cc: kvm list <kvm@vger.kernel.org>, =?utf-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "Gabriel L. Somlo" <gsomlo@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, qemu-devel@nongnu.org



> Am 11.04.2017 um 19:10 schrieb Jim Mattson <jmattson@google.com>:
>=20
> This might be more useful if it could be dynamically toggled on and
> off, depending on system load.

What would trapping mwait (currently) buy you?

As it stands today, before this patch, mwait is simply implemented as a nop,=
 so enabling the trap just means you're wasting as much cpu time, but never s=
end the pCPU idle. With this patch, the CPU at least has the chance to go id=
le.

Keep in mind that this patch does *not* advertise the mwait cpuid feature bi=
t to the guest.

What you're referring to I guess is actual mwait emulation. That is indeed m=
ore useful, but a bigger patch than this and needs some more thought on how t=
o properly cache the monitor'ed pages.


Alex
