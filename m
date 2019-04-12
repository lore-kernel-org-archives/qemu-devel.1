Received: from eggs.gnu.org ([209.51.188.92]:44887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hErWP-0005g9-0S
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hErWO-0005Qj-46
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:26:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hErWN-0005Q2-Na
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:26:52 -0400
References: <20190411175931.29235-1-brijesh.singh@amd.com>
	<61c415de-ac47-9818-2b06-b9e46445833f@redhat.com>
	<7d449ae2-6762-97c2-4930-358f34f3ef4b@amd.com>
	<869394fb-7b3d-cc01-7329-e931a260e73c@redhat.com>
	<20190412081912.GC16137@beluga.usersys.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <77338015-015c-aaef-d522-11cabbba4214@redhat.com>
Date: Fri, 12 Apr 2019 10:26:45 +0200
MIME-Version: 1.0
In-Reply-To: <20190412081912.GC16137@beluga.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: sev: add 'sev-max-guests'
 field to 'query-sev-capabilities'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Erik Skultety <eskultet@redhat.com>
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, Laszlo Ersek <lersek@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 12/04/19 10:19, Erik Skultety wrote:
>> Since this field is not specific to guest configuration, I don't think
>> it belongs in query-sev-capabilities; QEMU does not care about >1 guest.
> Neither pdh nor cert-chain are specific to the guest config.

Sort of, they are required to start a guest, aren't they?  But the
number of guests is irrelevant.

> I see why this
> should be better suited for query-sev, the same goes for libvirt - I think we
> shouldn't have gone with reporting the SEV platform caps in domain capabilities,
> we should have IMHO report it both in the host capabilities (platform specific
> stuff) and in domain capabilities to indicate that both libvirt and QEMU
> support the SEV feature. Having said that, we have a precedent which I think
> we might be better off with following rather than splitting the information
> among multiple commands.

For Libvirt, sure.  But I think this doesn't belong in QEMU at all.
Libvirt should just use CPUID.

Paolo
