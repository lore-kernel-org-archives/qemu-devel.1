Received: from eggs.gnu.org ([2001:4830:134:3::10]:58958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJ544-0007nt-CJ
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 16:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJ541-0002aF-Td
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 16:01:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43517)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cJ541-0002Zr-OW
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 16:01:41 -0500
Date: Mon, 19 Dec 2016 19:01:39 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161219210139.GE3808@thinpad.lan.raisama.net>
References: <1482140507-23607-1-git-send-email-vlad.lungu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1482140507-23607-1-git-send-email-vlad.lungu@windriver.com>
Subject: Re: [Qemu-devel] [PATCHv4] multiboot: copy the cmdline verbatim,
 unescape module strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vlad Lungu <vlad.lungu@windriver.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Mon, Dec 19, 2016 at 11:41:47AM +0200, Vlad Lungu wrote:
> get_opt_value() truncates the value at the first comma
> Use memcpy() instead
> Unescape the module filename and parameters with get_opt_value()
> before calling mb_add_cmdline()
> 
> Signed-off-by: Vlad Lungu <vlad.lungu@windriver.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
