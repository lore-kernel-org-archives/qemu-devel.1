Received: from eggs.gnu.org ([209.51.188.92]:51792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gs9wU-0004C0-T0
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gs9wU-0004Fn-5i
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:27:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gs9wT-000492-SQ
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:27:58 -0500
References: <cover.1549545591.git.berto@igalia.com>
	<f404632bb16afed8ae9e5f3cfe4032b718a00491.1549545591.git.berto@igalia.com>
	<20190207142649.GL19438@redhat.com>
	<w51va1u8vya.fsf@maestria.local.igalia.com>
	<3428f328-2418-d3f6-8236-0f96cf855fd9@redhat.com>
	<w51o97mqq6z.fsf@maestria.local.igalia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fbad0a4b-0686-d95b-b218-9d15d77a2b40@redhat.com>
Date: Fri, 8 Feb 2019 18:27:42 +0100
MIME-Version: 1.0
In-Reply-To: <w51o97mqq6z.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 08/02/19 16:01, Alberto Garcia wrote:
> On Fri 08 Feb 2019 02:46:27 PM CET, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 08/02/19 10:34, Alberto Garcia wrote:
>>>> and also works with the vhostuser reconnect device, then we are
>>>> probably ok.
>>> How do I test this?
>>
>> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 \
>>   QTEST_VHOST_USER_FIXME=1 \
>>   tests/vhost-user-test
> 
> I see. The ones enabled by QTEST_VHOST_USER_FIXME never finish with this
> patch applied.

I can look at it next week.

Paolo
