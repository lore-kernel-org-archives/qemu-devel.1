Received: from eggs.gnu.org ([2001:4830:134:3::10]:55095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gHMtg-0004T5-BE
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 01:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gHMtd-0000vV-3p
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 01:49:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gHMtc-0000uu-UD
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 01:48:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0BD330832C5
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 05:48:55 +0000 (UTC)
Date: Tue, 30 Oct 2018 13:48:48 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181030054848.GF22523@xz-x1>
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181029125733.14597-1-marcandre.lureau@redhat.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Oct 29, 2018 at 04:57:27PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> Here is a small series of fixes for the monitor, mostly related to
> threading issues.

Hi, Marc-Andr=C3=A9, Markus,

I'd be glad to know how you think about these monitor series,
considering that I just noticed it's exactly softfreeze for QEMU 3.1
today...

I gave a quick look on this series, IMHO patch 1,2,6 could be
candidate for 3.1 (though I'm not sure for patch 6; it seems even fine
to me with some comments there but I'd like to see how other people
think about it too, and whether it's really possible to insert a new
monitor at that time) and I'm not sure whether the rest can be
postponed (say, patch 3,4,5).  Meanwhile, I think we need Wolfgang's
patches to fix the daemonize chaos, and hopefully I also like to know
your thoughts on my oob enablement series (especially Marc-Andr=C3=A9,
since I talked to Markus face to face during the forum after all :).
I would like it to be in 3.1 as well but I'll see my luck.

Thoughts?

Regards,

--=20
Peter Xu
