Received: from eggs.gnu.org ([2001:4830:134:3::10]:41556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dpzJJ-00081l-MH
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dpzJE-00070s-OH
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:05:45 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dpzJE-000709-HS
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:05:40 -0400
Received: by mail-oi0-f41.google.com with SMTP id r20so883138oie.0
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 09:05:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170902091520.bxecfhisvy46o4cb@aurel32.net>
References: <20170901110332.32650-1-otubo@redhat.com>
	<20170901143016.GK7570@localhost.localdomain>
	<20170902091520.bxecfhisvy46o4cb@aurel32.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 7 Sep 2017 18:05:37 +0200
Message-ID: <CABgObfZ-CthwUFC-E2QTxnpqYZ-Sr_f_M3-FdmH6tQPdjG3OAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] dma/i82374: avoid double creation of
 i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jarno, Aurelien" <aurelien@aurel32.net>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Gibson,
	David" <david@gibson.dropbear.id.au>, Eduardo Otubo <otubo@redhat.com>, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, mst@redhat.com, Eduardo Habkost <ehabkost@redhat.com>

Il 02 set 2017 11:17 AM, "Aurelien Jarno" <aurelien@aurel32.net> ha scritto:

On 2017-09-01 11:30, Eduardo Habkost wrote:
> i82374 is compiled in only on ppc and sh4, so I'm CCing the
> maintainers for those architectures.

The i82374 device is not useful nor usable on SH4. It has just been
added in commit 85d3846a39 to be able to run the tests.


But that means that the patch is wrong and probably was not tested with
"make check".

Eduardo's proposal is the right one.

Paolo


Aurelien

--
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
