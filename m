Received: from eggs.gnu.org ([2001:4830:134:3::10]:33825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daSrS-0003eT-Ho
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 16:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daSrP-0005Xt-Uz
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 16:24:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daSrP-0005Wm-Oj
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 16:24:47 -0400
Date: Wed, 26 Jul 2017 16:24:41 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2080482614.19250435.1501100681184.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170726225402-mutt-send-email-mst@kernel.org>
References: <20170726093136.13627-1-pbonzini@redhat.com>
	<20170726155118-mutt-send-email-mst@kernel.org>
	<a98cf681-2f14-52f2-a5d0-b6273b21dfc3@redhat.com>
	<20170726225402-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu PATCH for 2.10] i386: acpi: provide an XSDT
 instead of an RSDT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, seabios@seabios.org, lersek@redhat.com, lists@philjordan.eu, imammedo@redhat.com, phil@philjordan.eu, programmingkidx@gmail.com, kraxel@redhat.com


> The point is that for PC we really should not keep piling up hacks,
> compatibility is more important.

Non-explosion of the test matrix is just as important.

> > Doing it for PC only would mean switching
> > back from FADT rev3 to rev1, which is worse for guest OS support,
> 
> It's only OSX AFAIK and IIRC OSX doesn't run on PC anyway.

Sure it does.  You can run it on VMware Workstation which emulates
some i440FX-like chipset.

> It's definitely way more code. I'll change my mind if there's
> a guest that needs the new FADT.

Then you can prepare a patch to revert the FADTv3 commit, or do the
work to make it specific to the 2.10 Q35 machine type.

Paolo
