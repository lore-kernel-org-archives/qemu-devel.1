Received: from eggs.gnu.org ([209.51.188.92]:45716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hF12V-0002dW-3h
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hF12U-0004TF-85
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:36:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hF12U-0004Rr-0y
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:36:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C062308792D
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 18:36:36 +0000 (UTC)
Date: Fri, 12 Apr 2019 15:36:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190412183628.GA31999@habkost.net>
References: <20190411175345.19414-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411175345.19414-1-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1] Declare -realtime as
 deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Apr 11, 2019 at 07:53:45PM +0200, Thomas Huth wrote:
> The old -realtime mlock=on|off parameter does exactly the same as the
> new -overcommit mem-lock=on|off parameter. Additionally, "-realtime"
> does not activate any additional "realtime" capabilities as the name
> might indicate. We should avoid to confuse the users this way, so
> let's deprecate the old -realtime option.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Paolo, do you want to queue this, or should I do it through the
machine queue?

-- 
Eduardo
