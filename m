Received: from eggs.gnu.org ([2001:4830:134:3::10]:48245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1carAM-0001jy-Ks
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 16:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1carAJ-0002jb-CF
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 16:49:42 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:32937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1carAJ-0002jG-41
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 16:49:39 -0500
Received: by mail-wm0-x241.google.com with SMTP id v77so24522045wmv.0
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 13:49:38 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170202204510.26617.69309.malonedeb@wampee.canonical.com>
	<20170206180523.5557.56952.malone@wampee.canonical.com>
	<CAJs94EbfKZKVnR97-EuVfjMmhDhG=zwxGhdHGE_OjPCjLCXj2A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b7687a46-62d5-8d03-5766-844fef8abaa8@redhat.com>
Date: Mon, 6 Feb 2017 22:49:35 +0100
MIME-Version: 1.0
In-Reply-To: <CAJs94EbfKZKVnR97-EuVfjMmhDhG=zwxGhdHGE_OjPCjLCXj2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1661386] Re: Assertion `ret ==
 cpu->kvm_msr_buf->nmsrs' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1661386 <1661386@bugs.launchpad.net>, qemu-devel@nongnu.org



On 06/02/2017 20:38, Matwey V. Kornilov wrote:
>> OK, so that suggests the problem is that with PMU disabled in VMWare
>> config, it's not giving the right info to the guest to know it's
>> disabled.
> How should it provide info? Can we check it?

ver should have been 0 when PMU is disabled.

Can you run "x86info -a" in the host (the VMware guest)?  Maybe it's not
a VMware bug. :)

Paolo
