Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAA0C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5AB12133D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AB12133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58183 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUEQH-0003Z9-V4
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 13:56:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hUEPG-0002ul-73
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hUEPD-0006Cg-HQ
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:55:00 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:51972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hUEPD-0006BI-B3
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:54:59 -0400
Received: by mail-wm1-f46.google.com with SMTP id f10so2798592wmb.1
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 10:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:cc:to:from:subject:openpgp:message-id:date
	:user-agent:mime-version:content-language:content-transfer-encoding;
	bh=dFK1ghyt7+Sob8e2l/Bq5kP5yvZs12bJrrYbZdXLeY4=;
	b=Xmkxn4pu7L7tRSFojWtTUE1c0XZ4YrvJ4H0QTvTUW9EHqfdGk1yYaE2doLz39vDKTO
	Tx5ue3qWynmgfaOhzTuosCBJeMVUAbkdOvMFrbadsKRFPuR7z54JBJUvyh9Eile0N3p8
	u6xo44lG0Ip27pNm0cJodMcD7iWvckMtlswY6OSppYwYRnhb+JxtLLpolkL5bXtC8c66
	g2JvL+vfwrG1s7c7ww3Yfd4tNI6+gdWDLpTXIX62gdkawzwEHZCCo90fYXyS4z5KKE2Q
	ErqxAdRiZ3wLGDVTv5Jaw0/sAdF7RUR3HHkryGv1xvM1fFBvEVoob4RWhuUfyc20MrWd
	Z1aQ==
X-Gm-Message-State: APjAAAWNtPyRkFrFcqf4ABD07KOfmrDisMVBTG6Aylx1wuGp9tP3q/GW
	kDNkCEmuzNfKGmKx7s08s+JdOw==
X-Google-Smtp-Source: APXvYqwaUN48G6j60NDO2fv0f9r8yNxui4yGtJcEiVeRrVqbkcQu3OKKN16bj2s2P+4+Y+oi30gGhA==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr872484wmb.168.1558720498243; 
	Fri, 24 May 2019 10:54:58 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	s127sm3221243wmf.48.2019.05.24.10.54.56
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 10:54:57 -0700 (PDT)
To: Christian Borntraeger <borntraeger@de.ibm.com>,
	Markus Armbruster <armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <51df31ee-54a1-d7be-bef4-71ae003b8811@redhat.com>
Date: Fri, 24 May 2019 19:54:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.46
Subject: [Qemu-devel] hw/s390x/ipl: Dubious use of qdev_reset_all_fn
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
	Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Christian,

I'm having hard time to understand why the S390_IPL object calls
qemu_register_reset(qdev_reset_all_fn) in its realize() method, while
being QOM'ified (it has a reset method).

It doesn't seem to have a qdev children added explicitly to it.
I see it is used as a singleton, what else am I missing?

Thanks,

Phil.

