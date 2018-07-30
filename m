Received: from eggs.gnu.org ([2001:4830:134:3::10]:46092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk1xv-0000hB-Tm
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk1xs-0006Sh-S4
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:47:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47276 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fk1xs-0006RN-Mg
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:47:32 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-24-armbru@redhat.com>
	<51e15087-3153-bb22-5363-9ece7a0008bf@redhat.com>
Date: Mon, 30 Jul 2018 08:47:29 +0200
In-Reply-To: <51e15087-3153-bb22-5363-9ece7a0008bf@redhat.com> (Thomas Huth's
	message of "Fri, 27 Jul 2018 19:19:55 +0200")
Message-ID: <87a7q91apq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 23/23] libqtest: Rename qtest_FOOv() to
 qtest_vFOO() for consistency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, f4bug@amsat.org

Thomas Huth <thuth@redhat.com> writes:

> On 07/27/2018 05:13 PM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/libqtest.c | 12 ++++++------
>>  tests/libqtest.h |  4 ++--
>>  2 files changed, 8 insertions(+), 8 deletions(-)
>> 
>> diff --git a/tests/libqtest.c b/tests/libqtest.c
>> index a0d44793fa..3706f30aa2 100644
>> --- a/tests/libqtest.c
>> +++ b/tests/libqtest.c
>> @@ -538,7 +538,7 @@ QDict *qmp_fdv(int fd, const char *fmt, va_list ap)
>>      return qmp_fd_receive(fd);
>>  }
>>  
>> -QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap)
>> +QDict *qtest_vqmp(QTestState *s, const char *fmt, va_list ap)
>
> Unless you also add something to our coding conventions which mandates
> the naming to be always this way, I think this is just unnecessary code
> churn.

Consistency isn't "necessary", but it helps.

Tree-wide consistency would be nice, but my aim right now is local
consistency in libqtest.h.  Four out of its six functions taking va_list
are sensibly named.  This patch renames the remaining two.  Well worth
the diffstat, in my opinion.
