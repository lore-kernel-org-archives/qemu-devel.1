Received: from eggs.gnu.org ([2001:4830:134:3::10]:43623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTt0c-0001kb-2o
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:22:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTt0b-0000g4-Cb
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:22:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTt0b-0000fX-6u
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:22:49 -0500
References: <1484749457-87117-1-git-send-email-phil@philjordan.eu>
	<aae83060-472d-97fb-9ada-2a78ff3f815f@redhat.com>
	<CAAibmn3SqnaEiM6NED=UyPNGp5j2ymgBxpRygpUzpLCNcL-X8g@mail.gmail.com>
	<df1239e9-e520-3c17-60cd-ec497c19e23b@redhat.com>
	<CAAibmn2X-b4yZw6Od=f96k3gkhM7=DGV-0RKG=XWU=Ti0rBWPQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30d84df6-c1de-d08f-fe82-daafabd1fba8@redhat.com>
Date: Wed, 18 Jan 2017 17:22:45 +0100
MIME-Version: 1.0
In-Reply-To: <CAAibmn2X-b4yZw6Od=f96k3gkhM7=DGV-0RKG=XWU=Ti0rBWPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] x86-KVM: Supply TSC and APIC clock rates
 to guest like VMWare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org



On 18/01/2017 17:16, Phil Dennis-Jordan wrote:
> On 18 January 2017 at 17:10, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> You enable vmware-cpuid-freq unconditionally.  But then you actually
>> publish 0x40000010 only if INVTSC is set.
> Right, got it, thanks. What about the Hyper-V conflict? That will be
> vastly more probable if the option is on by default. Don't publish
> leaf 0x40000010, print the warning and carry on in this case (as the
> patch does at the moment)?

Probably it's simplest to remove the warning altogether.

Paolo
