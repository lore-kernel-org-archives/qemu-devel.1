Received: from eggs.gnu.org ([2001:4830:134:3::10]:37300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsQ3s-0003v1-O4
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsQ3r-0005Ew-A6
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:08:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38946 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fsQ3n-00055H-GQ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:08:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4ECB24023ECB
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 10:08:11 +0000 (UTC)
References: <20180822095421.11765-1-quintela@redhat.com>
	<20180822095421.11765-2-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f95390a5-2b4b-e364-34b4-15ff62c2c580@redhat.com>
Date: Wed, 22 Aug 2018 12:08:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180822095421.11765-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/10] configure: We don't want to clean
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 2018-08-22 11:54, Juan Quintela wrote:
> If you don't want to compile everything, you configure
> config-devices.mak.  And then make clean remove it, and make will
> create a default one without your configuration.  Fix it by not
> removing it on clean target.  Remove it instead on distclean.

Sounds like a good idea!

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 
> Remove it instead on distclean.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Please remove the duplicated Sob. Then you can add:

Reviewed-by: Thomas Huth <thuth@redhat.com>
