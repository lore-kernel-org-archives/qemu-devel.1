Received: from eggs.gnu.org ([2001:4830:134:3::10]:58204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cj3P1-0001BN-IZ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cj3Ox-0002MY-LP
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:30:43 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170301115026.22621-3-stefanha@redhat.com>
References: <20170301115026.22621-1-stefanha@redhat.com>
	<20170301115026.22621-3-stefanha@redhat.com>
Date: Wed, 01 Mar 2017 13:29:58 +0100
Message-ID: <w51tw7dnprt.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/3] throttle: do not use invalid config
 in test
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

On Wed 01 Mar 2017 12:50:25 PM CET, Stefan Hajnoczi wrote:
> The (burst) max parameter cannot be smaller than the avg parameter.
> There is a test case that uses avg = 56, max = 1 and gets away with it
> because no input validation is performed by the test case.
>
> This patch switches to valid test input parameters.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
