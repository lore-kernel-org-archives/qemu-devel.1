Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325C8C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F082133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F082133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47152 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEY6S-00030k-99
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 07:42:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hEY5X-0002eW-68
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hEY5V-0001b8-59
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:41:51 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:34250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1hEY5S-0001aM-Q3
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:41:48 -0400
Received: by mail-wr1-f47.google.com with SMTP id p10so6937870wrq.1
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 04:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version;
	bh=2R7DMuyi6xYq2nswOZLbgokHaN1sZ+FwNvtx+iJQMAc=;
	b=RMykoP4WBGp3NSU3DuhKXXSzL61X+TqBNVLH5dhH+7pyipdtSDu+vBeKsnU67tfdqd
	jS0mv/M+0gJEYnHULt+4CPfUOrQwXuoUwEbALCpDyttVGAZLYi+0K6NO3gdMLk/wJS8+
	+46CbZbP6HxMth2REJ8fWvaBX9D9wc5aQ6HdW+TBdtQTjqlyb/Frpm+Ro3oEpsZhgbvh
	7qOR6Ryp3s7Evzg0REtgMGcPStP6H1yZVeAnJXGxajt0ix254dY6AURK936oiuHq1+s0
	YZzmckxWs/jYNIA8M3BOJTq1akts3uv6E98HcxiYEp1FBVUWuyjVPB5WiL9poZG+sZnk
	Cm0g==
X-Gm-Message-State: APjAAAV6F9wiX+HJE+ATc8OoT+1hcjQgnulPykiNiXLG4iHlTe/oH97s
	UNd89ydllX3Vz/+Jl+EE0SU8zA==
X-Google-Smtp-Source: APXvYqyT7Mn164DMWBRaBwdbmoH8mYvZgwAtoTW3oqP4LU5z0vxl6FHdZ1s5bUeO/D+KoxkFOW6h6g==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr29920819wrq.48.1554982905593; 
	Thu, 11 Apr 2019 04:41:45 -0700 (PDT)
Received: from dritchie.redhat.com (255.red-83-57-210.dynamicip.rima-tde.net.
	[83.57.210.255])
	by smtp.gmail.com with ESMTPSA id t76sm7586043wmt.8.2019.04.11.04.41.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 11 Apr 2019 04:41:44 -0700 (PDT)
References: <87zhpxmkg9.fsf@redhat.com>
	<20190315150036.GA11173@stefanha-x1.localdomain>
	<87a7hwm9t4.fsf@redhat.com> <20190315155010.GG5368@linux.fritz.box>
User-agent: mu4e 1.0; emacs 26.1
From: Sergio Lopez <slp@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
In-reply-to: <20190315155010.GG5368@linux.fritz.box>
Date: Thu, 11 Apr 2019 13:41:42 +0200
Message-ID: <87pnps3h1l.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.47
Subject: Re: [Qemu-devel] Combining synchronous and asynchronous IO
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
Cc: "fam@euphon.net" <fam@euphon.net>, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, "mreitz@redhat.com" <mreitz@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, jusual@mail.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411114142.v9q--JYCje46rIKoCHe1_AR4jLuFTSfRtGV8_OHGrLU@z>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Kevin Wolf <kwolf@redhat.com> writes:

> Am 15.03.2019 um 16:33 hat Sergio Lopez geschrieben:
>>=20
>> Stefan Hajnoczi writes:
>>=20
>> > On Thu, Mar 14, 2019 at 06:31:34PM +0100, Sergio Lopez wrote:
>> >> Our current AIO path does a great job at unloading the work from the =
VM,
>> >> and combined with IOThreads provides a good performance in most
>> >> scenarios. But it also comes with its costs, in both a longer executi=
on
>> >> path and the need of the intervention of the scheduler at various
>> >> points.
>> >>=20
>> >> There's one particular workload that suffers from this cost, and that=
's
>> >> when you have just 1 or 2 cores on the Guest issuing synchronous
>> >> requests. This happens to be a pretty common workload for some DBs an=
d,
>> >> in a general sense, on small VMs.
>> >>=20
>> >> I did a quick'n'dirty implementation on top of virtio-blk to get some
>> >> numbers. This comes from a VM with 4 CPUs running on an idle server,
>> >> with a secondary virtio-blk disk backed by a null_blk device with a
>> >> simulated latency of 30us.
>> >
>> > Can you describe the implementation in more detail?  Does "synchronous"
>> > mean that hw/block/virtio_blk.c makes a blocking preadv()/pwritev() ca=
ll
>> > instead of calling blk_aio_preadv/pwritev()?  If so, then you are also
>> > bypassing the QEMU block layer (coroutines, request tracking, etc) and
>> > that might explain some of the latency.
>>=20
>> The first implementation, the one I've used for getting these numbers,
>> it's just preadv/pwrite from virtio_blk.c, as you correctly guessed. I
>> know it's unfair, but I wanted to take a look at the best possible
>> scenario, and then measure the cost of the other layers.
>>=20
>> I'm working now on writing non-coroutine counterparts for
>> blk_co_[preadv|pwrite], so we have SIO without bypassing the block layer.
>
> Maybe try to keep the change local to file-posix.c? I think you would
> only have to modify raw_thread_pool_submit() so that it doesn't go
> through the thread pool, but just calls func directly.
>
> I don't think avoiding coroutines is possible without bypassing the block
> layer altogether because everything is really expecting to be run in
> coroutine context.

Turns out what I initially thought was a cost induced by the AIO nature
of our block layer, it's actually a bug in which polling mode works
against aio=3Dthreads, delaying the execution of the request completions.

This has been fixed by Paolo's "aio-posix: ensure poll mode is left when
aio_notify is called":

https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01426.html

So we can throw away the idea of combining synchronous and asynchronous
requests, as it doesn't provide a significant improvement that would
justify the added complexity.

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAlyvJ/YACgkQ9GknjS8M
AjV7LA//aqoMbyfpVzzOJsXo8BOj7Z2L/xjyY23HNLcc/5uHKHr0k/vMiGWix5HA
7yGXo8GEzmdlUzw0zggDPNXBRJVMhcift70lws4OAzcN32VGCjzvWJT/Dguicdkw
eOad12domVPpEREvJK6ffO1CAToVOWaOPcTJ22tHoKD7ASeeh+GA90ev7xVNhBRK
6nAU8BPNN9nIawKCoQi7cRjbK13qERskmQ3jD/8L0u4o0YW/2XX9ZlzxcfVvB3NR
+T0A6LGIFlQyXMBTzhY+jo9rsmiIQfyjP90QpXfk3YXxyecH86sQEXwJeO/lX7Ip
O8s8NeKkcaDf9OgMntA3vkEaQ48+fypjvmUU5iQvuFecQlMIvLUk4UbmyYsf/qfm
kLg1/1ZNa2t/lWBRNwb6H/9xHpnEHBXP12FdZNA7yzGZqqGldJJo34KJFbyVp8sc
QKBb6nPg3/JzjmXQFMSCq/FsnFuTT8KohZkKVf3SB0IsMoYsiCYn3G8+UZjy4gdw
JdZ/vA1f1nPBDXmGa7JHNvcEC+UfI7z/Eny37IuF1nyE4D+hAx6a2DivdIdEcY+k
4UWY4VFJdGo2Ms2KoXbXfB8RqDAmV81NGR1tIjHIA2jc6iOBU3+MT8X6cVUvYzTh
UoiLeN856WP3gxZlVZQN+Id26J1PZfRnV7A+4nVa7wXqFnWv8t0=
=1cZj
-----END PGP SIGNATURE-----
--=-=-=--

