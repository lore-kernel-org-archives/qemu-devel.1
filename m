Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF50BC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 20:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B465320869
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 20:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KijhhCh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B465320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSoTf-0002MK-SU
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 15:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iSoR5-0000MX-15
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 15:31:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iSoR2-0006fe-RG
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 15:31:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35886
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iSoR2-0006dt-LX
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 15:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573158676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XyAKP4mI1v7CAokFg9s/Q02evyxJC7/YMN+q4AJBoXM=;
 b=KijhhCh3NRQEYzslatvLGwVkvXC//hRH6In4sHcQsf9yHCe9HmU/l1AvcTQPnm7TxEo8HF
 md3Gk84AEY2AMgbUXKJTKtww8R1suJS4z6egKGQGTAd9wXMOfDmDkI3xNjgDTdQGuuI/Ss
 wN2qMiVF0fvUsYge45dX9JQPFm3cJ6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-pRMI0WJYMLebpKE57ubZXQ-1; Thu, 07 Nov 2019 15:31:13 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91AD51800D6B;
 Thu,  7 Nov 2019 20:31:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-91.gru2.redhat.com
 [10.97.116.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 413E460BEC;
 Thu,  7 Nov 2019 20:31:04 +0000 (UTC)
Subject: Re: [PATCH v7 7/8] Acceptance tests: depend on qemu-img
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-8-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <3b075001-d6c5-3391-8fe8-515bbfb3d979@redhat.com>
Date: Thu, 7 Nov 2019 18:31:03 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191104151323.9883-8-crosa@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: pRMI0WJYMLebpKE57ubZXQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Beraldo Leal <bleal@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/4/19 1:13 PM, Cleber Rosa wrote:
> Tests using the avocado.utils.vmimage library make use of qemu-img,
> and because it makes sense to use the version matching the rest of the
> source code, let's make sure it gets built.
>
> Its selection, instead of a possible qemu-img binary installed system
> wide, is already dealt with by the change that adds the build dir to
> the PATH during the test execution.
>
> This is based on the same work for qemu-iotests, and suggested by its
> author:
>
>    - https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00951.html
>
> CC: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   tests/Makefile.include | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 65e85f5275..559c3e6375 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1174,7 +1174,7 @@ $(TESTS_RESULTS_DIR):
>  =20
>   check-venv: $(TESTS_VENV_DIR)
>  =20
> -check-acceptance: check-venv $(TESTS_RESULTS_DIR)
> +check-acceptance: check-venv $(TESTS_RESULTS_DIR) qemu-img$(EXESUF)

To be honest, I don't fell comfortable by the fact that the whole=20
acceptance suite will depend on qemu-img which, in reality, is needed by=20
only a sub-set of tests. Besides it, there might be some reason for=20
someone to build QEMU with --disable-tools and this change will end up=20
forcing the qemu-img built (of course if check-acceptance is issued).

What if we instead:

1. Warn the users in case qemu tools weren't built. Alerting that=20
qemu-img and friends will be picked up from system-wide (if any).

2. The tests that rely on avocado.utils.vmimage check for the presence=20
of dependent tools, possible canceling itself on their lack. This may be=20
done at test code level or perhaps using Avocado's tag mechanism +=20
tweaking avocado_qemu.

Thanks,

Wainer

>   =09$(call quiet-command, \
>               $(TESTS_VENV_DIR)/bin/python -m avocado \
>               --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_RE=
SULTS_DIR) \


