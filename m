Received: from eggs.gnu.org ([2001:4830:134:3::10]:42693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dxsVW-00026n-Oo
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dxsVS-0000fu-R0
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:26:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dxsVS-0000fK-Kn
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:26:54 -0400
Message-ID: <1506680812.6902.22.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 29 Sep 2017 12:26:52 +0200
In-Reply-To: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
References: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3 v4] xenfb: Enablement for Windows PV
 HID frontend
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Owen Smith <owen.smith@citrix.com>, sstabellini@kernel.org, anthony.perard@citrix.com
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On Tue, 2017-09-26 at 14:43 +0000, Owen Smith wrote:
> Improve the input device model in xenfb, by updating the
> Qemu input handlers and adding a feature to allow for
> raw (unscaled) absolute coordinates to be represented.
> 
> By using a reverse mapping call, the Linux input.h #defines
> are not pulled into xenfb, and so should remove the compiler
> warnings reported.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

What is the plan with this?  Merge through xen queue?  I can merge it
via ui queue too, but in that case I'd like to get an review from the
xen guys.

Note: conflicts with keycodemapdb patch series, might need a rebase
depending on merge order.

cheers,
  Gerd
