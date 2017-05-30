Received: from eggs.gnu.org ([2001:4830:134:3::10]:41529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dFbv0-0003Fq-MF
	for qemu-devel@nongnu.org; Tue, 30 May 2017 03:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dFbuw-0007t5-Pu
	for qemu-devel@nongnu.org; Tue, 30 May 2017 03:50:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1dFbuw-0007sp-Ir
	for qemu-devel@nongnu.org; Tue, 30 May 2017 03:50:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id b84so23115401wmh.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 00:50:12 -0700 (PDT)
References: <CAKD7DEGotyMPcyptOkfJjJ9fPKqySWLdt20SZDZ16ZHzzovNYw@mail.gmail.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <2d023d00-d42c-ae88-e8d6-1852b1e89ded@tuxfamily.org>
Date: Tue, 30 May 2017 09:50:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAKD7DEGotyMPcyptOkfJjJ9fPKqySWLdt20SZDZ16ZHzzovNYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] sharing directories with Windows guest - virtio
 pci p9 on Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Behrooz Shabani <everplays@gmail.com>, qemu-devel@nongnu.org

On 30.05.2017 08:22, Behrooz Shabani wrote:
[...]
> Any information on how to have a shared storage between different running
> VMs that would not require `-net user` is very much appreciated as well.

If you need the storage just for transferring files, you could also try
the "-device usb-mtp" ... that emulates a Media Transfer Protocol device
(similar to a camera / mobile phone).

 Thomas
