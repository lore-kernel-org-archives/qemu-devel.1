Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B25C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106C7206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIBaYT+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106C7206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYqG-0001mi-Hm
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 07:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVYpG-0001Gy-QB
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:59:54 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVYpG-0003MD-0G
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:59:54 -0400
Received: by mail-wr1-x443.google.com with SMTP id h9so10037900wrt.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 03:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=84ZoJE/YWj0l6AWnNr5LOw8xlYv2MhJkngn4w6DJ8Sk=;
 b=fIBaYT+7niZCgh6XmjglexezurwPJYNXWfUBZCNtXf/gssxny7H3+U5IxfieRgFKta
 0lpBPtct0szf+PDuIHhC0oMA603M35iVdSP5CvEl4JW1hHrFUS9l0q03KUdOgHGErmL9
 MB2tSm6rzODBKfA6jZoyxJC8L2yom13iDR1w/NNNfC1Ux4Q0CIVqYpZanZHFvqOZ6w7X
 X61R3wn9E4+zNzEo4ZbSBDc0+iltcOTH9iQpXjA8hnsz9BC/O26t3wMHL63ZGWG9qXuf
 2M1UVzrfIowxarKwoCPLhy06JoeYCBFaTDFQhMhVRDG0mbWkJqmZG+Uq5RX+EvagUasv
 +SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=84ZoJE/YWj0l6AWnNr5LOw8xlYv2MhJkngn4w6DJ8Sk=;
 b=Dp1jOyz9hzDAlnv3zSlHyjbV+B70N/GIaDNdbYG4xHP3mdLsiApuSGx+Gz9txwLA49
 xjRLAhjdnyur2yD0mtAYYZM5F++0dS2NaNaBn8hLvHBmMAYgTDGfA9vINTRjudw2KDD6
 qk1Y7iU9ZF/5oxpxhgaDg+ksPOXDMQ3RqO8WOjvahu5wzd6QwHeg3JyQakUY108bQgr+
 OueOHRt3sxvOubvHJddX5EMjvMGw2aCLgy6Zu4I/ysTjngS/Pk3Gxo0kKzpeLUPBKG5H
 F6BIN9L/b3wM9BOKpNuBW5MqfKqOzKmkH5VlDHkGENcoo7zQCI7bxZhGtvGF8I6GHcsB
 aEMg==
X-Gm-Message-State: AGi0PuaMchvookfb46iASyMV7uqEzuS/k3jCWbYLZZGHJSKd3x06Yk/4
 LOyMGNnmprc7+98lKppRXdo=
X-Google-Smtp-Source: APiQypIf1+THPs8jIVheeZINHsv2kdlRcOhF77WjuhdU0jgsopoGD+DcJb9NglnB+xTQXF04R7uNKQ==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr16959849wrq.211.1588589992315; 
 Mon, 04 May 2020 03:59:52 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id q18sm12311525wmj.11.2020.05.04.03.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 03:59:51 -0700 (PDT)
Date: Mon, 4 May 2020 11:59:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 0/4] RFC/WIP: Fix scsi devices plug/unplug races w.r.t
 virtio-scsi iothread
Message-ID: <20200504105949.GD354891@stefanha-x1.localdomain>
References: <20200416203624.32366-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
In-Reply-To: <20200416203624.32366-1-mlevitsk@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2020 at 11:36:20PM +0300, Maxim Levitsky wrote:
> Hi!
>=20
> This is a patch series that is a result of my discussion with Paulo on
> how to correctly fix the root cause of the BZ #1812399.
>=20
> The root cause of this bug is the fact that IO thread is running mostly
> unlocked versus main thread on which device hotplug is done.
>=20
> qdev_device_add first creates the device object, then places it on the bu=
s,
> and only then realizes it.
>=20
> However some drivers and currently only virtio-scsi enumerate its child b=
us
> devices on each request that is received from the guest and that can happ=
en on the IO
> thread.
>=20
> Thus we have a window when new device is on the bus but not realized and =
can be accessed
> by the virtio-scsi driver in that state.
>=20
> Fix that by doing two things:
>=20
> 1. Add partial RCU protection to the list of a bus's child devices.
> This allows the scsi IO thread to safely enumerate the child devices
> while it races with the hotplug placing the device on the bus.
>=20
> 2. Make the virtio-scsi driver check .realized property of the scsi device
> and avoid touching the device if it isn't
>=20
> I don't think that this is very pretty way to solve this, we discussed th=
is
> with Paulo and it kind of looks like the lesser evil. I am open to your t=
houghts about this.
>=20
> Note that this patch series doesn't pass some unit tests and in particula=
r qtest 'drive_del-test'
> I did some light debug of this test and I see that the reason for this is=
 that now child device deletion
> can be delayed due to RCU. This is also something I would like to discuss=
 in this RFC.
>=20
> Note also that I might have some code style errors and bugs in this since=
 I haven't
> tested the code in depth yet, because I am not yet sure that this is the =
right way
> to fix that bug
>=20
> Also note that in the particular bug report the issue wasn't a race but r=
ather due
> to combination of things, the .realize code in the middle managed to trig=
ger IO on the virtqueue
> which caused the virtio-scsi driver to access the half realized device. H=
owever
> since this can happen as well with real IO thread, this patch series was =
done,
> which fixes this as well.

Nice approach! Thanks for solving this at the hw/core/bus.c level so
that other devices can benefit too.

Regarding drive_del, I guess the issue here is that this HMP command's
semantics need to include not synchronize_rcu() but some kind of
drain_call_rcu() operation as well that ensures deletion has completed?

This also suggests that all code that removes bus children needs to be
audited since the actual object unref is now deferred to a later point
in time. There could be other cases besides drive_del that don't yet
handle this.

drain_call_rcu() can be implemented by invoking call_rcu(temp,
drain_call_rcu_cb, rcu) where drain_call_rcu_cb() sets a QemuEvent that
the caller is waiting on. This way the caller can be sure that all
previously queued call_rcu() callbacks have completed. call_rcu_thread()
needs to be tweaked to avoid g_usleep() and instead use a timed wait so
that drain_call_rcu() can immediately wake up the thread.

Stefan

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6v9aUACgkQnKSrs4Gr
c8gK/wf9EwbNqBEZ+aB0Fw1QjL629iitBB76CHoj2gYK29vhVeELpEcmq4kuWms0
3sF7OEET+FYSIrenvqFTz9CE5n88o49fpRI86l5UD8mTJ/Zk8xzuH3hi2D+HRuV2
p+xKnwb+DsAA60RptX7zDbNcOB6orDHFONM/U9R5PAHvZdZf3SHrzdEi42YhGR9z
TLIeQDYLKnTVUBNTGv5r9KHq+gBvRrt7RhywVS2Ci0HWMEBWzP8zohELJvfn6cym
zf2lbeLmF0pwUhamEHa5RUDICPX3sHzfM1K1lSvuOdw0jH1Thb6iFAgPTHdaEHpa
kjXzpjpaBuC48hXPSJdA9Q2uM7ydvw==
=SBhr
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--

