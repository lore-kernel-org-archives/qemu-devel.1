Received: from eggs.gnu.org ([2001:4830:134:3::10]:60548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWjyl-0006ah-Vp
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWjyj-0005Y7-B0
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:20:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cWjyj-0005Xp-0q
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:20:41 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BBF2804FE
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 13:20:41 +0000 (UTC)
References: <20170126014416.11211-1-lersek@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd9e48f9-760d-3f46-bc48-cf7c8e6af51c@redhat.com>
Date: Thu, 26 Jan 2017 14:20:37 +0100
MIME-Version: 1.0
In-Reply-To: <20170126014416.11211-1-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 wave 2 0/3] q35: add negotiable
 broadcast SMI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>



On 26/01/2017 02:44, Laszlo Ersek wrote:
> Hi Paolo,
> 
> I'm sending v7 with no functional changes; I've only picked up Igor's
> R-b's from v6 so you don't have to, and while rebasing to current
> master, I resolved a conflict in patch #3 against recent commit
> abc62c89f319 ("pc.h: move x-mach-use-reliable-get-clock compat entry to
> PC_COMPAT_2_8", 2017-01-18).
> 
> The series is fully reviewed and is mergeable as-is.

Much appreciated, thanks.  I hope to send the pull request already tomorrow.

Paolo

> v6 wave 2 was at
> <http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg02424.html>.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> 
> Thanks
> Laszlo
> 
> Laszlo Ersek (3):
>   hw/isa/lpc_ich9: add SMI feature negotiation via fw_cfg
>   hw/isa/lpc_ich9: add broadcast SMI feature
>   hw/isa/lpc_ich9: negotiate SMI broadcast on pc-q35-2.9+ machine types
> 
>  include/hw/i386/ich9.h | 13 ++++++++
>  include/hw/i386/pc.h   |  6 ++++
>  hw/isa/lpc_ich9.c      | 91 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 109 insertions(+), 1 deletion(-)
> 
