Received: from eggs.gnu.org ([2001:4830:134:3::10]:36037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVDiL-0008TL-60
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVDiI-0007as-1h
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:13:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dVDiH-0007ai-ST
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:13:41 -0400
Date: Wed, 12 Jul 2017 10:13:35 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170712091335.GC5237@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170711124411.10499-1-berrange@redhat.com>
	<149978289196.30.5533219451464874880@5d477a5b5989>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <149978289196.30.5533219451464874880@5d477a5b5989>
Subject: Re: [Qemu-devel] [PULL v1 0/5] Merge sockets 2017/07/11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org

On Tue, Jul 11, 2017 at 07:21:32AM -0700, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
> 
> Message-id: 20170711124411.10499-1-berrange@redhat.com
> Type: series
> Subject: [Qemu-devel] [PULL v1 0/5] Merge sockets 2017/07/11
> 

[snip]

>   GTESTER check-qtest-x86_64
>   GTESTER check-qtest-aarch64

[snip]

> **
> ERROR:/tmp/qemu-test/src/tests/test-sockets-proto.c:849:test_listen: assertion failed: (data->ipv4 == 0)

The problem here is that we're running qtests for x86_64 and
aarch64 in parallel, and both are trying to bind to the same
IPv4/IPv6 ports and so one fails.

Peter please avoid applying this PULL request until I figure
out a solution for that race.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
