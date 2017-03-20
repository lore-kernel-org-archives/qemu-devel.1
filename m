Received: from eggs.gnu.org ([2001:4830:134:3::10]:58798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cq0C2-0005Uk-Iv
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cq0Bx-00020D-RM
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:30:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cq0Bx-000201-Ki
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:29:57 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490021158-4469-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA_QWrU6AGfWz1iNfgYJUuKJ=hyUOHkPOo8XKyyV=4WOSw@mail.gmail.com>
Date: Mon, 20 Mar 2017 17:29:47 +0100
In-Reply-To: <CAFEAcA_QWrU6AGfWz1iNfgYJUuKJ=hyUOHkPOo8XKyyV=4WOSw@mail.gmail.com>
	(Peter Maydell's message of "Mon, 20 Mar 2017 14:56:45 +0000")
Message-ID: <87bmsv29ok.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] hmp: gpa2hva and gpa2hpa hostaddr
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 20 March 2017 at 14:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> These commands are useful when testing machine-check passthrough.
>> gpa2hva is useful to inject a MADV_HWPOISON madvise from gdb, while
>> gpa2hpa is useful to inject an error with the mce-inject kernel
>> module.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  hmp-commands.hx |  32 ++++++++++++++++++
>>  monitor.c       | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 133 insertions(+)
>>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 8819281..0aca984 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -526,6 +526,38 @@ Dump 80 16 bit values at the start of the video memory.
>>  ETEXI
>
> I have some comments which feel kind of nit-picky, but since this
> is a public-facing HMP API I think they need attention since we only
> get one chance to get it right.

HMP is not a stable interface.  If we get it wrong, we change it.  If
our change breaks your usage, you get to keep the pieces.

That said, we prefer not to change HMP commands.  It's certainly better
to get it right from the start.

[...]
