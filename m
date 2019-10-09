Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B8FC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C645020679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C645020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIH4w-0007X8-OE
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iIDtN-0000YJ-Hn
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iIDtM-0002yf-C8
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:28:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45978)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1iIDtI-0002wf-Di; Wed, 09 Oct 2019 11:28:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C0ED1300CB6E;
 Wed,  9 Oct 2019 15:28:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-151.rdu2.redhat.com
 [10.10.122.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4372060606;
 Wed,  9 Oct 2019 15:28:36 +0000 (UTC)
Date: Wed, 9 Oct 2019 11:28:34 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 14/19] python/qemu/machine: Allow to use other serial
 consoles than default
Message-ID: <20191009152834.GA30349@localhost.localdomain>
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-15-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190926173428.10713-15-f4bug@amsat.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 09 Oct 2019 15:28:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?iso-8859-1?Q?Zolt=E1n?= Baldaszti <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cheng Xiang <ext-cheng.xiang@here.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 07:34:22PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Currently we are limited to use the first serial console available.
> Some machines/guest might use another console than the first one as
> the 'boot console'.
>=20
> To be able to use the N console as default, we simply need to connect
> all the N - 1 consoles to the null chardev.
>=20
> Add an index argument, so we can use a specific serial console as
> default.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  python/qemu/machine.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 128a3d1dc2..302b158a18 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -235,6 +235,8 @@ class QEMUMachine(object):
>                  '-display', 'none', '-vga', 'none']
>          if self._machine is not None:
>              args.extend(['-machine', self._machine])
> +        for i in range(self._console_id):
> +            args.extend(['-serial', 'null'])
>          if self._console_set:
>              self._console_address =3D os.path.join(self._temp_dir,
>                                                   self._name + "-consol=
e.sock")
> @@ -495,7 +497,7 @@ class QEMUMachine(object):
>          """
>          self._machine =3D machine_type
> =20
> -    def set_console(self, device_type=3DNone):
> +    def set_console(self, device_type=3DNone, console_id=3D0):

My guts tell me that we'll need to support multiple devices of a single
type shortly, but for now, this looks fine.

Would you please add a docstring parameter entry for console_id
explaining its effect?

Thanks,
- Cleber.

>          """
>          Sets the device type for a console device
> =20
> @@ -519,6 +521,7 @@ class QEMUMachine(object):
>          """
>          self._console_set =3D True
>          self._console_device_type =3D device_type
> +        self._console_id =3D console_id
> =20
>      @property
>      def console_socket(self):
> --=20
> 2.20.1
>=20

