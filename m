Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038D8C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 07:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B3C20789
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 07:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGjQ0Lsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B3C20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNWEn-0004zr-Da
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 03:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kNWE9-0004TW-0j
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 03:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kNWE7-0001ma-HE
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 03:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601449714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7kUs5d+Zsd2wY/LnTcUI6w/pXXOgggi3joJfi847hNg=;
 b=WGjQ0LsvgfFkPXwNX4P3+mwb6W8YVBkzs/zbkSWuplvbpkPWT7006lw7n106bUHOWNN0EB
 qFJhyZu+fBJVAoJC+QsFOd8g46+6uw9dtbY6qLCittMiMX28SqsHgGbnlUoDHZdT+E/X1h
 1E7l36hi/hFD6UsuUXv3rzajAT69wbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-e6i0tfBfOgCcVxw46at20Q-1; Wed, 30 Sep 2020 03:08:30 -0400
X-MC-Unique: e6i0tfBfOgCcVxw46at20Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EBD51005E64;
 Wed, 30 Sep 2020 07:08:28 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-148.ams2.redhat.com [10.36.112.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34D5473678;
 Wed, 30 Sep 2020 07:08:25 +0000 (UTC)
Subject: Re: [PATCH v4 01/12] accel/tcg: Add stub for cpu_loop_exit()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200929224355.1224017-1-philmd@redhat.com>
 <20200929224355.1224017-2-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b8a687c8-248f-abc5-a046-37e6d84a21c8@redhat.com>
Date: Wed, 30 Sep 2020 09:08:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200929224355.1224017-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Keith Packard <keithp@keithp.com>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/2020 00.43, Philippe Mathieu-Daudé wrote:
> Since the support of SYS_READC in commit 8de702cb67 the
> semihosting code is strongly depedent of the TCG accelerator
> via a call to cpu_loop_exit().
> 
> Ideally we would only build semihosting support when TCG
> is available, but unfortunately this is not trivial because
> semihosting is used by many targets in different configurations.
> For now add a simple stub to avoid link failure when building
> with --disable-tcg:
> 
>   hw/semihosting/console.c:160: undefined reference to `cpu_loop_exit'
> 
> Cc: Keith Packard <keithp@keithp.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  accel/stubs/tcg-stub.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
> index e4bbf997aa..1eec7fb90e 100644
> --- a/accel/stubs/tcg-stub.c
> +++ b/accel/stubs/tcg-stub.c
> @@ -29,3 +29,8 @@ void *probe_access(CPUArchState *env, target_ulong addr, int size,
>       /* Handled by hardware accelerator. */
>       g_assert_not_reached();
>  }
> +
> +void cpu_loop_exit(CPUState *cpu)
> +{
> +    g_assert_not_reached();
> +}
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


