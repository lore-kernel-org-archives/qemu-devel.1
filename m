Received: from eggs.gnu.org ([2001:4830:134:3::10]:37990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpAgN-00005d-5h
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpAgB-00086t-7C
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:02:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpAgB-00085v-2A
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:01:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20AF0C04BD2C
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 10:01:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-11-eblake@redhat.com>
	<172f4b48-f791-2f36-3df5-0a2bd4c859c3@redhat.com>
Date: Tue, 05 Sep 2017 12:01:56 +0200
In-Reply-To: <172f4b48-f791-2f36-3df5-0a2bd4c859c3@redhat.com> (Thomas Huth's
	message of "Tue, 5 Sep 2017 11:22:14 +0200")
Message-ID: <87vakxxy3v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 10/29] libqtest: Topologically sort
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

Thomas Huth <thuth@redhat.com> writes:

> On 01.09.2017 20:03, Eric Blake wrote:
>> Put static functions prior to public ones, in part so that
>> improvements to qtest_start() can benefit from the static
>> helpers without needing forward references.  Code motion, with
>> no semantic change.
>> 
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  tests/libqtest.c | 263 +++++++++++++++++++++++++++----------------------------
>>  1 file changed, 131 insertions(+), 132 deletions(-)
[...]
> That's a *lot* of code motion - just to get rid of one forward
> declaration. IMHO getting rid of just one forward declaration does not
> justify this code churn. But if we really, really want to get rid of the
> forward declaration here, it's maybe better to move the
> qtest_init_without_qmp_handshake() and qtest_init() function to the end
> of the file instead?

I've never understood why people hate forward declarations so much.
Just because the compiler needs to see a declaration before any use
doesn't mean a human reader profits from seeing the definition before
any use.  Sometimes the code is easier to understand in top-down order.

For code I maintain, I evaluate code motion proposals strictly on
readability merits, with complete disregard for the number of forward
declarations added or deleted.

I'm very much not maintaining this code, though :)
