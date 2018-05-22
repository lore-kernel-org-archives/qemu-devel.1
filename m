Received: from eggs.gnu.org ([2001:4830:134:3::10]:35660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fL0Pm-0006Wr-Bp
	for qemu-devel@nongnu.org; Tue, 22 May 2018 02:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fL0Pl-0003Nf-GR
	for qemu-devel@nongnu.org; Tue, 22 May 2018 02:04:54 -0400
Received: from mail-lf0-x22a.google.com ([2a00:1450:4010:c07::22a]:40339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fL0Pl-0003NM-9h
	for qemu-devel@nongnu.org; Tue, 22 May 2018 02:04:53 -0400
Received: by mail-lf0-x22a.google.com with SMTP id f22-v6so119436lfc.7
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 23:04:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <287ca613-aaeb-b2b6-77ac-df3b9ceaf7cd@gmail.com>
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<287ca613-aaeb-b2b6-77ac-df3b9ceaf7cd@gmail.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Tue, 22 May 2018 14:04:51 +0800
Message-ID: <CAKwiv-iuzspx560N9q-6P47Z33AunBrmyRP7e037om72+qBOYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 0/3] pci_expander_brdige: Put pxb host bridge
 into separate pci domain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

> Maybe we should add a parameter to the pxb-pci device specifying the PCI
domain
> instead of adding it on the fly. It will help ensuring the PCI domain
will not change over
> time due to code changes.In this case "bus sharing" should be off. For
the moment
> the pxb devices get the bus range from the same PCI domain.

That's good advice. I'll do that in v2.

Thanks,
Zihan
