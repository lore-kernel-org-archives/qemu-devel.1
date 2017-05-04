Received: from eggs.gnu.org ([2001:4830:134:3::10]:55182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6CDY-0007w3-8F
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6CDV-0001bN-5c
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:34:32 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d6CDU-0001a7-Ve
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:34:29 -0400
Received: by mail-wm0-x235.google.com with SMTP id 142so3246025wma.1
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 01:34:27 -0700 (PDT)
References: <20170503223846.6559-1-marcandre.lureau@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170503223846.6559-1-marcandre.lureau@redhat.com>
Date: Thu, 04 May 2017 09:35:04 +0100
Message-ID: <878tmdnhon.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Memory leak fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org


Marc-André Lureau <marcandre.lureau@redhat.com> writes:

> Hi,
>
> A new series of leaks spotted by ASAN. Mostly after introducing of the
> test-hmp. Would it be useful having a configure --enable-asan, and

Yes.

> enabled by default with --enable-debug?

Not sure - isn't --enable-debug just for debug symbols and we enable
extra stuff like --enable-tcg-debug for additional checking? Given the
overhead of asan I still think we need a configure setup for reasonably
debugable but still performant.

>
> Marc-André Lureau (5):
>   test-keyval: fix leaks
>   audio: fix capture buffer leaks
>   audio: fix WAVState leak
>   slirp: fix leak
>   dump: fix memory_mapping_filter leak
>
>  audio/audio.c       | 2 ++
>  audio/wavcapture.c  | 1 +
>  memory_mapping.c    | 1 +
>  slirp/socket.c      | 3 +++
>  tests/test-keyval.c | 4 ++++
>  5 files changed, 11 insertions(+)


--
Alex Bennée
