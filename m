Received: from eggs.gnu.org ([2001:4830:134:3::10]:58717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdFnB-0000I8-22
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdFn6-0008Mc-5u
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:31:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdFn5-0008MW-WF
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:31:36 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12E4C80F8F
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 12:31:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170203160651.19917-2-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 3 Feb 2017 16:06:48 +0000")
References: <20170203160651.19917-1-dgilbert@redhat.com>
	<20170203160651.19917-2-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 13 Feb 2017 13:31:27 +0100
Message-ID: <87lgta5l28.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/4] migration: Add
 VMSTATE_UNUSED_VARRAY_UINT32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> VMSTATE_UNUSED_VARRAY_UINT32 is used to skip a chunk of the stream
> that's an n-element array;  note the array size and the dynamic value
> read never get multiplied so there's no overflow risk.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
