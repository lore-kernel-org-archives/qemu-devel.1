Received: from eggs.gnu.org ([2001:4830:134:3::10]:59301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJvsA-00016M-KP
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 01:29:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJvs5-0005EK-NF
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 01:29:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eJvs5-0005Dp-HA
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 01:29:25 -0500
Date: Wed, 29 Nov 2017 14:29:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171129062916.GA12220@lemon>
References: <2b5d04f3.523b.160064da4db.Coremail.15700157322@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b5d04f3.523b.160064da4db.Coremail.15700157322@163.com>
Subject: Re: [Qemu-devel] device_del fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lying <15700157322@163.com>
Cc: qemu-devel@nongnu.org

On Wed, 11/29 13:43, Lying wrote:
> Hello everybody, I encounter a error on my vm guest
> I remove my device on my guest is failed, following is detail message.
> I didn't add my audio device before running my guest, So i add audio with "device_add" after running
> Then i can use it, so i remove it with "device_del", but when i do it again, i
> can't use my audio device and cannot remove it.


I haven't tried unplugging an audio device myself but in general PCI hot unplug
needs guest cooperation so some infomation about guest is also helpful.  Which
guest OS is this?

What are the exact commands that you used and what are the messages from
host/guest when you device_del?

Fam
