Received: from eggs.gnu.org ([2001:4830:134:3::10]:53932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dIOKZ-0000Tl-4f
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 19:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dIOKY-0004G6-7V
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 19:56:11 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dIOKX-0004Fm-WF
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 19:56:10 -0400
Received: by mail-wm0-x22e.google.com with SMTP id x70so47248576wme.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 16:56:09 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <270686d0-1ca8-965f-a14a-397f45616deb@redhat.com>
References: <2b2311b1b070a0b03973e39deccf4682de4a6cd4.1496686997.git.alistair.francis@xilinx.com>
	<CAJ+F1CLuPkWjG3Hn8hfaxTApn6+ouqh5nJZNWSQYX1C3_HRFqA@mail.gmail.com>
	<e340cdb9-3c97-8624-81d9-f7888f819a68@amsat.org>
	<CAKmqyKOOhu7iKuW4naNi0+7cwayLaftkPf=gS7uBakMvKavxVQ@mail.gmail.com>
	<270686d0-1ca8-965f-a14a-397f45616deb@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 6 Jun 2017 16:55:38 -0700
Message-ID: <CAKmqyKM=e4zDG-jv-MdHQH3pqtLzBSnq7F-YWeB7S+bw91udVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/1] char-socket: Don't report TCP
 socket waiting as an error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Tue, Jun 6, 2017 at 3:14 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 06/06/2017 18:30, Alistair Francis wrote:
>>>
>>> This is somehow confusing. I don't think it is worth having another
>>> qemu_log_stderr() function rather than using error_report() but this very
>>> call might deserve a comment explaining this unusual use. What do you think?
>>
>> The problem with stderr is that this isn't an error. Some uses of QEMU
>> (inside Eclipse for example) flag everything printed on stderr as red
>> which confuses users that they are seeing an error when they really
>> aren't.
>
> But they are wrong.  Would it work for you to work around it, by making
> QEMU use a client (connect) rather than a server (listen) socket?

No, we use QEMU as both so we will always have this issue.

>
>> Also all the uses of this message that I have seen (there are probably
>> others though) stops QEMU until the connection is made, which means it
>> doesn't matter if it is mixed up in console output.
>
> It may not mix up, but it would break programs expecting only console
> output to be on stdout.

Is that something we guarantee that stdout will only ever be program output?

Thanks,
Alistair

>
>> I just think that this message to most users isn't helpful and they
>> probably don't even read it, so printing to stderr seems like a bit
>> much.
>
> I would compare it with dd's output.  It goes to stderr even though it's
> not an error.
>
> Paolo
>
