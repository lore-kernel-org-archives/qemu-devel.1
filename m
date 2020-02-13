Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B5CC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 20:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589542465D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 20:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLouCIat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589542465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2L2f-0001xL-Fl
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 15:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1j2L1s-0001W1-3l
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1j2L1p-0003V5-NC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:24:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43928
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1j2L1p-0003PY-9v
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581625443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2IicUNsUu02N5jrG2mBmQhIdyCTShodZwM9dDIE49g=;
 b=aLouCIatg5HYG4aftW8TqZ6AnbVspBLmlbQwh+3ZsIr40Qi5HhUKzaG4wF2W+Bybuhgcpf
 lIePb5PIf24UGeZd3u+aZ1+9mPedDOTWSnRdimMpidx1ncv2otvda41YBgHi5tKLYRImuY
 q9fPi27MJxw8IxfWY2UY5s3O9K1+AD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-sjidpGmiNsarW0rbWkT_TA-1; Thu, 13 Feb 2020 15:23:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F93B107ACC5;
 Thu, 13 Feb 2020 20:23:56 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-24.gru2.redhat.com
 [10.97.116.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CCEA5C131;
 Thu, 13 Feb 2020 20:23:49 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance/ppc_prep_40p: Do not run NetBSD test by
 default
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200211131948.26142-1-philmd@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <314af1aa-f584-4465-0ce5-3dd9cbec5df5@redhat.com>
Date: Thu, 13 Feb 2020 18:23:47 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200211131948.26142-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: sjidpGmiNsarW0rbWkT_TA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-ppc@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2/11/20 11:19 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> The ftp.netbsd.org server is slow and downloading the NetBSD ISO
> takes too long. Do not include this test in the default suite.
>
> Similarly to commit 471c97a69b:
>
>    Currently the Avocado framework does not distinct the time spent
>    downloading assets vs. the time spent running a test. With big
>    assets (like a full VM image) the tests likely fail.
>
>    This is a limitation known by the Avocado team.
>    Until this issue get fixed, do not run this tests automatically.
>
>    Tests can still be run setting the AVOCADO_TIMEOUT_EXPECTED
>    environment variable.
>
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   tests/acceptance/ppc_prep_40p.py | 1 +
>   1 file changed, 1 insertion(+)


LGTM.

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep=
_40p.py
> index b27572f212..efe06037ba 100644
> --- a/tests/acceptance/ppc_prep_40p.py
> +++ b/tests/acceptance/ppc_prep_40p.py
> @@ -61,6 +61,7 @@ def test_openbios_192m(self):
>           wait_for_console_pattern(self, '>> CPU type PowerPC,604')
>  =20
>       @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI'=
)
> +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeo=
ut')
>       def test_openbios_and_netbsd(self):
>           """
>           :avocado: tags=3Darch:ppc


