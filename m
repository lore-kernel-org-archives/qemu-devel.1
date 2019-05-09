Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0297CC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:47:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C365E205C9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIyNJs0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C365E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54837 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOjOU-0007pu-4h
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:47:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hOjMj-0006v4-1f
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hOjMi-0008DM-3j
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:45:41 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:34890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hOjMh-00082e-Ou
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:45:39 -0400
Received: by mail-wr1-x42f.google.com with SMTP id w12so3184743wrp.2
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 06:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=eXYxWsNKz9ZS1eEmOrvZuOreVYVFHPBffsyVKJwYhV4=;
	b=jIyNJs0OEubQKDh6xm9/bYKKaQi3BctHnuUeg0qTlLKfRpAMKUhoNTu473G9WRxCQp
	KTGjPiPDhRE8kLwG9O2cQEVbQqtz6velENSbmhvIqNZ8GEwLaCtpelz/gwDJxb76PL5h
	peobq2UuacqgLK+KFyFsZMimwGU/i/YeUVPcV0t7jxvKGj7ImoFH3cX3TwKKKw0Ges2m
	7THXWot613xSdZywDy0nMtnbjYTpBV2ZVBxlHGuH/0jDOLmZCJR7jOJQbhEclwuAbzSF
	vgRM3nodVXi+hvi3YyR4/q6u83SAePeRX3GeZ8op+gt8pbARbDXCcWj/Xf9douz494PP
	Hb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=eXYxWsNKz9ZS1eEmOrvZuOreVYVFHPBffsyVKJwYhV4=;
	b=M+XNlAYYd9B1F6+li6dAexQ/topfj7rEvERrV4jbjHSksCvfzAGB/ItOZxBMBzY0oo
	y3CcDJ+CvGpOH0DT8+GFClUcxAmRvOBS+m97pRDtIKolFqq6EO88ph3fSEt6kX7Wxv2u
	b22BNWHr9glPtyGelSmQxoAQP2dAET6h+iOXObDOTt7waahQAsuurJ2R1JMYtR/jZWXb
	SgINxVOOQJl36ari4k16OKCGw1uObsSTTgMNYubv+Y8lgAW5TpWgultHjq8LlcARP1dm
	CKULP58kFPjbnyftJSu5Qhl0MwQEExBAH7zQXdZjAzB4KBB5IMGPtVQ0ZD/nI59DMQA1
	VDZg==
X-Gm-Message-State: APjAAAXONeENpL08KQAgyfW42Ny3rujktOlYvboH05P9QVlfTlLBvpuo
	xzUdIsKY2/zrKXy2askPF+8=
X-Google-Smtp-Source: APXvYqxwFEUlg5AKcP9UbFXqizi5Li53U3HdP72FoS7RSVo8Pp5VFcp7AwTfxFjyeUj67YAZ4yHCZQ==
X-Received: by 2002:a5d:4a92:: with SMTP id o18mr3125852wrq.80.1557409527608; 
	Thu, 09 May 2019 06:45:27 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	s10sm2950657wrt.66.2019.05.09.06.45.26
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 06:45:26 -0700 (PDT)
Date: Thu, 9 May 2019 14:45:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: S KH <sgh8183@gmail.com>
Message-ID: <20190509134525.GD17133@stefanha-x1.localdomain>
References: <CAE519-nz3KE2GcQCj_4Ufs+ZR_jKwoMDpdrZS43bbZ_SxSjHeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Content-Disposition: inline
In-Reply-To: <CAE519-nz3KE2GcQCj_4Ufs+ZR_jKwoMDpdrZS43bbZ_SxSjHeg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: Re: [Qemu-devel] Question on QEMU : How to record debug log in VM
 of QEMU
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 11:29:03AM +0900, S KH wrote:
> This is a question I have encountered while using QEMU.
>=20
> I want to compile the source directly rather than through apt or yum and
> install QEMU and input the output statement to the source to check the
> output value.
>=20
> When I compiled QEMU using dpkg-buildpackage in Ubuntu, I verified that
> when QEMU's VM is executed by inputting and compiling the output statemen=
t,
> the output value is recorded in the log file(ex.
> /var/log/libvirt/qemu/win7.log) of that VM.
>=20
> In Centos, I tried to use rpmbuild to input the output to QEMU source,
> compile and check the output value. I confirmed that the log file is not
> written, but I have confirmed that the output value is rare from the
> terminal during the compilation process.
>=20
> What I want to do is to get the output to be written to the log file like
> in Ubuntu.

Try diffing /etc/libvirt/qemu.conf between the Ubuntu and CentOS hosts.
Maybe they have different logging setups.  In particular, the
stdio_handler setting might be different.

Stefan

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzULvUACgkQnKSrs4Gr
c8iCqwf/d73V7V0caZWk/m4LJB4YJ9eyaicY+g9AHSyr9Wpty0zci9jfJBJP1owY
v4EM6pH16XnKOhN+npn0KgFOFqKpB1qLE0IiByIS72HQfCLC/oknArBu+mK49dpv
8QtZKct56V3CZQ0wXuXoF1Zjk4v4zBwLG5gtJSA2dBJeUJaAnM13uunFqYqGZS8Z
9DWIg+M8JjHfR4nZMYh8IvAkGpwR38ftJORnr/SYhxgHVq3R4N9iSIGj8DcSFVsw
ae3LRjtM78rJrV4I2uVDP0ClL5t4Pwu6EivsukaeGKUDfHMEvMOejcL83LlvP5Ks
Ub3lTzf2cIFzwDnZ9QVzLNTqnv8jBA==
=TyV8
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--

