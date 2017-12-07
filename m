Received: from eggs.gnu.org ([2001:4830:134:3::10]:37055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMu58-0005wG-HY
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 06:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMu57-0003T8-HO
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 06:11:10 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:34848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eMu57-0003SL-CN
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 06:11:09 -0500
Received: by mail-oi0-x22a.google.com with SMTP id 184so4657616oii.2
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 03:11:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171207110342.GB2439@work-vm>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
	<20171206200346.116537-24-brijesh.singh@amd.com>
	<20171207110342.GB2439@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Dec 2017 11:10:48 +0000
Message-ID: <CAFEAcA9J35+cC1cZr2U1aJERP6=_DtoHZ-ukvQQ8Ngj37ZGARA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 23/23] sev: add migration blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>

On 7 December 2017 at 11:03, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> * Brijesh Singh (brijesh.singh@amd.com) wrote:
>> SEV guest migration is not yet implemented yet.

Is there at least a plan for how migration of a guest with
encrypted memory would be implemented?

thanks
-- PMM
