Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0194CC4BA13
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65AD206E6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gty/SbdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65AD206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6zbA-0003lk-2G
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 11:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j6zaY-0003MN-Eh
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j6zaX-0003rP-7i
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:31:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21809
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j6zaX-0003r9-3f
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582734668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OaBGeW8TV1bZb8T1nGFKsWuLsj8WNbI6c7dU1o7M4oQ=;
 b=gty/SbdI4xg15Vg5AFB198o2Y0b1eqDysZMPgZxhomceQIJyG/+XBzFQy5Fc20dCATrYyr
 kIqMVrM1zmF1+Ec1zPUnA2Wsr8erXwnL9uZQIBrh/3ldJXEz7LTVmjsUIlCe3a5w0T7ODJ
 1DtMoo+vT+fwq+nYfREx043Z/PfB7Hc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-5AXjKZXVMPCUDFdQBzmUsA-1; Wed, 26 Feb 2020 11:31:05 -0500
X-MC-Unique: 5AXjKZXVMPCUDFdQBzmUsA-1
Received: by mail-wm1-f71.google.com with SMTP id c5so786911wmd.8
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 08:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OaBGeW8TV1bZb8T1nGFKsWuLsj8WNbI6c7dU1o7M4oQ=;
 b=cKfplSEPUVqI47PfX0QYk5UrRzS4IUauUcAU3N3CKJ49ifX/auV8K6QAxWyVFjypHh
 UpzC10jNhfAHWZU6T0Reby2IfC/gv9YUEgTTBSSkQUBc0M2uk4O1Y0yXlef3yeALE3Lr
 MjXdDwRTFbiKNOHWulBZn6AT+SkdUHLOQgX2QomryspPnmC/N9Amak7OgmRtlyJbqDNM
 dX/KYVbwx95YTSzxnfArYm4bMLfpfS0se95fuunMCuPxq26UftgBS+eUIPqW3PTREd5g
 hrcXzCRuTtZWgNMP9IAg+F+J3CH+YCRA/Uho6YzO5NRWgroEQbQQz06cWrNG88AUTU+Y
 1rpQ==
X-Gm-Message-State: APjAAAVG2PjLTkRfceZDU31HY9OBecwdV+MhcW+7P00iYKfZ0w6doKWN
 GwMvnpe+HGFKD9lQwIL9DDaS7QsxMQ3MMefjbUw7uLwZvrElk2/W+/eMq0BwysgByV+syp8PbTf
 AFHzVMO8Mg3xSUmA=
X-Received: by 2002:a05:6000:1187:: with SMTP id
 g7mr6403279wrx.109.1582734663970; 
 Wed, 26 Feb 2020 08:31:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqys58DctmkR3RYWPk3Y9g3dPFfoBEsVJGnDT7ZOrSztKtiakXmug+QVpHxhY/DZQuwpSfTMXA==
X-Received: by 2002:a05:6000:1187:: with SMTP id
 g7mr6403246wrx.109.1582734663638; 
 Wed, 26 Feb 2020 08:31:03 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f?
 ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id l6sm3974056wrb.75.2020.02.26.08.31.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 08:31:03 -0800 (PST)
Subject: Re: [qemu-web PATCH] Add GSoC 2020 announcement to blog
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200226152055.75190-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8b25a635-bddb-ef37-0e9c-8d125d4b9593@redhat.com>
Date: Wed, 26 Feb 2020 17:31:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226152055.75190-1-stefanha@redhat.com>
Content-Language: en-US
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/02/20 16:20, Stefan Hajnoczi wrote:
> Let people know that we are participating in Google Summer of Code again
> this year.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  ...-google-summer-of-code-internships-2020.md | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 _posts/2020-02-26-google-summer-of-code-internships-2020.md
> 
> diff --git a/_posts/2020-02-26-google-summer-of-code-internships-2020.md b/_posts/2020-02-26-google-summer-of-code-internships-2020.md
> new file mode 100644
> index 0000000..51c764b
> --- /dev/null
> +++ b/_posts/2020-02-26-google-summer-of-code-internships-2020.md
> @@ -0,0 +1,27 @@
> +---
> +layout: post
> +title:  "Announcing Google Summer of Code 2020 internships"
> +date:   2020-02-26 07:00:00 +0000
> +categories: [gsoc, internships]
> +---
> +QEMU is participating in [Google Summer of Code
> +2020](https://summerofcode.withgoogle.com/) again this year!  Google Summer of
> +Code (GSoC) is an internship program that brings students into open source
> +development.  GSoC offers full-time remote work opportunities for talented new
> +developers wishing to get involved in our community.
> +
> +Each intern works with one or more mentors who support them in their project.
> +Code is submitted through QEMU's open source development process, giving the
> +intern experience in open source software development.
> +
> +If you are interested in contributing to QEMU through a paid 12-week internship
> +from May to August, take a look at [our project
> +ideas](https://wiki.qemu.org/Google_Summer_of_Code_2020) for more information.
> +Applications are open March 16-31, 2020.
> +
> +Please review the [eligibility
> +criteria](https://developers.google.com/open-source/gsoc/faq#what_are_the_eligibility_requirements_for_participation) before applying.
> +
> +QEMU is also participating in the [Outreachy internship
> +program](https://www.outreachy.org/apply/project-selection/#qemu), so be sure
> +to check that out as well!
> 

Applied, thanks.

Paolo


