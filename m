Received: from eggs.gnu.org ([2001:4830:134:3::10]:46098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faO53-000723-QF
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faO4y-0007R8-SS
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:23:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37498 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faO4y-0007Qw-NR
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:23:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B6F0401D7AD
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 16:23:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180703155648.11933-1-marcandre.lureau@redhat.com>
	<20180703155648.11933-5-marcandre.lureau@redhat.com>
Date: Tue, 03 Jul 2018 18:22:57 +0200
In-Reply-To: <20180703155648.11933-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 3 Jul 2018 17:56:38 +0200")
Message-ID: <871scke1b2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 04/14] qapi: add 'ifcond' to visitor
 methods
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

> Modify the test visitor to check correct passing of values.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
[...]
> diff --git a/roms/seabios b/roms/seabios
> index f9626ccb91..0551a4be2c 160000
> --- a/roms/seabios
> +++ b/roms/seabios
> @@ -1 +1 @@
> -Subproject commit f9626ccb91e771f990fbb2da92e427a399d7d918
> +Subproject commit 0551a4be2ce599fb60e478b4c15e06ab6587822c

Whoops!  Dropping this part :)

[...]
