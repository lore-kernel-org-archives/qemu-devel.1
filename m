Received: from eggs.gnu.org ([2001:4830:134:3::10]:39011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cM0Eu-0008Lq-Ew
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 17:29:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cM0Et-0006c3-LT
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 17:29:00 -0500
Received: from mail-vk0-x22f.google.com ([2607:f8b0:400c:c05::22f]:34773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cM0Et-0006bu-E5
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 17:28:59 -0500
Received: by mail-vk0-x22f.google.com with SMTP id x186so214553658vkd.1
	for <qemu-devel@nongnu.org>; Tue, 27 Dec 2016 14:28:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAK5BdwNYBgHBqiByVeZqtz6+VqB-2FY5vkP3Q8trRJm8hxrADg@mail.gmail.com>
References: <516AC28F-18A9-4FC9-8028-5AE2F37CB897@gmail.com>
	<C50D14FE-4C5D-4944-948B-09376B20FF16@gmail.com>
	<CAK5BdwOhfw2t=AYqs-Bu4sFJcRe4a-aq7k+2G-boLbV-P+5MyQ@mail.gmail.com>
	<5A9C1952-461A-4829-8916-C2F40EE8E5D8@gmail.com>
	<CAK5BdwN8hXReei6YAUs=9OmNqF1DTxmH+q2BSuvUESWLf_1ABw@mail.gmail.com>
	<7094FB37-03A9-4511-B4A6-519CDA1E6854@gmail.com>
	<CAK5BdwMi82wiefTqr_gLKtw7sUv24OWDdr0U6VDvpq9eK8wVdQ@mail.gmail.com>
	<6B96C329-A972-4CBE-A021-36DBAF92EFF9@gmail.com>
	<CAK5BdwNYBgHBqiByVeZqtz6+VqB-2FY5vkP3Q8trRJm8hxrADg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 22:28:36 +0000
Message-ID: <CAFEAcA9nGKzZfXjKt9hV_O0HqFB_66QpTaZzV7Ld8CHHCsHUOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] PowerPC question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KHQvNC40YDQvdC+0LI=?= <vave1313@gmail.com>
Cc: Programmingkid <programmingkidx@gmail.com>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 27 December 2016 at 19:50, =D0=94=D0=BC=D0=B8=D1=82=D1=80=D0=B8=D0=B9 =
=D0=A1=D0=BC=D0=B8=D1=80=D0=BD=D0=BE=D0=B2 <vave1313@gmail.com> wrote:
> I haven't tried QEMU 2.8.0, because the job-task requires use QEMU 2.5.1.=
1.
> So I need to decide this problem on 2.5.1.1 version:(

You haven't really explained what the job-task is or why
it requires 2.5.1.1 in particular. Does this RTOS not work
on more recent versions?

That said, it looks like QEMU has supported displaying
the DECR value in the monitor 'info registers' command
for a very long time, so it probably should work in 2.5.
Could you say clearly:
 * what monitor command you're trying
 * what output it gives
 * why you think that's not right and what the output should be
?

thanks
-- PMM
