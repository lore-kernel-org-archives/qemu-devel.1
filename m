Received: from eggs.gnu.org ([209.51.188.92]:57941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gs6UZ-0006th-HG
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 08:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gs6UX-0003Z5-L3
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 08:46:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gs6UX-0003Ra-D6
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 08:46:53 -0500
References: <cover.1549545591.git.berto@igalia.com>
	<f404632bb16afed8ae9e5f3cfe4032b718a00491.1549545591.git.berto@igalia.com>
	<20190207142649.GL19438@redhat.com>
	<w51va1u8vya.fsf@maestria.local.igalia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3428f328-2418-d3f6-8236-0f96cf855fd9@redhat.com>
Date: Fri, 8 Feb 2019 14:46:27 +0100
MIME-Version: 1.0
In-Reply-To: <w51va1u8vya.fsf@maestria.local.igalia.com>
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
To: Alberto Garcia <berto@igalia.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 08/02/19 10:34, Alberto Garcia wrote:
>> and also works with the vhostuser reconnect device, then we are
>> probably ok.
> How do I test this?

QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 \
  QTEST_VHOST_USER_FIXME=3D1 \
  tests/vhost-user-test

Paolo
