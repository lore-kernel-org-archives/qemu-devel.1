Received: from eggs.gnu.org ([2001:4830:134:3::10]:35718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQdbu-0008T3-TH
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQdbr-0002op-QP
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:56:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38562 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fQdbr-0002oh-LZ
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:56:39 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <alpine.BSF.2.21.1806061909150.94568@zero.eik.bme.hu>
Date: Wed, 06 Jun 2018 20:56:37 +0200
In-Reply-To: <alpine.BSF.2.21.1806061909150.94568@zero.eik.bme.hu> (BALATON
	Zoltan's message of "Wed, 6 Jun 2018 19:15:54 +0200 (CEST)")
Message-ID: <87muw768wq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Stair step trace output since 12fb0ac05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Patryk Olszewski <patryk@fala.ehost.pl>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

BALATON Zoltan <balaton@eik.bme.hu> writes:

> Hello,
>
> Since 12fb0ac05 (char: Remove unwanted crlf conversion) trace output
> is printed in stair steps when using -trace and -serial stdio
> together. E.g.
> $ qemu-system-i386 -trace 'pci*' -serial stdio
>
> Regards,
> BALATON Zoltan

I cc'ed the people involved with this patch for you.
