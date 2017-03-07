Received: from eggs.gnu.org ([2001:4830:134:3::10]:51470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cl9qA-0001Lg-My
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cl9q5-0005fw-S1
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:47:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cl9q5-0005fr-MH
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:47:21 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-17-git-send-email-armbru@redhat.com>
	<49e43891-f2cc-6ba8-5abf-09e24fde70be@amsat.org>
Date: Tue, 07 Mar 2017 08:47:18 +0100
In-Reply-To: <49e43891-f2cc-6ba8-5abf-09e24fde70be@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 6 Mar 2017 14:07:29
	-0300")
Message-ID: <87lgshil4p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 16/28] qapi: Make string input and opts
 visitor require non-null input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 03/03/2017 09:32 AM, Markus Armbruster wrote:
>> The string input visitor tries to cope with null input.  Null input
>> isn't used anywhere, and isn't covered by tests.  Unsurprisingly, it
>> doesn't fully work: start_list() crashes because it passes the input
>> via parse_str() to strtoll() unchecked.
>>
>> Make string_input_visitor_new() assert its argument isn't null, and
>> drop the code trying to deal with null input.
>>
>> The opts visitor crashes when you try to actually visit something with
>> null input.  Make opts_visitor_new() assert its argument isn't null,
>> mostly for clarity.
>>
>> qobject_input_visitor_new() already asserts its argument isn't null.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Since the series has been merged already, there's no way for me to
record your review with the commit.  Thanks anyway!
