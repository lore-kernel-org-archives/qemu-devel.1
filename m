Received: from eggs.gnu.org ([2001:4830:134:3::10]:35763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAHyp-0006Nj-62
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAHyj-0003m9-GA
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:04:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eAHyj-0003lX-9w
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:04:25 -0400
Message-ID: <1509638660.11873.13.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 02 Nov 2017 17:04:20 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] seabios serial console vs. sgabios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios <seabios@seabios.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>

  Hi,

One problem we have with the serial console support in seabios and
sgabios:  It can happen that both are activated.  We'll go fix that in
qemu, but that'll work for new qemu versions only, not for the old
already released ones.

So I think it would be useful if seabios makes sure sgabios and serial
console are not both active at the same time, i.e. in case we find
"vgaroms/sgabios.bin" being present either turn off builtin serial
console, or don't load sgabios (and possibly also enable builtin serial
console).

Comments?

cheers,
  Gerd
