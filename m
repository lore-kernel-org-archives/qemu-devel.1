Received: from eggs.gnu.org ([2001:4830:134:3::10]:34091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWLRE-0007q7-BZ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:17:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWLRA-0002wP-F8
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:17:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gWLRA-0002vL-7S
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:17:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51FC9356F1
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 13:17:27 +0000 (UTC)
Date: Mon, 10 Dec 2018 14:17:26 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181210131726.erol3faahqvrtelm@sirius.home.kraxel.org>
References: <1543614312-54253-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543614312-54253-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0] usb: move
 ehci_create_ich9_with_companions to hw/i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Nov 30, 2018 at 10:45:12PM +0100, Paolo Bonzini wrote:
> This function is only needed when Q35 is in use.  Moving it to
> the same file that uses it lets you disable the entire USB
> subsystem in x86_64-softmmu.mak; of course doing that will
> cause -usb to break horribly, but one thing at a time.

Patch doesn't apply.

> -    if (0 && machine_usb(machine)) {
> +    if (machine_usb(machine)) {

Leftover local debug change here?

cheers,
  Gerd
