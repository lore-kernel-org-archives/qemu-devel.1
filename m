Received: from eggs.gnu.org ([2001:4830:134:3::10]:56517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cKASd-0006zr-Fg
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 15:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cKASZ-0002SQ-JC
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 15:59:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cKASZ-0002RZ-E7
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 15:59:31 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40D2781252
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 20:59:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20161206141343.28044-1-marcandre.lureau@redhat.com>
	<20161206141343.28044-13-marcandre.lureau@redhat.com>
Date: Thu, 22 Dec 2016 21:59:28 +0100
In-Reply-To: <20161206141343.28044-13-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 6 Dec 2016
	17:13:38 +0300")
Message-ID: <87shpfr87j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 12/17] docs: add qemu logo to pdf
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

> Add a logo to texi2pdf output. Other formats (info/html) are left as
> future improvements.
>
> The pdf (needed by texi2pdf for vectorized images) was generated thanks
> to inkscape, from the pc-bios/qemu_logo.svg file, with the following
> command:

Suggest:

  The PDF (needed by texi2pdf for vectorized images) was generated from
  pc-bios/qemu_logo.svg like this:

Can touch up on commit.

>
> inkscape --export-pdf=3Ddocs/qemu_logo.pdf pc-bios/qemu_logo.svg
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

According to the Texinfo documentation, not having any of qemu_logo.png,
.jpg, .jpeg, .gif is an error, but my actual programs don't throw one.
I'm worried that other versions might.

Reluctantly
Reviewed-by: Markus Armbruster <armbru@redhat.com>
