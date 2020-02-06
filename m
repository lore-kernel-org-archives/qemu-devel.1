Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFECC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 19:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB5521741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 19:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6NggitM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB5521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iznFM-0003B5-QT
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 14:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iznEj-0002iF-8Z
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 14:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iznEg-0001CV-Va
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 14:54:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27243
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iznEg-00018S-Nv
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 14:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581018889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vyIhwNNfZZZJ94VfGVRWmcRH3sOem+l0HcLkcjdUUpc=;
 b=C6NggitM31bm2m7y91DR/R1Q3U5I4aI+VMq8xPCrawhoAB+9l9BMcb3Dr1E8y1LBbETz0i
 RQ2S4TmPNpFzT9SZzDqFQyeE8OenZfZhBlMNjiN2ftQjVTDUX9XSz1c7fgmAIzmhQ4xsFg
 UQPaC9C0JxgHuTeh10Fbd/QF2w8eyvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-9_VT89K2NamwKLKFbHSF4g-1; Thu, 06 Feb 2020 14:54:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6FC718B5FA1;
 Thu,  6 Feb 2020 19:54:46 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F835867E2;
 Thu,  6 Feb 2020 19:54:41 +0000 (UTC)
Date: Thu, 6 Feb 2020 14:54:41 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 17/29] tests/acceptance/virtio_check_params: Improve
 exception logging
Message-ID: <20200206195441.GA412524@habkost.net>
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-18-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200129212345.20547-18-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 9_VT89K2NamwKLKFbHSF4g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Cleber Rosa <crosa@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 10:23:33PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  tests/acceptance/virtio_check_params.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/v=
irtio_check_params.py
> index 4a417b8ef5..51a2dd76e8 100755
> --- a/tests/acceptance/virtio_check_params.py
> +++ b/tests/acceptance/virtio_check_params.py
> @@ -77,8 +77,12 @@ class VirtioMaxSegSettingsCheck(Test):
>              vm.set_machine(mt["name"])
>              for s in VM_DEV_PARAMS[dev_type_name]:
>                  vm.add_args(s)
> -            vm.launch()
> -            query_ok, props, error =3D self.query_virtqueue(vm, dev_type=
_name)
> +            try:
> +                vm.launch()
> +                query_ok, props, error =3D self.query_virtqueue(vm, dev_=
type_name)
> +            except:
> +                query_ok =3D False
> +                error =3D sys.exc_info()[0]

I would prefer to do this inside query_virtqueue(), but:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo


