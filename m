Received: from eggs.gnu.org ([2001:4830:134:3::10]:51454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jmattson@google.com>) id 1gIIqm-0007kO-EZ
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 15:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jmattson@google.com>) id 1gIIqj-0004bJ-Nj
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 15:41:52 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jmattson@google.com>) id 1gIIqh-0004W4-ST
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 15:41:48 -0400
Received: by mail-ot1-x343.google.com with SMTP id g27so5970255oth.6
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 12:41:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181101190730.GF2726@work-vm>
References: <5F34DE35-D1EE-441A-87A1-379C7A04AFE7@oracle.com>
	<20181031181759.GR3902@habkost.net>
	<a5b6cdf7-6ff9-7bd8-d591-3e2669b4f802@redhat.com>
	<B34C4E8C-748D-4D78-807F-3F51C80EA5B2@oracle.com>
	<20181031185930.GC2403@work-vm>
	<5FA867F7-3520-4903-BC2F-B55227A04FED@oracle.com>
	<20181101131059.GB2726@work-vm>
	<F144DC98-45AA-4DD8-8A7E-25B867FE7863@oracle.com>
	<20181101155610.GD2726@work-vm>
	<13842591-5801-493B-A82D-FE44610FE5A1@oracle.com>
	<20181101190730.GF2726@work-vm>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 1 Nov 2018 12:41:42 -0700
Message-ID: <CALMp9eSEtzJ05fBoyXNaaepFtH2+BepoLocNFm1xXvJfdS0zfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [QEMU PATCH v2 0/2]: KVM: i386: Add support for
 save and restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Liran Alon <liran.alon@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm list <kvm@vger.kernel.org>, mtosatti@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net

On Thu, Nov 1, 2018 at 12:07 PM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:

> OK; the tricky thing is when you upgrade one host in a small cluster as
> you start doing an upgrade, and then once it's got it's first VM you
> can't migrate away from it until others are updated; that gets messy.

One must always be able to migrate off of kernel N+1 back to kernel N.
We depend on that whenever we have to rollback a kernel upgrade.
