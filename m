Received: from eggs.gnu.org ([2001:4830:134:3::10]:38850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clE45-0004xe-3c
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:18:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clE3y-0007RI-Na
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:18:03 -0500
Received: from mail-qk0-x236.google.com ([2607:f8b0:400d:c09::236]:32854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clE3y-0007RB-HV
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:17:58 -0500
Received: by mail-qk0-x236.google.com with SMTP id y76so71768qkb.0
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 04:17:58 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-17-git-send-email-armbru@redhat.com>
	<49e43891-f2cc-6ba8-5abf-09e24fde70be@amsat.org>
	<87lgshil4p.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <da0ca708-df2b-2eba-38bd-e118db155f6d@amsat.org>
Date: Tue, 7 Mar 2017 09:17:53 -0300
MIME-Version: 1.0
In-Reply-To: <87lgshil4p.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On 03/07/2017 04:47 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>
>> On 03/03/2017 09:32 AM, Markus Armbruster wrote:
>>> The string input visitor tries to cope with null input.  Null input
>>> isn't used anywhere, and isn't covered by tests.  Unsurprisingly, it
>>> doesn't fully work: start_list() crashes because it passes the input
>>> via parse_str() to strtoll() unchecked.
>>>
>>> Make string_input_visitor_new() assert its argument isn't null, and
>>> drop the code trying to deal with null input.
>>>
>>> The opts visitor crashes when you try to actually visit something with
>>> null input.  Make opts_visitor_new() assert its argument isn't null,
>>> mostly for clarity.
>>>
>>> qobject_input_visitor_new() already asserts its argument isn't null.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>
> Since the series has been merged already, there's no way for me to
> record your review with the commit.  Thanks anyway!
>

ups didn't notice the PULL, no worries ;)
