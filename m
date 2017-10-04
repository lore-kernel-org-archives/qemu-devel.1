Received: from eggs.gnu.org ([2001:4830:134:3::10]:42174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzqZ8-0007Hq-9x
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 16:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzqZ4-0004Jg-E7
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 16:46:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzqZ4-0004JK-7W
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 16:46:46 -0400
Date: Wed, 4 Oct 2017 17:46:43 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171004204643.GB5259@localhost.localdomain>
References: <20171004030025.7866-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004030025.7866-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Deprecate -nodefconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair23@gmail.com>

On Wed, Oct 04, 2017 at 12:00:23AM -0300, Eduardo Habkost wrote:
> Changes v2 -> v3:
> * Move documentation to the right section of qemu-doc.texi
> 
> Changes v1 -> v2:
> * Document at "Deprecated features" section in qemu-doc.texi
>   (Daniel)
> * Remove documentation for the option from qemu-options.hx
>   (Markus)
> 
> Since 2012 (commit ba6212d8 "Eliminate cpus-x86_64.conf file") we
> have no default config files that would be disabled using
> -nodefconfig.  This series cleans up the code, updates
> documentation, and document -nodefconfig as deprecated.

Paolo, if you are OK with it I'm queueing this series on
machine-next.

-- 
Eduardo
