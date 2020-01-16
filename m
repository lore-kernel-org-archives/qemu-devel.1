Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA99CC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750652073A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9OpDiqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750652073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is88b-0004zZ-Gy
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 11:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1is87Q-0003j0-D4
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1is87P-00021Q-7w
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:35:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52721
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1is87P-00020x-3o
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579192538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=plUoY3hyOmbGcWFNFIDBsmMggdoRQIpDbcuWA/+3Wzg=;
 b=D9OpDiqwHYaUw9yaTVJdrdv74Af6LBo6Ym/jAloxrEfaOYrckr648a3DSBtMuHvk5TouZu
 XKgaXIpLh8WT3b9TwM50ksiKBpdLv6OGMgUHodVWTMBmKiAXWg4p5C77mcqzepFLXczngt
 huqA8m5ipm1pHJPYUfFs0Sea8XEcibM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-H5RK8sLqPJ-Nndu_GiGAlg-1; Thu, 16 Jan 2020 11:35:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 421861937FD7
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 16:35:36 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-204-105.brq.redhat.com [10.40.204.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03C1B38A;
 Thu, 16 Jan 2020 16:35:34 +0000 (UTC)
Subject: Re: [PATCH v2 83/86] tests:numa-test: make top level args dynamic and
 g_autofree(cli) cleanups
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-84-git-send-email-imammedo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <20e88588-13b4-8c7d-3f97-cb2d50b85edd@redhat.com>
Date: Thu, 16 Jan 2020 17:35:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-84-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: H5RK8sLqPJ-Nndu_GiGAlg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: lvivier@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/01/2020 16.07, Igor Mammedov wrote:
> Use GString to pass argument to make_cli() so that it would be easy
> to dynamically change test case arguments from main(). The follow up
> patch will use it to change RAM size options depending on target.
>=20
> While at it cleanup 'cli' freeing, using g_autofree annotation.

Hmm, I'd use g_autofree for new code or do it in a separate cleanup
patch, but doing this here distracts quite a bit from the real changes
that you are doing...

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> PS:
>   made as a separate patch so it won't clutter followup testcase changes.
>=20
> CC: thuth@redhat.com
> CC: lvivier@redhat.com
> ---
>  tests/qtest/numa-test.c | 38 ++++++++++++++------------------------
>  1 file changed, 14 insertions(+), 24 deletions(-)
>=20
> diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
> index 17dd807..a696dfd 100644
> --- a/tests/qtest/numa-test.c
> +++ b/tests/qtest/numa-test.c
> @@ -14,16 +14,16 @@
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qlist.h"
> =20
> -static char *make_cli(const char *generic_cli, const char *test_cli)
> +static char *make_cli(const GString *generic_cli, const char *test_cli)
>  {
> -    return g_strdup_printf("%s %s", generic_cli ? generic_cli : "", test=
_cli);
> +    return g_strdup_printf("%s %s", generic_cli->str, test_cli);
>  }
[...]
> @@ -539,11 +529,11 @@ static void pc_hmat_erange_cfg(const void *data)
> =20
>  int main(int argc, char **argv)
>  {
> -    const char *args =3D NULL;
> +    g_autoptr(GString) args =3D g_string_new("");

I think g_string_new(NULL) would be better?

>      const char *arch =3D qtest_get_arch();
> =20
>      if (strcmp(arch, "aarch64") =3D=3D 0) {
> -        args =3D "-machine virt";
> +        g_string_append(args, " -machine virt")>      }

Is this really required? Looking at your next patch, you could also
simply do

          args =3D " -object memory-backend-ram,id=3Dram,size=3DxxxM"

there? So using a GString seems overkill to me here.

 Thomas


