Received: from eggs.gnu.org ([2001:4830:134:3::10]:42163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cTsup-00059o-U2
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cTsuo-0005j7-TO
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:16:51 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cTsuo-0005ij-NH
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:16:50 -0500
Received: by mail-ot0-x241.google.com with SMTP id 73so1601363otj.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 08:16:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <df1239e9-e520-3c17-60cd-ec497c19e23b@redhat.com>
References: <1484749457-87117-1-git-send-email-phil@philjordan.eu>
	<aae83060-472d-97fb-9ada-2a78ff3f815f@redhat.com>
	<CAAibmn3SqnaEiM6NED=UyPNGp5j2ymgBxpRygpUzpLCNcL-X8g@mail.gmail.com>
	<df1239e9-e520-3c17-60cd-ec497c19e23b@redhat.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 18 Jan 2017 17:16:29 +0100
Message-ID: <CAAibmn2X-b4yZw6Od=f96k3gkhM7=DGV-0RKG=XWU=Ti0rBWPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org

On 18 January 2017 at 17:10, Paolo Bonzini <pbonzini@redhat.com> wrote:
> You enable vmware-cpuid-freq unconditionally.  But then you actually
> publish 0x40000010 only if INVTSC is set.

Right, got it, thanks. What about the Hyper-V conflict? That will be
vastly more probable if the option is on by default. Don't publish
leaf 0x40000010, print the warning and carry on in this case (as the
patch does at the moment)?
