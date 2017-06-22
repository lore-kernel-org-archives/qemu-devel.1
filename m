Received: from eggs.gnu.org ([2001:4830:134:3::10]:37482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dNwlw-0006xq-8R
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dNwls-0007li-8L
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:43:24 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:34965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dNwls-0007le-3f
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:43:20 -0400
Received: by mail-ua0-f180.google.com with SMTP id j53so8447714uaa.2
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 00:43:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <VI1PR1001MB13731144A5E55914A9E414A5B7DA0@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
References: <VI1PR1001MB137395F2FCBDE6389A9AC5FCB7C30@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7358YVXbk++Z7s+q6Z5O0Q=6CQiQvYsTdc35eqmQeUnP_Q@mail.gmail.com>
	<VI1PR1001MB1373C8915C51F7453D41B950B7C10@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7345_Nu_kpsSDGq7OyOSuKmgtyS-DuXTafkGeaCCXzV5LQ@mail.gmail.com>
	<VI1PR1001MB1373B1F3C97D9528166E2305B7C40@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb735e_NjY47LRZ58+zvKGmCRQKAmFo-HhByhsosRzQkOgxA@mail.gmail.com>
	<HE1PR1001MB1371F7874B487B0907C42A7EB7C50@HE1PR1001MB1371.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7372Pv3hR4S8C0TCV19u9XAKn=y0VmreGuZavhOjqRrypQ@mail.gmail.com>
	<VI1PR1001MB13731144A5E55914A9E414A5B7DA0@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 22 Jun 2017 09:43:18 +0200
Message-ID: <CABdb7377U9SpZno1kU6+TuARUmqfMMcC2uuwXTHqSZpLsqB7Gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Guest unresponsive after Virtqueue size exceeded
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Fernando_Casas_Sch=C3=B6ssow?= <casasfernando@hotmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Fernando,

On Wed, Jun 21, 2017 at 2:19 PM, Fernando Casas Sch=C3=B6ssow
<casasfernando@hotmail.com> wrote:
> Hi Ladi,
>
> Sorry for the delay in my reply.
> I will leave the host kernel alone for now then.
> For the last 15 hours or so I'm running memtest86+ on the host. So far so
> good. Two passes no errors so far. I will try to leave it running for at
> least another 24hr and report back the results. Hopefully we can discard =
the
> memory issue at hardware level.
>
> Regarding KSM, that will be the next thing I will disable if after removi=
ng
> the balloon device guests still crash.
>
> About leaving a guest in a failed state for you to debug it remotely, tha=
t's
> absolutely an option. We just need to coordinate so I can give you remote
> access to the host and so on. Let me know if any preparation is needed in
> advance and which tools you need installed on the host.

I think that gdbserver attached to the QEMU process should be enough.
When the VM gets into the broken state please do something like:

gdbserver --attach host:12345 <QEMU pid>

and let me know the host name and port (12345 in the above example).

> Once I again I would like to thank you for all your help and your great
> disposition!

You're absolutely welcome, I don't think I've done anything helpful so far =
:)

> Cheers,
>
> Fer
>
> On mar, jun 20, 2017 at 9:52 , Ladi Prosek <lprosek@redhat.com> wrote:
>
> The host kernel is less likely to be responsible for this, in my opinion.
> I'd hold off on that for now.
>
> And last but not least KSM is enabled on the host. Should I disable it?
>
> Could be worth the try.
>
> Following your advice I will run memtest on the host and report back. Jus=
t
> as a side comment, the host is running on ECC memory.
>
> I see. Would it be possible for you, once a guest is in the broken state,=
 to
> make it available for debugging? By attaching gdb to the QEMU process for
> example and letting me poke around it remotely? Thanks!
>
>
>
