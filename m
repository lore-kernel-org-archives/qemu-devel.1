Received: from eggs.gnu.org ([209.51.188.92]:48836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gkAAR-0006Vi-E0
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gkAAO-0008VG-Rf
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:05:19 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <23150df9-1a9d-d1ef-c624-64eb2425a8d5@redhat.com>
References: <cover.1547739122.git.berto@igalia.com>
	<23150df9-1a9d-d1ef-c624-64eb2425a8d5@redhat.com>
Date: Thu, 17 Jan 2019 17:05:08 +0100
Message-ID: <w51a7jz2rt7.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 00/13] Add a 'x-blockdev-reopen' QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 17 Jan 2019 04:50:20 PM CET, Eric Blake wrote:

>> Removing the backing file can be done by simply passing the option {
>> ..., "backing": null } to x-blockdev-reopen.
>> 
> Hmm - that makes my proposal of "option":null as an explicit request
> to the default a bit trickier, if we are already using null for a
> different meaning for backing files.

At the moment 'backing' seems to be the only option that allows a null
value (BlockdevRefOrNull in particular). I suppose there could be more
in the future?

Also, having 'null' meaning 'reset to default' would make this API
differ from blockdev-add, which I'm trying not to do.

Berto
