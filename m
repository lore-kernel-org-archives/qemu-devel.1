Received: from eggs.gnu.org ([2001:4830:134:3::10]:39537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fixsk-00051I-Lk
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fixsh-0000YF-Gp
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:13:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fixsh-0000Vx-Ac
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:13:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB8AD819700A
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 08:13:44 +0000 (UTC)
Reply-To: thuth@redhat.com
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-21-quintela@redhat.com>
	<13a77722-0a4e-ede7-60e9-749278c39d3a@redhat.com>
	<87sh468258.fsf@secure.laptop>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d8a97d29-951a-f851-5f9c-b58422bc5e41@redhat.com>
Date: Fri, 27 Jul 2018 10:13:42 +0200
MIME-Version: 1.0
In-Reply-To: <87sh468258.fsf@secure.laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/25] check: Only test usb-xhci-nec when
 it is compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

On 07/26/2018 05:09 PM, Juan Quintela wrote:
> Thomas Huth <thuth@redhat.com> wrote:
>> On 17.07.2018 13:33, Juan Quintela wrote:
[...]
>>> @@ -347,8 +347,8 @@ check-qtest-ppc64-y += tests/usb-hcd-ohci-test$(EXESUF)
>>>  gcov-files-ppc64-y += hw/usb/hcd-ohci.c
>>>  check-qtest-ppc64-y += tests/usb-hcd-uhci-test$(EXESUF)
>>>  gcov-files-ppc64-y += hw/usb/hcd-uhci.c
>>> -check-qtest-ppc64-y += tests/usb-hcd-xhci-test$(EXESUF)
>>> -gcov-files-ppc64-y += hw/usb/hcd-xhci.c
>>> +check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
>>> +gcov-files-ppc64-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci.c
>>>  check-qtest-ppc64-y += $(check-qtest-virtio-y)
>>>  check-qtest-ppc64-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
>>>  check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
>>
>> I wonder whether the gcov lines are still up-to-date, or whether they
>> should include hcd-xhci-nec.c as well? (See commit 0bbb2f3df1ffd9ccf713
>> for the split)
> 
> Added the hcd-xhci-nec.c file to gcov.  I still don't know how to launch
> gcowv :-(  So no clue about how up-to-date the lines are.

See docs/devel/testing.rst - this file contains some explanations.

 Cheers,
  Thomas
