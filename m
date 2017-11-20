Received: from eggs.gnu.org ([2001:4830:134:3::10]:41044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eGlt7-0000MQ-6y
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:13:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eGlt6-0001Hq-EP
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:13:25 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171120091520.86128-1-borntraeger@de.ibm.com>
	<5a4be37f-29b5-1d0d-91ab-9cb15c93e088@suse.de>
	<08cec003-1291-8302-1280-d53cba5c7538@de.ibm.com>
	<5a6cd622-3064-a920-8f72-bc820aa13203@suse.de>
	<ca89eb6e-4565-c789-02f4-98ea6ab05b2f@de.ibm.com>
	<7c64f444-d9b7-f2d0-0717-717365efa268@suse.de>
	<c2859af2-e14c-9a36-9842-11ee5d90b989@de.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d18f5fab-e437-6c0b-245d-6725154941ec@twiddle.net>
Date: Mon, 20 Nov 2017 14:13:13 +0100
MIME-Version: 1.0
In-Reply-To: <c2859af2-e14c-9a36-9842-11ee5d90b989@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc-bios/s390-ccw: build s390 bios with
 -fno-zero-initialized-in-bss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

On 11/20/2017 11:19 AM, Christian Borntraeger wrote:
> Are we sure that the range between __bss_start and _end does not include
> other elements (besides bss)?
Yes, we are sure.


r~
