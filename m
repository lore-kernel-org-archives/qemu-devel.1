Received: from eggs.gnu.org ([2001:4830:134:3::10]:58088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gNDTe-0001WY-G3
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 03:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gNDTa-00045z-RL
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 03:58:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53577)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gNDTa-00045L-HX
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 03:58:14 -0500
Date: Thu, 15 Nov 2018 16:58:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181115085808.GH27915@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] Are FreeBSD guest images working?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Devel Mailing List <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Hi, the list,

I am trying to boot a FreeBSD guest but failed.  It hangs at the
kernel booting phase:

/boot/ker]el/kernel text=0x14ed860 data=0x132538+0x4baa68 syms=[0x8+0x159ee8+0x8
Booting...
(nothing more)

It's just as simple as downloading the image and boot so I can't think
of anything strange within my procedures so far:

https://wiki.qemu.org/Hosts/BSD#FreeBSD

I also tried the latest image here:

https://download.freebsd.org/ftp/releases/VM-IMAGES/11.2-RELEASE/amd64/Latest/FreeBSD-11.2-RELEASE-amd64.qcow2.xz

but it's having the same problem as 11.0.

Am downloading an fresh ISO, but before I continue I'm just curious on
whether anyone is using these images and whether there's quick answers
to what I have encountered.

Thanks in advance,

-- 
Peter Xu
