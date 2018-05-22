Received: from eggs.gnu.org ([2001:4830:134:3::10]:35495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fL0Oi-0005vJ-Bl
	for qemu-devel@nongnu.org; Tue, 22 May 2018 02:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fL0Oh-0002un-Ge
	for qemu-devel@nongnu.org; Tue, 22 May 2018 02:03:48 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fL0Oh-0002uV-8M
	for qemu-devel@nongnu.org; Tue, 22 May 2018 02:03:47 -0400
Received: by mail-lf0-x242.google.com with SMTP id u9-v6so10140202lfc.0
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 23:03:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-4-git-send-email-whois.zihan.yang@gmail.com>
	<ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Tue, 22 May 2018 14:03:45 +0800
Message-ID: <CAKwiv-gmfOhM_4BZbjH4VcTh4qmRQ0GuAskJ74T+M3KMHg6_mQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 3/3] acpi-build: allocate mcfg for multiple
 host bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, lersek@redhat.com

> An interesting point is if we want to limit the MMFCG size for PXBs, as
we may not be
> interested to use all the buses in a specific domain.

OK, perhaps providing an option for the user to specify the desired bus
numbers?

> For each bus we require some address space that remains unused.

Does this mean we should reserve some slots in a bus, or reduce
the number of buses used in each domain?

> [Adding Laszlo for his insights]
> Looking forward to see the SeaBIOS patches :)

I appreciate your reviews, I'll write the rest part as soon as possible.

Thanks
