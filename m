Received: from eggs.gnu.org ([2001:4830:134:3::10]:49704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fik2Z-0004dO-6S
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fik2U-00046L-Ap
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:27:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54512 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fik2U-00045Q-4Z
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:26:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1855781663C5
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 17:26:57 +0000 (UTC)
Date: Thu, 26 Jul 2018 20:26:55 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180726201502-mutt-send-email-mst@kernel.org>
References: <20180710000024.542612-1-mst@redhat.com>
	<20180710000024.542612-7-mst@redhat.com>
	<20180725144205.67dc24c0@redhat.com>
	<20180725155031-mutt-send-email-mst@kernel.org>
	<20180725163928.418a485c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725163928.418a485c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH hack dontapply v2 6/7] acpi: aml generation
 for _CST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com

On Wed, Jul 25, 2018 at 04:39:28PM +0200, Igor Mammedov wrote:
> Fixed dynamic tables are usually more or less self sufficient
> so it's safer to reload so I'm ok with their reloading.

Well it's just a matter of excercising self-control and
building sane APIs to make sure we do.
E.g. let's say we agree on prefix DQ for dynamic tables.

Now, isn't

Name(DQCS, Package() {...} )

which is constrained not to use any names from the main
table not self-sufficient?

To ensure this contraint, we can add APIs like dynamic_name
that add the "DQ" prefix, and we can verify that a dynamic
table does not use a name without this prefix.

> As for current cpuhp interface, it was designed to be extendable
> and we can extend it for CST. It most likely would be much less
> code to extend than it is in this series.

I do have patches that use cpuhp to signal CST changes.
I don't think cpuhp solves the mess that is dynamic
package generation though.

-- 
MST
