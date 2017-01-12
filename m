Received: from eggs.gnu.org ([2001:4830:134:3::10]:32948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRfc7-0007VA-3l
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:40:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRfc4-0006ZM-1E
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:40:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRfc3-0006Yj-Ry
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:40:19 -0500
Date: Thu, 12 Jan 2017 11:40:17 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170112134017.GM3565@thinpad.lan.raisama.net>
References: <1484052795-158195-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484052795-158195-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] fix query-memdev not repporting IDs
 of memory backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, eblake@redhat.com, afaerber@suse.de, pbonzini@redhat.com

On Tue, Jan 10, 2017 at 01:53:12PM +0100, Igor Mammedov wrote:
> 
> Changelog:
>     since v1:
>         * fix mistakes in commit messages/change them as suggested
>         * extend 3/3 commit message to explain why it's ok to use 'id'
>         * 3/3 set 'id' property directly instead of injecting it back
>           into qdict.
> 
> 
> Series is a couple of preparratory cleanups which simplify fix
> and a fix itself.
> 
> Before fix HMP 'info memdevs' for CLI:
> qemu-system-x86_64 -object memory-backend-ram,id=mem0,size=1G
> outputs:
> 
>   memory backend: 0
>     size:  1073741824
>     merge: true
>     dump: true
>     prealloc: false
>     policy: default
>     host nodes: 128
> 
> after fix:
> 
>   memory backend: mem0
>     size:  1073741824
>     merge: true
>     dump: true
>     prealloc: false
>     policy: default
>     host nodes: 128
> 
> it should help to avoid remembering hotplugged IDs as they
> could be queried back via HMP/QMP interface.
> 

Applied to machine-next. Thanks!

-- 
Eduardo
