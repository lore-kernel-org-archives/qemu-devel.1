Received: from eggs.gnu.org ([2001:4830:134:3::10]:44322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY6Qu-0002Z7-Ql
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY6Qr-00052D-7s
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:08:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56058 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fY6Qr-00051v-3c
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:08:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96A81406E8C4
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 09:08:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180611060228.2998-3-peterx@redhat.com> (Peter Xu's message of
	"Mon, 11 Jun 2018 14:02:28 +0800")
References: <20180611060228.2998-1-peterx@redhat.com>
	<20180611060228.2998-3-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 27 Jun 2018 11:11:34 +0200
Message-ID: <87tvpolhkp.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: delay postcopy paused state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Before this patch we firstly setup the postcopy-paused state then we
> clean up the QEMUFile handles.  That can be racy if there is a very fast
> "migrate-recover" command running in parallel.  Fix that up.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
