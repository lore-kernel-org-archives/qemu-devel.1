Received: from eggs.gnu.org ([2001:4830:134:3::10]:40791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1erdwx-0000D8-J4
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1erdwt-0000Yn-IQ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:13:47 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:50679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1erdwt-0000YU-Bd
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:13:43 -0500
Received: by mail-wm0-f50.google.com with SMTP id w128so1041054wmw.0
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 22:13:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <079a5da7-6586-b974-6b99-e5de055b1bd1@linux.vnet.ibm.com>
References: <079a5da7-6586-b974-6b99-e5de055b1bd1@linux.vnet.ibm.com>
From: Fam Zheng <famz@redhat.com>
Date: Fri, 2 Mar 2018 14:13:01 +0800
Message-ID: <CAK1Eb9=6ZVorRSRmNwi-xxo+mAHLuhyEZqEtOrY1d=66xPFkLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [BUG] I/O thread segfault for QEMU on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>

On Thu, Mar 1, 2018 at 10:33 PM, Farhan Ali <alifm@linux.vnet.ibm.com> wrote:
> Hi,
>
> I have been noticing some segfaults for QEMU on s390x, and I have been
> hitting this issue quite reliably (at least once in 10 runs of a test case).
> The qemu version is 2.11.50, and I have systemd created coredumps
> when this happens.

Can you describe the test case or suggest how to reproduce it for us?

Fam
