Received: from eggs.gnu.org ([2001:4830:134:3::10]:36893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dxX54-0000zE-DQ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 07:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dxX50-0001pP-CW
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 07:34:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dxX50-0001p5-5o
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 07:34:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14E368683
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 11:34:09 +0000 (UTC)
References: <20170927203225.30896-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c0b49123-0c28-49c1-fdd6-e105d2f87aa4@redhat.com>
Date: Thu, 28 Sep 2017 13:34:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170927203225.30896-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] Deprecate -nodefconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

On 27/09/2017 22:32, Eduardo Habkost wrote:
> Since 2012 (commit ba6212d8 "Eliminate cpus-x86_64.conf file") we
> have no default config files that would be disabled using
> -nodefconfig.  This series cleans up the code, updates
> documentation, and document -nodefconfig as deprecated.

Don't forget to list this in the 2.11 changelog!

Thanks,

Paolo

> Eduardo Habkost (2):
>   vl: Eliminate defconfig variable
>   qemu-options: Deprecate -nodefconfig
> 
>  vl.c            |  5 +----
>  qemu-options.hx | 13 +++++++------
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
