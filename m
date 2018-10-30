Received: from eggs.gnu.org ([2001:4830:134:3::10]:34132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHYG0-0002L5-P1
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHYFx-00071n-C3
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:56:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gHYFx-0006w5-1D
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:56:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2097F308421B
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 17:56:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
Date: Tue, 30 Oct 2018 18:56:23 +0100
In-Reply-To: <20181029125733.14597-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 29 Oct 2018 16:57:27 +0400")
Message-ID: <87tvl38gjc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] monitor: misc fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi,
>
> Here is a small series of fixes for the monitor, mostly related to
> threading issues.

Series looks good on first glance, but thread safety is subtle business,
so I'd like to give it a bit more time for review.  Bug fixes like these
can go in after soft freeze.
