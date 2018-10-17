Received: from eggs.gnu.org ([2001:4830:134:3::10]:39225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCmAN-00083I-W8
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCmAI-0007oV-PV
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:47:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gCmAI-0007nI-Gw
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:47:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96C0785A07
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 13:47:09 +0000 (UTC)
Date: Wed, 17 Oct 2018 15:47:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181017134707.GD31479@localhost.localdomain>
References: <20181017082702.5581-1-armbru@redhat.com>
	<20181017082702.5581-37-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017082702.5581-37-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 36/38] block: Clean up
 bdrv_img_create()'s error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 17.10.2018 um 10:27 hat Markus Armbruster geschrieben:
> bdrv_img_create() takes an Error ** argument and uses it in the
> conventional way, except for one place: when qemu_opts_do_parse()
> fails, it first reports its error to stderr or the HMP monitor with
> error_report_err(), then error_setg()'s a generic error.
> 
> When the caller reports that second error similarly, this produces two
> consecutive error messages on stderr or the HMP monitor.
> 
> When the caller does something else with it, such as send it via QMP,
> the first error still goes to stderr or the HMP monitor.  Fortunately,
> no such caller exists.
> 
> Simply use the first error as is.  Update expected output of
> qemu-iotest 049 accordingly.
> 
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
