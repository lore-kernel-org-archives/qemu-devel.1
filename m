Received: from eggs.gnu.org ([2001:4830:134:3::10]:45210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT51t-0000Fa-Ur
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT51r-0007oa-Cs
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:37:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53332 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fT51r-0007n6-75
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:37:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2E28818F6EA
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 12:37:34 +0000 (UTC)
References: <1525843212-31922-1-git-send-email-thuth@redhat.com>
	<87bmch48w6.fsf@dusky.pond.sub.org>
	<a16c729a-8856-1141-5a6f-e647624bab44@redhat.com>
	<dcd08712-9dbd-eeda-7040-40b1afb14429@redhat.com>
	<87d0wvkxwi.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <efa8d9fd-c567-455d-4b50-4b04ee0f0e5b@redhat.com>
Date: Wed, 13 Jun 2018 14:37:32 +0200
MIME-Version: 1.0
In-Reply-To: <87d0wvkxwi.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add an entry for
 qemu-options* files in main directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 13/06/2018 08:23, Markus Armbruster wrote:
> 
>>> Do you think you could still be available as (co-)maintainer of that new
>>> section? If not, who are going to be the maintainers of that new
>>> section? Paolo? Eric? Daniel? ...?
>> Well, currently it's going through me.  I'd add vl.c too, by the way.
> vl.c has much more than just CLI parsing.  It's pushing 4kSLOC...

Not much more though.  There is some main loop / runstate stuff which
could be split to its own file, but it's perhaps 2-300 lines of code.
The rest is main() and its dependencies.  Actually 1/3rd of it is main(). :)

> Splitting it up would be nice.  As long as it's not, I guess the
> pragmatic solution is to have multiple MAINTAINERS sections claim it:
> existing "Main loop", proposed "CLI", ...

That would work too.
