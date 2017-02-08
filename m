Received: from eggs.gnu.org ([2001:4830:134:3::10]:60592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbTeT-0000W6-KO
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:55:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbTeQ-0005ZQ-Il
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:55:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cbTeQ-0005ZG-Ce
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:55:18 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D913804EF
	for <qemu-devel@nongnu.org>; Wed,  8 Feb 2017 14:55:18 +0000 (UTC)
References: <20170207100302.3995.67911.malonedeb@chaenomeles.canonical.com>
	<20170207232226.5557.42629.malone@wampee.canonical.com>
	<8fccd2e6-43ff-d684-d300-253fb4a4306c@redhat.com>
	<61123a62-8649-cbb4-37be-5fd6953de439@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1b2025c0-c3c5-1e1e-5d91-64fc9d21439f@redhat.com>
Date: Wed, 8 Feb 2017 15:55:15 +0100
MIME-Version: 1.0
In-Reply-To: <61123a62-8649-cbb4-37be-5fd6953de439@redhat.com>
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
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

On 02/08/17 15:04, Max Reitz wrote:
> [removed LP from CC, but kept qemu-devel because everyone is interested]

[citation needed] :)

> On 08.02.2017 02:29, Laszlo Ersek wrote:
>> On 02/08/17 00:22, Max Reitz wrote:
>>> That should be simple enough to implement considering we have this
>>> behavior already on SIGUSR1. Unfortunately, I wouldn't be able to test
>>> it because Linux apparently doesn't implement SIGINFO...
>>>
>>> Max
>>>
>>>
>>> PS: By the way, thanks for the information. I didn't know about SIGINFO at all. Well, now I have mapped Ctrl-T to SIGUSR1 in my terminal emulator so I don't have to feel quite as inferior...
>>>
>>
>> By that you may have lost the following Readline action:
>>
>>        transpose-chars (C-t)
>>               Drag the character before point forward over the charac-
>>               ter at point, moving point forward as well.  If point is
>>               at  the  end  of  the line, then this transposes the two
>>               characters before point.   Negative  arguments  have  no
>>               effect.
>>
>> I'm sure you've been using that all the time... ;)
> 
> More importantly, I forgot that C-T is my shortcut in vim for going back
> the cscope stack. I accidentally killed vim twice until I figured out
> what "Vim: Caught deadly signal USR1" means.

Haha, very cool!

> 
> I then put it on Ctrl-Alt-T. :-)

No can do; that's my shortcut in IceWM for opening an xterm! :)

Laszlo
