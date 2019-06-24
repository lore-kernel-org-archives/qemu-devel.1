Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94694C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C30720652
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C30720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52194 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfQeD-0000Cx-Dn
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 11:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39139)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hfQdL-0007ER-Kh
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hfQdK-0006fU-9I
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:11:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54520)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1hfQdH-0006Vo-Ei; Mon, 24 Jun 2019 11:11:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1B4136EB97;
 Mon, 24 Jun 2019 15:11:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 779EC1001B04;
 Mon, 24 Jun 2019 15:11:40 +0000 (UTC)
Date: Mon, 24 Jun 2019 16:11:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190624151138.GJ17698@redhat.com>
References: <20190620122132.10075-1-philmd@redhat.com>
 <20190620122132.10075-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620122132.10075-2-philmd@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 24 Jun 2019 15:11:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 1/3] hw/firmware: Add Edk2Crypto and
 edk2_add_host_crypto_policy()
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 20, 2019 at 02:21:30PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> The Edk2Crypto object is used to hold configuration values specific
> to EDK2.
>=20
> The edk2_add_host_crypto_policy() function loads crypto policies
> from the host, and register them as fw_cfg named file items.
> So far only the 'https' policy is supported.
>=20
> A usercase example is the 'HTTPS Boof' feature of OVMF [*].
>=20
> Usage example:
>=20
> - via the command line:
>=20
>   $ qemu-system-x86_64 \
>       --object edk2_crypto,id=3Dhttps,\
>               ciphers=3D/etc/crypto-policies/back-ends/openssl.config,\
>               cacerts=3D/etc/pki/ca-trust/extracted/edk2/cacerts.bin
>=20
> - via QMP:
>=20
>   {
>     "execute": "object-add",
>     "arguments": {
>       "qom-type": "edk2_crypto",
>       "id": "https",
>       "props": {
>         "ciphers": "/etc/crypto-policies/back-ends/openssl.config",
>         "cacerts": "/etc/pki/ca-trust/extracted/edk2/cacerts.bin"
>       }
>     }
>   }

These commands / args create an object with ID "https" but you are
not telling anything to use this object, which makes me fear that
you have some code somewhere hardcoded to mandate an object with
an ID of "https".....


> +static void edk2_add_host_crypto_policy_https(FWCfgState *fw_cfg)
> +{
> +    Edk2Crypto *s;
> +
> +    s =3D edk2_crypto_by_policy_id("https", NULL);

....indeed you have hardcoded use of a particular object ID.

This is not good - choice of what strings to use for object IDs is someth=
ing
for the the management app - QEMU must not be dictating certain magic IDs=
.

There needs to be a command line arg somewhere to tell the firmware what
object ID provides the data.

Given that you're triggering load of this object from the machine type
initializer code, having an arg to the -machine option is a natural
choice.

ie something like this:

   $ qemu-system-x86_64 \
       --object edk2_crypto,id=3Dedkpolicy0,\
               ciphers=3D/etc/crypto-policies/back-ends/openssl.config,\
               cacerts=3D/etc/pki/ca-trust/extracted/edk2/cacerts.bin \
       --machine q35,edk2_crypto_policy=3Dedkpolicy0

I don't see a compelling reason to separate https policy out as an
explicit tunable, distinct from other, yet to be invented, needs for
crypto policy even if EDK2 itself is fine grained in this way.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

