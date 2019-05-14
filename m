Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A64C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A642084E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A642084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49196 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQYf0-0005va-SQ
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 10:44:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQYeJ-0005eK-CN
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQYeI-0002i8-2Y
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:43:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQYeH-0002di-Qp
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:43:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 369B8307EA93;
	Tue, 14 May 2019 14:43:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 28F5E619BC;
	Tue, 14 May 2019 14:43:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id BB44A11385E4; Tue, 14 May 2019 16:43:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
References: <20190514075602.7674-1-lvivier@redhat.com>
	<20190514075602.7674-2-lvivier@redhat.com>
Date: Tue, 14 May 2019 16:43:08 +0200
In-Reply-To: <20190514075602.7674-2-lvivier@redhat.com> (Laurent Vivier's
	message of "Tue, 14 May 2019 09:56:00 +0200")
Message-ID: <87k1etdrlv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 14 May 2019 14:43:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 1/3] VirtIO-RNG: Update default entropy
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
	S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, "Richard W
	. M . Jones" <rjones@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <lvivier@redhat.com> writes:

> From: Kashyap Chamarthy <kchamart@redhat.com>
>
> When QEMU exposes a VirtIO-RNG device to the guest, that device needs a
> source of entropy, and that source needs to be "non-blocking", like
> `/dev/urandom`.  However, currently QEMU defaults to the problematic
> `/dev/random`, which on linux is "blocking" (as in, it waits until
> sufficient entropy is available).
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
> What about other OSes?
> ----------------------
>
> `/dev/urandom` exists and works on OS-X, FreeBSD, DragonFlyBSD, NetBSD
> and OpenBSD, which cover all the non-Linux platforms we explicitly
> support, aside from Windows.
>
> On Windows `/dev/random` doesn't work either so we don't regress.
> This is actually another argument in favour of using the newly
> proposed 'rng-builtin' backend by default, as that will work on
> Windows.
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

Reviewed-by: Markus Armbruster <armbru@redhat.com>

