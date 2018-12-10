Received: from eggs.gnu.org ([2001:4830:134:3::10]:47696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gWPUp-00034Z-VH
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gWPUn-0006Qa-Nk
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:37:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gWPUn-0006Og-6x
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:37:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 025014E33B
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 17:37:28 +0000 (UTC)
References: <1543614312-54253-1-git-send-email-pbonzini@redhat.com>
	<20181210131726.erol3faahqvrtelm@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c082c4ad-7eba-b234-110e-2e6b45c0c92d@redhat.com>
Date: Mon, 10 Dec 2018 18:37:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181210131726.erol3faahqvrtelm@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On 10/12/18 14:17, Gerd Hoffmann wrote:
> On Fri, Nov 30, 2018 at 10:45:12PM +0100, Paolo Bonzini wrote:
>> This function is only needed when Q35 is in use.  Moving it to
>> the same file that uses it lets you disable the entire USB
>> subsystem in x86_64-softmmu.mak; of course doing that will
>> cause -usb to break horribly, but one thing at a time.
> 
> Patch doesn't apply.
> 
>> -    if (0 && machine_usb(machine)) {
>> +    if (machine_usb(machine)) {
> 
> Leftover local debug change here?

Yes, more precisely this patch replaced the quick "0 &&" hack.

Paolo
