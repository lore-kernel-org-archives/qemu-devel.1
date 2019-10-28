Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A079CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 14:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54EA4208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 14:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y53J5nP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EA4208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP6Ng-0000TC-EU
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 10:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iP6Mp-0007yZ-UA
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iP6Mn-0008US-20
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:51:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34241
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iP6Mm-0008SQ-UK
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572274290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0G07qLqCUu82KfuXdWRsDNz+fA3QGXz2xF86i5poy0=;
 b=Y53J5nP6p3glNdyedlsEs6ieyEuSFslxxmiiR81n7Mu0cItWZ+a9jeJu6Vc+DEt+2RDtuh
 b908EFa3R+usq6NMMQ2AAWbbnxCVMSIrhPnhJ2naABLhuktBN4NhXU46G5sV0VMVFmQahd
 LTJMPL119Vk/tH1Ym6Z4C2ronvWUl5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-XsHMlSJyOtWFuPvgE-0DqQ-1; Mon, 28 Oct 2019 10:51:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08354107AD28;
 Mon, 28 Oct 2019 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59D3526360;
 Mon, 28 Oct 2019 14:51:14 +0000 (UTC)
Date: Mon, 28 Oct 2019 10:51:12 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 01/26] python/qemu/machine: Allow to use other serial
 consoles than default
Message-ID: <20191028145112.GA965@localhost.localdomain>
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191028073441.6448-2-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: XsHMlSJyOtWFuPvgE-0DqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 08:34:16AM +0100, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Currently the QEMU Python module limits the QEMUMachine class to
> use the first serial console.
>=20
> Some machines/guest might use another console than the first one as
> the 'boot console'. For example the Raspberry Pi uses the second
> (AUX) console.
>=20
> To be able to use the Nth console as default, we simply need to
> connect all the N - 1 consoles to the null chardev.
>=20
> Add an index argument, so we can use a specific serial console as
> default.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> v2:
> - renamed 'console_index', added docstring (Cleber)
> - reworded description (pm215)
> ---
>  python/qemu/machine.py | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 128a3d1dc2..6fa68fa35a 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -235,6 +235,8 @@ class QEMUMachine(object):
>                  '-display', 'none', '-vga', 'none']
>          if self._machine is not None:
>              args.extend(['-machine', self._machine])
> +        for i in range(self._console_index):
> +            args.extend(['-serial', 'null'])

This will get executed even when set_console() is never called, so it
will result in an AttributeError because 'self._console_index' does
not exist.

It's also a good practice to define all attributes on __init__(), so
I'd suggest that as a fix.

- Cleber.


