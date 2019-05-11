Return-Path: <SRS0=nJ0+=TL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB34EC04A6B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 00:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F1A7217D7
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 00:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqaSsG8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1A7217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51803 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPFcN-00011G-Ea
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 20:11:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hPFbU-0000Qx-Px
	for qemu-devel@nongnu.org; Fri, 10 May 2019 20:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hPFbU-0002d7-1R
	for qemu-devel@nongnu.org; Fri, 10 May 2019 20:11:04 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:35654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hPFbT-0002cc-Rl; Fri, 10 May 2019 20:11:03 -0400
Received: by mail-ed1-x542.google.com with SMTP id p26so7421041edr.2;
	Fri, 10 May 2019 17:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=GA4jyekjY6xXU5QxQG4iMKgvD1YOHe3YtFrceeyDa4g=;
	b=FqaSsG8D8FnVfT8nSZcZfALbZvbSvx8J3Nwzv3ZwiyklEp0VSK9e4arKfJdQ6Ngvcs
	6hnb0qBH8fanYwxBbMZhSJ0CIxlOy7oOa6FSVPfHex7bw1LHsg1y/rYXGliJjevDY/vm
	cnp6VlZp3VWFoaiZHsb0LN0o9MKhO0Wl947+OqVsTFQg/5RwnPiMJFCLx+OuCwHOyoBx
	yL+sFSnq0iPNzCWKF0+iOKV9LywexGfRsEoxuLKBN13y/7PsEqCFLTPvBfqSmNEyaAMz
	I+9AOFB6vW0gWGzo+I1k8rTTMIL5bEAsWFxq/jKw4hDZWanZHtJyW3Nu+Ng5sH4VXPao
	Jw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=GA4jyekjY6xXU5QxQG4iMKgvD1YOHe3YtFrceeyDa4g=;
	b=mjG6hrBTJcUpdbIsTWSUzm1wum3mcjRmo6IaLk/80uWnIu+WJg29Eqj54ZmjghdCUz
	QrqDhne6mp6fxiqLKmZRBOyNZtzuu1wT54e0+K59CmfQWXgcfxWwy2/cvSIg+8TfNhdD
	/uic6jg3flKtu7zHeZLslndn9zuzJcsQhcwaJyk9RGnx7UO/N1rDKvx1dMJiUocEpHVa
	bzCDOcqJoY5kEEmiEOHEWP7kLPV8g+FmtjfixHvRgdhzffkQl4nJZWq0hEJSW/P1HgAk
	IBGroEhUIQzhZsU4N+DzkKgA/dHoXnMbN+U6hgs6EBMRPkFYoh9EtF7N/kWrdjVXcFVf
	t9cA==
X-Gm-Message-State: APjAAAX/hrSFpms1f3ULLlFUhYS18J/728Pow/IU8aswaxLOk8Ck546C
	H4q3/2uFh9mzEuoQLGZcQPA=
X-Google-Smtp-Source: APXvYqykI0OTs4kH+e6Rz/og8QU+cJFqA1RsZPFTNQEiPFjrGQ5H5P4h0JvHM7K3MsWXLiU+0OxyVg==
X-Received: by 2002:a17:906:6408:: with SMTP id
	d8mr11393182ejm.185.1557533462408; 
	Fri, 10 May 2019 17:11:02 -0700 (PDT)
Received: from localhost ([185.92.221.13])
	by smtp.gmail.com with ESMTPSA id 65sm1819643edk.88.2019.05.10.17.10.58
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 17:11:01 -0700 (PDT)
Date: Sat, 11 May 2019 00:10:56 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190511001056.o3owpr3kll4unnic@master>
References: <20190419003053.8260-1-richardw.yang@linux.intel.com>
	<20190510212210.4ao2zoikky7jivwc@master>
	<20190510195932-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510195932-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v4 0/6] Extract build_mcfg
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
	Wei Yang <richard.weiyang@gmail.com>, shannon.zhaosl@gmail.com,
	qemu-arm@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
	imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 07:59:43PM -0400, Michael S. Tsirkin wrote:
>I merged this will send pull request soon.
>

Ah, Thanks :-)

-- 
Wei Yang
Help you, Help me

