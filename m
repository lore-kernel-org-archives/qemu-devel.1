Received: from eggs.gnu.org ([2001:4830:134:3::10]:59944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAfQY-0006Il-Sh
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAfQV-00032G-Oq
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:34:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAfQV-000327-JG
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:34:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6930BC05972F
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 16:34:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1494562661-9063-1-git-send-email-peterx@redhat.com>
	<1494562661-9063-3-git-send-email-peterx@redhat.com>
Date: Tue, 16 May 2017 18:34:18 +0200
In-Reply-To: <1494562661-9063-3-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Fri, 12 May 2017 12:17:40 +0800")
Message-ID: <87vap0ahh1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 2/3] utils: provide size_to_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> Moving the algorithm from print_type_size() into size_to_str() so that
> other component can also leverage it. With that, refactor
> print_type_size().
>
> The assert() in that logic is removed though, since even UINT64_MAX
> would not overflow.

I'd keep it.

> Signed-off-by: Peter Xu <peterx@redhat.com>

Regardless:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
