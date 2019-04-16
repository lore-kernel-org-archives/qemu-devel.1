Received: from eggs.gnu.org ([209.51.188.92]:33167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGVUt-0002Au-D2
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 17:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGVUs-0002PO-Fg
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 17:20:07 -0400
Date: Tue, 16 Apr 2019 18:20:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190416212003.GB2272@habkost.net>
References: <1555315185-16414-1-git-send-email-like.xu@linux.intel.com>
	<1555315185-16414-3-git-send-email-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555315185-16414-3-git-send-email-like.xu@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] core/qdev: refactor
 qdev_get_machine() with type assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, like.xu@intel.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Mon, Apr 15, 2019 at 03:59:45PM +0800, Like Xu wrote:
> To avoid the misuse of qdev_get_machine() if machine hasn't been created yet,
> this patch uses qdev_get_machine_uncheck() for obj-common (share with user-only
> mode) and adds type assertion to qdev_get_machine() in system-emulation mode.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I'm queueing the series on machine-next, thanks!

-- 
Eduardo
