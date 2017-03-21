Received: from eggs.gnu.org ([2001:4830:134:3::10]:47521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqIh7-00015R-Dp
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqIh3-0007jo-5b
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:15:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqIh3-0007jj-00
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:15:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3FE6C05490A
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 12:15:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170320173840.3626-1-dgilbert@redhat.com>
Date: Tue, 21 Mar 2017 13:15:12 +0100
In-Reply-To: <20170320173840.3626-1-dgilbert@redhat.com> (David Alan Gilbert's
	message of "Mon, 20 Mar 2017 17:38:38 +0000")
Message-ID: <87bmsuomgf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/2 for 2.10] Remove some monitor_printf's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> I found myself trying to understand cur_mon and found a bunch
> of uses that could easily be replaced by error_report or Error **.

Speaking of cur_mon: a patch making it thread-local would be most
welcome.

Some of error wavcapture messages still aren't so great, but it's an
obvious improvement, so
Reviewed-by: Markus Armbruster <armbru@redhat.com>
