Received: from eggs.gnu.org ([2001:4830:134:3::10]:55542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1d9JMt-0004jF-V3
	for qemu-devel@nongnu.org; Fri, 12 May 2017 18:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1d9JMq-0006L7-2r
	for qemu-devel@nongnu.org; Fri, 12 May 2017 18:49:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1d9JMp-0006KM-Sv
	for qemu-devel@nongnu.org; Fri, 12 May 2017 18:49:00 -0400
References: <dcc8c16f-7d4d-3fdf-a1e8-508548239bb1@landley.net>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d15aabb2-2313-4b2e-4e88-0649664aaf01@redhat.com>
Date: Sat, 13 May 2017 00:48:56 +0200
MIME-Version: 1.0
In-Reply-To: <dcc8c16f-7d4d-3fdf-a1e8-508548239bb1@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] multiple -append?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rob Landley <rob@landley.net>, qemu-devel@nongnu.org

On 05/12/17 16:20, Rob Landley wrote:
> When I feed a second -append to qemu-system-i386 they don't get
> concatenated, the second replaces the first. Why is it called "append" then?

This behavior dates back to commit a20dd508aa38 ("simplified invocation
- added automatic IDE disk geometry guessing to reuse old disk images
directly", 2003-09-30), which is when "-append" was added.

In said commit, "kernel_cmdline" was *appended* to "params->commandline"
with pstrcat(). The rest is history.

TL;DR: "just because" :)

Thanks
Laszlo
