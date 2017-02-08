Received: from eggs.gnu.org ([2001:4830:134:3::10]:40678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbH4u-0000uY-TY
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 20:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbH4q-0003dY-WB
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 20:29:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cbH4q-0003dD-Q7
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 20:29:44 -0500
References: <20170207100302.3995.67911.malonedeb@chaenomeles.canonical.com>
	<20170207232226.5557.42629.malone@wampee.canonical.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8fccd2e6-43ff-d684-d300-253fb4a4306c@redhat.com>
Date: Wed, 8 Feb 2017 02:29:41 +0100
MIME-Version: 1.0
In-Reply-To: <20170207232226.5557.42629.malone@wampee.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1662468] Re: [feature request] qemu-img
 convert should respond to control-T like dd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1662468 <1662468@bugs.launchpad.net>, qemu-devel@nongnu.org

On 02/08/17 00:22, Max Reitz wrote:
> That should be simple enough to implement considering we have this
> behavior already on SIGUSR1. Unfortunately, I wouldn't be able to test
> it because Linux apparently doesn't implement SIGINFO...
> 
> Max
> 
> 
> PS: By the way, thanks for the information. I didn't know about SIGINFO at all. Well, now I have mapped Ctrl-T to SIGUSR1 in my terminal emulator so I don't have to feel quite as inferior...
> 

By that you may have lost the following Readline action:

       transpose-chars (C-t)
              Drag the character before point forward over the charac-
              ter at point, moving point forward as well.  If point is
              at  the  end  of  the line, then this transposes the two
              characters before point.   Negative  arguments  have  no
              effect.

I'm sure you've been using that all the time... ;)

Laszlo
