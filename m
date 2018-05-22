Received: from eggs.gnu.org ([2001:4830:134:3::10]:48965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fLCCK-0006e7-N8
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fLCCF-000578-RY
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:39:48 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:36883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fLCCF-00055A-KA
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:39:43 -0400
Received: by mail-wr0-x22e.google.com with SMTP id i12-v6so8790400wrc.4
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 11:39:43 -0700 (PDT)
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-3-git-send-email-whois.zihan.yang@gmail.com>
	<5f5a0e11-7048-ff5a-ec0c-8d05d50c2887@gmail.com>
	<CAKwiv-iGmOJDGiOFvbvHX48xCcoUXvXQwTSUW5OxOeEB9n=d3g@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <f56745ae-91c3-af06-f5a0-b612c171db7b@gmail.com>
Date: Tue, 22 May 2018 21:39:39 +0300
MIME-Version: 1.0
In-Reply-To: <CAKwiv-iGmOJDGiOFvbvHX48xCcoUXvXQwTSUW5OxOeEB9n=d3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC 2/3] pci: Link pci_host_bridges with QTAILQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

Hi Zihan,

On 05/22/2018 08:59 AM, Zihan Yang wrote:
> >  have no objection here, we'll see later how the modification helps.
>
> The purpose is to place the q35 host at the start of queue. In the 
> original QLIST,
> when a new pxb host is added, q35 host will be bumped to the end end list.
>
> By replacing it with QTAILQ, we can always get q35 host bridges first, 
> so that
> we can make sure q35 host stays in pci domain 0. If there is no pxb host,
> the code needs not change because the 'next' field will be NULL.
>

We can use the pxb list we keep, but I don't see an issue here.

> I'm not sure whether it is necessary to let q35 host reside in pci 
> domain 0,
> but I think I'd better reserve the original when I don't know the 
> potential impact.
>

Q35 should always reside in PCI domain 0.

Thanks,
Marcel

> Thanks
> Zihan
>
