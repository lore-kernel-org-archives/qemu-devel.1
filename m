Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6981BCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4316F20869
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4316F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRh4b-00043D-Fe
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 13:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iRh3d-0003D2-3j
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:26:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iRh3b-0001sS-Sn
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:26:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iRh3b-0001sE-K1
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:26:27 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B807F59455
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 18:26:26 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id b4so10737542wrn.8
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 10:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jEwZitOhASGI6jfO+IEKmX4rfZ1KHdUOxXglec9ylnQ=;
 b=DrQEM1HwSw69ummGaDAybfXZeLnvYOZNQBaJ7EmwIFObAxSLrz16D29R8encB8ac7M
 dL7lPsk1h7HNsVCZ78Jx+PQk24PJ2Z090GpUoTohDrFv2xJsgeTcs1nHtPHBmLylai59
 Io5qLqqbIsYLMG+jJTmW6uArclA9KE8wV6RVNupezdkHfBzM9YTnFbSXDOo96S9/6TA2
 KC9pRCcdU/+7MOGLhSTwcbCJdsqGCpG4a4kIV6Ij4a3pXRxPKFnY3wgSDwPAELnvIdim
 wIVBGwoG5e2qpX53MT+0sFsP7mKq56lXk6x7SnBLh2fKltJZd1Ts8S4GJ3sC0bv9B6UP
 IU1w==
X-Gm-Message-State: APjAAAVe+bXylCqBcVY+AYD0Mjwv7VStnhLRPbxxs+ng+y/cH5uSbxIh
 aEkrnCHprl1IiZBwb3Hw7qAek2v2iSlgw4QYu7xYiIdG6090hikcpGYHcxiJEcndYeGph+siyh7
 YoesvI+jsN01lIyk=
X-Received: by 2002:a1c:2344:: with SMTP id j65mr461217wmj.38.1572891985504;
 Mon, 04 Nov 2019 10:26:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzS16ffa7flNjeHiaFWlh35xbhQf7axhpcmmgEBIKFlgDjQaDVMGBG1BVsOOOpLg2mx+0JB9g==
X-Received: by 2002:a1c:2344:: with SMTP id j65mr461195wmj.38.1572891985288;
 Mon, 04 Nov 2019 10:26:25 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id a8sm20603117wme.11.2019.11.04.10.26.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2019 10:26:24 -0800 (PST)
Subject: Re: [PATCH v7 4/8] Acceptance tests: use relative location for tests
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-5-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <adf94475-b241-e8d9-afd6-2b5992d0b9f9@redhat.com>
Date: Mon, 4 Nov 2019 19:26:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104151323.9883-5-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: Beraldo Leal <bleal@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/19 4:13 PM, Cleber Rosa wrote:
> An Avocado Test ID[1] is composed by a number of components, but it
> starts with the Test Name, usually a file system location that was
> given to the loader.
>=20
> Because the source directory is being given as a prefix to the
> "tests/acceptance" directory containing the acceptance tests, the test
> names will needlessly include the directory the user is using to host
> the QEMU sources (and/or build tree).
>=20
> Let's remove the source dir (or a build dir) from the path given to
> the test loader.  This should give more constant names, and when using
> result servers and databases, it should give the same test names
> across executions from different people or from different directories.

Can we strip the full path to directory and only keep the filename in=20
the database? (Thinking about out-of-tree tests).

>=20
> [1] - https://avocado-framework.readthedocs.io/en/69.0/ReferenceGuide.h=
tml#test-id
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   tests/Makefile.include | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 56f73b46e2..65e85f5275 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1180,7 +1180,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
>               --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_=
RESULTS_DIR) \
>               --filter-by-tags-include-empty --filter-by-tags-include-e=
mpty-key \
>               $(AVOCADO_TAGS) \
> -            --failfast=3Don $(SRC_PATH)/tests/acceptance, \
> +            --failfast=3Don tests/acceptance, \
>               "AVOCADO", "tests/acceptance")
>  =20
>   # Consolidated targets
>=20

