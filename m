Received: from eggs.gnu.org ([2001:4830:134:3::10]:60620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1csrKF-0003jm-Sc
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1csrKB-0005ep-CC
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:38:19 -0400
Received: from [59.151.112.132] (port=48738 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1csrKA-0005dM-Vv
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:38:15 -0400
References: <1490260163-6157-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170324161234.2ada63fb@t450s.home>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58DA695D.5020306@cn.fujitsu.com>
Date: Tue, 28 Mar 2017 21:47:09 +0800
MIME-Version: 1.0
In-Reply-To: <20170324161234.2ada63fb@t450s.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] vfio-pci: support recovery of AER
 non fatal error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, mst@redhat.com



On 03/25/2017 06:12 AM, Alex Williamson wrote:
> On Thu, 23 Mar 2017 17:09:20 +0800
> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> 
>> v3 changelog:
>> 1. Address all comments from MST in patch 3, include remove the flag
>>    pci_aer_non_fatal & passive_reset, also the boilerplate code.
>>    The corresponding kernel patch is v6.
>>
>> Test:
>> Test with func1 passthroughed while func0 doesn't have user.
> 
> So the slot_reset trigger really hasn't been tested at all?

No, because we don't have that kind of multi-function device. IIRC, in
real world, most of multi-function devices have the same functions.

I plan to do basic test as described above before got Reviewed-by, and
will do full test as before after reviewed.

I will consider if we can fake to trigger slot_reset.

-- 
Sincerely,
Cao jin
