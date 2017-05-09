Received: from eggs.gnu.org ([2001:4830:134:3::10]:35990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d85W1-0001tc-0Y
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d85Vx-0001Fb-1L
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:49:25 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:35979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d85Vw-0001FP-R4
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:49:20 -0400
Received: by mail-wr0-x22e.google.com with SMTP id l50so73948599wrc.3
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 06:49:20 -0700 (PDT)
References: <20170505103822.20641-1-alex.bennee@linaro.org>
	<20170505103822.20641-9-alex.bennee@linaro.org>
	<9d3cca3f-3a95-0beb-9342-428b96816173@redhat.com>
	<87pofnmgzl.fsf@linaro.org>
	<20170508175217.GO22428@stefanha-x1.localdomain>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170508175217.GO22428@stefanha-x1.localdomain>
Date: Tue, 09 May 2017 14:50:04 +0100
Message-ID: <87fuge87hv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 8/9] util/qemu-thread-*: add
 qemu_lock, locked and unlock trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, boost.lists@gmail.com, pavel.dovgaluk@ispras.ru, cota@braap.org, qemu-devel@nongnu.org


Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Fri, May 05, 2017 at 04:59:58PM +0100, Alex Bennée wrote:
>>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>> > On 05/05/2017 12:38, Alex Bennée wrote:
>> >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> >
>> > Can you look at the patch I just sent a pull request for?  It only has
>> > locked and unlocked trace events, you can add lock on top.
>>
>> Cool - great minds think alike ;-)
>>
>> I'll re-spin my trace analysis script and the lock trace point once that
>> pull request is merged. I would be nice if we could associate locks with
>> names though as the QemuMutex * is basically just an anonymous handle.
>> Would it be overly extravagant to add a const char * to QemuMutex to can
>> be init'ed with a human readable name?
>>
>> Stefan,
>>
>> Does the trace sub-system have any way to register a human readable
>> string to a given pointer value? I guess this is something that could be
>> added to the trace pre-amble?
>
> No, it doesn't.  I would make the trace event take const char * and pass
> in the string.

It would be nice to avoid having the string for non-trace builds. I was
thinking of something like:

  trace_register_human_name(void *ptr, const char *name)

Which compiles away to nothing when tracing is not enabled.

>
> Stefan


--
Alex Bennée
