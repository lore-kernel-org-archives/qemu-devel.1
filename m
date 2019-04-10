Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A76BC10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 16:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D62C20818
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 16:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D62C20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34678 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEGSa-0004OH-LW
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 12:52:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hEGRg-00044A-BU
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hEGRf-0005Og-4G
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:51:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1hEGRe-0005LN-Mm
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:51:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so3397622wmf.1
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 09:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version;
	bh=KbEmWh0MR9TTw5GELpI9kZb3ZVGmDMLhegkX2iQWjNE=;
	b=YuBhuSM0GYzYqhdw9XU52ykqzUCfuYJgk5v2ASGmhsj81iP0szoH6FzNrJb3fArGFy
	1KAINRLslCqyQ9QuSDrt4CcYG3VFdXFwsSGyfNLxZvJ6woYhRE3YGyXyut+meMxtyoVf
	hQCFmhsBNzCNxPUuTNwRW5NgFUQ4tQClsBqGriSe93lSQXHErAh5ttPST7uDCvd9MDb5
	xChj5t5QFs5BG9DXjDxPQ+EYbWNdP+8krjjpw+F+OrWMfCn199tZ5ZU6G3M+zmRhnmFm
	DQ8kCwvTLCxZO6L6s24AbXMDQV6wxenWRvvvl/hq/JGfTSTp5qNB0Olo0GuYNVjjrOIF
	gKLQ==
X-Gm-Message-State: APjAAAVfC9p6rSGakqLkOUFYzrAAe+byzHS4u2c5XmDYtWXyFK6OiqcS
	4oz1O1KWQ9fDIaXh7UObbbpAKQ==
X-Google-Smtp-Source: APXvYqw7A2tKJpfDsu3SyvHHk5eZQYUHxjrW8A7lNRJ5cUIGh2Ex5Wpa98lA4DsGAiqndGDaIzfrsw==
X-Received: by 2002:a1c:9d4c:: with SMTP id g73mr3498692wme.48.1554915088931; 
	Wed, 10 Apr 2019 09:51:28 -0700 (PDT)
Received: from dritchie.redhat.com (226.red-88-11-92.dynamicip.rima-tde.net.
	[88.11.92.226])
	by smtp.gmail.com with ESMTPSA id z17sm4118165wmc.7.2019.04.10.09.51.27
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 10 Apr 2019 09:51:27 -0700 (PDT)
References: <20190402121908.44081-1-slp@redhat.com>
	<20190409112608.GD16944@stefanha-x1.localdomain>
User-agent: mu4e 1.0; emacs 26.1
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
In-reply-to: <20190409112608.GD16944@stefanha-x1.localdomain>
Date: Wed, 10 Apr 2019 18:51:16 +0200
Message-ID: <87bm1diz23.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH] aio: Add a knob to always
 poll if there are in-flight requests
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
	pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410165116.W3NRRAiUmv63pGhkWpUN1-Ud7b9MyVu3Lil5iZ0dnZM@z>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Tue, Apr 02, 2019 at 02:19:08PM +0200, Sergio Lopez wrote:
>> The polling mode in aio_poll is able to trim down ~20us on the average
>> request latency, but it needs manual fine tuning to adjust it to the
>> characteristics of the storage.
>>=20
>> Here we add a new knob to the IOThread object, "poll-inflight". When
>> this knob is enabled, aio_poll will always use polling if there are
>> in-flight requests, ignoring the rest of poll-* parameters. If there
>> aren't any in-flight requests, the usual polling rules apply, which is
>> useful given that the default poll-max-ns value of 32us is usually
>> enough to catch a new request in the VQ when the Guest is putting
>> pressure on us.
>>=20
>> To keep track of the number of in-flight requests, AioContext has a
>> new counter which is increased/decreased by thread-pool.c and
>> linux-aio.c on request submission/completion.
>>=20
>> With poll-inflight, users willing to spend more Host CPU resources in
>> exchange for a lower latency just need to enable a single knob.
>>=20
>> This is just an initial version of this feature and I'm just sharing
>> it to get some early feedback. As such, managing this property through
>> QAPI is not yet implemented.
>>=20
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  block/linux-aio.c         |  7 +++++++
>>  include/block/aio.h       |  9 ++++++++-
>>  include/sysemu/iothread.h |  1 +
>>  iothread.c                | 33 +++++++++++++++++++++++++++++++++
>>  util/aio-posix.c          | 32 +++++++++++++++++++++++++++++++-
>>  util/thread-pool.c        |  3 +++
>>  6 files changed, 83 insertions(+), 2 deletions(-)
>
> Hi Sergio,
> More polling modes are useful for benchmarking and performance analysis.
> From this perspective I think poll-inflight is worthwhile.
>
> Like most performance optimizations, the effectiveness of this new
> polling mode depends on the workload.  It could waste CPU, especially on
> a queue depth 1 workload with a slow disk.
>
> Do you think better self-tuning is possible?  Then users don't need to
> set tunables like this one.

