Received: from eggs.gnu.org ([2001:4830:134:3::10]:41256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eD69U-0002kL-Ek
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 05:03:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eD69T-0000Jw-Cu
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 05:03:08 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171109203025.27493-5-mreitz@redhat.com>
References: <20171109203025.27493-1-mreitz@redhat.com>
	<20171109203025.27493-5-mreitz@redhat.com>
Date: Fri, 10 Nov 2017 11:02:57 +0100
Message-ID: <w51375mv4by.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 4/5] iotests: Make 083 less
 flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Thu 09 Nov 2017 09:30:24 PM CET, Max Reitz wrote:
> +        echo > "$TEST_DIR/nbd-fault-injector.out"
>  	$PYTHON nbd-fault-injector.py $extra_args "$nbd_addr" "$TEST_DIR/nbd-fault-injector.conf" >"$TEST_DIR/nbd-fault-injector.out" 2>&1 &

It seems that in this patch you're indenting with spaces but this file
uses tabs.

Berto
