Received: from eggs.gnu.org ([209.51.188.92]:45863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1grlFV-0000fL-Gx
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1grlFU-0004eE-Bp
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:05:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1grlFU-0004JZ-3H
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:05:56 -0500
References: <cover.1549545591.git.berto@igalia.com>
	<f404632bb16afed8ae9e5f3cfe4032b718a00491.1549545591.git.berto@igalia.com>
	<CAJ+F1CJh5vJa_py=eChkZCW-+zbuU1GmdFWcfSYg+=t8ukwYNg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <38cce726-69b6-d7cc-6392-0bbabfc067ca@redhat.com>
Date: Thu, 7 Feb 2019 16:05:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJh5vJa_py=eChkZCW-+zbuU1GmdFWcfSYg+=t8ukwYNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] char-socket: Lock tcp_chr_disconnect()
 and socket_reconnect_timeout()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Alberto Garcia <berto@igalia.com>
Cc: QEMU <qemu-devel@nongnu.org>

On 07/02/19 15:46, Marc-Andr=C3=A9 Lureau wrote:
> That looks like a subset of "[Qemu-devel] Segfaults in chardev due to
> races". The problem is likely to occur with other chardevs I am
> afraid.

Yes, it could possibly happen with pty at least.  However, Alberto's
patch is a start.

Paolo
