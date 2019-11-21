Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69461C43215
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C182089D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+g90HH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C182089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXlRu-0001k5-NH
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 07:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXlQd-0000Ec-4e
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:19:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXlQb-0008As-U4
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:19:18 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37565)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXlQb-0008A1-N3
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:19:17 -0500
Received: by mail-wr1-x441.google.com with SMTP id t1so4161607wrv.4
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 04:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3YrPhJBd+6NEb7cnbcUSADo+3FmjBzw09oDJhuQoavQ=;
 b=t+g90HH7caFDaLe1QzVaEek7zNyez2tgcFlNuNafGiLyQk84KxcW+ZhzCxfUjYl+4f
 ckvgNi/c4thk7L/xPCsbUANViQTZ6xF6TGRr5zbzvhDQEFd//e/qFe+DSTbPHWpjDjt2
 Jg588B97iz2WFIN3pTXc6JDMORDr2cf9F6ITgbm+YiEvhdTJcom1tMX/nWYT9oDHTUP2
 uueInwe4dsQiZw+SLLfQN9tSq0eJ+6jgTRBqUMPGrr8pD2O2Ex9MMcgl7JLXwMP8Grlm
 U5zEVCfz+XydbIRkgMltUdowh3pQwcW8wf7TZymFfIFx7g3bozkMQLJKyIvvlN3HI1/E
 sSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3YrPhJBd+6NEb7cnbcUSADo+3FmjBzw09oDJhuQoavQ=;
 b=njeaezGhxh+N/H2jMbNuBzEqehSsYlXDm9IIm6uvcO8/NMgIcjm9+ASo732Ekkcl8g
 D7yYvkCpUluI9X9MLmAqxl9gjxFlcASuQH0FAaUVBUocS5ZUn/RcrTc/T9LZbeKnVFF4
 WFhBwDOAUSOI0pUej50G2Xn4BtsDofX7cLRGZKJQhK/u6yUSKIHlD4C6bHJ/fysg5OEn
 Df4I97w6yrlX5jL/+UHBEobq3PNGpQjSYd+SZZDjNanetcLouGCvOMFrmYuvEX3u8UxA
 vRl1mLeyfdjXmldVVyBQDEnjuoZG1LEbA8herEsoaQt763/5Ha2l5MIqCaFQUXnBH5tG
 vmGQ==
X-Gm-Message-State: APjAAAWY/A8b3J9aKjVoRqpVeOi6zObydsYhm574w+freIy45NfuG7Ah
 001wKTkEOO437If2fZHRd14=
X-Google-Smtp-Source: APXvYqwZv0qhyUWJoXnJPlc0c5UBM+/rawUg+B3xoRQ2Yz75H0oK2txXZmP3BTAnJDA8L9RgYhGSQg==
X-Received: by 2002:adf:ffd0:: with SMTP id x16mr9890894wrs.86.1574338756485; 
 Thu, 21 Nov 2019 04:19:16 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id d202sm2526642wmd.47.2019.11.21.04.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 04:19:15 -0800 (PST)
Date: Thu, 21 Nov 2019 12:19:14 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jag Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 30/49] multi-process: send heartbeat messages to
 remote
Message-ID: <20191121121914.GP439743@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <14c33104778e77fcf2e7f0df2a1dd96fbcaf49d7.1571905346.git.jag.raman@oracle.com>
 <20191111162750.GJ402228@stefanha-x1.localdomain>
 <6f063381-c842-9c03-280f-1e9652a15881@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BnCwdHgQ2ZomtW9r"
Content-Disposition: inline
In-Reply-To: <6f063381-c842-9c03-280f-1e9652a15881@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, Stefan Hajnoczi <stefanha@redhat.com>, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BnCwdHgQ2ZomtW9r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2019 at 11:01:07AM -0500, Jag Raman wrote:
>=20
>=20
> On 11/11/2019 11:27 AM, Stefan Hajnoczi wrote:
> > On Thu, Oct 24, 2019 at 05:09:11AM -0400, Jagannathan Raman wrote:
> > > +static void broadcast_msg(MPQemuMsg *msg, bool need_reply)
> > > +{
> > > +    PCIProxyDev *entry;
> > > +    unsigned int pid;
> > > +    int wait;
> > > +
> > > +    QLIST_FOREACH(entry, &proxy_dev_list.devices, next) {
> > > +        if (need_reply) {
> > > +            wait =3D eventfd(0, EFD_NONBLOCK);
> > > +            msg->num_fds =3D 1;
> > > +            msg->fds[0] =3D wait;
> > > +        }
> > > +
> > > +        mpqemu_msg_send(entry->mpqemu_link, msg, entry->mpqemu_link-=
>com);
> > > +        if (need_reply) {
> > > +            pid =3D (uint32_t)wait_for_remote(wait);
> >=20
> > Sometimes QEMU really needs to wait for the remote process before it can
> > make progress.  I think this is not one of those cases though.
> >=20
> > Since QEMU is event-driven it's problematic to invoke blocking system
> > calls.  The remote process might not respond for a significant amount of
> > time.  Other QEMU threads will be held up waiting for the QEMU global
> > mutex in the meantime (because we hold it!).
>=20
> There are places where we wait synchronously for the remote process.
> However, these synchronous waits carry a timeout to prevent the hang
> situation you described above.
>=20
> We will add an error recovery in the future. That is, we will respawn
> the remote process if the QEMU times out waiting for it.

Even with a timeout, in the meantime the event loop is blocked.  That
means timers will be delayed by a large amount, the monitor will be
unresponsive, etc.

> >=20
> > Please implement heartbeat/ping asynchronously.  The wait eventfd should
> > be read by an event loop fd handler instead.  That way QEMU can continue
> > with running the VM while waiting for the remote process.
>=20
> In the current implementation, the heartbeat/ping is asynchronous.
> start_heartbeat_timer() sets up a timer to perform the ping.

The heartbeat/ping is synchronous because broadcast_msg() blocks.

Stefan

--BnCwdHgQ2ZomtW9r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WgMIACgkQnKSrs4Gr
c8hTrwgAxH0CgmLgNHPUPzFNFBCUJV0EnwEPzxQkVShAQFe/eSh2eAj7br5Kduj/
QIIL5OJNg7wEScXpdoiOlt0jj0QZN2FWSDTSA3GZZOObcPyoc1C89W+auY7YDwLm
qnSNt4utnfWvSSb2JO0/OQjxPyLHJKwQmclBme0KWXvdMBMKnbOb7ETmxwjxqKHO
g3Xe7PWmBrouIxr6OHTbLIErhkW1wC9VcNTpAe4iBhSaGheMMSHFZtLFcYs/DmYd
bGhw7kZDKDQ3NB8awfS9Lhd980J29Woq/vCS8VvuJilkEEluVhxZitpHKLJ8l01b
+qmWJRDkND31P32g43LGQOSv4JM3Fg==
=1WrO
-----END PGP SIGNATURE-----

--BnCwdHgQ2ZomtW9r--

