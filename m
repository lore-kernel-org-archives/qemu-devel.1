Received: from eggs.gnu.org ([2001:4830:134:3::10]:34010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fO3rY-00019A-4K
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fO3rU-0001cs-Vu
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:22:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fO3rU-0001cE-Ph
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:22:08 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com
	[10.5.11.26])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6CE4A30BDEF6
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 16:22:07 +0000 (UTC)
Date: Wed, 30 May 2018 13:22:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180530162203.GD7451@localhost.localdomain>
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
	<20180530124717.7b1af597@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530124717.7b1af597@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 00/11] enable numa configuration before
 machine_init() from QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, May 30, 2018 at 12:47:17PM +0200, Igor Mammedov wrote:
> Eduardo,
> 
> I've rebased series on top of current master
> the only change in several patches was s/2.13/3.0/
> otherwise there weren't any other conflicts.
> You can find rebased version at
> 
> https://github.com/imammedo/qemu.git qmp_preconfig_v9

Thanks!  I've rebased my branch on top of it and noticed that the
only differences are the "since 3.0" lines.  I've fixed them and
pushed a new numa-next branch.

Once the travis-ci job finishes, I will send a pull request.

-- 
Eduardo
