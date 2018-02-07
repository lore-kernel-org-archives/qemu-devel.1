Received: from eggs.gnu.org ([2001:4830:134:3::10]:34647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejSs6-0005Xj-0M
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejSs3-0003AW-0Y
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:46:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ejSs2-0003AB-S9
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:46:54 -0500
References: <20180207160638.98872-1-brijesh.singh@amd.com>
	<20180207160638.98872-2-brijesh.singh@amd.com>
	<63949650-cea1-f035-261e-e79dc15d85b8@redhat.com>
	<bf25f97c-0020-12a8-d1f4-f40b0dc08c38@amd.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e4ce42e-9017-4a3a-d457-f6ca4b4c740f@redhat.com>
Date: Wed, 7 Feb 2018 10:46:38 -0600
MIME-Version: 1.0
In-Reply-To: <bf25f97c-0020-12a8-d1f4-f40b0dc08c38@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 02/26] exec: add ram_debug_ops support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Richard Henderson <rth@twiddle.net>

On 02/07/2018 10:33 AM, Brijesh Singh wrote:

>> [meta-comment]
>>
>> Your threading is off.=C2=A0 This email was sent with the headers:
>>

> I am just looking at the my git send email script log and it seems that
> after sending the cover-letter patch, exchange server timeout and my
> script restarting send from patch 02/.. hence threading got messed up.
> sorry about that. If its an issue then I can resend the whole series.

No need to resend for just that issue (we can deal with a one-off, and=20
there may be a v8 anyways depending on what reviewers find).  Does your=20
server allow you to pre-specify message ids, or does it always ignore=20
your input and generate its own message ids?

If interruptions are a common issue, you can use 'git send-email=20
--in-reply-to=3D...' to forcefully (try and) thread a second batch of sen=
t=20
mail to an earlier batch that was interrupted from completion.  It may=20
also be possible to have 'git format-patch' pre-thread all mails,=20
although that may already match what you were doing (pre-specifying=20
message ids only works if your server preserves those requested message=20
ids from the input instead of blindly replacing it with its own ids)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
