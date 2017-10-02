Received: from eggs.gnu.org ([2001:4830:134:3::10]:50436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyuwl-00051F-R6
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 03:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyuwe-0003ig-50
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 03:15:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dyuwd-0003hQ-VL
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 03:15:16 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-6-eblake@redhat.com>
	<6f449d3a-bff7-f3bd-23e2-7b56258ee8c9@redhat.com>
Date: Mon, 02 Oct 2017 09:15:00 +0200
In-Reply-To: <6f449d3a-bff7-f3bd-23e2-7b56258ee8c9@redhat.com> (Eric Blake's
	message of "Mon, 11 Sep 2017 16:52:06 -0500")
Message-ID: <87o9pqqavf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 05/22] qobject: Simplify
 qobject_from_jsonv()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
List-ID: <qemu-devel.nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 08/03/2017 08:25 PM, Eric Blake wrote:
>> qobject_from_jsonv() was unusual in that it took a va_list*, instead
>> of the more typical va_list; this was so that callers could pass
>> NULL to avoid % interpolation.  While this works under the hood, it
>> is awkward for callers, so move the magic into qjson.c rather than
>> in the public interface, and finally improve the documentation of
>> qobject_from_jsonf().
>> 
>
>> +/*
>> + * va_list form of qobject_from_jsonf().
>> + *
>> + * IMPORTANT: This function aborts on error, thus it must not
>> + * be used with untrusted arguments.
>> + */
>> +QObject *qobject_from_jsonv(const char *string, va_list ap)
>> +{
>
> Given your comments on vararg naming elsewhere in the series, I'm also
> thinking this is a good chance to fix this to be named
> qobject_from_vjsonf() (making it obvious it is the va_list form of
> formatted json, and similar to printf/vprintf or my
> qtest_startf/qtest_vstartf in my v7 preliminary cleanup series).

Yes, please.
