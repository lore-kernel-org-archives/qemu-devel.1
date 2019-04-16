Received: from eggs.gnu.org ([209.51.188.92]:49879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hGOfQ-0002Wd-H3
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hGOfO-0002E7-W2
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:02:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hGOfO-0002Dx-OF
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:02:30 -0400
References: <874f0f8e-780e-6600-e11b-b97f5b055cf8@durchholz.org>
	<dbd6541e-5013-d0bc-b23e-a8de4f4cd171@redhat.com>
	<20190416072430.dp742ehg27drpplb@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2af5fa7d-bbdc-a3c7-23da-dd00dd1ed351@redhat.com>
Date: Tue, 16 Apr 2019 16:02:19 +0200
MIME-Version: 1.0
In-Reply-To: <20190416072430.dp742ehg27drpplb@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Cc: Joachim Durchholz <jo@durchholz.org>, qemu-devel@nongnu.org

On 04/16/19 09:24, Gerd Hoffmann wrote:
> On Mon, Apr 15, 2019 at 03:10:09PM -0400, John Snow wrote:
>> <CC'ing curses maintainer>
>>
>> On 4/13/19 5:02 AM, Joachim Durchholz wrote:
>>> Hi all,
>>>
>>> what's the reasoning behind "We need a terminal output" in curses.c?
> 
> curses needs a terminal.
> 
>>> I don't really see a scenario where it's problematic if qemu emits
>>> escape sequences to a pipe.
> 
> It's not about sending escape sequences.  A pipe simply doesn't support
> all the tty ioctls (query terminal size, turn echo on/off, set all kinds
> of terminal modes, ...).

(

Indeed, it's called the "General Terminal Interface".

http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap11.html

)

>>> I can see another scenario when this is problematic: Unit testing code
>>> that directly writes to the console. E.g. testing BIOS code, or testing
>>> operating systems when using the serial port is not an option.
> 
> seabios can work with the serial console just fine, try "qemu -nographic"
> 
> cheers,
>   Gerd
> 
> 
