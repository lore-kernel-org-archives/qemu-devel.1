Received: from eggs.gnu.org ([2001:4830:134:3::10]:45473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejRx1-0007RI-4c
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejRww-0000oA-UB
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:47:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37050 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ejRww-0000nz-PA
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:47:54 -0500
References: <151801810352.29167.4832480228518630626.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f0b0adfe-d399-a3e7-386a-a00f5d8aff2b@redhat.com>
Date: Wed, 7 Feb 2018 09:47:52 -0600
MIME-Version: 1.0
In-Reply-To: <151801810352.29167.4832480228518630626.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: improve documentation of
 postcopy-ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 02/07/2018 09:41 AM, Greg Kurz wrote:
> This capability must have the same value on both source and destination,
> otherwise migration fails (commit 875fcd013ab6 "migration: incoming
> postcopy advise sanity checks").
> 
> Let's write it down in various places where postcopy-ram is documented.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   docs/devel/migration.rst |    4 ++--
>   hmp-commands.hx          |    3 ++-
>   qapi/migration.json      |   10 ++++++----
>   3 files changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
