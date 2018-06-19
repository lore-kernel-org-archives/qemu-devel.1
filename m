Received: from eggs.gnu.org ([2001:4830:134:3::10]:47211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.vrabel@nutanix.com>) id 1fVKaU-00082J-J7
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 13:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.vrabel@nutanix.com>) id 1fVKaR-0006hZ-Bk
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 13:38:38 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:35488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david.vrabel@nutanix.com>)
	id 1fVKaQ-0006gt-J6
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 13:38:35 -0400
References: <CAAGnT3bjYPu9bordn_Dh8z+MW6p5DDLoSsZC9xg8QxQriVus9A@mail.gmail.com>
From: David Vrabel <david.vrabel@nutanix.com>
Message-ID: <7337582f-0007-d006-0809-cf41fd93b31e@nutanix.com>
Date: Tue, 19 Jun 2018 18:37:53 +0100
MIME-Version: 1.0
In-Reply-To: <CAAGnT3bjYPu9bordn_Dh8z+MW6p5DDLoSsZC9xg8QxQriVus9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Design Decision for KVM based anti rootkit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ahmed Soliman <ahmedsoliman0x666@gmail.com>, kvm@vger.kernel.org, Kernel Hardening <kernel-hardening@lists.openwall.com>, riel@redhat.com, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Hossam Hassan <7ossam9063@gmail.com>, Ahmed Lotfy <A7med.lotfey@gmail.com>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org

On 16/06/18 12:49, Ahmed Soliman wrote:
> 
> To wrap things up, the basic design will be a method for communication
> between host and guest is guest can request certain pages to be read
> only, and then host will force them to be read-only by guest until
> next guest reboot, then it will impossible for guest OS to have them
> as RW again. The choice of which pages to be set as read only is the
> guest's. So this way mixed pages can still be mixed with R/W content
> even if holds kernel code.

It's not clear how this increases security. What threats is this
protecting again?

As an attacker, modifying the sensitive pages (kernel text?) will
require either: a) altering the existing mappings for these (to make
them read-write or user-writable for example); or b) creating aliased
mappings with suitable permissions.

If the attacker can modify page tables in this way then it can also
bypass the suggested hypervisor's read-only protection by changing the
mappings to point to a unprotected page.

David
