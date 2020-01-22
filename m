Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FDFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 09:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CCD424656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 09:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONU7klXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCD424656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuCEP-0005Dt-Ku
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 04:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuCDk-0004dz-W9
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuCDj-0005Fr-U5
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:22:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43814
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuCDj-0005Fi-Pi
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579684963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=pEHattFXHbNItRJfjczm6Cz4eTdvS8wCWm3BHHsMAus=;
 b=ONU7klXyaN/QH07nSMqWW/RTAw9hS48YTxhs80Ay8BidBJsTbVm8IIAzZqXm/lVWGFbMbX
 Edo/X5QanoKIZqTj8S2E7nazqKbsvP0A5R/AxeYKlMTcPP7cVPd1wnppHCNtdC+Hv3yy3x
 /sNVuYYqVzBKteLwCwUl3yjIwR86aEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-7pv5ha0LNHWVz25aabTeSg-1; Wed, 22 Jan 2020 04:22:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B08818A6EC2;
 Wed, 22 Jan 2020 09:22:40 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 853E363742;
 Wed, 22 Jan 2020 09:22:34 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] travis.yml: Enable acceptance KVM tests
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200122012753.9846-1-wainersm@redhat.com>
 <20200122012753.9846-5-wainersm@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2425f078-578a-f76b-b815-945a58cd1309@redhat.com>
Date: Wed, 22 Jan 2020 10:22:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200122012753.9846-5-wainersm@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 7pv5ha0LNHWVz25aabTeSg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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

By the way, in case you respin, could you please use singel "[" instead
of "[[" ... since that's what we use in almost all other shell scripts, too.

 Thomas


