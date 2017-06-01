Received: from eggs.gnu.org ([2001:4830:134:3::10]:36576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGR0W-0002rG-NJ
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGR0R-00083M-Ja
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:23:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dGR0R-000835-E7
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:23:19 -0400
References: <1494854073-19898-1-git-send-email-peterx@redhat.com>
	<87d1ar504h.fsf@dusky.pond.sub.org>
	<13985c6d-d24a-ac50-2708-fc3b9cc64acd@redhat.com>
	<87h902l8qd.fsf@dusky.pond.sub.org>
	<6a6a91cc-7ea1-2b45-a4bd-31aa3cfef917@redhat.com>
	<20170531070346.GE14845@pxdev.xzpeter.org>
	<1633113774.3648008.1496216414543.JavaMail.zimbra@redhat.com>
	<20170531082651.GJ14845@pxdev.xzpeter.org>
	<1013114653.3661277.1496219327691.JavaMail.zimbra@redhat.com>
	<2c763ebf-d11e-f414-a2cf-f7117ea6d4fb@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c666d24d-c8fc-ea77-af25-7f528aee0a81@redhat.com>
Date: Thu, 1 Jun 2017 16:23:14 +0200
MIME-Version: 1.0
In-Reply-To: <2c763ebf-d11e-f414-a2cf-f7117ea6d4fb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] msi: remove return code for msi_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>



On 01/06/2017 10:27, Marcel Apfelbaum wrote:
> On 31/05/2017 11:28, Paolo Bonzini wrote:
>> No, for now I'd rather just go and remove msi_nonbroken.  When someone
>> reports a bug, we can add back "msi_broken".
> 
> Hi,
> I agree with the direction, but I am concerned msi_nonbroken is there
> for a reason.
> We might break some (obscure/not in use) machine.
> Maybe we should CC all arch machine maintainers/contributors to give
> them a chance to object...

Yeah, Alpha, MIPS and SH are those that support PCI.  Adding Richard and
Aurelien, do your platforms support MSI on real hardware but not in QEMU?

Thanks,

Paolo
