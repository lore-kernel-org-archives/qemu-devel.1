Received: from eggs.gnu.org ([2001:4830:134:3::10]:46228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAf7u-0001uK-K4
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAf7r-0001is-Bm
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:51:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAf7r-0001iX-5C
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:51:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-29-armbru@redhat.com>
	<1ca2afa9-1eb3-6b01-bea9-486227dc1355@redhat.com>
Date: Thu, 11 Oct 2018 19:51:52 +0200
In-Reply-To: <1ca2afa9-1eb3-6b01-bea9-486227dc1355@redhat.com> (Eric Blake's
	message of "Mon, 8 Oct 2018 15:46:16 -0500")
Message-ID: <87lg74xtfr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 28/31] fsdev: Clean up error reporting in
 qemu_fsdev_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

Eric Blake <eblake@redhat.com> writes:

> On 10/8/18 12:31 PM, Markus Armbruster wrote:
>> Calling error_report() from within a a function that takes an Error **
>
> s/a a/a/

Fixing, thanks!

>> argument is suspicious.  qemu_fsdev_add() does that, and its caller
>> fsdev_init_func() then fails without setting an error.  Its caller
>> main(), via qemu_opts_foreach(), is fine with it, but clean it up
>> anyway.
>>
