Received: from eggs.gnu.org ([209.51.188.92]:55678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bp@alien8.de>) id 1hK7l6-0006dl-HN
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 16:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bp@alien8.de>) id 1hK7h2-0007Vf-Gx
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 16:43:37 -0400
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457]:53928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bp@alien8.de>) id 1hK7h0-0007Qq-2I
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 16:43:36 -0400
Date: Fri, 26 Apr 2019 22:43:27 +0200
From: Borislav Petkov <bp@alien8.de>
Message-ID: <20190426204327.GM4608@zn.tnic>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
	<20190424160942.13567-2-brijesh.singh@amd.com>
	<20190426141042.GF4608@zn.tnic>
	<e6f8da38-b8dd-a9c5-a358-5f33b6ea7b37@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6f8da38-b8dd-a9c5-a358-5f33b6ea7b37@amd.com>
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

On Fri, Apr 26, 2019 at 02:29:31PM +0000, Singh, Brijesh wrote:
> Yes that's doable but I am afraid that caching the value may lead us to
> wrong path and also divergence from the SEV API spec. The spec says the
> returned length is a minimum length but its possible that caller can
> give a bigger buffer and FW will still work with it.

Does the caller even have a valid reason to give a bigger buffer len?

I mean I'm still thinking defensively here but maybe the only thing that
would happen here with a bigger buffer is if the kmalloc() would fail,
leading to eventual failure of the migration.

If the code limits the allocation to some sane max length, the migration
won't fail even if userspace gives it too big values...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
