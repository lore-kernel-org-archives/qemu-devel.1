Received: from eggs.gnu.org ([2001:4830:134:3::10]:53677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFjYm-0008Ev-Jj
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFjYj-0005dB-Id
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:59:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFjYj-0005d4-C5
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:59:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 269ECC049D57
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 15:59:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495176212-14446-5-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Fri, 19 May 2017 14:43:30 +0800")
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
	<1495176212-14446-5-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 30 May 2017 17:59:44 +0200
Message-ID: <87o9uae3nz.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 4/6] migration: shut src return path
 unconditionally
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
> We were do the shutting off only for postcopy. Now we do this as long as
> the source return path is there.
>
> Moving the cleanup of from_src_file there too.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

You can also submmit this and previous patch alone and I will integrate
them.

thanks, Juan.
