Received: from eggs.gnu.org ([2001:4830:134:3::10]:45238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <malbarbo@gmail.com>) id 1e066y-00011a-5G
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <malbarbo@gmail.com>) id 1e066u-0001kt-3n
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:22:48 -0400
MIME-Version: 1.0
In-Reply-To: <82b1a00d-ea31-c76f-96bd-402828cceebf@redhat.com>
References: <CAHpsRN-XzxjJZb=rb0iHMv4Afv=2H3N5U7p4+NNJFPkxgSLMXg@mail.gmail.com>
	<43071208-759c-6476-0cb0-c4e7e0daaf77@redhat.com>
	<CAHpsRN9s_qa_knpn0QRVu0UasFrx1c+nvy2rY6hHB7GvnRkCZg@mail.gmail.com>
	<82b1a00d-ea31-c76f-96bd-402828cceebf@redhat.com>
From: Marco A L Barbosa <malbarbo@gmail.com>
Date: Thu, 5 Oct 2017 10:22:41 -0300
Message-ID: <CAHpsRN-MpkJyBsO2y0DEOyuo_wAGT+F-y6yzQT=ObL220rZ9eg@mail.gmail.com>
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

I submitted a new patch. Thanks.

On Thu, Oct 5, 2017 at 7:35 AM, Laurent Vivier <lvivier@redhat.com> wrote:

> On 05/10/2017 12:24, Marco A L Barbosa wrote:
> >     I doesn't look really trivial...
> >
> >     To manage the buf field you must read buf_size and it cannot be done
> in
> >     a generic way: you must define a function to translate the buffer,
> use
> >     IOCTL_SPECIAL() with RNDADDENTROPY and RNDGETPOOL.
> >
> >     You should send your patch using "git send-email" or "git publish"
> >     instead of adding it in you email client.
> >
> >
> > Thanks for your advices.
> >
> > My use case only requires support for RNDGETENTCNT... Considering that
> > RNDADDENTROPY and RNDGETPOOL are non trivial, would a patch with only
> > RNDGETENTCNT, RNDADDTOENTCNT, RNDZAPENTCNT and RNDCLEARPOOL be accepted?
>
> I think you can only post what you use. If it is tested, it's better...
>
> Thanks,
> Laurent
>



-- 
Marco A L Barbosa
http://malbarbo.pro.br
--
