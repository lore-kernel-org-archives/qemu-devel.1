Received: from eggs.gnu.org ([209.51.188.92]:53790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1goVCQ-00033o-8u
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:21:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1goVC7-0003Q3-RI
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:21:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1goVC7-0002ka-A8
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:20:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so22494859wrt.4
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 07:20:53 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
In-Reply-To: <20190128182229.GF2585@work-vm>
References: <20190125114155.32062-1-vkuznets@redhat.com>
	<20190125114155.32062-5-vkuznets@redhat.com>
	<20190125124738.GB30730@rkaganb.sw.ru>
	<87bm44onnh.fsf@vitty.brq.redhat.com>
	<20190128113017.GA2435@rkaganb.sw.ru>
	<87lg34zy37.fsf@vitty.brq.redhat.com>
	<20190128182229.GF2585@work-vm>
Date: Tue, 29 Jan 2019 16:20:33 +0100
Message-ID: <877eenze0u.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 4/8] i386/kvm: Implement 'hv-all'
 pass-through mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> I'm not sure what the equivalent bear traps are in the Hyper-V world,
> but I'd be surprised if there weren't any; for example what happens
> when someone upgrades one of their hosts to some minor version that
> adds/removes a feature?

Here we're talking about Hyper-V emulation in KVM, features only get
added there, but even if it gets removed it will be detected by libvirt ...

>
> Also, how does libvirt figure out that the features are actually the
> same - does it need a bunch of detection code?

... as I *think* it compares Feature CPUID words (and all Hyper-V
features which we enable with hv-all are there).

-- 
Vitaly
