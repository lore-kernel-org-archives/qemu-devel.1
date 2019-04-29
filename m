Received: from eggs.gnu.org ([209.51.188.92]:57936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bp@alien8.de>) id 1hL9GI-0004hp-LV
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bp@alien8.de>) id 1hL9GH-0002hE-JH
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:36:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bp@alien8.de>) id 1hL9GH-0002dK-2V
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:36:13 -0400
Date: Mon, 29 Apr 2019 18:36:02 +0200
From: Borislav Petkov <bp@alien8.de>
Message-ID: <20190429163602.GE2324@zn.tnic>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
	<20190424160942.13567-2-brijesh.singh@amd.com>
	<20190426141042.GF4608@zn.tnic>
	<e6f8da38-b8dd-a9c5-a358-5f33b6ea7b37@amd.com>
	<20190426204327.GM4608@zn.tnic>
	<2b63d983-a622-3bec-e6ac-abfd024e19c0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b63d983-a622-3bec-e6ac-abfd024e19c0@amd.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 01/10] KVM: SVM: Add KVM_SEV
 SEND_START command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Joerg Roedel <joro@8bytes.org>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Apr 29, 2019 at 03:01:24PM +0000, Singh, Brijesh wrote:
> Practically I don't see any reason why caller would do that but
> theoretically it can. If we cache the len then we also need to consider
> adding another flag to hint whether userspace ever requested length.
> e.g an application can compute the length of session blob by looking at
> the API version and spec and may never query the length.
> 
> > I mean I'm still thinking defensively here but maybe the only thing that
> > would happen here with a bigger buffer is if the kmalloc() would fail,
> > leading to eventual failure of the migration.
> > 
> > If the code limits the allocation to some sane max length, the migration
> > won't fail even if userspace gives it too big values...

So what about this? Limiting to a sane length...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
