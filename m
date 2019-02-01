Received: from eggs.gnu.org ([209.51.188.92]:49400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpUuO-0002TI-0n
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 04:14:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpUuN-0005y1-Aa
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 04:14:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gpUuN-0005xg-4b
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 04:14:47 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190131202637.4062-1-jusual@mail.ru>
Date: Fri, 01 Feb 2019 10:14:41 +0100
In-Reply-To: <20190131202637.4062-1-jusual@mail.ru> (Julia Suvorova via
	Qemu-devel's message of "Thu, 31 Jan 2019 23:26:37 +0300")
Message-ID: <87lg2zj2f2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] monitor: Add whitelist support for QMP
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
Cc: Julia Suvorova <jusual@mail.ru>, Jim Mussared <jim@groklearning.com>, Steffen =?utf-8?Q?G=C3=B6rtz?= <contrib@steffen-goertz.de>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org> writes:

> The whitelist option allows to run a reduced monitor with a subset of
> QMP commands. This allows the monitor to run in secure mode, which is

For a value of "secure".  I'm not saying this can't be useful, just
tempering expecations.  I guess you intend to use this to restrict the
monitor to sufficiently harmless commands, such as commands that merely
return information without changing anything.  However, even such
commands can be abused for denial of service.  Whether that's an issue
depends on your use case.

> convenient for sending commands via the WebSocket monitor using the
> web UI. This is planned to be done on micro:bit board.
>
> The list of allowed commands should be written to a file, one per line.
> The command line will look like this:
>     -mon chardev_name,mode=control,whitelist=path_to_file
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>

Please describe your intended use case in more detail, and provide at
least a rough security analysis that includes the denial of service
aspect.
