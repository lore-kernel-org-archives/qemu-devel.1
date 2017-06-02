Received: from eggs.gnu.org ([2001:4830:134:3::10]:53062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGhaW-0006ny-Rj
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGhaR-0006iW-T5
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:05:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dGhaR-0006i6-N6
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:05:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B074281F07
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 08:05:34 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-13-marcandre.lureau@redhat.com>
Date: Fri, 02 Jun 2017 10:05:31 +0200
In-Reply-To: <20170531135709.345-13-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 31 May 2017 17:56:36 +0400")
Message-ID: <8737bike5w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 12/45] qnum: add uint type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> In order to store integer values superior to INT64_MAX, add a u64

"superior" sounds odd.  What about "above"?  Or perhaps "between
INT64_MAX and UINT64_MAX".

s/a u64/a uint64_t/

> internal representation.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

With the commit message tidied up:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
