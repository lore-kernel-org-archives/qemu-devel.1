Received: from eggs.gnu.org ([2001:4830:134:3::10]:33404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1cvOlW-0003M7-PC
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1cvOlT-00087v-Lh
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:44:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1cvOlT-00087V-FG
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:44:55 -0400
Date: Tue, 4 Apr 2017 15:44:46 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20170404134445.GB9525@potion>
References: <1489612895-12799-1-git-send-email-mst@redhat.com>
	<87f187de-64ef-22a2-7714-a811883bce02@suse.de>
	<20170328142837.GA21738@potion>
	<CALMp9eRs+WMt+8+wgWk7+H8Kd5zU0_U+On0O_G4cp_7xEffrGQ@mail.gmail.com>
	<20170329121147.GA5129@potion>
	<f6607513-4cbd-3fa0-1663-5477e855e783@suse.de>
	<20170404123915.GA9525@potion>
	<abcfc109-296d-ec8e-2f4a-4f55f6a1b632@suse.de>
	<20170404131308.GA9826@potion>
	<a37a29a2-429c-6f41-42d5-a1a8928045b0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a37a29a2-429c-6f41-42d5-a1a8928045b0@suse.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 untested] kvm: better MWAIT emulation
 for guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: Jim Mattson <jmattson@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "Gabriel L. Somlo" <gsomlo@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, qemu-devel@nongnu.org

[Cc qemu-devel as we've gone off-topic]

2017-04-04 15:15+0200, Alexander Graf:
> On 04/04/2017 03:13 PM, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
>> 2017-04-04 14:51+0200, Alexander Graf:
>> > Please see my patch to force enable CPUID bits ;).
>> Nice.  MWAIT could also use setting of arbitrary values for its leaf,
>> but a generic interface for that would probably look clunky on the
>> command line ...
>=20
>=20
> I think we should have an interface similar to smbios for that eventual=
ly.
> Something where you can explicitly set arbitrary CPUID leaf information
> using leaf specific syntax. There are more leafs where it would make se=
nse -
> cache topology for example.

Right, separating cpuid from -cpu makes it bearable, like

  -cpuid leaf=3D%x[,subleaf=3D%x][,eax=3D%x][,ebx=3D%x][,ecx=3D%x][,edx=3D=
%x]

And Having multiple interfaces for the same thing would result in some
corner case decisions ...
I think QEMU should check that feature flags specified flags specified
by -cpu are not cleared by -cpuid.
I'm not sure if setters like "|=3D" and "&=3D~" would be beneficial in so=
me
cases.
