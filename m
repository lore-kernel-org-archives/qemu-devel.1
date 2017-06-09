Received: from eggs.gnu.org ([2001:4830:134:3::10]:34993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dJIHf-0003HF-BC
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dJIHb-0006Zp-Ck
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:40:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dJIHb-0006Zj-6S
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:40:51 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CEC19C04B332
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 11:40:49 +0000 (UTC)
References: <20170608161013.17920-1-lersek@redhat.com>
	<20170608204026-mutt-send-email-mst@kernel.org>
	<1496951333.29761.5.camel@redhat.com>
	<20170608224942-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7a7647cd-3d7a-0b6f-0691-d656c9026f44@redhat.com>
Date: Fri, 9 Jun 2017 13:40:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170608224942-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] q35/mch: implement extended TSEG sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>



On 08/06/2017 21:55, Michael S. Tsirkin wrote:
> We don't have room anywhere in PCI config space. Laszlo makes argument
> why it's safe for this device based on spec but it's anyone's guess
> whether current and future software will follow spec.  In short, going
> anywhere near the emulated device has a potential to break some drivers.

There are no such drivers.  The MCH and PCH are only touched by the
firmware, not by the OS.  There are exceptions such as the Intel
graphics driver's incestuous relationship with the PCH, but they are
well known.

Let's avoid overengineering please.  The only sensible (but less
sensible) alternative is to just say it's 32MB (or 64, or 128) and cross
fingers that we won't need more.

Paolo
