Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352BEC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C4C20896
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C4C20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46359 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8Px-0001fi-7n
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:30:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hP8Ef-000638-3M
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hP8Ed-0002sF-UO
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:19:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hP8Ed-0002rj-Md
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:18:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA0E8306034D;
	Fri, 10 May 2019 16:18:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 229C31779C;
	Fri, 10 May 2019 16:18:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 9BA4F11385E4; Fri, 10 May 2019 18:18:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
References: <20190510134203.24012-1-lvivier@redhat.com>
	<20190510134203.24012-2-lvivier@redhat.com>
Date: Fri, 10 May 2019 18:18:52 +0200
In-Reply-To: <20190510134203.24012-2-lvivier@redhat.com> (Laurent Vivier's
	message of "Fri, 10 May 2019 15:42:01 +0200")
Message-ID: <877eayjn9v.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 10 May 2019 16:18:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/3] VirtIO-RNG: Update default entropy
 source to `/dev/urandom`
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Daniel P . =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>,
	Markus Armbruster <armbru@redhat.com>,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <lvivier@redhat.com> writes:

> From: Kashyap Chamarthy <kchamart@redhat.com>
>
> When QEMU exposes a VirtIO-RNG device to the guest, that device needs a
> source of entropy, and that source needs to be "non-blocking", like
> `/dev/urandom`.  However, currently QEMU defaults to the problematic
> `/dev/random`, which is "blocking" (as in, it waits until sufficient
> entropy is available).
>
> Why prefer `/dev/urandom` over `/dev/random`?
> ---------------------------------------------
>
> The man pages of urandom(4) and random(4) state:
>
>     "The /dev/random device is a legacy interface which dates back to a
>     time where the cryptographic primitives used in the implementation
>     of /dev/urandom were not widely trusted.  It will return random
>     bytes only within the estimated number of bits of fresh noise in the
>     entropy pool, blocking if necessary.  /dev/random is suitable for
>     applications that need high quality randomness, and can afford
>     indeterminate delays."
>
> Further, the "Usage" section of the said man pages state:
>
>     "The /dev/random interface is considered a legacy interface, and
>     /dev/urandom is preferred and sufficient in all use cases, with the
>     exception of applications which require randomness during early boot
>     time; for these applications, getrandom(2) must be used instead,
>     because it will block until the entropy pool is initialized.
>
>     "If a seed file is saved across reboots as recommended below (all
>     major Linux distributions have done this since 2000 at least), the
>     output is cryptographically secure against attackers without local
>     root access as soon as it is reloaded in the boot sequence, and
>     perfectly adequate for network encryption session keys.  Since reads
>     from /dev/random may block, users will usually want to open it in
>     nonblocking mode (or perform a read with timeout), and provide some
>     sort of user notification if the desired entropy is not immediately
>     available."
>
> And refer to random(7) for a comparison of `/dev/random` and
> `/dev/urandom`.
>
>     - - -
>
> Given the above, change the entropy source for VirtIO-RNG device to
> `/dev/urandom`.
>
> Related discussion in these[1][2] past threads.
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08335.html
>     -- "RNG: Any reason QEMU doesn't default to `/dev/urandom`?"
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02724.html
>     -- "[RFC] Virtio RNG: Consider changing the default entropy source to
>        /dev/urandom"
>
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Suggest to work Daniel's analysis into the commit message, like this:

  When QEMU exposes a VirtIO-RNG device to the guest, that device needs a
  source of entropy, and that source needs to be "non-blocking", like
  `/dev/urandom`.  However, currently QEMU defaults to the problematic
  `/dev/random`, which on Linux is "blocking" (as in, it waits until
  sufficient entropy is available).

  Why prefer `/dev/urandom` over `/dev/random` on Linux?
  ------------------------------------------------------
  [...]

  What about other OSes?
  ----------------------

  /dev/urandom exists and works on OS-X, FreeBSD, DragonFlyBSD, NetBSD
  and OpenBSD, which covers all the non-Linux platforms we explicitly
  support, aside from Windows.

  On Windows /dev/random doesn't work either so we don't regress. This
  is actually another argument in favour of using the newly proposed
  rng-builtin backend by default, as that will work on Windows.

      - - -

  Given the above, change the entropy source for VirtIO-RNG device to
  `/dev/urandom`.
  [...]

