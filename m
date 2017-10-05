Received: from eggs.gnu.org ([2001:4830:134:3::10]:46309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <malbarbo@gmail.com>) id 1e03Kl-0004wK-Qh
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <malbarbo@gmail.com>) id 1e03Kk-0001nj-W7
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:24:51 -0400
MIME-Version: 1.0
In-Reply-To: <43071208-759c-6476-0cb0-c4e7e0daaf77@redhat.com>
References: <CAHpsRN-XzxjJZb=rb0iHMv4Afv=2H3N5U7p4+NNJFPkxgSLMXg@mail.gmail.com>
	<43071208-759c-6476-0cb0-c4e7e0daaf77@redhat.com>
From: Marco A L Barbosa <malbarbo@gmail.com>
Date: Thu, 5 Oct 2017 07:24:48 -0300
Message-ID: <CAHpsRN9s_qa_knpn0QRVu0UasFrx1c+nvy2rY6hHB7GvnRkCZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] linux-user: Add random
 ioctls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

>
> I doesn't look really trivial...
>
> To manage the buf field you must read buf_size and it cannot be done in
> a generic way: you must define a function to translate the buffer, use
> IOCTL_SPECIAL() with RNDADDENTROPY and RNDGETPOOL.
>
> You should send your patch using "git send-email" or "git publish"
> instead of adding it in you email client.
>

Thanks for your advices.

My use case only requires support for RNDGETENTCNT... Considering that
RNDADDENTROPY and RNDGETPOOL are non trivial, would a patch with only
RNDGETENTCNT, RNDADDTOENTCNT, RNDZAPENTCNT and RNDCLEARPOOL be accepted?

Note: I swapped the types of RNDADDTOENTCNT and RNDGETPOOL...
