Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95C4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE39521019
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE39521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7a5b-00058U-03
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 02:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i7a4x-0004fM-AL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i7a4w-0007QG-3x
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:56:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i7a4v-0007Q0-Uq
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:56:42 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D059E970DD
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 06:56:40 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id j2so329682wre.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 23:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KGhdGEwkp1Yz9vQK/2vSRY1GNV2dMR9xyrLoEKPDqwk=;
 b=gPhR5xbpgKMmvxxlKxQwXnHuXdDhYvu6+xruo3nQdtR+fQw4JfgK9u4JCR1A2Nh/M1
 7Qdvh8t22QXyORuuBVTSgER8Ln6pWlmxEKrebYugaZFhog4GYWtk9s32lN7q5cNhJ3Zg
 U4q63f7l+1aGtV0HL0nEVsSjS0PRPm8BNRVQojq04UmsRDTi7uLb+7FPYyrsPVTQgBXF
 irA8FzxSVrB1ZykqkE7sgxCAPe2Y0YAWiIV9WXEVssPUpt5b5l7EsUqhVHvWK2A+L3BM
 gDsT7LZbJnRxo3Bwb4498lyORaSRMrXITsevT+OiNeXRcQJxTnLvf+KbHncYztK8mGNm
 1Xbg==
X-Gm-Message-State: APjAAAV/mcxZgw8mMlafqMX5UcTQ59IG6ZLtqUhv7aavyizNSKjUMbFO
 4r1bUAeRRAM6fME1X6qiTjQjbkPIKIrCEfe+MZkBzcW4GAesu4KX0+J7Bb+9nTMmWVKYPM+/LTB
 1/cYJZYE76qkipjg=
X-Received: by 2002:adf:fac3:: with SMTP id a3mr2760581wrs.24.1568098599673;
 Mon, 09 Sep 2019 23:56:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw3Yz1JXpqhlJKXbOUX0OCAaUAuqvUFSrnKJTqjuLzJD0m7Q0ueeFE338D/M9BHYuEoQo6EDg==
X-Received: by 2002:adf:fac3:: with SMTP id a3mr2760556wrs.24.1568098599502;
 Mon, 09 Sep 2019 23:56:39 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id b184sm3983697wmg.47.2019.09.09.23.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2019 23:56:38 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <53649ed1-4b7b-46df-4fa8-f9b1e4f208b8@redhat.com>
Date: Tue, 10 Sep 2019 08:56:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190910063724.28470-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 01/16] scripts/git.orderfile: Match QAPI
 schema more precisely
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/19 8:37 AM, Markus Armbruster wrote:
> Pattern *.json also matches the tests/qapi-schema/*.json.  Separates
> them from the tests/qapi-schema/*.{err,exit,out} in diffs.  I hate
> that.  Change the pattern to match just the "real" QAPI schemata.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/git.orderfile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/git.orderfile b/scripts/git.orderfile
> index ac699700b1..e89790941c 100644
> --- a/scripts/git.orderfile
> +++ b/scripts/git.orderfile
> @@ -19,11 +19,11 @@ Makefile*
>  *.mak
> =20
>  # qapi schema
> -*.json
> +qapi/*.json
> +qga/*.json
> =20
>  # headers
>  *.h
> =20
>  # code
>  *.c
> -
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

