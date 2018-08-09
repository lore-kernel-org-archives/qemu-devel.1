Received: from eggs.gnu.org ([2001:4830:134:3::10]:40336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fndVQ-0003Ms-7U
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 01:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fndVN-0002Gv-2m
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 01:29:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fndVM-0002Gg-Rz
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 01:29:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE7E877886
	for <qemu-devel@nongnu.org>; Thu,  9 Aug 2018 05:28:59 +0000 (UTC)
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-6-quintela@redhat.com>
	<81c76597-7dd3-59f0-8b04-4972e489bbc8@redhat.com>
	<87lg9gx04f.fsf@trasno.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8a4af30e-b61d-6892-6a36-c18b1c9dfb8c@redhat.com>
Date: Thu, 9 Aug 2018 07:28:55 +0200
MIME-Version: 1.0
In-Reply-To: <87lg9gx04f.fsf@trasno.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/22] check: Only test usb-xhci-nec
 when it is compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 08/08/2018 07:02 PM, Juan Quintela wrote:
> Thomas Huth <thuth@redhat.com> wrote:
[...]
> I didn't want to go "further", but I think that we should have here is
> something like:
> 
> check-qtest-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
> gcov-files-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci.c
> 
> and remove the arch specific bits.  If one arch don't support it, we
> know have CONFIG_USB_XHCI bits to not _enable_ it there.
> 
> What do you think?
> 
> Thanks, Juan.

If "make check" passes with that change, that sounds like the right
solution to me, too.

 Thomas
