Received: from eggs.gnu.org ([2001:4830:134:3::10]:59073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejSfo-00020g-TR
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejSfj-0003Nr-SU
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:34:16 -0500
Received: from mail-by2nam03on0048.outbound.protection.outlook.com
	([104.47.42.48]:39640
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1ejSfj-0003Mx-JF
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:34:11 -0500
References: <20180207160638.98872-1-brijesh.singh@amd.com>
	<20180207160638.98872-2-brijesh.singh@amd.com>
	<63949650-cea1-f035-261e-e79dc15d85b8@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <bf25f97c-0020-12a8-d1f4-f40b0dc08c38@amd.com>
Date: Wed, 7 Feb 2018 10:33:57 -0600
MIME-Version: 1.0
In-Reply-To: <63949650-cea1-f035-261e-e79dc15d85b8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v7 02/26] exec: add ram_debug_ops support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: brijesh.singh@amd.com, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Richard Henderson <rth@twiddle.net>


On 2/7/18 10:19 AM, Eric Blake wrote:
> On 02/07/2018 10:06 AM, Brijesh Singh wrote:
>> Currently, the guest memory access for the debug purpose is performed
>> using the memcpy(). Lets extend the 'struct MemoryRegion' to include
>> ram_debug_ops callbacks. The ram_debug_ops can be used to override
>> memcpy() with something else.
>
> [meta-comment]
>
> Your threading is off.=C2=A0 This email was sent with the headers:
>
> > In-Reply-To: <20180207160638.98872-1-brijesh.singh@amd.com>
> > References: <20180207160638.98872-1-brijesh.singh@amd.com>
>
> which ties it only to patch 1/26; in turn, that message has no
> In-Reply-To header at all, making it a top-level thread.=C2=A0 Meanwhile,
> your 0/26 cover letter has:
>
>> Message-Id: <20180207160324.98614-1-brijesh.singh@amd.com>
>
> which nothing in the rest of the series refers to, making it a
> separate thread.=C2=A0 It would be helpful if you could the threading use=
d
> in your sending environment, although I don't have any specific
> suggestions on what that fix would be.
>

I am just looking at the my git send email script log and it seems that
after sending the cover-letter patch, exchange server timeout and my
script restarting send from patch 02/.. hence threading got messed up.
sorry about that. If its an issue then I can resend the whole series.

-Brijesh
