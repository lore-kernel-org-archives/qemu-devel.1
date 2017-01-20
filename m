Received: from eggs.gnu.org ([2001:4830:134:3::10]:46757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUTtB-0006wr-Tu
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUTt8-0002Yt-QY
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:45:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cUTt8-0002Yh-6n
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:45:34 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D9C985545
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 07:45:34 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
Date: Fri, 20 Jan 2017 08:45:30 +0100
In-Reply-To: <1484859998-25074-1-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 19 Jan 2017 23:07:24 +0200")
Message-ID: <87o9z22mzp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 0/4] ARRAY_SIZE fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Turns out virtio kept using ARRAY_SIZE on fields which stopped
> being arrays, this was noticed by a coverity scan.
> I fixed this up, this patchset fixes up the ARRAY_SIZE macro so that this
> bug does not reappear in any other place.

Preferably with the tweaks I asked for, series
Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks again for squashing the bug pattern, and not just the bug!
