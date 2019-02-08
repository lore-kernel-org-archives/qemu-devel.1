Received: from eggs.gnu.org ([209.51.188.92]:44558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gs7fY-0007OL-A3
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:02:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gs7fW-00020I-AN
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:02:20 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:49276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gs7fU-0001ol-0K
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:02:18 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <3428f328-2418-d3f6-8236-0f96cf855fd9@redhat.com>
References: <cover.1549545591.git.berto@igalia.com>
	<f404632bb16afed8ae9e5f3cfe4032b718a00491.1549545591.git.berto@igalia.com>
	<20190207142649.GL19438@redhat.com>
	<w51va1u8vya.fsf@maestria.local.igalia.com>
	<3428f328-2418-d3f6-8236-0f96cf855fd9@redhat.com>
Date: Fri, 08 Feb 2019 16:01:56 +0100
Message-ID: <w51o97mqq6z.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang?= =?utf-8?Q?=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Fri 08 Feb 2019 02:46:27 PM CET, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 08/02/19 10:34, Alberto Garcia wrote:
>>> and also works with the vhostuser reconnect device, then we are
>>> probably ok.
>> How do I test this?
>
> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 \
>   QTEST_VHOST_USER_FIXME=1 \
>   tests/vhost-user-test

I see. The ones enabled by QTEST_VHOST_USER_FIXME never finish with this
patch applied.

Berto
