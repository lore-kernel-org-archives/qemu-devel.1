Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C36C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 11:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B0020644
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 11:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/JE7N6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B0020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33695 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSgVt-0000g7-OK
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 07:31:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hSgUx-0000JT-0j
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hSgUu-0002nq-6n
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:30:30 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:33621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hSgUq-0002ln-8g
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:30:26 -0400
Received: by mail-pg1-x52d.google.com with SMTP id h17so6683526pgv.0
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 04:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=message-id:subject:from:to:date:mime-version
	:content-transfer-encoding;
	bh=2CfyU5TJNQt7qc4D3IL6bgMjZPzIRTmeHboOlfS9TjE=;
	b=i/JE7N6XgXHz0jlHlrwRT4R47OY2QmpIp2Xkos+t3ftNI/67caW3nlivBOVPrm64Q/
	zDZ/+oXw3+JilRqMddMRLwNw3zEp80yjS0dXCugyqp8BsJCq9n/DfhogJDdNyVGQZ/g8
	o/blTuj7TL6uHyt1ujxVx/jKbNQp7as0NgIODC7Ahtc6Twcgkssp0GUPbK2YqFa/J7EW
	jcXRv7IEHx8FFO63HrBarikhpBqDCE/gFTYEyyrVy6AIBvhn2Hd0/oWavGVHeksCm3Yl
	Qjc9a9OwuEsJkoI8PdrmjZbMXIZHufKMJHIB6WxuHCMRs536+R+drS/MHA9O0V3vqNtU
	kgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:mime-version
	:content-transfer-encoding;
	bh=2CfyU5TJNQt7qc4D3IL6bgMjZPzIRTmeHboOlfS9TjE=;
	b=cf6eZFZCjH2T6Q9tgqgKkrOtQGUrToWqZ9tFHpu783lAhtTEWCbz1+XwyqDJ04DsNp
	Le+FT1R0Da+DvAe8c6ujc3ciY3KnZJots/yxk0SzQrq9JbJfOEWbCBzwhxKjFQ8s1/Xe
	yRUAsHPLaH6ujgiFoH4vHc3QbPcIn7ZLgoVsf8mLVkypnNRaTCUjkuZzlcwOmGfHfP4p
	Ogoi0xixGKQy4/Soa9osyYOmnmK0ZgCBei6sVJ8YqsmjdlKRnspj4MVzgY+bgBzVmW6z
	QBn188La77+lAc1jKgf/yoVULMr2DXVW8FpWZ/2s7BrIsoSGoSTj6F1RWuYUg75SLrAh
	ic2g==
X-Gm-Message-State: APjAAAWdZkGT0YJ4zABO+C8RcrunSgOo4cFdBtVHWpBKkvBpXxd4naCd
	FbLSeefRatB83NNqe2A6clumGPPjRNM=
X-Google-Smtp-Source: APXvYqxLPIXqKwsJqluCBgtvHa64eLWAk1g+0vqqaVtpw+eJlbTZesAR9lLELOeXgKnrEH6ZDb12Zg==
X-Received: by 2002:a65:4544:: with SMTP id x4mr51839417pgr.323.1558351820483; 
	Mon, 20 May 2019 04:30:20 -0700 (PDT)
Received: from am-swift ([120.57.121.233]) by smtp.gmail.com with ESMTPSA id
	z11sm34893189pfg.187.2019.05.20.04.30.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 20 May 2019 04:30:19 -0700 (PDT)
Message-ID: <8c0a113e959cc2419aa52253c261e111ac9caf4a.camel@gmail.com>
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, jsnow@redhat.com
Date: Mon, 20 May 2019 17:00:15 +0530
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52d
Subject: [Qemu-devel] [Bug] Docs build fails at interop.rst
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://paste.fedoraproject.org/paste/kOPx4jhtUli---TmxSLrlw
running python3-sphinx-2.0.1-1.fc31.noarch on Fedora release 31
(Rawhide)

uname - a
Linux iouring 5.1.0-0.rc6.git3.1.fc31.x86_64 #1 SMP Thu Apr 25 14:25:32
UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

Reverting commmit 90edef80a0852cf8a3d2668898ee40e8970e431
allows for the build to occur

Regards
Aarushi Mehta


