Received: from eggs.gnu.org ([2001:4830:134:3::10]:45550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1etEKl-0000Yz-VD
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:17:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1etEKi-0003ce-K0
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:16:55 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180306151117.GH7139@localhost.localdomain>
References: <cover.1519921268.git.berto@igalia.com>
	<d58bbc353563bb9c83ffe90faaa36fadf683e332.1519921268.git.berto@igalia.com>
	<20180306145426.GG7139@localhost.localdomain>
	<w51vae9l041.fsf@maestria.local.igalia.com>
	<20180306151117.GH7139@localhost.localdomain>
Date: Tue, 06 Mar 2018 16:16:49 +0100
Message-ID: <w51sh9dkzdq.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/7] qcow2: Check L1 table parameters in
 qcow2_expand_zero_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue 06 Mar 2018 04:11:17 PM CET, Kevin Wolf wrote:
> I've finished the review now, the rest looks correct.
>
> The only other thing I wondered is about the cases where you pass a
> NULL errp because the callers don't get an Error parameter, so they
> can't pass it on. Some of these callers already use error_report(), so
> it would be okay to use error_report_err() for an error returned by
> qcow2_validate_table(), too. I think that would improve the messages.

Good idea, I'll change that and resend the series.

Berto
