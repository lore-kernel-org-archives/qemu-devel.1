Received: from eggs.gnu.org ([2001:4830:134:3::10]:36466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmGgz-0001S4-9O
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmGgv-0001DB-3j
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:18:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:31370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cmGgu-0001D4-U2
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:18:29 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 292824DD5F
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 09:18:29 +0000 (UTC)
References: <20170309182049.30040-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2ccd013f-ade7-58e5-aef5-a8aa94659d09@redhat.com>
Date: Fri, 10 Mar 2017 10:18:26 +0100
MIME-Version: 1.0
In-Reply-To: <20170309182049.30040-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9? v2 0/2] vl: Print warning if a
 non-empty default config-file is found
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



On 09/03/2017 19:20, Eduardo Habkost wrote:
> (This missed hard freeze, but I would still like to include the
> warning in 2.9 so we can remove the default config file in 2.10.
> I will include this series in a pull request only if at least 2
> other maintainers send their Acked-by.)
> 
> We plan to remove support for /etc/qemu/qemu.conf in the near
> future. Make QEMU print a warning in case there a non-empty
> /etc/qemu/qemu.conf is loaded, so users have time to adapt.

Thanks, it's certainly good to have this in 2.9.

Paolo
