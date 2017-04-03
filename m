Received: from eggs.gnu.org ([2001:4830:134:3::10]:49713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cv5NC-0004I3-TJ
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cv5NA-0003xj-9E
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:02:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cv5NA-0003xK-30
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:02:32 -0400
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
	<e1ccd5bc-f683-93b7-374d-0707765a8715@ilande.co.uk>
	<1490881315.28523.11.camel@redhat.com>
	<e0df6143-81f2-a0e7-2c23-90dd01724e9f@redhat.com>
	<1491221026.17505.39.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5e1fc0b8-188c-28e8-7a4a-9f0388790219@redhat.com>
Date: Mon, 3 Apr 2017 19:02:22 +0200
MIME-Version: 1.0
In-Reply-To: <1491221026.17505.39.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RfC PATCH 0/4] make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org



On 03/04/2017 14:03, Gerd Hoffmann wrote:
> We might clear some more bits, but these are
> outsize the visible area so they should cause visible corruption (and if
> the visible area changes the display code needs to do a full refresh
> anyway).

True, though this makes the snapshot abstraction a little more
specialized.  Please add a FIXME comment with the explanation, at least.

Paolo
