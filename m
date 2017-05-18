Received: from eggs.gnu.org ([2001:4830:134:3::10]:50212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dBNWk-0005mv-DQ
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dBNWh-0001oh-Ad
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:39:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dBNWh-0001ob-4S
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:39:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0E6780503
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 15:39:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
Date: Thu, 18 May 2017 17:39:36 +0200
In-Reply-To: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 9 May 2017 20:35:42 +0300")
Message-ID: <87pof6max3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/17] qobject/qapi: add uint type
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

> Hi,
>
> In previously sent series "[PATCH 00/21] WIP: dump: add kaslr support
> (for after 2.9)", I proposed changes to accept uint64 values from
> json, by adding a QUint type. During review, it was suggested to
> introduce a QNum type to hold various number representations.
>
> This series introduces the QNum type, adds uint representation to it,
> and make uint64 values over json possible (while keeping json negative
> int for values >INT64_MAX to unsigned cast compatibility). It also
> improves some int vs uint usage for object properties and other
> QObject related clean-ups.
>
> The series is on top of http://repo.or.cz/qemu/armbru.git qapi-next

The series needs a bit of work here and there, but I think you're on the
right path.  Thanks for tackling this!
