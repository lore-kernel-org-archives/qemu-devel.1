Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EEEC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7335820881
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUlsD8Qt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7335820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34626 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTmP5-0006UV-Os
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 08:00:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTmO3-0005yj-J0
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTmO2-0004cX-EY
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:59:55 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hTmO2-0004by-6H
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:59:54 -0400
Received: by mail-wm1-x344.google.com with SMTP id t5so5492616wmh.3
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 04:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=L3mid2STVSIdD8eiNHxsdEidcq87IHDG6jiwp46vKQI=;
	b=GUlsD8QtCK4y8xNjTRgvBmAzYJeh3AvsKd2mwTDPkzNtQQjYLrMYQodh4M/Y5O6sRQ
	VJcoMQKG6pi97qUU1uC14TXPJjGVqHiMUBfq0ETaaUfBIMbD4x8nxmMKqGO/SBwCTBB3
	LoclFZcSgjS8adJYWDiMHwIEMVAfg4LjeLU27HMv2/B7CdBPz5KvB+p10QL/qWRNQmj0
	Z4W0MS4WLn8xoCvC+C+UniXGDmyhlf+hD4TPAXUDtnRVGj44b06Qofq5Q9gtbDaohJKS
	vJus6H7buR7dgwT1cXtpGNdsP7TzZpKHyJUUBQsKN0KWrYJKz74FauWho3sdBOiG41pQ
	+QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=L3mid2STVSIdD8eiNHxsdEidcq87IHDG6jiwp46vKQI=;
	b=iN/9ljptf87bLBXKpI+Rr0rzp38YDI+PAImaBtGIPu68G5BFkXG921uCk7aXsiOVrH
	ZjscSYOTuEdCEvi/9tKMzKPKyKsVy44WDfsaIrM7Zo4nRd8DWORchIcjUSF81aCZ0qp3
	9YxXwNYBmyiUxqxR7i0w3RDBs+9XQsMHKAVT9KkbOnIdpUHyh1xfXB5r0/z1sUWBa0dw
	XSyRWtgxclOaTf2lpxVDz8IlLMkXvVchuRmSGQzf46w0GR4nf7lTaIBZqKWc/M/fe6pB
	1KD+1Bp4l1mY87B7VnprZRAdlfgqJ4aKVrvY5fWYBv54N9Rlpi84Dfn8kQgX4/lcHnwA
	x3og==
X-Gm-Message-State: APjAAAXWKJDzgO47EII4Y+WYGr5ynMXJgPT4BzpmWga0goH67oDuV5/E
	w+hPoR47O39rrOcce6FEhxY=
X-Google-Smtp-Source: APXvYqxR6Be+zenq7GFbSVZx3MBVQ+PtX/+Sdlr65Nnf4//E3fh2cAdrklzAyBYdROqEqIb3M1LGMA==
X-Received: by 2002:a1c:cf4c:: with SMTP id f73mr10886050wmg.118.1558612792215;
	Thu, 23 May 2019 04:59:52 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	m10sm9530008wmf.40.2019.05.23.04.59.51
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 04:59:51 -0700 (PDT)
Date: Thu, 23 May 2019 12:59:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190523115950.GH26632@stefanha-x1.localdomain>
References: <0952696452f5ff4e38d2417029243fc60efa33d6.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="82evfD9Ogz2JrdWZ"
Content-Disposition: inline
In-Reply-To: <0952696452f5ff4e38d2417029243fc60efa33d6.camel@sipsolutions.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] custom virt-io support (in user-mode-linux)
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
Cc: linux-um@lists.infradead.org, qemu-devel@nongnu.org,
	virtualization@lists.linux-foundation.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--82evfD9Ogz2JrdWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2019 at 03:02:38PM +0200, Johannes Berg wrote:
> Hi,
>=20
> While my main interest is mostly in UML right now [1] I've CC'ed the
> qemu and virtualization lists because something similar might actually
> apply to other types of virtualization.
>=20
> I'm thinking about adding virt-io support to UML, but the tricky part is
> that while I want to use the virt-io basics (because it's a nice
> interface from the 'inside'), I don't actually want the stock drivers
> that are part of the kernel now (like virtio-net etc.) but rather
> something that integrates with wifi (probably building on hwsim).
>=20
> The 'inside' interfaces aren't really a problem - just have a specific
> device ID for this, and then write a normal virtio kernel driver for it.
>=20
> The 'outside' interfaces are where my thinking breaks down right now.
>=20
> Looking at lkl, the outside is just all implemented in lkl as code that
> gets linked to the library, so in UML terms it'd just be extra 'outside'
> code like the timer handling or other netdev stuff we have today.
> Looking at qemu, it's of course also implemented there, and then
> interfaces with the real network, console abstraction, etc.
>=20
> However, like I said above, I really need something very custom and not
> likely to make it upstream to any project (because what point is that if
> you cannot connect to the rest of the environment I'm building), so I'm
> thinking that perhaps it should be possible to write an abstract
> 'outside' that lets you interact with it really from out-of-process?
> Perhaps through some kind of shared memory segment? I think that gets
> tricky with virt-io doing DMA (I think it does?) though, so that part
> would have to be implemented directly and not out-of-process?
>=20
> But really that's why I'm asking - is there a better way than to just
> link the device-side virt-io code into the same binary (be it lkl lib,
> uml binary, qemu binary)?

Hi Johannes,
Check out vhost-user.  It's a protocol for running a subset of a VIRTIO
device's emulation in a separate process (usually just the data plane
with the PCI emulation and other configuration/setup still handled by
QEMU).

vhost-user uses a UNIX domain socket to pass file descriptors to shared
memory regions.  This way the vhost-user device backend process has
access to guest RAM.

This would be quite different for UML since my understanding is you
don't have guest RAM but actual host Linux processes, but vhost-user
might still give you ideas:
https://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Ddocs/interop/vhost-us=
er.rst;hb=3DHEAD

Stefan

--82evfD9Ogz2JrdWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzmizYACgkQnKSrs4Gr
c8iyiQgAtcvNB/axTFWFW8B8Yja3ssAl/WQoNmZFkMVKrMmaRWNWwkZpLvFuijDm
hKISZpLqpwJLktRbr57OEBdVBGqyORDULJABoB+Tk4le6zQhgXARKoEetmjUQgEM
0CFEvYO5HrlTERLU0hFfudeH39yz8r3xMI+yZ3PWjCkqZC/KYu8Ny2s82Ltc4mnb
6OjybksHD4G5MDYC0BJO/lXeARjOO6/eLgxMGDPTWENAJTXOCeXg1ZvYtdvPsdOs
TFmzkvY63x8j8jKkgR1iJb1QjtGzpLjzhadfIPSl2MQN7hhBmOOsBzvBNJFAqOlo
ue1U9AT0+ZRt1HMcfWx59MyXofnM+Q==
=2T/5
-----END PGP SIGNATURE-----

--82evfD9Ogz2JrdWZ--

