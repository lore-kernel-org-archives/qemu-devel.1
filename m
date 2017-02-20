Received: from eggs.gnu.org ([2001:4830:134:3::10]:53688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cfh81-0005KL-M7
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 01:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cfh7x-0007qC-OT
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 01:07:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cfh7x-0007py-Hk
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 01:07:13 -0500
References: <20170217082704.23270-1-skiver.cloud.yzy@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5a03f6f2-f867-8dfe-28bb-6f481782f6af@redhat.com>
Date: Mon, 20 Feb 2017 07:07:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170217082704.23270-1-skiver.cloud.yzy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] fix segfaults caused by accessing CPU
 in empty machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ziyue Yang <skiver.cloud.yzy@gmail.com>, qemu-devel@nongnu.org
Cc: Ziyue Yang <yzylivezh@hotmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>

On 17.02.2017 09:27, Ziyue Yang wrote:
> From: Ziyue Yang <yzylivezh@hotmail.com>
> 
> Many QEMU monitor commands, like "info lapic", "info tlb" and so on
> use mon_get_cpu or related wrappers to access CPU info without checking
> whether the CPU exists.
> This patch series fix the "info lapic" case, and is the base of the incoming
> patch series aiming to eliminate segfaults caused by other QEMU commands
> trying to access CPU that doesn't exist.

 Hi,

FYI, I've posted a patch for all of these monitor commands that crash
without CPU already last month:

https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg02602.html

 Thomas
