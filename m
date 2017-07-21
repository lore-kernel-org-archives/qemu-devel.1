Received: from eggs.gnu.org ([2001:4830:134:3::10]:57062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dYUur-00037Y-Bu
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dYUuq-0001kn-I9
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:12:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dYUuq-0001k6-CH
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:12:12 -0400
Date: Fri, 21 Jul 2017 12:12:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170721121206.63bcbffd@nial.brq.redhat.com>
In-Reply-To: <CABdb736GdDK_Kxa4u_eCt=1qiV0Hn69NfrvofJTFgaXJzx1gow@mail.gmail.com>
References: <1500629531-184026-1-git-send-email-imammedo@redhat.com>
	<CABdb736GdDK_Kxa4u_eCt=1qiV0Hn69NfrvofJTFgaXJzx1gow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc: acpi: force FADT rev1 for old i440fx
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>

On Fri, 21 Jul 2017 11:54:20 +0200
Ladi Prosek <lprosek@redhat.com> wrote:

> On Fri, Jul 21, 2017 at 11:32 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> > w2k used to boot on QEMU until we bumped revision of FADT to rev3
> > (commit 77af8a2b hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve guest OS support.)
> >
> > Considering that w2k is ancient and long time EOLed, leave default
> > rev3 but make pc-i440fx-2.9 and older machine types to force rev1
> > so old setups won't break (w2k could boot).
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > CC: Programmingkid <programmingkidx@gmail.com>
> > CC: Phil Dennis-Jordan <lists@philjordan.eu>
> > CC: "Michael S. Tsirkin" <mst@redhat.com>
> >
> > Only compile test since I don't have w2k to test with  
> 
> Confirming that Windows 2000 boots with this patch and -machine pc-i440fx-2.9.
Ladi,

Could you to try find out reason why w2k doesn't boot?

> 
> Tested-by: Ladi Prosek <lprosek@redhat.com>
