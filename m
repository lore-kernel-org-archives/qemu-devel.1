Received: from eggs.gnu.org ([209.51.188.92]:35155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hG6zr-0002pz-5y
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 15:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hG6zm-0002Jn-Bm
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 15:10:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1hG6zf-0002F2-5R
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 15:10:16 -0400
References: <874f0f8e-780e-6600-e11b-b97f5b055cf8@durchholz.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <dbd6541e-5013-d0bc-b23e-a8de4f4cd171@redhat.com>
Date: Mon, 15 Apr 2019 15:10:09 -0400
MIME-Version: 1.0
In-Reply-To: <874f0f8e-780e-6600-e11b-b97f5b055cf8@durchholz.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] curses.c: "We need a terminal output" ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joachim Durchholz <jo@durchholz.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

<CC'ing curses maintainer>

On 4/13/19 5:02 AM, Joachim Durchholz wrote:
> Hi all,
> 
> what's the reasoning behind "We need a terminal output" in curses.c?
> 
> I don't really see a scenario where it's problematic if qemu emits
> escape sequences to a pipe.
> I have experienced one scenario where it is problematic: It doesn't work
> properly with pexpect and expectit (a Python and a Java library that do
> expect). I suspect they fail to use a pty, but then I see no harm in not
> doing so.
> I can see another scenario when this is problematic: Unit testing code
> that directly writes to the console. E.g. testing BIOS code, or testing
> operating systems when using the serial port is not an option.
> 
> Regards,
> Jo
> 
