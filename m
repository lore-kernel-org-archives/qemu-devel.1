Received: from eggs.gnu.org ([2001:4830:134:3::10]:44288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk1jp-0005KJ-00
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk1jo-00025r-A7
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:33:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38042 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fk1jo-00025g-4e
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:33:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-23-armbru@redhat.com>
	<8a69adaa-c842-8db7-b003-67ff82293553@redhat.com>
Date: Mon, 30 Jul 2018 08:32:58 +0200
In-Reply-To: <8a69adaa-c842-8db7-b003-67ff82293553@redhat.com> (Eric Blake's
	message of "Fri, 27 Jul 2018 12:08:51 -0500")
Message-ID: <87effl1bdx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 22/23] libqtest: Replace qtest_startf()
 by qtest_initf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com, f4bug@amsat.org

Eric Blake <eblake@redhat.com> writes:

> On 07/27/2018 10:13 AM, Markus Armbruster wrote:
>> qtest_init() creates a new QTestState, and leaves @global_qtest alone.
>> qtest_start() additionally assigns it to @global_qtest, but
>> qtest_startf() additionall sets assigns NULL to @global_qtest.  This
>
> s/additionall sets/additionally/

Fixing...

>> makes no sense.  Replace it by qtest_initf() that works like
>> qtest_init(), i.e. leaves @global_qtest alone.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
