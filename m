Received: from eggs.gnu.org ([209.51.188.92]:49149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gz9av-0002dI-Bm
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gz9ao-0000EC-33
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:30:33 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190227111411.22890-1-david@redhat.com>
	<20190227111411.22890-3-david@redhat.com>
	<ec7a9ec1-3d6d-6d19-246c-4f6d41f52ec1@redhat.com>
	<87h8cpkmra.fsf@zen.linaroharston>
	<56298ace-a6f7-2b2a-acc2-0e09615c121b@redhat.com>
	<87fts8lxl8.fsf@zen.linaroharston>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <bd3c9d75-ab17-cd04-ba04-cb1fb19b4ce8@twiddle.net>
Date: Wed, 27 Feb 2019 16:24:26 -0800
MIME-Version: 1.0
In-Reply-To: <87fts8lxl8.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 2/27/19 1:40 PM, Alex Bennée wrote:
> And crucially have nice regular sized instructions. Is that not an option?

s390 insns are {2,4,6} bytes.  I don't think that there's an easy way to pick
out the hw status codes that would give the ilen of the faulting insn.


r~
