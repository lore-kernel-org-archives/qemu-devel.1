Received: from eggs.gnu.org ([2001:4830:134:3::10]:32790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyLdI-0006z0-U1
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyLdE-0002Si-Mx
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:05:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37876 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eyLdE-0002S2-Hc
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:05:08 -0400
References: <1521566230-111929-1-git-send-email-mst@redhat.com>
	<1521566230-111929-2-git-send-email-mst@redhat.com>
	<CAFEAcA-mpWJf6e05Q-_5+Pfh_-Ae2vnbYM+C9bdyYQe_1Sxq9g@mail.gmail.com>
	<20180320192839-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7e78c808-8ca3-e235-aa5c-f9529ea0c1d5@redhat.com>
Date: Tue, 20 Mar 2018 19:05:04 +0100
MIME-Version: 1.0
In-Reply-To: <20180320192839-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] update-linux-headers.sh: add
 unistd.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Cornelia Huck <cohuck@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 20/03/2018 18:29, Michael S. Tsirkin wrote:
>> For MIPS, KVM is supposed to be properly supported these days, right?
>> That sounds like we should not be blacklisting them either, but instead
>> sorting out whatever issues it was that made us exclude them.
>
> I agree but I'd rather someone else looked at this.

Yeah, this doesn't look like the best time to change that.

Thanks,

Paolo
