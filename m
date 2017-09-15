Received: from eggs.gnu.org ([2001:4830:134:3::10]:48890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dslCg-0005gc-GD
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dslCb-0003uL-JT
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:38:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dslCb-0003uF-DC
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:38:17 -0400
Date: Fri, 15 Sep 2017 09:38:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170915093808.4cd4d0ae.cohuck@redhat.com>
In-Reply-To: <24e458ff-39c8-7407-62ad-46568e150c5d@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-12-david@redhat.com>
	<2c620927-0406-2fc1-895c-09ffc2e44a4e@linux.vnet.ibm.com>
	<6b3e9c2b-4cb7-fdf8-5f9b-ff7ebbf52d1e@linaro.org>
	<24e458ff-39c8-7407-62ad-46568e150c5d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/19] s390x: allow only 1 CPU with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, qemu-devel@nongnu.org, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Aurelien Jarno <aurelien@aurel32.net>

On Thu, 14 Sep 2017 20:13:49 +0200
David Hildenbrand <david@redhat.com> wrote:

> FWIW, I started factoring out today KVM SIGP code to make it usable by TCG.
> 
> I also started adding the missing SIGP instructions the kernel handles
> for KVM. I dropped the old TCG SIGP handling code and completely reuse
> the new SIGP code. I already got boot/reboot/shutdown  properly running
> (implementing STOP and RESTART interrupts like KVM has).

Cool!

> 
> But its still quite hacky and there are is a bunch of stuff to clean up,
> especially:
> - external interrupt handling (the queue approach we have right now is
>   no good for external calls and emergency signals)
> - floating interrupt support (io interrupts always going to CPU 0 is a
>   hack)
> 
> I think I can at least implement SIGP properly and fix the external call
> stuff. floating interrupts might require more thought.

I'm wondering whether something should move into the qemu version of
the flic. I'm also wondering whether we should look to the kvm floating
interrupt code for inspiration.

(I have 'look at floating interrupts with tcg' on my todo list as
well :)
