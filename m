Received: from eggs.gnu.org ([2001:4830:134:3::10]:60655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYuTz-0001R2-B1
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:57:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYuTv-00085N-W0
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:57:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cYuTv-00085D-Q4
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:57:51 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCBA661B86
	for <qemu-devel@nongnu.org>; Wed,  1 Feb 2017 12:57:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170109201340.16593-3-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 9 Jan 2017 20:13:39 +0000")
References: <20170109201340.16593-1-dgilbert@redhat.com>
	<20170109201340.16593-3-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 01 Feb 2017 13:57:45 +0100
Message-ID: <87shnyqd9y.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Check for ID length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, amit.shah@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The qdev id of a device can be huge if it's on the end of a chain
> of bridges; in reality such chains shouldn't occur but they can
> be made to by chaining PCIe bridges together.
>
> The migration format has a number of 256 character long format
> limits; check we don't hit them (we already use pstrcat/cpy but
> that just protects us from buffer overruns, we fairly quickly
> hit an assert).
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
