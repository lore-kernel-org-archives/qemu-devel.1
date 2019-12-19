Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41554C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4EA222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWnYodxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4EA222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihuPz-0000Hq-3N
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ihuPI-0008Ic-LO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ihuPG-0005ce-WE
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:55:52 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ihuPG-0005W7-Nk
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:55:50 -0500
Received: by mail-wm1-x342.google.com with SMTP id p9so5151341wmc.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 03:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6VKHYPvpRWsLMgCXnnJp4BSZ2RXylJ4J9ObKVirO2NI=;
 b=CWnYodxvRu/jayrpifxnvp+Gkwlm1HL0QzkEc32r0rK3lBx6k9aCMaJzYqlFdGieCX
 yWVVPG0Xtk+gzWbFK1nK2aZjWZNcI3ytCkyCgyeAvGNttgOMshJs4WhS6Qv9KPKvkGty
 K76ZCjST6hiy8fQJiy9GnkAexfgie06GFmNrUnKiTV6QSmyFhl1LmI8zMOufeCLx08Md
 xEHzjRsFSk2EaYHIAQ/cbQWQ+ldxGiood9VMLr1nrq0BbcSsHzTbiVSIWVXCsqdupvRS
 dEGpvuRgYgfd2/TiST9eMJWrzRbkvWEiVUZ+JI/CaMmV6HQ7jc6AuWUmkSqqqehir7Zs
 uGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6VKHYPvpRWsLMgCXnnJp4BSZ2RXylJ4J9ObKVirO2NI=;
 b=S8uqCJezguvAS8N5I2BxI5TAGtpkat4Ye1MWcHE0j9H+8nv2NhJq1GXZ42zSwzJNMU
 BVJHSeuTvGCdPRu03sw759PUrnqSRBvkWaviCt/Ekx6CLoKV083qC2Ft1vWEX4M8UbVJ
 U/yZfUvrRjX/aH3a09t08KeE+Csdj0tnCn/DK3v77lk3YK0jU+F6WZI0CA1knfr/zFra
 j7+HgRckRqjAp9nZftkeaIm1/Yk0tu+bJXQSwr/Tcs5Rlo1Cwbeg/zilCT1Cd8mcQdzq
 Cm4pdc8jWTxXsDiOP1FLzIVNfVkO6HpZdRyvFc8Mukg7igVkH08R9zvD1qOHBGu8+7UW
 D3TQ==
X-Gm-Message-State: APjAAAWA5AksPClLnkp8DLa+X/S2HV/DEiqFGuzzD6OpJMzVJcqkeWKy
 lufV4WLlUrsor2wITkPUibw=
X-Google-Smtp-Source: APXvYqzxNoIVSzG/EiEMyng+LExvoaroxBOIaWWuYublxBdClAfoeNnNwMFuB8SNsDVsQisLaUd1Uw==
X-Received: by 2002:a1c:4c5:: with SMTP id 188mr9494554wme.82.1576756549114;
 Thu, 19 Dec 2019 03:55:49 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z11sm5906877wrt.82.2019.12.19.03.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 03:55:47 -0800 (PST)
Date: Thu, 19 Dec 2019 11:55:45 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20191219115545.GD1624084@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
In-Reply-To: <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 10:57:17PM +0000, Felipe Franciosi wrote:
> > On Dec 17, 2019, at 5:33 PM, Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
> > On Mon, Dec 16, 2019 at 07:57:32PM +0000, Felipe Franciosi wrote:
> >>> On 16 Dec 2019, at 20:47, Elena Ufimtseva <elena.ufimtseva@oracle.com=
> wrote:
> >>> =EF=BB=BFOn Fri, Dec 13, 2019 at 10:41:16AM +0000, Stefan Hajnoczi wr=
ote:
> > Questions I've seen when discussing muser with people have been:
> >=20
> > 1. Can unprivileged containers create muser devices?  If not, this is a
> >   blocker for use cases that want to avoid root privileges entirely.
>=20
> Yes you can. Muser device creation follows the same process as general
> mdev device creation (ie. you write to a sysfs path). That creates an
> entry in /dev/vfio and the control plane can further drop privileges
> there (set selinux contexts, &c.)

In this case there is still a privileged step during setup.  What about
completely unprivileged scenarios like a regular user without root or a
rootless container?

> > 2. Does muser need to be in the kernel (e.g. slower to develop/ship,
> >   security reasons)?  A similar library could be implemented in
> >   userspace along the lines of the vhost-user protocol.  Although VMMs
> >   would then need to use a new libmuser-client library instead of
> >   reusing their VFIO code to access the device.
>=20
> Doing it in userspace was the flow we proposed back in last year's KVM
> Forum (Edinburgh), but it got turned down. That's why we procured the
> kernel approach, which turned out to have some advantages:
> - No changes needed to Qemu
> - No Qemu needed at all for userspace drivers
> - Device emulation process restart is trivial
>   (it therefore makes device code upgrades much easier)
>=20
> Having said that, nothing stops us from enhancing libmuser to talk
> directly to Qemu (for the Qemu case). I envision at least two ways of
> doing that:
> - Hooking up libmuser with Qemu directly (eg. over a unix socket)
> - Hooking Qemu with CUSE and implementing the muser.ko interface
>=20
> For the latter, libmuser would talk to a character device just like it
> talks to the vfio character device. We "just" need to implement that
> backend in Qemu. :)

What about:
 * libmuser's API stays mostly unchanged but the library speaks a
   VFIO-over-UNIX domain sockets protocol instead of talking to
   mdev/vfio in the host kernel.
 * VMMs can implement this protocol directly for POSIX-portable and
   unprivileged operation.
 * A CUSE VFIO adapter simulates /dev/vfio so that VFIO-only VMMs can
   still take advantage of libmuser devices.

Assuming this is feasible, would you lose any important
features/advantages of the muser.ko approach?  I don't know enough about
VFIO to identify any blocker or obvious performance problems.

Regarding recovery, it seems straightforward to keep state in a tmpfs
file that can be reopened when the device is restarted.  I don't think
kernel code is necessary?

Stefan

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl37ZUEACgkQnKSrs4Gr
c8gCgggAlD45AcFJEst3u1vtz9Cso94uDZ+2+mHK3+7argBzEgeRTml10u6ta1OM
FPvx8/qh6UtrjzXvfPhKjb22jRUt7KlB/gtepJ9XMScteielZm0irHnA83INVS1h
ekBleGkg5ObSH0MNNx4DZFqkxHlStydZnRsIIcFDcbT5rL4wIWaRB+3cnXbk9ZPC
tsy9HOoswNgeVPkUFVLDYB4H1f6BRhBFmwctWjYlIwaDjrFSUSl7jHAJBRC/7fN8
aFrxN2oYzXSrgX7W/cOL0r6rG7BRt7IbJkNarbYGMV3On1ShbFM5iTU+7qW+x0vt
c4TuWwTTcH1jyJ22/ecdH2NT5R7zJg==
=5WqR
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--

