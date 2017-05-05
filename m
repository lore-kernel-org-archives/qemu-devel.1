Received: from eggs.gnu.org ([2001:4830:134:3::10]:36169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6f8R-0005Zq-Fo
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6f8O-0004n6-UG
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:27:11 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:36746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d6f8O-0004mu-LD
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:27:08 -0400
Received: by mail-wr0-x235.google.com with SMTP id l50so5799909wrc.3
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 08:27:08 -0700 (PDT)
References: <1618105799.2706822.1493821255206.ref@mail.yahoo.com>
	<1618105799.2706822.1493821255206@mail.yahoo.com>
	<20170505150751.GD14316@stefanha-x1.localdomain>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170505150751.GD14316@stefanha-x1.localdomain>
Date: Fri, 05 May 2017 16:27:47 +0100
Message-ID: <87tw4zmih8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Dummy Panel.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: John Bradley <flypie1@yahoo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, John Bradley <flypie@rocketmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>


Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Wed, May 03, 2017 at 02:20:55PM +0000, John Bradley via Qemu-devel wrote:
>> Hi
>> I have created a new fork on GitHub https://github.com/flypie/flypie-pi-qemu and an associated project https://github.com/flypie/GDummyPanel the idea as well as getting the Original PI emulation working is to add some facility for simulated IO. This is a demonstration of the latest version, running the QEMU demo from https://github.com/rsta2/circle. I took the idea from an implementation for the BIFFboard but only the socket number is left, the commuications is all via IP. The code is only really Alpha level at the moment and needs some refing to reduce bandwidth. I could also extend the code so that the connection can be to a remote machine rather than via the local host.
>>
>> I intend to generalise the code, to work with several different
>> boards other than the PI, could anyone suggest a board that would
>> benefit from such an add on.

There is certainly interest in being able to plug in generic GPIO
devices into QEMU's emulation. The trick would be to come up with
something that is both flexible enough and simple to plug into device
emulation.

There are other out-of-tree solutions to this that have been developed
by hardware tool bods to plug QEMU into things like SystemC emulations
of FPGAs and other devices.

>> Is this a worth while addon?

It's certainly worth exploring but it would have to be a generic
solution not tied just to the Raspberry Pi.

>> John BradleyTel: 07896 839635Skype: flypie125 125B Grove StreetEdge Hill Liverpool L7 7AF
>
> CCing ARM maintainers (see the ./MAINTAINERS file to find the right
> people to CC)
>
> Stefan


--
Alex Bennée
