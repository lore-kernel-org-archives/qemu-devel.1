Received: from eggs.gnu.org ([2001:4830:134:3::10]:45568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzqkI-0002LM-5m
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 16:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzqkF-0006Uy-By
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 16:58:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzqkF-0006Tf-5q
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 16:58:19 -0400
Date: Wed, 4 Oct 2017 17:58:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171004205816.GA4015@localhost.localdomain>
References: <1506935300-132598-2-git-send-email-imammedo@redhat.com>
	<1507111682-66171-1-git-send-email-imammedo@redhat.com>
	<1507111682-66171-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507111682-66171-2-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qom: update doc comment for
 type_register[_static]()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Wed, Oct 04, 2017 at 12:08:00PM +0200, Igor Mammedov wrote:
> type_register()/type_register_static() functions in current impl.
> can't fail returning 0, also none of the users check for error
> so update doc comment to reflect current behaviour.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I'm queueing it on machine-next.

-- 
Eduardo
