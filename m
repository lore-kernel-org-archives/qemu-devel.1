Received: from eggs.gnu.org ([2001:4830:134:3::10]:43983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGmxa-0003zE-5U
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGmxV-00005h-Aq
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:49:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dGmxV-000056-4t
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:49:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11A29C0587C3
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 13:49:44 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-19-marcandre.lureau@redhat.com>
Date: Fri, 02 Jun 2017 15:49:40 +0200
In-Reply-To: <20170531135709.345-19-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 31 May 2017 17:56:42 +0400")
Message-ID: <8737bicxe3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 18/45] qdev: make default property int
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

> The following patch will add uint properties.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

"Make default property int" doesn't make sense to me.  The patch does
two things:

1. Rename DEFINE_PROP_DEFAULT() to DEFINE_PROP_INT(), to prepare for the
next patch's DEFINE_PROP_UINT().

2. Wrap the Property default value (an int64_t) in a union, to prepare
for the next patch adding a uint64_t.

If you split the patch accordingly, the commit messages will write
themselves :)

I'd use DEFINE_PROP_SIGNED() to avoid misleading readers into making a
connection to type int, and DEFINE_PROP_UNSIGNED() to match.

Other than that, the patch looks good.
