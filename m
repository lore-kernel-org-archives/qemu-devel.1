Received: from eggs.gnu.org ([209.51.188.92]:48172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1go8CN-0004Il-24
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1go8CF-0000p7-TJ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:47:38 -0500
Date: Mon, 28 Jan 2019 15:47:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190128144720.GB5756@localhost.localdomain>
References: <20190128142748.29140-1-antonkuchin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128142748.29140-1-antonkuchin@yandex-team.ru>
Subject: Re: [Qemu-devel] [PATCH 0/2] block: add blk_lookup() for getting
 device by node_name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Kuchin <antonkuchin@yandex-team.ru>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>

Am 28.01.2019 um 15:27 hat Anton Kuchin geschrieben:
> Some HMP and QMP commands are targeting BlockBackend but
> for hotplugged devices name of BB is deprecated, instead
> name of root BlockDriverState is set. These patches add
> functions to search BB by attached root BDS name.
> 
> This approach isn't perfect, but I couldn't invent a better
> one and I belive it's more convinient than accessing BB
> by QOM path.

There could be more than one BlockBackend attached to a single node, so
this approach is simply wrong.

I think the qdev ID is actually not only a pretty convenient way, but in
fact the only logical way to address a guest device (and BlockBackends
that can be accessed by the monitor are essentially a part of the guest
device).

Does your series allow to perform any operation that isn't possible
currently? If so, it's probably this operation that needs to be fixed to
either accept node names (if it's a backend operation) or a device ID
(if it's a frontend operation).

Kevin
