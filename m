Received: from eggs.gnu.org ([209.51.188.92]:41309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj5aJ-0005iB-OD
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:59:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj5aJ-0005sc-0i
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:59:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54501)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gj5aI-0005qd-OU
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:59:34 -0500
References: <CAFEAcA8GE72MaUFvbfHUL7vwkBNzWh+q_0VgzbmLJ-StYhWM4Q@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a1dddb07-0602-f488-210e-e4f6611f64ae@redhat.com>
Date: Mon, 14 Jan 2019 17:59:28 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8GE72MaUFvbfHUL7vwkBNzWh+q_0VgzbmLJ-StYhWM4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] -device foo,
 help shouldn't be allowed for devices where -device foo is forbidden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 2019-01-14 17:31, Peter Maydell wrote:
> We prohibit -device foo for non-pluggable devices:
> $ ./build/all/x86_64-softmmu/qemu-system-x86_64 -device i8257
> qemu-system-x86_64: -device i8257: Parameter 'driver' expects
> pluggable device type
> 
> And we suppress them from "-device help" output too.
> 
> But we still allow the user to do this:
> 
> $ ./build/all/x86_64-softmmu/qemu-system-x86_64 -device i8257,help
> i8257 options:
>   dshift=<int32>
>   base=<int32>
>   pageh-base=<int32>
>   page-base=<int32>

Could this still be sometimes useful, e.g. when a device is configured
with the "-global" parameter?

 Thomas
