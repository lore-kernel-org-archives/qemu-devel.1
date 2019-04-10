Received: from eggs.gnu.org ([209.51.188.92]:51542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE5xq-00075Q-ML
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE5xo-0001Ir-Iz
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:40:02 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190409210655.777-1-jsnow@redhat.com>
Date: Wed, 10 Apr 2019 07:39:50 +0200
In-Reply-To: <20190409210655.777-1-jsnow@redhat.com> (John Snow's message of
	"Tue, 9 Apr 2019 17:06:55 -0400")
Message-ID: <87y34i2zbt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemu-img: fix .hx and .texi disparity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

John Snow <jsnow@redhat.com> writes:

> It turns out that having options listed in three places continues to be
> a bad idea. I'm still toying with the idea of an improved infrastructure
> here, but in the meantime, another bandaid.
>
> There are three locations:
> (1) .hx file, formatted as texi
> (2) .hx file, formatted as human readable.
> (3) .texi file, as section headers, formatted as texi.
>
> You can compare the two summaries within the .hx file like so:
>
> Human-readable command summaries:
> `./qemu-img --help | grep 'Command syntax' -A14`
> Detokenized texi command summaries:
> `grep "@item" qemu-img-cmds.hx | sed -E 's|@var\{([^\}]*?)\}|\1|g'`
>
> You can compare the two separate texi summaries like so:
>
> Texi command summaries:
> `grep "@item" qemu-img-cmds.hx"`
> Texi command headers:
> grep -E "@item.*@var" qemu-img.texi | tail -14
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Extra points for explaining how you found the issues in detail
sufficient for reproducing.

Nice to have in 4.0.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
