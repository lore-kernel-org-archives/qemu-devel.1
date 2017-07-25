Received: from eggs.gnu.org ([2001:4830:134:3::10]:43667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1da1NA-0003vo-CQ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1da1N6-0003Tb-El
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:03:44 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1da1N6-0003T6-8l
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:03:40 -0400
Received: by mail-wr0-x229.google.com with SMTP id 12so120461466wrb.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 08:03:40 -0700 (PDT)
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-36-f4bug@amsat.org>
	<87lgncehbq.fsf@linaro.org>
	<5effed07-96c1-ae79-32a5-46b75516bf21@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <5effed07-96c1-ae79-32a5-46b75516bf21@amsat.org>
Date: Tue, 25 Jul 2017 16:03:37 +0100
Message-ID: <87eft4eeye.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 35/35] script to run docker
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

>> This isn't appropriate for 2.10 now we are feature frozen. That said I
>
> Surely. From the cover:
>
> "... provided at the end of this series as RFC for people wanted
> to give a try (also include 'dockershell' script and a fix in
> ./configure). These RFC patches (33-35) are not expected to enter
> 2.10."

My mistake - I hadn't gone over the cover letter. I would usually expect
a series with [PATCH for 2.10] just to contain stuff being considered
for the immediate future.

>
> Peter also commented on the "./configure" patch, so I probably
> mis-titled "RFC" those patch
>
> http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg07584.html:
> "I prefixed this patch 'RFC' to not consider it but provide it
> if someone wanted to reproduce the analysis. Maybe I should prefix it
> 'XXX' next time or 'NOT FOR MERGE'."
>
> better "NOT FOR REVIEW" or "!RFC"? :p

Better to post a logically separate series. It's fine to make an
in-flight series a pre-requisite though (not that I think you need it
here).

>> have pondered a helper script for this sort of thing before. As it stand
>> I just rely on my shell to remember the correct invocation for me.
>>
>> This is the sort of functionality we would need for maybe cross
>> compiling tests using docker.
>
> This script is way incomplete and far being finished.
>
> Regards,
>
> Phil.


--
Alex Bennée
