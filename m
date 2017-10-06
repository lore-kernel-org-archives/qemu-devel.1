Received: from eggs.gnu.org ([2001:4830:134:3::10]:60075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0LT1-0007dA-FN
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0LSy-0000rf-D9
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:46:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1e0LSy-0000q7-6o
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:46:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06E91806A1
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 05:46:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20171005105157.10831-1-dgilbert@redhat.com>
	<20171005105157.10831-4-dgilbert@redhat.com>
	<19c477ab-a3dc-a994-905b-7a8d01298a76@redhat.com>
Date: Fri, 06 Oct 2017 07:46:29 +0200
In-Reply-To: <19c477ab-a3dc-a994-905b-7a8d01298a76@redhat.com> (Paolo
	Bonzini's message of "Thu, 5 Oct 2017 14:47:01 +0200")
Message-ID: <87shew96bu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 3/5] hmp-commands-info: Fix "info
 rocker-FOO" misspellings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 05/10/2017 12:51, Dr. David Alan Gilbert (git) wrote:
>> From: Markus Armbruster <armbru@redhat.com>
>> 
>> Screwed up in commit da76ee7.
>
> Let me introduce you to these two aliases:
>
>         whatis = "show -s --pretty='tformat:%h (\"%s\", %cd)' --date=short"
>         pwhatis = "show -s --pretty='tformat:%h, \"%s\", %cd' --date=short"
>
> $ git whatis da76ee7
> da76ee76f7 ("hmp-commands-info: move info_cmds content out of monitor.c", 2015-09-16)
>
> pwhatis is more appropriate if you are including the commit at the end
> of a parenthetical remark, like
>
>    ... (see commit message for 53ec73e, "block: Use bdrv_drain to
>    replace uncessary bdrv_drain_all", 2015-07-07).

Heh, nice way to call out my laziness ;)  Thanks!
