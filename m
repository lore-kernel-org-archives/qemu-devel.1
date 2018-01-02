Received: from eggs.gnu.org ([2001:4830:134:3::10]:46162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eWQPl-0001LD-Pu
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eWQPj-0000Hs-6s
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:31:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eWQPi-0000GW-WF
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:31:47 -0500
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-5-marcandre.lureau@redhat.com>
	<CAJ+F1CLxk6vC+ZB09BUBMnJj12RuaeYS=S5KwcBGhoHiYbCd5g@mail.gmail.com>
	<CAJ+F1CLHsFoRFYy825f0MxyAU4T+97YrjMQWfmu6Cni49zyZWQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bfe98eaa-bf87-dabe-ec63-7eae338495a2@redhat.com>
Date: Tue, 2 Jan 2018 18:31:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLHsFoRFYy825f0MxyAU4T+97YrjMQWfmu6Cni49zyZWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/13] build-sys: add AddressSanitizer
 when --enable-debug if possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>

On 02/01/2018 16:49, Marc-Andr=C3=A9 Lureau wrote:
>>> If necessary, we could consider a seperate configure option, although
>>> I like the idea to have it enabled by default with --enable-debug.
>> Peter, Paolo, Fam, any thoughts about having ASAN enabled by default
>> with --enable-debug? (when available)
>>
>> Slow down is not really noticeable to me when running make check, but
>> I can do some measurements if that helps.
>>
>> thanks
> ping, thanks
>=20

Sounds good, but:

1) please remove --enable-debug from existing docker tests and add a new
one based on tests/docker/test-full;

2) I think removing -O2 from --enable-debug should be removed at the
same time.  That pretty much guarantees that nobody will use
--enable-debug, and optimized builds are decently debuggable nowadays.
The best would be to detect -Og, and add either -Og or -O1 depending on
presence.

Paolo
