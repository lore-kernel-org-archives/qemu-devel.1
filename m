Received: from eggs.gnu.org ([2001:4830:134:3::10]:34626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fL0L2-0004JK-65
	for qemu-devel@nongnu.org; Tue, 22 May 2018 02:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fL0L1-0001cg-DU
	for qemu-devel@nongnu.org; Tue, 22 May 2018 02:00:00 -0400
Received: from mail-lf0-x236.google.com ([2a00:1450:4010:c07::236]:43425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fL0L1-0001bn-5j
	for qemu-devel@nongnu.org; Tue, 22 May 2018 01:59:59 -0400
Received: by mail-lf0-x236.google.com with SMTP id n18-v6so27265051lfh.10
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 22:59:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5f5a0e11-7048-ff5a-ec0c-8d05d50c2887@gmail.com>
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-3-git-send-email-whois.zihan.yang@gmail.com>
	<5f5a0e11-7048-ff5a-ec0c-8d05d50c2887@gmail.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Tue, 22 May 2018 13:59:57 +0800
Message-ID: <CAKwiv-iGmOJDGiOFvbvHX48xCcoUXvXQwTSUW5OxOeEB9n=d3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 2/3] pci: Link pci_host_bridges with QTAILQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>

>  have no objection here, we'll see later how the modification helps.

The purpose is to place the q35 host at the start of queue. In the original
QLIST,
when a new pxb host is added, q35 host will be bumped to the end end list.

By replacing it with QTAILQ, we can always get q35 host bridges first, so
that
we can make sure q35 host stays in pci domain 0. If there is no pxb host,
the code needs not change because the 'next' field will be NULL.

I'm not sure whether it is necessary to let q35 host reside in pci domain 0,
but I think I'd better reserve the original when I don't know the potential
impact.

Thanks
Zihan
