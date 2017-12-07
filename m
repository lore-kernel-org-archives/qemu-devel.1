Received: from eggs.gnu.org ([2001:4830:134:3::10]:44301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMyIQ-0006H8-Ga
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:41:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMyIN-0001EA-ER
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:41:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eMyIN-0001Cy-8n
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:41:07 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-13-marcandre.lureau@redhat.com>
Date: Thu, 07 Dec 2017 16:41:02 +0100
In-Reply-To: <20170911110623.24981-13-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 11 Sep 2017
	13:05:45 +0200")
Message-ID: <87mv2uo8a9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 12/50] qapi-introspect: add preprocessor
 conditions to generated QLit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add 'ifcond' condition to top-level QLit objects.
>
> to_qlit() handles the (obj, ifcond) tuples in previous patch.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

According to my testing, this patch adds blank lines between the
elements of qmp_schema_qlit.  I suspect this is because to_qlit((obj,
None) is not actually equivalent to to_qlit(obj).  It should be.

Note that the issue is in PATCH 11, but becomes visible only in PATCH
12, because the new code only gets used in PATCH 12.  Consider squashing
the two together.
