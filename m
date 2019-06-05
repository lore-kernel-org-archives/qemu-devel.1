Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B67C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F232067C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F232067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44212 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYXW1-0005oA-4d
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 11:07:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYXUX-00052Z-15
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYXUV-00016y-Ry
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:06:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hYXUV-00015d-LT
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:06:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFD5E821DE;
	Wed,  5 Jun 2019 15:06:14 +0000 (UTC)
Received: from redhat.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 101B2519C3;
	Wed,  5 Jun 2019 15:06:04 +0000 (UTC)
Date: Wed, 5 Jun 2019 16:06:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190605150601.GD8956@redhat.com>
References: <20190523234011.583-1-marcandre.lureau@redhat.com>
	<20190523234011.583-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190523234011.583-5-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 05 Jun 2019 15:06:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/4] qemu-sockets: do not require
 configured ipv4/ipv6 address
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 24, 2019 at 01:40:11AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> podman containers without network don't have ipv4/ipv6 addresses other
> than loopback address. However, some of our tests require
> getaddrinfo("127.0.0.1") to succeed.
>=20
> Alternatively, we may want to treat 127.0.0.1 as a special case, to
> keep the AI_ADDRCONFIG convenience.

Keeping AI_ADDRCONFIG is mandatory as this is required for correctly
operating IPv4/IPv6 dual stack support.

In tests/socket-helpers.h I have a couple of APIs designed to help
in this case.

  int socket_can_bind_connect(const char *hostname);
  int socket_check_protocol_support(bool *has_ipv4, bool *has_ipv6);

The latter function just calls the former with "127.0.0.1" and
"::1" and reports results =3D.

The intention is that any test which relies on using getaddrinfo()
should call one of these functions, and then skip any tests which
have a dependancy on this working.

We certainly don't do these checks it all our tests right now
though, so it is not surprising if some fail.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

