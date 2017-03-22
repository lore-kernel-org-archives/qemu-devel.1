Received: from eggs.gnu.org ([2001:4830:134:3::10]:34504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqd7U-0004FD-8C
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqd7R-0005ju-2c
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:03:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cqd7Q-0005jU-U8
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:03:53 -0400
References: <87bmstu19t.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1f744cad-f67b-92d3-b4e4-32f8b05c643c@redhat.com>
Date: Wed, 22 Mar 2017 11:03:44 +0100
MIME-Version: 1.0
In-Reply-To: <87bmstu19t.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Minimum RAM size for PC machines?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, seabios@seabios.org, =?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>

On 22.03.2017 10:08, Markus Armbruster wrote:
[...]
> Are we now ready to accept a simple & stupid patch that actually helps
> users, say letting boards that care declare minimum and maximum RAM
> size?  And make PC reject RAM size less than 1MiB, even though "someone=
"
> might conceivably have firmware that works with less?

I'd say enforce a minimum RAM size on the normal "pc" and "q35" machine,
but still allow smaller sizes on the "isapc" machine. So if "someone"
comes around and claims to have a legacy firmware that wants less memory
than 1MiB, just point them to the isapc machine.
Just my 0.02 =E2=82=AC.

 Thomas
