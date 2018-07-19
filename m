Received: from eggs.gnu.org ([2001:4830:134:3::10]:37722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fg7zv-0001Ch-UD
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fg7zv-0003HT-5u
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:25:31 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:41097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fg7zu-0003HF-My
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:25:31 -0400
Received: by mail-oi0-x234.google.com with SMTP id k12-v6so15133620oiw.8
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 05:25:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87tvove7pv.fsf@dusky.pond.sub.org>
References: <20180703213556.20619-1-armbru@redhat.com>
	<20180703213556.20619-14-armbru@redhat.com>
	<CAFEAcA97fm3+17jjvktAXPQOj0VrVCGXPSFi8mQvU1bnnzgWZg@mail.gmail.com>
	<87tvove7pv.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jul 2018 13:25:09 +0100
Message-ID: <CAFEAcA_B+3jRQ7bxhXYwUPoG6YYnMfD+SmO3WBTk0xV2GtkspA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 13/32] qmp: Revert change to
 handle_qmp_command tracepoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 July 2018 at 13:22, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> Coverity CID 1394216 points out that in this function a
>> little earlier we did a check on "if (!req && !err)", which
>> implies that we can get here with a NULL req pointer,
>> which will crash in qobject_to_json().
>
> Since fixed in
> commit 8720e63e monitor: Fix tracepoint crash on JSON syntax error

Aha, thanks. I've marked the Coverity issue as fix-submitted.

-- PMM
