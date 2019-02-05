Received: from eggs.gnu.org ([209.51.188.92]:38976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqwip-0000Jq-Kt
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqwio-00035v-VI
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:08:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqwio-00035S-PC
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:08:50 -0500
Date: Tue, 5 Feb 2019 10:08:47 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190205090847.hdf72mu7b2zn6qyu@sirius.home.kraxel.org>
References: <20190201071225.20576-1-brendan@bslabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201071225.20576-1-brendan@bslabs.net>
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: Fix macOS 10.14 deprecation
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brendan Shanks <brendan@bslabs.net>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Thu, Jan 31, 2019 at 11:12:25PM -0800, Brendan Shanks wrote:
> macOS 10.14 deprecated NSOnState/NSOffState in favour of
> NSControlStateValueOn/NSControlStateValueOff. Use the new constants,
> and #define them to the old ones when compiling against a pre-10.13 SDK.
> Also [NSGraphicsContext graphicsPort] is now deprecated, use
> [NSGraphicsContext CGContext] when available.

Added to UI patch queue.

thanks,
  Gerd
