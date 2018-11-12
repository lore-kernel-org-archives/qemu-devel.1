Received: from eggs.gnu.org ([2001:4830:134:3::10]:49976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gM9HD-0003UM-Mq
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:17:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gM9H8-0007JZ-Ij
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:17:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gM9H8-0007IR-3z
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:16:58 -0500
References: <20181109141447.13101-1-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <46a2f2b3-37f0-665f-2b1d-a5b5983d911e@redhat.com>
Date: Mon, 12 Nov 2018 11:16:50 +0100
MIME-Version: 1.0
In-Reply-To: <20181109141447.13101-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/bt: drop bluetooth keyboard emulation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrzej Zaborowski <andrew.zaborowski@intel.com>, Andrzej Zaborowski <balrogg@gmail.com>

On 2018-11-09 15:14, Gerd Hoffmann wrote:
> Broken (segfaultson first keypress) and appearently unused.

Broken since QEMU v2.1 (!) already, if I've got that right - please
mention that version number, so that it is clear that it is broken since
more than two releases (i.e. it has been "deprecated" by being broken
for so long).

There is also one more occurance of "-bt device:keyboard" in
qemu-doc.texi which you should now remove, too, I think.

 Thomas
