Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA31C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5C921882
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnOBL71z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5C921882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSmvF-0003mD-Sz
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 13:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iSmuL-0002s6-Sq
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:53:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iSmuK-0002A2-GC
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:53:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21728
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iSmuK-00029r-CL
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573152803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s1GLFciaNNkYl0YRTMxeZF+170AZctfSW4kCWmqV1wE=;
 b=ZnOBL71zQbxEOCjlNo/nlIMdtKNeyXQ0RxTy+OIGX4k1+PbboQ/ICFHxX4wRujBJHR9j1c
 3yEe0xWBCnJP1qzNvVBGF3XWLvsNyJu8h7exqPlIxxzeyiJs+DC3aUE8PBc7jr1SvTNi8C
 EDLBHGDdBn8E4sQci9jA10V+2UuK2w8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-NJyGioWhODe5q8H-ZkwRPw-1; Thu, 07 Nov 2019 13:53:20 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28717107ACC4;
 Thu,  7 Nov 2019 18:53:19 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-91.gru2.redhat.com
 [10.97.116.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAD015D6D8;
 Thu,  7 Nov 2019 18:52:48 +0000 (UTC)
Subject: Re: [PATCH v7 4/8] Acceptance tests: use relative location for tests
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-5-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <4eeb56e4-2a64-3c12-d57d-3f6eab26726e@redhat.com>
Date: Thu, 7 Nov 2019 16:52:47 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191104151323.9883-5-crosa@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: NJyGioWhODe5q8H-ZkwRPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Beraldo Leal <bleal@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-ppc@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/4/19 1:13 PM, Cleber Rosa wrote:
> An Avocado Test ID[1] is composed by a number of components, but it
> starts with the Test Name, usually a file system location that was
> given to the loader.
>
> Because the source directory is being given as a prefix to the
> "tests/acceptance" directory containing the acceptance tests, the test
> names will needlessly include the directory the user is using to host
> the QEMU sources (and/or build tree).
>
> Let's remove the source dir (or a build dir) from the path given to
> the test loader.  This should give more constant names, and when using
> result servers and databases, it should give the same test names
> across executions from different people or from different directories.

Completely agree.

>
> [1] - https://avocado-framework.readthedocs.io/en/69.0/ReferenceGuide.htm=
l#test-id
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/Makefile.include | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

- Wainer

>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 56f73b46e2..65e85f5275 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1180,7 +1180,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
>               --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_RE=
SULTS_DIR) \
>               --filter-by-tags-include-empty --filter-by-tags-include-emp=
ty-key \
>               $(AVOCADO_TAGS) \
> -            --failfast=3Don $(SRC_PATH)/tests/acceptance, \
> +            --failfast=3Don tests/acceptance, \
>               "AVOCADO", "tests/acceptance")
>  =20
>   # Consolidated targets


