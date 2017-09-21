Received: from eggs.gnu.org ([2001:4830:134:3::10]:50538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dv3yt-0004Qy-P6
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dv3yq-0007NI-Ot
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:05:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dv3yq-0007Mi-Jr
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:05:36 -0400
Date: Thu, 21 Sep 2017 18:05:10 +0200
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20170921160510.h2b6kbtsvf3rc73z@localhost.localdomain>
References: <20170808203900.7661-1-jfreimann@redhat.com>
	<20170808203900.7661-4-jfreimann@redhat.com>
	<CAJ+F1C+1WzPe4Z6DDZyn308VV+D7AjVob2VseWK+0FFpiY2NsA@mail.gmail.com>
	<20170920150903.arckboulxo7o72d4@dhcp-192-218.str.redhat.com>
	<CAJ+F1CJVZxt3pWW1GEuy+0KNab4wxY4wc8A-raMPzTF5Qq_G4Q@mail.gmail.com>
	<20170921133137.dbs6o6mwe6tm3joh@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20170921133137.dbs6o6mwe6tm3joh@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] libvhost-user: quit when no more
 data received
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc-Andr?? Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Victor Kaplansky <victork@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Sep 21, 2017 at 01:31:37PM +0000, Jens Freimann wrote:
>On Wed, Sep 20, 2017 at 04:14:33PM +0000, Marc-Andr?? Lureau wrote:
>>On Wed, Sep 20, 2017 at 5:09 PM, Jens Freimann <jfreimann@redhat.com> wrote:
>>>On Tue, Sep 19, 2017 at 04:46:24PM +0000, Marc-Andr?? Lureau wrote:
>>>>On Tue, Aug 8, 2017 at 10:52 PM Jens Freimann <jfreimann@redhat.com>
>>>>wrote:
>>We want to treat disconnect as a panic condition imho, that the
>>library user is free to implement in different way (abort() clean
>>exit, reconnect etc).
>
>Ok, that wasn't obvious to me. Thanks for clarifying! So I was 
>"fixing" the wrong part. On a disconnect vubr_panic() in
>vhost-user-bridge.c is called and is supposed to do the right thing.
>
>Currently it will print an error message "PANIC: Unhandled request:

Actually it is "Error while recvmsg" because in vu_message_read()
vu_panic is called if rc from recvmsg is <= 0. Followed by "Error
while dispatching" printed by vhost-user-bridge. 

regards,
Jens 
