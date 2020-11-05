Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D88C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC481206D9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guXmt7u7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC481206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kagm2-0001qc-Np
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 10:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kagjr-0000XG-8G
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:59:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kagjp-0007BW-M2
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604588383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gvo9RqVoy+Fy452fyzDZz+vtXYHbi3dU9kOp1w3QHhI=;
 b=guXmt7u7vZKLkm5WNdJqTmhtD7TrFuk6gY2eQH5P8umn6ePIyTdK7RkUAZj2UlUCkb8Td1
 +tYoazNDTagZlaoBHzjb2dDQX54wIlJWsTc6ga67yWj8NZlZ3+1Gzau5WDNsBozp8R+ae4
 gl73nLnkeNKnqtL+CvaXE/r+YCIehsk=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-KDelP34DPlStSteYYFk-QQ-1; Thu, 05 Nov 2020 09:59:41 -0500
X-MC-Unique: KDelP34DPlStSteYYFk-QQ-1
Received: by mail-io1-f71.google.com with SMTP id y17so1286587iot.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 06:59:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Gvo9RqVoy+Fy452fyzDZz+vtXYHbi3dU9kOp1w3QHhI=;
 b=m7V2O9qmYanbKJNboKxCpzDqGZcOA2ySHyQFRYYVS8BhBL9Uhu8DTRzLm15PDL3Kj8
 NKKAxKSMYiNprrmBEWngCZ7fVw7rO4vLE+EzyoxtUTUYJ6oX9EC6JFtFK7GBVWRuDZL2
 NScWflyY5jx6j0tQ64bzJQewvSZpSt6/F5McH4xxKnbbLbCIw+FrZr63EQrYh3iD7Cy0
 hnEn3+reWElxtlxudNz9DzMvFnhwe56dwfSVyb1hTk6UHxKGbNCUeFcD5kCj8/OGUFE0
 jgx41LWe16NCckv4uBIDOBHY2GZ9tcxFV82erzDJzGU0cGGwcUwf4JfasHoGpMa7c3SX
 8ACw==
X-Gm-Message-State: AOAM533M0anNMZmSERYZRr8+ADch3Sva1mUnnDaQQqFyafFn5HTTE+hw
 86jZ39OgEw+Anh7ZPElEumfk0JIsxNwsFSdTAmwGcF9Lk8kcJ97tuXlYGQjBjpg8bWum1q6tHBN
 Y5og/WCXmX6lAMnp2swng9K7GmdDXfJs=
X-Received: by 2002:a02:6a25:: with SMTP id l37mr2350589jac.70.1604588381271; 
 Thu, 05 Nov 2020 06:59:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFxOR63Ph7WsCM5gQjf62LXUJDS/xSERt/33J9cUZa9K5hb5IF0lQMcS0LUbSm5OI/ONt2vK/K/U3hhhcuPIk=
X-Received: by 2002:a02:6a25:: with SMTP id l37mr2350567jac.70.1604588380984; 
 Thu, 05 Nov 2020 06:59:40 -0800 (PST)
MIME-Version: 1.0
References: <1249e3b862a119bdcba74f8f052222cc28de988d.1604588274.git.crobinso@redhat.com>
In-Reply-To: <1249e3b862a119bdcba74f8f052222cc28de988d.1604588274.git.crobinso@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 5 Nov 2020 18:59:30 +0400
Message-ID: <CAMxuvazAjpFircbEYM698GLm_L7OYApATVuvQeS885u6sEXr1A@mail.gmail.com>
Subject: Re: [PATCH] configure: Fix gio detection
To: Cole Robinson <crobinso@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Nov 5, 2020 at 6:58 PM Cole Robinson <crobinso@redhat.com> wrote:
>
> Signed-off-by: Cole Robinson <crobinso@redhat.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 2c3c69f118..bc06aa81e5 100755
> --- a/configure
> +++ b/configure
> @@ -3499,7 +3499,7 @@ if $pkg_config --atleast-version=$glib_req_ver gio-2.0; then
>      # with pkg-config --static --libs data for gio-2.0 that is missing
>      # -lblkid and will give a link error.
>      write_c_skeleton
> -    if compile_prog "" "gio_libs" ; then
> +    if compile_prog "" "$gio_libs" ; then
>          gio=yes
>      else
>          gio=no

it's queued already "[PULL 12/20] configure: fix gio_libs reference"

thanks


