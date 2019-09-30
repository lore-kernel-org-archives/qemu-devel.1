Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F411CC4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 09:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF12A2086A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 09:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aj3b9xJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF12A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iErlD-0003Sn-UJ
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 05:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iErkR-0002y1-Up
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 05:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iErkQ-00052g-Gh
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 05:13:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:40815)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iErkQ-00051A-9G
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 05:13:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id b24so11809813wmj.5
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 02:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=i9shVhTxaMkIF2Yy9ABNw8gRClszuZyzP3dex/hd/kc=;
 b=aj3b9xJBSbmgw8ylHGWZO9rpKTqJNJPggOffLDaac3xZ0itkN4eWSZ96jxnLSnzpKH
 4jmukYYjAOQn49yi3MewQ4V+mV4gClh6YekuZQ8ZAQKxNNgzmPveALPltCZNiKrJ5vle
 0LQ3rFvFPD+JYOrBUix93qcuNu3C9M+6ajv68uUsjnsnR8nYGcCvr8GXJNiIAnkQbbF1
 Kb/fDOwYkPOGYaEJEHMS0M1Bp4bGFMxPjv3hErqnOHvTLhDVOV/y0Ch6iDZwar1ZgO1O
 b5vwg9shNxb77JVN/TvEo0SJd2Jd+VErWkHLa/eZlb12I2hEfzM6A0Kam3qRaA4CiUYS
 PkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=i9shVhTxaMkIF2Yy9ABNw8gRClszuZyzP3dex/hd/kc=;
 b=U5WWYWvbEHT7QIzaK1Pbi06JafSiFTn3Q7BVqDp/8PguqdNhoVk1kfeiGkmJb7HXl1
 8BxYpwT0x/wyPBVsGLimuyggj6AGVAff6oFsFSxN/aR5Y4lhdpzdyZ3ugONvWC5Zzav7
 VnZty+J3TAhxMTSJhOFTSjzUWdAWUSw2hUwK4BvvJG7uLaox15X8ssu4hoZoeKeIHrE1
 na2BERUlb/Arbyh4rMDU7PxyYWLrdZ6qmKoh7k32lYXdT3U09lvGsjAMAh6Hlqs5mTCo
 ETam12Ilt1zX8z7IJOoI7KlqMziEbUvJsQ66uD2LtqJr+j6pQ9Yrr3bUo8mhyo50R81q
 3Jaw==
X-Gm-Message-State: APjAAAXQMRuTv/FwQeH3k9/M7xctIEz0naaRXWPr2KA0CY1SBzsAhVgw
 oJn0o8CJUbgSpkYPOwbsQSqong==
X-Google-Smtp-Source: APXvYqwjjunEFN8byR/BxpK36o3ru8xk+vxG2pW9Oc+cPy4UjYqyV2GMGJhCWvXZRvRdgNzp9ShJVA==
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr17369494wmt.81.1569834816467; 
 Mon, 30 Sep 2019 02:13:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f17sm10776742wru.29.2019.09.30.02.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 02:13:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 241F51FF87;
 Mon, 30 Sep 2019 10:13:35 +0100 (BST)
References: <87blv2i5ha.fsf@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: Arch info lost in "info cpus"
In-reply-to: <87blv2i5ha.fsf@redhat.com>
Date: Mon, 30 Sep 2019 10:13:35 +0100
Message-ID: <87lfu6kuyo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: imammedo@redhat.com, tao3.xu@intel.com, dgilbert@redhat.com,
 ehabkost@redhat.com, mihajlov@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Sergio Lopez <slp@redhat.com> writes:

> Hi,
>
> Commit 137b5cb6ab565cb3781d5337591e155932b4230e (hmp: change
> hmp_info_cpus to use query-cpus-fast) updated the "info cpus" commit to
> make it more lightweight, but also removed the ability to get the
> architecture specific status of each vCPU.
>
> This information was really useful to diagnose certain Guest issues,
> without the need of using GDB, which is more intrusive and requires
> enabling it in advance.

You can always enable the gdbserver from the HMP when you need it.

> Is there an alternative way of getting something equivalent to what
> "info cpus" provided previously (in 2.10)?

info registers

should give you a full dump of the CPU state including the PC.

>
> Thanks,
> Sergio.


--
Alex Benn=C3=A9e

