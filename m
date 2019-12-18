Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFA8C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 06:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1BE20717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 06:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaNivfk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1BE20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihStn-000392-Qv
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 01:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ihSt9-0002d8-Ld
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 01:32:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ihSt6-000190-I2
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 01:32:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40132
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ihSt6-00016t-5u
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 01:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576650767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=1KKn6U+/ywUnPKKL8LJsqgLOyVqm7OJXYIGf2lnOawg=;
 b=eaNivfk+5qqR9vEEOlLyvTfwWGJncb2l1Wof5feGsbto/gSevHcpz9Hr+XA0f/K/AlO1Rd
 mXvTqKJAoEyf96q0XxGvbyLsQPCAK2ydpA5UekhRxUL1IfKQeDrBgWyAidzc1fF/i2QVS+
 6xM+UCWZPSCsXrBno0p/ddj9bgApErw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53--nAnQBo1NkeHyETDJj4EWg-1; Wed, 18 Dec 2019 01:32:44 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87D9C800D48;
 Wed, 18 Dec 2019 06:32:43 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-150.ams2.redhat.com [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79F251891F;
 Wed, 18 Dec 2019 06:32:42 +0000 (UTC)
Subject: Re: [PATCH] docker: gtester is no longer used
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1576632611-55032-1-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <bea5bec3-bf6c-8784-0bf0-038143fffa17@redhat.com>
Date: Wed, 18 Dec 2019 07:32:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1576632611-55032-1-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: -nAnQBo1NkeHyETDJj4EWg-1
X-Mimecast-Spam-Score: 0
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/12/2019 02.30, Paolo Bonzini wrote:
> We are using tap-driver.pl, do not require anymore gtester to be installed
> to run the testsuite in docker-based tests.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/common.rc | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index 512202b..02cd67a 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -53,12 +53,7 @@ check_qemu()
>          INVOCATION="$@"
>      fi
>  
> -    if command -v gtester > /dev/null 2>&1 && \
> -           gtester --version > /dev/null 2>&1; then
> -        make $MAKEFLAGS $INVOCATION
> -    else
> -        echo "No working gtester, skipping make $INVOCATION"
> -    fi
> +    make $MAKEFLAGS $INVOCATION
>  }
>  
>  test_fail()
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


