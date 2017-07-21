Received: from eggs.gnu.org ([2001:4830:134:3::10]:34612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYyg-0006Q2-TM
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYyd-0001sW-Dd
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:32:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dYYyd-0001rU-7F
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:32:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1714A883C9
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:32:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170720214008.28494-1-eblake@redhat.com>
	<20170720214008.28494-4-eblake@redhat.com>
	<87shhpj3uo.fsf@dusky.pond.sub.org>
	<f3b66d5f-4dad-4d46-a5f8-6709a40aabf4@redhat.com>
Date: Fri, 21 Jul 2017 16:32:19 +0200
In-Reply-To: <f3b66d5f-4dad-4d46-a5f8-6709a40aabf4@redhat.com> (Eric Blake's
	message of "Fri, 21 Jul 2017 09:04:22 -0500")
Message-ID: <8760eleu8c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/4] qtest: Avoid passing raw strings
 through hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 07/21/2017 08:50 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> The next patch will add __attribute__((__format__)) to hmp(), which
>> 
>> It did in v1, but no more.  Intentional?
>
> Oh shoot.  I got so busy deleting the attribute for qmp() and friends
> that I also deleted it for hmp().  I'm not having a very good run at
> this, am I?

I've done worse :)
