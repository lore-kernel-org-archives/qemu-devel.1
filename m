Received: from eggs.gnu.org ([208.118.235.92]:35398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gegQh-0001DR-5c
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 08:19:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gegQZ-0008OU-Lj
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 08:19:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gegQU-0008LD-7I
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 08:19:16 -0500
Date: Wed, 2 Jan 2019 13:19:10 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190102131909.GA2781@work-vm>
References: <SG2PR03MB3594A9080D305565DE9FB4E380BB0@SG2PR03MB3594.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR03MB3594A9080D305565DE9FB4E380BB0@SG2PR03MB3594.apcprd03.prod.outlook.com>
Subject: Re: [Qemu-devel] live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ? ? <zach_turing@outlook.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

* ? ? (zach_turing@outlook.com) wrote:
> 
> Hello, I have a question I would like to ask.
> If I add the -incoming parameter when starting the qemu virtual machine, the virtual machine will block all the time, waiting for the migration connection request to arrive.
> I want to modify the time of this blocking wait, how should I modify the source code?

It's not a timeout; it's a permanent wait for an incoming VM image.

What are you trying to do, and what would you like it to do if
it were to time out?

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
