Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FB9C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 20:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C4B24670
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 20:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5qx//jQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C4B24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icxid-0003HY-Qs
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 15:27:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1icxh9-0002Wl-DQ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 15:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1icxh2-00008n-1z
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 15:25:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42461
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1icxgr-0008WU-Oh
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 15:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575577530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yeRAvPUzrhCLNi7VSIBfVNOVfdoZAWw6/GYi6/c3Y9Y=;
 b=U5qx//jQP3+sjkzgSumzl2bE7oUPQjWJ5GUM2r53iyik6LsAYrH/VdnL15XrgnkzwrXahf
 AnvweKw87h/vVFvgbirAncLDNuP32OiwJpSYcURoL5iS7BDslkO6OYn5Q1zZPZrwOpFQaO
 BSgQ2yTV7jov9bSwoOj9Z6oVBY67GW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-QGEyEmj-NOaDUVMPZTBK-g-1; Thu, 05 Dec 2019 15:25:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69995593A2;
 Thu,  5 Dec 2019 20:25:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-37.rdu2.redhat.com
 [10.10.125.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BD6410013A1;
 Thu,  5 Dec 2019 20:25:10 +0000 (UTC)
Date: Thu, 5 Dec 2019 15:25:08 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 4/7] tests/hd-geo-test: Skip test when images can not
 be created
Message-ID: <20191205202508.GD29262@localhost.localdomain>
References: <20191204154618.23560-1-thuth@redhat.com>
 <20191204154618.23560-5-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191204154618.23560-5-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: QGEyEmj-NOaDUVMPZTBK-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: qemu-block@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Eric Auger <eric.auger@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 04, 2019 at 04:46:15PM +0100, Thomas Huth wrote:
> In certain environments like restricted containers, we can not create
> huge test images. To be able to use "make check" in such container
> environments, too, let's skip the hd-geo-test instead of failing when
> the test images could not be created.
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/hd-geo-test.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
> index 7e86c5416c..a249800544 100644
> --- a/tests/hd-geo-test.c
> +++ b/tests/hd-geo-test.c
> @@ -34,8 +34,13 @@ static char *create_test_img(int secs)
>      fd =3D mkstemp(template);
>      g_assert(fd >=3D 0);
>      ret =3D ftruncate(fd, (off_t)secs * 512);
> -    g_assert(ret =3D=3D 0);
>      close(fd);
> +
> +    if (ret) {
> +        free(template);
> +        template =3D NULL;
> +    }
> +
>      return template;
>  }
> =20
> @@ -934,6 +939,10 @@ int main(int argc, char **argv)
>      for (i =3D 0; i < backend_last; i++) {
>          if (img_secs[i] >=3D 0) {
>              img_file_name[i] =3D create_test_img(img_secs[i]);
> +            if (!img_file_name[i]) {
> +                g_test_message("Could not create test images.");
> +                goto test_add_done;
> +            }
>          } else {
>              img_file_name[i] =3D NULL;
>          }
> @@ -965,6 +974,7 @@ int main(int argc, char **argv)
>                         "skipping hd-geo/override/* tests");
>      }
> =20
> +test_add_done:
>      ret =3D g_test_run();
> =20
>      for (i =3D 0; i < backend_last; i++) {
> --=20
> 2.18.1
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>


