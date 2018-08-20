Received: from eggs.gnu.org ([2001:4830:134:3::10]:59678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1frfeR-0002uP-EQ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1frfeN-0008G6-GB
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:35:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48766 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1frfeM-0008Fe-6h
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:34:59 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-6-armbru@redhat.com>
	<5150f7dd-d6f7-d09d-6881-6d45f097cf21@redhat.com>
Date: Mon, 20 Aug 2018 10:34:54 +0200
In-Reply-To: <5150f7dd-d6f7-d09d-6881-6d45f097cf21@redhat.com> (Eric Blake's
	message of "Fri, 17 Aug 2018 10:51:06 -0500")
Message-ID: <87tvnpsafl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 05/60] qmp-test: Cover syntax and
 lexical errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/17/2018 10:05 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> Might be worth mentioning the addition of qtest_qmp_send_raw() in the
> commit message body.

I'm adding:

    qmp-test neglects to cover QMP input that isn't valid JSON.  libqtest
    doesn't let us such input.  Add qtest_qmp_send_raw() for this purpose,
    and put it to use in qmp-test.

>>   tests/libqtest.c | 17 +++++++++++++++++
>>   tests/libqtest.h | 11 +++++++++++
>>   tests/qmp-test.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>>   3 files changed, 68 insertions(+), 1 deletion(-)
>>
>
>> +/**
>> + * qtest_qmp_send_raw:
>> + * @s: #QTestState instance to operate on.
>> + * @fmt...: text to send, formatted like sprintf()
>> + *
>> + * Sends text to the QMP monitor verbatim.  Need not be valid JSON;
>> + * this is useful for negative tests.
>> + */
>> +void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
>> +    GCC_FMT_ATTR(2, 3);
>> +
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
