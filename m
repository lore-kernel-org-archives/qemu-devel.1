Received: from eggs.gnu.org ([2001:4830:134:3::10]:34447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dITtr-0006BV-Bv
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 01:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dITto-0006AA-A2
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 01:52:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dITto-00069x-48
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 01:52:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDB27368E5
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 05:52:54 +0000 (UTC)
Message-ID: <1496814770.5126.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 07 Jun 2017 07:52:50 +0200
In-Reply-To: <20170530212614.18343-1-lersek@redhat.com>
References: <20170530212614.18343-1-lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [RFC] q35/mch: implement extended TSEG sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

  Hi,

Patch looks sane overall.

> Invent a new, QEMU-specific register in the config space of the DRAM
> Controller, at offset 0x50, in order to allow guest firmware to query
> the
> TSEG (SMRAM) size.

Hmm, 0x50 appears to be the only unused config space register in the
specs.  I suspect in reality it isn't unused but undocumented.  I don't
have a better idea though, and in practice it probably isn't much of a
problem.

cheers,
  Gerd
