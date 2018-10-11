Received: from eggs.gnu.org ([2001:4830:134:3::10]:34259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gAcpF-00043e-Dm
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gAcpB-00021D-F1
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:24:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gAcpB-00020Y-55
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:24:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C80E0C049AFC
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 15:24:27 +0000 (UTC)
References: <20181011144751.2724218-1-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4c1d98a8-f21e-4358-f47a-6087ca63412a@redhat.com>
Date: Thu, 11 Oct 2018 17:24:22 +0200
MIME-Version: 1.0
In-Reply-To: <20181011144751.2724218-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: Prevent more accidental test
 disabling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, armbru@redhat.com

On 2018-10-11 16:47, Eric Blake wrote:
> GNU make is perfectly happy to use 'check-FOO-y += bar' to
> initialize check-FOO-y.  (GNU Automake strictly insists that
> you cannot use += until after an initial = per variable, but
> thankfully we aren't using automake).
> 
> As we have had more than one instance where copy-and-paste of
> 'check-FOO-y = bar' from a first test under category FOO into
> an additional test, which ends up disabling the first (see
> commits 992159c7 and 4429532b), it's better to just always use
> the form that survives copy-and-paste, even for categories that
> don't currently add more than one test.
> 
> Done with s/^\(check-[a-z]*-y \)=/\1+=/g
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/Makefile.include | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Good idea!

Acked-by: Thomas Huth <thuth@redhat.com>