Probably only if we aim for some more complex, which will have its own
inherent costs. We could take inspiration from Linux's io_poll hybrid
mode, which maintains per-device statistics to calculate the average
latency, to take a nap for half that time and free the CPU a bit.

Of course, our case is significantly harder. The kernel only deals with
the HW, and only a few devices do have support for io_poll. In our case,
the IOThread may be shared among various devices with radically
different backends, which may also have a wide range of latencies
(depending on the underlying storage, file format, cache mode...). But
perhaps we can try to be clever and calculate the standard deviation
of the collected data to (in)validate the stats.

There are also some implementation challenges, as deciding where to
store those stats and designing an interface for aio_poll to access
that information, preferably in a lockless fashion.

If we can figure those out, we should be able to iterate over all the
BDSs sharing the AioContext, using the average latency (if valid),
combined with a timestamp from when the first in-flight request was
issued, to calculate a deadline and, with it, decide if we should either
take a nap using ppoll() with a timeout calculated to be wake up early
enough to catch the completion while polling, or just enter polling mode
for a while.

Perhaps it'd be worth doing a simple PoC outside QEMU, using the
vhost-user-blk example server to avoid the block layer complexity and
evaluate the raw benefits with different kinds of backends and
workloads.

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAlyuHwQACgkQ9GknjS8M
AjUcchAAodC9gAeXWlIuRIFKDTNhGo4xhmNkI0vIQ9I84mCMwypdDds6wen/SIQj
AXjFqxYhNBbCRFvaNCTgb6OPtHDJsyrXclm+aOqrB+iECCrOjyiDS+kpN3hxa0Oq
Z1jIfa1v0ZbJ8AOqo+10SkGa225Qh7ym0MqNtkwwv6apBwsv2Fk0/16dlSuxP2Qy
zdbFau0/XeelHwgbz/rs22cFJE2lZgwyvpRKJp+mgbxaSZBLbgmlpLa3SdHEQoOI
LfEgBfKGBgPOqfJ4Je4cyv28PosueI/i6+4TMw0IXK0eA7WiSz3UW6o+L8oIAhtr
to4e3Odi7b4EOX80F+9XYDrIm3EC4GJ/9vchFo+j7W6rXhgy5yvFPzRVfuFp3XfV
zf/gEnT49fj6h9LkhOe83yaZeGn6Mo0YXTB1Y/MVRJq5Dm4kTKjMREFVJyRj7e5k
crjXL+YJXkoJ2m2Z3gQLhQruowRoc3bqanDglzGIazfpk4K3iN4A3oJ5BiAEYnrj
2nH6jQRZJXReQ5YXoJJrtTzv+VpEdAkD1ffJgqB5qLI/Z2wuc7pwe8VYdc/opigu
Q8lhvCwJcUixTc3pyiUNTX8c4/wrbvNqdFzfC/30rwMiyz8TnwfwNt8RSWqNfmcn
9mHTm/QKSga2wK89CsvwPd1/LDkG6CgeERKa9ymMi6CTMMrtOWU=
=ABGc
-----END PGP SIGNATURE-----
--=-=-=--

