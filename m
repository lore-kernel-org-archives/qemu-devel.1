Received: from eggs.gnu.org ([2001:4830:134:3::10]:40510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNx1k-0001mm-6J
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNx1h-00014n-43
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:59:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dNx1g-00014V-RZ
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:59:41 -0400
Date: Thu, 22 Jun 2017 03:59:38 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1191660648.11171409.1498118378181.JavaMail.zimbra@redhat.com>
In-Reply-To: <6639c0c3-0db4-d96e-8227-6b5bf169d232@redhat.com>
References: <1497937927-19738-1-git-send-email-thuth@redhat.com>
	<1497937927-19738-9-git-send-email-thuth@redhat.com>
	<d76ab927-ba90-f8d1-000d-b596edeccfcb@twiddle.net>
	<6639c0c3-0db4-d96e-8227-6b5bf169d232@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 8/8] hw/misc/edu: Compile the edu device
 as common object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org



----- Original Message -----
> From: "Thomas Huth" <thuth@redhat.com>
> To: "Richard Henderson" <rth@twiddle.net>, qemu-devel@nongnu.org, "Paolo Bonzini" <pbonzini@redhat.com>
> Sent: Wednesday, June 21, 2017 3:40:31 AM
> Subject: Re: [PATCH v3 8/8] hw/misc/edu: Compile the edu device as common object
> 
> On 20.06.2017 20:14, Richard Henderson wrote:
> > On 06/19/2017 10:52 PM, Thomas Huth wrote:
> >> edu.c does not contain any target-specific code, so we can put
> >> it into common-obj-y to compile it only once for all targets.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> > 
> > Isn't CONFIG_EDU defined by the target, via pci.conf?
> > Would it ever be set generically?
> 
> This is about Makefiles, not #defines in C sources ... so if I
> understand our build-system correctly, the variable is set for the
> Makefiles of the targets that use pci.mak. As far as I see, it gets
> compiled correctly here.
> And we've got plenty of those common-obj-$(CONFIG_xxx) statements
> elsewhere in this file (e.g. for CONFIG_PCI_TESTDEV which is also
> declared in default-configs/pci.mak), so this is just normal, no problem
> here, as far as I can tell.

Yes, the variable is evaluated once during the main directory build,
where it comes from config-all-devices.mak.  Then it is evaluated again
during the per-target build, where it comes from target-specific
configuration.

config-all-devices.mak should be documented in docs/devel/build-system.txt.

Paolo
Paolo
