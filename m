Received: from eggs.gnu.org ([2001:4830:134:3::10]:57755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTjr6-0004lp-RJ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTjr2-0001X4-OY
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:13:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43792 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fTjr2-0001Wp-JE
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:13:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180615014249.22730-1-peterx@redhat.com>
	<20180615014249.22730-4-peterx@redhat.com>
Date: Fri, 15 Jun 2018 10:13:07 +0200
In-Reply-To: <20180615014249.22730-4-peterx@redhat.com> (Peter Xu's message of
	"Fri, 15 Jun 2018 09:42:46 +0800")
Message-ID: <87tvq4bh7w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 3/6] tests: iotests: drop some stderr
 line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Auger <eric.auger@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Dr
	. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> In my Out-Of-Band test, "check -qcow2 060" fail with this:
>
> 060 5s ... - output mismatch (see 060.out.bad)
> --- /home/peterx/git/qemu/tests/qemu-iotests/060.out    2018-06-15 08:31:14.607411950 +0800
> +++ /home/peterx/git/qemu/bin/tests/qemu-iotests/060.out.bad    2018-06-15 08:33:09.679880113 +0800
> @@ -427,8 +427,8 @@
>  QMP_VERSION
>  {"return": {}}
>  qcow2: Image is corrupt: L2 table offset 0x2a2a2a00 unaligned (L1 index: 0); further non-fatal corruption events will be suppressed
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "", "msg": "L2 table offset 0x2a2a2a0
> 0 unaligned (L1 index: 0)", "node-name": "drive", "fatal": false}}
>  read failed: Input/output error
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "", "msg": "L2 table offset 0x2a2a2a0
> 0 unaligned (L1 index: 0)", "node-name": "drive", "fatal": false}}
>  {"return": ""}
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
> Failures: 060
> Failed 1 of 1 tests

Please indent this diff; git-am chokes on it for me.

> The order of the event and the in/out error line is swapped.  I didn't
> dig up the reason, but AFAIU what we want to verify is the event rather
> than stderr.  Let's drop the stderr line directly for this test.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Lose one S-o-b, please :)
