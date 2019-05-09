Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B763BC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 23:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8055D20989
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 23:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q41kKpB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8055D20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33917 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOs3v-0007Qc-Og
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 19:02:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOs31-00075f-4u
	for qemu-devel@nongnu.org; Thu, 09 May 2019 19:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOs30-0006UJ-AF
	for qemu-devel@nongnu.org; Thu, 09 May 2019 19:01:55 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOs2z-0006Ti-Kx
	for qemu-devel@nongnu.org; Thu, 09 May 2019 19:01:54 -0400
Received: by mail-pf1-x443.google.com with SMTP id 10so2089275pfo.5
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 16:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=fQ0fJ3BpmsoRpSWmJsQf9gAeBoJRo+AWJrSZ1+uijU0=;
	b=q41kKpB7WSKhgBqgw0V+XBM1C+muG+qpqAxKu6m0YJ/7V2o+xd4Q2rOhW1oiTonJqn
	E1sVb7mIkVHXKT4Yp9MaCgAVfIt44tnAFhwStlbbS+VRMqMJloQt27+vnIQxOdl8777W
	qwi6sYSRiKw2xaojWFQ5H4t7RSw9ypKCj8cD7LEaJd5mrpne2FOqjxwP0/BUJen1h42q
	/+bON9JCa4lDDVH19kZ++/dCuG5YAs7tXd0w07wf2TGxzy2jZI2PMOgmlbjUwh/Nm1ja
	nbQXsp+Sb9eByU//Uwzf9fw2YPVCnJEOFjJlAkTU43IVDxGLlFfGTH8naYUf89GuByN3
	uIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fQ0fJ3BpmsoRpSWmJsQf9gAeBoJRo+AWJrSZ1+uijU0=;
	b=PV1cJB/ZLfqXXxIQ3Uqwvm+C3aweaTs3XiH9RbLIl6wPme4a0SysWKlWZ+S8AtGz+v
	6naHAi6C0kM255HSOa3auuBy0JsiF8OB6UHO8JaMWDQy082xu8iSjlT73IlZwDaZ3ATc
	QVQXYVEo1LnP4YYnJdfdr8MAcbqwS8hRe0IVpDr38j9IjZcvHSfDdWUm4AgvfkNoVAqt
	5TB04+LS11nMZe5ltt/soNIhbF2IyiB4wq4ob0hzkuBFov9DmOWLxwXI2grpt7JFmQE7
	CjDEaDre8kkZwuGX9kXT/8Mg74Mtu6dk24saaabSsRljb4DjdYvaFvaS2xH2kyDhVUp6
	6jAQ==
X-Gm-Message-State: APjAAAV3r4ti7dfIhe+dXm702B5/1Z/s4OUSBI3HCPWdQ/POdArU3WvZ
	gfzjSDpjAmbH6Y2x9+F0d2eL3A==
X-Google-Smtp-Source: APXvYqx2Kj8DJcctdNuHhQfKLozFXF4VnzfsJtJRMqttzDVpt8SvhXW5PcaCmZZE96UTOudfcq7KnQ==
X-Received: by 2002:a65:44c8:: with SMTP id g8mr9177864pgs.443.1557442911664; 
	Thu, 09 May 2019 16:01:51 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	x19sm3799654pga.4.2019.05.09.16.01.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 16:01:50 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190509165912.10512-1-alex.bennee@linaro.org>
	<20190509165912.10512-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c5e5f77c-613d-218c-4d75-2e0b62ca3cf1@linaro.org>
Date: Thu, 9 May 2019 16:01:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509165912.10512-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v1 12/23] .travis.yml: enable
 aarch64-softmmu and alpha-softmmu tcg tests
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
Cc: Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 9:59 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

