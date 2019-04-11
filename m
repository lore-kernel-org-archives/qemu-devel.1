Received: from eggs.gnu.org ([209.51.188.92]:36080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEZGw-0002ua-8k
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEZ4G-0000qI-6O
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:44:36 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190410162918.9343-1-mreitz@redhat.com>
References: <20190410162918.9343-1-mreitz@redhat.com>
Date: Thu, 11 Apr 2019 14:44:30 +0200
Message-ID: <w518swgvhht.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] iotests: Let 245 pass on tmpfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Wed 10 Apr 2019 06:29:18 PM CEST, Max Reitz wrote:
>      # Reopen an image several times changing some of its options
>      def test_reopen(self):
> +        # Check whether the filesystem supports O_DIRECT
> +        if 'O_DIRECT' in qemu_io('-f', 'raw', '-t', 'none', '-c', 'quit', hd_path[0]):
> +            supports_direct = False
> +        else:
> +            supports_direct = True

I don't see any other test needing this at the moment (at least none
written in Python), but I wonder if this is something worth having in
iotests.py.

The patch looks fine anyway.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
