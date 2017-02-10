Received: from eggs.gnu.org ([2001:4830:134:3::10]:44485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ccDqr-0007aR-KM
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ccDqo-0007ma-Ey
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:15:13 -0500
Received: from mx3-phx2.redhat.com ([209.132.183.24]:41092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ccDqo-0007ln-5d
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:15:10 -0500
Date: Fri, 10 Feb 2017 11:14:59 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1847999171.20327674.1486743299204.JavaMail.zimbra@redhat.com>
In-Reply-To: <589DDC05.9010807@windriver.com>
References: <589C7E96.9060905@huawei.com> <589D83CE.1090803@huawei.com>
	<589DDC05.9010807@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] kvm bug in __rmap_clear_dirty during live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chris Friesen <chris.friesen@windriver.com>
Cc: "Herongguang (Stephen)" <herongguang.he@huawei.com>, rkrcmar@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, fangying1@huawei.com, "wangxin (U)" <wangxinxin.wang@huawei.com>

> Well, not so much solved as worked around it.
> 
> It seems that the problem only showed up on Broadwell, which made us wonder
> about something hardware specific.

Yes, the bug seems to be related to PML.  I am looking at the code,
but I haven't found anything yet.

Paolo
