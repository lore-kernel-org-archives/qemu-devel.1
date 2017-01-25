Received: from eggs.gnu.org ([2001:4830:134:3::10]:40320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cWRLP-0008Ci-QG
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cWRLP-0000m4-0j
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:26:51 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:33620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cWRLO-0000lI-Ml
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:26:50 -0500
Received: by mail-ot0-x241.google.com with SMTP id f9so24330480otd.0
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 09:26:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6ce45588-a312-aff1-6e7a-e54e29d4882c@redhat.com>
References: <1484921496-11257-1-git-send-email-phil@philjordan.eu>
	<6ce45588-a312-aff1-6e7a-e54e29d4882c@redhat.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 25 Jan 2017 18:26:29 +0100
Message-ID: <CAAibmn3ihTgE=U15e3PkR7P8WE3hEEnoAv8COcuQmZEX5EK9Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 0/3] x86-kvm: Fix Mac guest timekeeping
 by exposing TSC frequency in CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org

On 24 January 2017 at 12:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Looks good, thanks!  Queued patches 1 and 3 for 2.9 (patch 2 is in already).

Awesome, thanks for your help!

As there are now some minor merge conflicts with upstream, I've
rebased the remaining 2 patches on latest master, they're in the
vmware-cpuid-freq branch at https://github.com/pmj/qemu.git - in case
that makes your job of merging them a bit easier.

Phil
