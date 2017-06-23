Received: from eggs.gnu.org ([2001:4830:134:3::10]:41379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dOOar-0004CX-Uu
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dOOaq-00043z-NR
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:25:49 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dOOaq-00043H-9i
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:25:48 -0400
Received: by mail-lf0-x244.google.com with SMTP id u62so6423892lfg.0
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 06:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1498222907.git.tgolembi@redhat.com>
In-Reply-To: <cover.1498222907.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 23 Jun 2017 13:25:34 +0000
Message-ID: <CAJ+F1C+-fXWoVjeML1Op67+h-nYbe03k-k0TYdkNA2RQ7t9-ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/3] qemu-ga: support for sending events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

Hi

On Fri, Jun 23, 2017 at 3:03 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi=
@redhat.com>
wrote:

> This is just a draft, or a request for comments if you will.
>
> This patch sets drafts the support of sending events by QEMU Guest Agent.
> Events can plan important role in monitoring of the guest OS behaviour. T=
he
> range of use cases ranges from events important for scheduling, e.g.
> memory and
> CPU usage statistics, to things like changes to IP addresses on network
> interfaces to for example changes in the list of active users.
>
> For now the patch set adds single periodic callback function to the GA ma=
in
> loop that can perform checks and trigger events that have occured since
> previous run of the callback.
>
> We can of course take it one step further and add a general framwork for
> periodically running any of the already implemented commands. Add a
> function
> that would maintain a list of registered checks. Client would use some
> command
> (register-monitor-command) passing it a command name and timeout in
> seconds and
> the monitoring handler would then run the specified command and report th=
e
> result... or report only if the return value changed since previous
> invocation.
> This feature would remove part of the communication overhead between
> client and
> GA.
>
> So before I invest any more time in either of these approaches, tell me.
> Would
> somethign like this be wanted or is that too controversial? Any other
> thoughts
> and ideas?
>
>
It doesn't feel wrong, but Is there really too much overhead and/or latency
if a request is periodic from the client? ie did you do some measurements
before coming to this proposal?

Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (3):
>   qemu-ga: add support for events
>   qemu-ga: add simple event reporting memory statistics
>   qemu-ga: add support for periodic command runner
>
>  Makefile               |  7 +++-
>  qga/Makefile.objs      |  2 +-
>  qga/channel-posix.c    |  8 +++++
>  qga/channel-win32.c    |  6 ++++
>  qga/channel.h          |  1 +
>  qga/guest-agent-core.h |  1 +
>  qga/main.c             | 98
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  qga/qapi-event.json    | 35 ++++++++++++++++++
>  qga/qapi-schema.json   |  2 ++
>  9 files changed, 158 insertions(+), 2 deletions(-)
>  create mode 100644 qga/qapi-event.json
>
> --
> 2.13.1
>
>
> --
Marc-Andr=C3=A9 Lureau
