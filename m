Received: from eggs.gnu.org ([209.51.188.92]:60161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGVRB-0001Hg-SC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 17:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGVRA-0007uw-Sy
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 17:16:17 -0400
Date: Tue, 16 Apr 2019 18:16:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190416211606.GA2272@habkost.net>
References: <1555315185-16414-1-git-send-email-like.xu@linux.intel.com>
	<1555315185-16414-2-git-send-email-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555315185-16414-2-git-send-email-like.xu@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] vl.c: refactor current_machine as
 non-global variable
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

On Mon, Apr 15, 2019 at 03:59:44PM +0800, Like Xu wrote:
> This patch makes the remaining dozen or so uses of the global
> current_machine outside vl.c use qdev_get_machine() instead,
> and then make current_machine local to vl.c instead of global.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
