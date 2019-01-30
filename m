Received: from eggs.gnu.org ([209.51.188.92]:60933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gog8J-0007lE-HF
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gog8I-0005du-Nz
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:01:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gog8I-0005KS-HZ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:01:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 89EFC155E0
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 03:01:22 +0000 (UTC)
Date: Wed, 30 Jan 2019 11:01:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190130030117.GB27390@xz-x1>
References: <20190129051432.22023-1-peterx@redhat.com>
	<87lg33306f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lg33306f.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] iothread: fix iothread hang when stop too
 soon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Thomas Huth <thuth@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Tue, Jan 29, 2019 at 05:20:40PM +0100, Markus Armbruster wrote:
> Marc-Andr=C3=A9 (cc'ed) recently fixed a deadlock (commit 34f1f3e06d8
> "monitor: avoid potential dead-lock when cleaning up").  Looks like we
> got more.

Yes, and a few tests too.  Hopefully these fallouts can settle soon
before the rcs.  Looks like there's still plenty of time for it to be
ready (softfreeze is March 19th).

Thanks,

--=20
Peter Xu
