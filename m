Received: from eggs.gnu.org ([2001:4830:134:3::10]:48642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1dkcli-0002XF-5B
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 17:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1dkclh-0005lA-7T
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 17:00:54 -0400
Received: from mail-yw0-x231.google.com ([2607:f8b0:4002:c05::231]:34844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1dkclh-0005l2-0t
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 17:00:53 -0400
Received: by mail-yw0-x231.google.com with SMTP id s187so7951530ywf.2
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 14:00:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170823163349.11663-1-eblake@redhat.com>
References: <20170823163349.11663-1-eblake@redhat.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Wed, 23 Aug 2017 23:00:21 +0200
Message-ID: <CAATJJ0KjTRiZWTMJ_oi+UkDYz_EVmkwNgf+kLgJ2sLBUueCj3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] NBD pull request for 2.10-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, Aug 23, 2017 at 6:33 PM, Eric Blake <eblake@redhat.com> wrote:
[...]
>
> ----------------------------------------------------------------
> nbd patches for 2017-08-23
>
> - Fam Zheng: 0/4 block: Fix non-shared storage migration
> - Stefan Hajnoczi: qemu-iotests: add 194 non-shared storage migration test
> - Stefan Hajnoczi: nbd-client: avoid spurious qio_channel_yield() re-entry
>
> ----------------------------------------------------------------
> Fam Zheng (3):
>       block-backend: Refactor inactivate check
>       block-backend: Allow more "can inactivate" cases
>       mirror: Mark target BB as "force allow inactivate"
>
> Stefan Hajnoczi (3):
>       block: Update open_flags after ->inactivate() callback
>       qemu-iotests: add 194 non-shared storage migration test
>       nbd-client: avoid spurious qio_channel_yield() re-entry
>

... no need for tested-by after being applied already, but I wanted to
thank Fam, Stefan, David and everybody else involved.
With all six on top of rc3 the copy-storage migrations are working on 2.10
now - thanks!
