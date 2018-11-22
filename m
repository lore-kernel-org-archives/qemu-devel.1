Received: from eggs.gnu.org ([2001:4830:134:3::10]:53924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gPvFZ-0005lq-3Y
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 15:06:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gPvFU-0006uU-9y
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 15:06:57 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181122175200.GG31879@linux.fritz.box>
References: <cover.1541002357.git.berto@igalia.com>
	<20181122175200.GG31879@linux.fritz.box>
Date: Thu, 22 Nov 2018 21:06:47 +0100
Message-ID: <w51o9ag6fmw.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/2] Update the inherits_from pointer after
 stream and commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 22 Nov 2018 06:52:00 PM CET, Kevin Wolf <kwolf@redhat.com> wrote:
> Not a problem with the series, but I tried to run the test case without
> the fix, and this is what I got:
>
> -{"return": ""}
> +{"return": "Cannot change the option 'backing.detect-zeroes'rn"}
>
> Where does that final "rn" come from? Looks like we have a bug
> somewhere in the error reporting code?

It looks like a \r\n that hasn't been properly interpreted as CRLF.

Berto
