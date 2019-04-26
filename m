Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F6DC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 10:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF452067C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 10:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5hqgpKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF452067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44232 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJxiP-0001h9-J8
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 06:04:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJxhK-0000dr-1X
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJxhI-0005X2-Rf
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:03:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hJxhI-0005Uw-Gr
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:03:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id a12so3582676wrq.10
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 03:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=V95Jw1Zz4QeJGJUt5uK5iCe9qFMHXSi61Ru3OPtDsyQ=;
	b=h5hqgpKFFmERjz3YoWAqDaoZQhPQ4e2aVoiaw9bZk1QKaCIjfybPr3P59ecXvoJZCc
	ZwCzOVZUHM6is22OWh7TNEC+64PlXtOeA0Y26F5efpi+ZF3SkmMOAE84JILBQ5ak4Xav
	hvx9veZqWr5uCc95k4fGHJBcBLu0KMLNsJ+Hwi5vevx3oV7iVpN344YrfdB0gxy9K9rk
	2GrDBrxD0QnNX9lXeSlopH9zdzrYk3PTB8Jr6597EF6g9Cz+Va1LfiAKL3O5QJoan3+N
	OD/W5UyYfWuYwE/Y17zstQPav1w6EVySRgoKjI6INJ67DKa38+iQRlRV6qZ8+QCnBXWO
	i3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=V95Jw1Zz4QeJGJUt5uK5iCe9qFMHXSi61Ru3OPtDsyQ=;
	b=ts1Iynnmmg0/hxvCxf6XUm8DhdsX+nMjL3x7sMpdDIkUuwaJxZ9iLBsZSs/MAwWqtY
	NQqcYjDoYqyAYOJVt7qQSdUYNLaWPgsoJjWpasJFsH8WW53jEamwrIz1t5R/3tFlha9D
	YbYJPgqiNOx4RR+V940hWz2MecQ35V4aXl8IeDdKWncFCAfcAWy8W1n/E0cqfiwugh0u
	M2do6bQLPfumKGk9xHIobYQHa81pnfrgqsVyBEMKMGxFlAsNpTtCAz3kyF6QQyG1mYgr
	PFZfPPT41b8Z4W+Z0UksnYdbVXwUdI7dJOOQGgVTguShcNwgGPPwi0o16T/fN1mUBVIM
	C/Rg==
X-Gm-Message-State: APjAAAVSdbVNuHslVlSnPxIRRNsBBfC8jjT+tUFI1LSuXeYBeFLX0h7Q
	oau3eTCBAu61wHLBOZ06tctrT7dDk0g0CG3y9dM=
X-Google-Smtp-Source: APXvYqxPN4xh7CtTqSHnhMNA2GqZV3fRY8hcpmslw7uXzoumEp6AC/xZ69PBsBn/YRwGAsXVmIZI44A5UKzg0cMzGNo=
X-Received: by 2002:adf:9042:: with SMTP id h60mr920186wrh.248.1556272991222; 
	Fri, 26 Apr 2019 03:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-5-marcandre.lureau@redhat.com>
	<20190426071530.y4eeu6ekx2nzvpar@sirius.home.kraxel.org>
In-Reply-To: <20190426071530.y4eeu6ekx2nzvpar@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 26 Apr 2019 12:02:58 +0200
Message-ID:
 <CAJ+F1CJrR60CpTp4_tYC4Up2rFZ-7TJ4HBghKSe9VQmUzhKDZw@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v6 04/11] contrib: add vhost-user-input
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
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426100258.TkjnWazGVQ5rfyP50PuoEPskvSsYOK6H3d6_T8BpIHk@z>

Hi

On Fri, Apr 26, 2019 at 9:16 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Apr 23, 2019 at 03:19:57PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Add a vhost-user input backend example, based on virtio-input-host
> > device. It takes an evdev path as argument, and can be associated with
> > a vhost-user-input device via a UNIX socket:
> >
> > $ vhost-user-input -p /dev/input/eventX -s /tmp/vui.sock
> >
> > $ qemu ... -chardev socket,id=3Dvuic,path=3D/tmp/vui.sock
> >   -device vhost-user-input-pci,chardev=3Dvuic
> >
> > This example is intentionally not included in $TOOLS, to not be built
> > and installed by default.
>
> I think we should build it by default, so it doesn't bitrot,
> even if we don't install it by default.
>
> > +static int unix_sock_new(char *path)
> > +{
>
> Move to common code?
>

Better, use existing unix_listen()!

thanks



--=20
Marc-Andr=C3=A9 Lureau

