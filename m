Received: from eggs.gnu.org ([2001:4830:134:3::10]:55132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYY7N-0005Ff-Oc
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYY7I-0006DQ-T5
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:05:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYY7I-0006DI-NQ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:05:00 -0500
Message-ID: <1485867896.23903.61.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 14:04:56 +0100
In-Reply-To: <20170131100945.8189-1-kwolf@redhat.com>
References: <20170131100945.8189-1-kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] gtk: Hardcode LC_CTYPE as C.utf-8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com, mfabian@redhat.com

> Recently, however, glibc introduced a new locale "C.utf-8" that just
> uses UTF-8 as its charset, but otherwise leaves the semantics alone.
> Just setting the right character set is enough for our use case, so we
> can just hardcode this one without having to be afraid of nasty side
> effects.

Cool.  Added to ui queue.

thanks,
  Gerd.
