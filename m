Received: from eggs.gnu.org ([2001:4830:134:3::10]:57085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elGiG-0006zR-A3
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elGiC-0004Wi-H3
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:12:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elGiC-0004WB-CL
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:12:12 -0500
References: <20180211004013.10784-1-eblake@redhat.com>
	<20180211004013.10784-3-eblake@redhat.com>
	<87a7wfj1p6.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cc862cab-5d2b-e786-1867-ffdc84b1da34@redhat.com>
Date: Mon, 12 Feb 2018 10:12:11 -0600
MIME-Version: 1.0
In-Reply-To: <87a7wfj1p6.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] qapi: Rename QMP and QGA schema files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 02/11/2018 03:49 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> Having two files in the tree both named qapi-schema.json just adds
>> confusion.  Rename these files, and relocate them into the common
>> qapi/ subdirectory.  Update all build rules that refer to the file
>> names, and adjust other documentation and comment references to
>> either track the new name or be rewritten so as to not mention
>> the file name.
>>
>> Maintainer-wise, this means that qapi/qga-schema.json continues
>> to belong to Michael as QGA maintainer, but now also notifies
>> Markus and Eric as QAPI maintainers, alongside all the other
>> QMP QAPI files, matching how other .json QAPI modules belong
>> to multiple maintainer blurbs.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   docs/devel/writing-qmp-commands.txt          | 13 ++++++-----
>>   docs/interop/qmp-intro.txt                   |  3 ++-
>>   Makefile                                     | 10 ++++----
>>   qga/qapi-schema.json => qapi/qga-schema.json |  0
> 
> This move is up to the QGA maintainer.  My usual argument for keeping
> the schema in one place is weak for the QGA schema: it's maintained
> separately, and ususuall grepped separately, too.

Michael, your thoughts?

> 
>>   qapi-schema.json => qapi/qmp-schema.json     | 34 ++++++++++++++--------------
> 
> While it was certainly created for QMP, it's now used for non-QMP stuff,
> too.  Do we mind?
> 

Well, patch 3 renames it further; having qapi/qapi-schema.qapi sounds 
redundant, and the fact that the file DOES drive our QMP decisions (even 
if it has some other types for internal use only) seems reasonable 
enough.  If anyone has a better name, I'm all ears.

>>   tpm.c                                        |  2 +-
>>   MAINTAINERS                                  |  2 +-
>>   7 files changed, 33 insertions(+), 31 deletions(-)
>>   rename qga/qapi-schema.json => qapi/qga-schema.json (100%)
>>   rename qapi-schema.json => qapi/qmp-schema.json (99%)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
