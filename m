Received: from eggs.gnu.org ([2001:4830:134:3::10]:39495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d4OgE-00069J-7k
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 05:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d4OgB-0001nb-4T
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 05:28:42 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d4OgA-0001nK-Te
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 05:28:39 -0400
Received: by mail-wm0-x242.google.com with SMTP id y10so15111055wmh.0
	for <qemu-devel@nongnu.org>; Sat, 29 Apr 2017 02:28:38 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170428122444.23361-1-berrange@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a3f22a00-1f2e-6d22-f2a2-edc233cd6c64@twiddle.net>
Date: Sat, 29 Apr 2017 11:28:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170428122444.23361-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] (RFC) remove the GThread coroutine
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 04/28/2017 02:24 PM, Daniel P. Berrange wrote:
> At the 2016 summit it was suggested that we delete the GThread
> coroutine impl since it is not fully functional, and you can
> debug the ucontext impl with our GDB helper script.
> 
> I don't recall the subject being raised again since the summit
> so here's a proposal to delete the GThread impl, as a way to
> trigger input from anyone who thinks we need to keep it......

The last time this was mentioned, the reason that we were keeping it was to 
make clang's thread-sanitizer module happy.  Whether we can still find relevant 
bugs with that, I don't know.


r~
