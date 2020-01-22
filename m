Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770AEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 09:14:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DF524655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 09:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeRf2IMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DF524655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuC5s-0000F7-Fw
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 04:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuC3T-0006U6-NZ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:12:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuC3R-0001VE-U3
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:12:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40181
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuC3R-0001Uy-PH
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579684325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=41Srd/DnnoueRDF3hsdQOIWBuErq2X/BeF3ubBHY2Ug=;
 b=PeRf2IMm3JCJNqhkQQk/HS3QRgudAE8Po9KAsDNGpg2pC61n/g0w6PS9AEkca4MO6jol9r
 maJG9h6cpNu9fXSIwXXTYZ+DyHqaSoZMXjcmMpNZlfFVTyDxOiQsdX6tMOYCmPWBIqTSer
 N+Hvz129ThIlwmBgcsMQ0CoqoIUMpJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-WsxbEnqaMNy1y2ATKI2bhA-1; Wed, 22 Jan 2020 04:12:03 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AFBD800D48;
 Wed, 22 Jan 2020 09:12:02 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EB79100164D;
 Wed, 22 Jan 2020 09:11:56 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] travis.yml: Enable acceptance KVM tests
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200122012753.9846-1-wainersm@redhat.com>
 <20200122012753.9846-5-wainersm@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c0b54b05-06da-4f53-fd0c-0ca25d98eee5@redhat.com>
Date: Wed, 22 Jan 2020 10:11:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200122012753.9846-5-wainersm@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: WsxbEnqaMNy1y2ATKI2bhA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, ehabkost@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/01/2020 02.27, Wainer dos Santos Moschetta wrote:
> Some acceptance tests require KVM or they are skipped. Travis
> enables nested virtualization by default with Ubuntu
> 18.04 (Bionic) on x86_64. So in order to run the kvm tests, this
> changed the acceptance builder to run in a Bionic VM. Also
> it was needed to ensure the current user has rw permission
> to /dev/kvm.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  .travis.yml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 6c1038a0f1..c3edd0a907 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -2,6 +2,7 @@
>  # Additional builds with specific requirements for a full VM need to
>  # be added as additional matrix: entries later on
>  dist: xenial
> +sudo: true
>  language: c
>  compiler:
>    - gcc
> @@ -83,6 +84,9 @@ git:
>  
>  before_script:
>    - if command -v ccache ; then ccache --zero-stats ; fi
> +  - if [[ -e /dev/kvm ]] && ! [[ -r /dev/kvm && -w /dev/kvm ]]; then
> +        sudo chmod o+rw /dev/kvm ;
> +    fi
>    - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>    - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
>  script:
> @@ -272,12 +276,13 @@ matrix:
>          - TEST_CMD="make check-acceptance"
>        after_script:
>          - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
> +      dist: bionic
>        addons:
>          apt:
>            packages:
>              - python3-pil
>              - python3-pip
> -            - python3.5-venv
> +            - python3.6-venv
>              - tesseract-ocr
>              - tesseract-ocr-eng

I'm surprised that the chmod is sufficient enough here (since I was
having trouble with that in the kvm-unit-tests), but it seems to work,
indeed:

 https://travis-ci.com/huth/qemu/jobs/278226646#L3762

So:
Tested-by: Thomas Huth <thuth@redhat.com>


