Received: from eggs.gnu.org ([2001:4830:134:3::10]:58850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1drPwn-0003bB-MY
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1drPwj-0002Qh-P7
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:44:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1drPwj-0002Pe-J5
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:44:21 -0400
Date: Mon, 11 Sep 2017 15:44:14 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170911144414.GB26791@stefanha-x1.localdomain>
References: <CANr0WEe-r-eXMt2sZuVSVGs5Zk1h+_BhmW30sCptzi2oeZUduQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANr0WEe-r-eXMt2sZuVSVGs5Zk1h+_BhmW30sCptzi2oeZUduQ@mail.gmail.com>
Subject: Re: [Qemu-devel] irqfd for QEMU NVMe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Huaicheng Li <lhcwhu@gmail.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Sep 08, 2017 at 04:17:32PM -0500, Huaicheng Li wrote:
> I'm writing to ask if it's possible to use irqfd mechanism in QEMU's NVMe
> virtual controller implementation. My search results show that back in
> 2015, there is a discussion on improving QEMU NVMe performance by utilizing
> eventfd for guest-to-host notification, thus i guess irqfd should also work
> ? If so, could you briefly describe how to do that and how much can we save
> for the host-to-guest notification path by using irqfd?

You'd could benchmark it to find out but I have a vague memory that the
ioctl() is actually faster for injecting interrupts than irqfd.

Stefan
