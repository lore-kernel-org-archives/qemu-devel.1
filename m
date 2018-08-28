Received: from eggs.gnu.org ([2001:4830:134:3::10]:46742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mkschreder.uk@googlemail.com>) id 1fudN6-0003gK-2T
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mkschreder.uk@googlemail.com>) id 1fudN5-0005sL-D7
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:45:24 -0400
Received: from mail-vk0-x22f.google.com ([2607:f8b0:400c:c05::22f]:35255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mkschreder.uk@googlemail.com>)
	id 1fudN1-0005pq-Eg
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:45:21 -0400
Received: by mail-vk0-x22f.google.com with SMTP id w193-v6so697092vke.2
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 05:45:14 -0700 (PDT)
MIME-Version: 1.0
From: Martin Schroeder <mkschreder.uk@googlemail.com>
Date: Tue, 28 Aug 2018 14:45:02 +0200
Message-ID: <CAGmj6qv7NfwcL2Jk3mCA4V6ghru4rnO21BR_FXJ03ws3mUZPcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Telling qemu to run for a number of guest milliseconds
 and then pause
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'm working on an interface between qemu and an in house testing suite
and one of the things I would like to do is tell qemu to run the guest
for a number of guest milliseconds and then pause execution of the
guest.

I do not want qemu to raise a debug exception. I just want it to pause
(ie sleep on an external semaphore for example) so that it does not
execute any more guest instructions but then when told to resume it
should just continue and make sure that guest does not see this pause
at all.

Where in the code would be the best place to add such functionality?
