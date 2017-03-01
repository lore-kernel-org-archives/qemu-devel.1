Received: from eggs.gnu.org ([2001:4830:134:3::10]:58266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cj3PG-0001jc-90
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cj3PC-0002Ov-1x
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:30:58 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170301115026.22621-4-stefanha@redhat.com>
References: <20170301115026.22621-1-stefanha@redhat.com>
	<20170301115026.22621-4-stefanha@redhat.com>
Date: Wed, 01 Mar 2017 13:30:52 +0100
Message-ID: <w51r32hnpqb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 3/3] throttle: make
 throttle_config(throttle_get_config()) symmetric
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nini Gu <ngu@redhat.com>, qemu-block@nongnu.org

On Wed 01 Mar 2017 12:50:26 PM CET, Stefan Hajnoczi wrote:
> Throttling has a weird property that throttle_get_config() does not
> always return the same throttling settings that were given with
> throttle_config().  In other words, the set and get functions aren't
> symmetric.
>
> If .max is 0 then the throttling code assigns a default value of .avg /
> 10 in throttle_config().  This is an implementation detail of the
> throttling algorithm.  When throttle_get_config() is called the .max
> value returned should still be 0.
>
> Users are exposed to this quirk via "info block" or "query-block"
> monitor commands.  This has caused confusion because it looks like a bug
> when an unexpected value is reported.
>
> This patch hides the .max value adjustment in throttle_get_config() and
> updates test-throttle.c appropriately.
>
> Reported-by: Nini Gu <ngu@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
