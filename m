Received: from eggs.gnu.org ([209.51.188.92]:37088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gzPeP-0000XK-9s
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gzPeO-0006MC-KF
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:39:17 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190227111411.22890-1-david@redhat.com>
	<20190227111411.22890-3-david@redhat.com>
	<ec7a9ec1-3d6d-6d19-246c-4f6d41f52ec1@redhat.com>
	<e1b83ea1-2ae3-e137-90d1-1d6adcc7a3f3@twiddle.net>
	<18326ade-4b6b-04f9-f34b-9bd7ff39bd2c@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c50c4bd5-6af4-a4af-c540-f55203d01e9e@twiddle.net>
Date: Thu, 28 Feb 2019 09:39:08 -0800
MIME-Version: 1.0
In-Reply-To: <18326ade-4b6b-04f9-f34b-9bd7ff39bd2c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] tests/tcg: target/s390: Add test
 for VECTOR LOAD GR FROM VR ELEMENT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 2/27/19 11:14 PM, David Hildenbrand wrote:
> I guess signal + sigsetjmp/siglongjmp is the one with the smalles LOC?
> Will give it a try.

I suppose it depends on how you write it.

    struct sigaction sa = {
        .sa_mask = SA_RESETHAND | SA_NODEFER,
        .sa_handler = sig_sigill,
    };
    check("SIGILL not registered", sigaction(SIGILL, &sa, NULL) == 0);

is 5 lines to the 6 you currently use for registering and unregistering the
signal handler.  ;-)


r~
