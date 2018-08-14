Received: from eggs.gnu.org ([2001:4830:134:3::10]:35332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpY2F-0005Y5-Kq
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpY2C-0008GA-Je
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:02:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50510 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fpY2C-0008Fv-DF
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:02:48 -0400
References: <1534243693-9560-1-git-send-email-jianjay.zhou@huawei.com>
	<2278afdb-d2a6-54b3-67c7-c1f43e4d311c@redhat.com>
	<20180814115202.GH2580@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <517f613f-3885-7b6f-aff7-cffee9d8f35f@redhat.com>
Date: Tue, 14 Aug 2018 14:02:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180814115202.GH2580@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] vl: fix migration when watchdog expires
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Jay Zhou <jianjay.zhou@huawei.com>, qemu-devel@nongnu.org, quintela@redhat.com, wangxinxin.wang@huawei.com

On 14/08/2018 13:52, Dr. David Alan Gilbert wrote:
>  a) Should the watchdog expire when the VM is stopped; I think it
> shouldn't - hw/acpi/tco.c uses a virtual timer as does i6300esb; so
> is the bug here that the watchdog being used didn't use a virtual
> timer?

All watchdogs do.

>  b) If the watchdog expires just before the VM gets stopped, is there
> a race which could hit this?  Possibly.

Yes, I think it is a race that happens just before vm_stop, but I don't
understand why the "qemu_clock_enable" in pause_all_vcpus does not
prevent it.

It should be possible to write a deterministic testcase with qtest...

Paolo
