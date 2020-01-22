Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6CFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A9421569
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TE87iXJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A9421569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGNJ-0001e1-8E
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 08:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuGMM-0000ow-B6
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:47:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuGML-0001Xo-Al
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:47:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36326
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuGML-0001XW-6r
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579700872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=OJgdX1ErAQGzFQrvBfAIUodKMdV1ZF9cAksyUZ8gs1o=;
 b=TE87iXJWKl+txhj06N0roaXketX5b2JNYlsSBnN1AlDSvOsFZpC1fZ381zh1JXyj77YaNW
 8v5jZuZH+yQsldldddJtGGZln6sVI4JuAT6SpeXjsNJ44PrQI65W805gkDSHAFXK6v408m
 4K55VpHNDHv9E6PqjcXebf2OPNZFDeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-uydaFmu_Noq1g44c_6-PVg-1; Wed, 22 Jan 2020 08:47:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 568BC477;
 Wed, 22 Jan 2020 13:47:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66CC85DA80;
 Wed, 22 Jan 2020 13:47:34 +0000 (UTC)
Subject: Re: [PATCH 1/1] travis.yml: Install genisoimage package
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200110191254.11303-1-wainersm@redhat.com>
 <20200110191254.11303-2-wainersm@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <67a6e23d-c3c5-4a99-27db-e273e9d753c7@redhat.com>
Date: Wed, 22 Jan 2020 14:47:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200110191254.11303-2-wainersm@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: uydaFmu_Noq1g44c_6-PVg-1
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
Cc: fam@euphon.net, philmd@redhat.com, John Snow <jsnow@redhat.com>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/01/2020 20.12, Wainer dos Santos Moschetta wrote:
> The genisoimage program is required for tests/cdrom-test
> tests, otherwise they are skipped. The current Travis
> environments do not provide it by default, so let's
> explicitly require the genisoimage package.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  .travis.yml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 6c1038a0f1..131c920255 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -51,6 +51,8 @@ addons:
>        - sparse
>        - uuid-dev
>        - gcovr
> +      # Tests dependencies
> +      - genisoimage
>  
>  
>  # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
> @@ -383,6 +385,8 @@ matrix:
>            - libusb-1.0-0-dev
>            - libvdeplug-dev
>            - libvte-2.91-dev
> +          # Tests dependencies
> +          - genisoimage
>        env:
>          - TEST_CMD="make check check-tcg V=1"
>          - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS}"
> @@ -412,6 +416,8 @@ matrix:
>            - libusb-1.0-0-dev
>            - libvdeplug-dev
>            - libvte-2.91-dev
> +          # Tests dependencies
> +          - genisoimage
>        env:
>          - TEST_CMD="make check check-tcg V=1"
>          - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},ppc64le-linux-user"
> @@ -441,6 +447,8 @@ matrix:
>            - libusb-1.0-0-dev
>            - libvdeplug-dev
>            - libvte-2.91-dev
> +          # Tests dependencies
> +          - genisoimage
>        env:
>          - TEST_CMD="make check check-tcg V=1"
>          - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


