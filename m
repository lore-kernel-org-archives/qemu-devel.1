Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB18DC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 18:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8266F20850
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 18:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8266F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53070 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEe5p-0008Au-Rj
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 14:06:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEe4w-0007Ym-Vw
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEe4v-00061i-1e
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:05:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEe4p-0005pH-FS
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:05:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECE723D960;
	Thu, 11 Apr 2019 18:05:25 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B1F0619D2;
	Thu, 11 Apr 2019 18:05:18 +0000 (UTC)
Date: Thu, 11 Apr 2019 19:05:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190411180516.GJ3641@redhat.com>
References: <20190411175931.29235-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190411175931.29235-1-brijesh.singh@amd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Thu, 11 Apr 2019 18:05:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] target/i386: sev: add 'sev-max-guests'
 field to 'query-sev-capabilities'
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
Cc: Erik Skultety <eskultet@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411180516.UrAvdoHHOeYdU_BDdaZWnlYuJc1x_lT2KGZxnWOMqKU@z>

On Thu, Apr 11, 2019 at 05:59:50PM +0000, Singh, Brijesh wrote:
> There are limited numbers of the SEV guests that can be run concurrentl=
y.
> A management applications may need to know this limit so that it can pl=
ace
> SEV VMs on hosts which have suitable resources available.
>=20
> Currently, this limit is not exposed to the application. Add a new
> 'sev-max-guest' field in the query-sev-capabilities to provide this
> information.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Erik Skultety <eskultet@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  qapi/target.json  | 6 ++++--
>  target/i386/sev.c | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/qapi/target.json b/qapi/target.json
> index 1d4d54b600..b45121d30b 100644
> --- a/qapi/target.json
> +++ b/qapi/target.json
> @@ -183,7 +183,8 @@

A few lines above here you need to document the new field
with (since 4.1) annotation.

>    'data': { 'pdh': 'str',
>              'cert-chain': 'str',
>              'cbitpos': 'int',
> -            'reduced-phys-bits': 'int'},
> +            'reduced-phys-bits': 'int',
> +            'sev-max-guests': 'int'},
>    'if': 'defined(TARGET_I386)' }
> =20
>  ##
> @@ -200,7 +201,8 @@
>  #
>  # -> { "execute": "query-sev-capabilities" }
>  # <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
> -#                  "cbitpos": 47, "reduced-phys-bits": 5}}
> +#                  "cbitpos": 47, "reduced-phys-bits": 5,
> +#                  "sev-max-guests" : 15}}
>  #
>  ##
>  { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index cd77f6b5d4..bb0cd79acd 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -488,7 +488,7 @@ sev_get_capabilities(void)
>      guchar *pdh_data =3D NULL;
>      guchar *cert_chain_data =3D NULL;
>      size_t pdh_len =3D 0, cert_chain_len =3D 0;
> -    uint32_t ebx;
> +    uint32_t ebx, ecx, edx;
>      int fd;
> =20
>      fd =3D open(DEFAULT_SEV_DEVICE, O_RDWR);
> @@ -507,7 +507,7 @@ sev_get_capabilities(void)
>      cap->pdh =3D g_base64_encode(pdh_data, pdh_len);
>      cap->cert_chain =3D g_base64_encode(cert_chain_data, cert_chain_le=
n);
> =20
> -    host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
> +    host_cpuid(0x8000001F, 0, NULL, &ebx, &ecx, &edx);
>      cap->cbitpos =3D ebx & 0x3f;
> =20
>      /*
> @@ -516,6 +516,8 @@ sev_get_capabilities(void)
>       */
>      cap->reduced_phys_bits =3D 1;
> =20
> +    /* the maximum number of SEV guests that can run simultaneously */
> +    cap->sev_max_guests =3D ecx - edx + 1;
>  out:
>      g_free(pdh_data);
>      g_free(cert_chain_data);

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

