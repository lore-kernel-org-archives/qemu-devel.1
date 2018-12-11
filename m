Received: from eggs.gnu.org ([2001:4830:134:3::10]:48558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gWdcn-0006wT-FN
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 03:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gWdcj-0004OL-GK
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 03:42:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gWdcj-0004NK-6t
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 03:42:37 -0500
References: <20181210165636.28366-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <84718cdc-6983-6cb1-1f0f-4491361ca690@redhat.com>
Date: Tue, 11 Dec 2018 09:42:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181210165636.28366-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/3] target/m68k: convert to
 transaction_failed hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent Vivier <laurent@vivier.eu>, patches@linaro.org

On 2018-12-10 17:56, Peter Maydell wrote:
> This patchset converts the m68k target from the deprecated
> unassigned_access hook to the new transaction_failed hook.
> It's RFC for a couple of reasons:
>  * it's untested, since I don't have an m68k test image

Have a look at the arnewsh 5206 and 5208evb images here:

https://web.archive.org/web/20180427080645/http://www.uclinux.org/ports/coldfire/binary.html

or

https://www.qemu-advent-calendar.org/2018/#day-7 :-)

 Thomas
