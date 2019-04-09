Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B1FC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3038B20833
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDmwW4IF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3038B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38014 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDn2o-0008DI-2L
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 05:27:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hDn22-0007p3-Tn
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hDn22-0005Do-5K
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:27:06 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hDn21-0005Ch-Lu
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:27:06 -0400
Received: by mail-wr1-x442.google.com with SMTP id h4so19910111wre.7
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 02:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding:content-language;
	bh=8Mw77qPG9fd9FzZy9dXdJcPVigNa0ZKUjLv2FyOj5bo=;
	b=iDmwW4IFQCRxMhOFxv1VxG4qciFCOXLZj/eqtZ3N/9H54GtwIDCYKh+g66CGscrq+c
	XQZImwxenaVPuYFFkBofCxBfr2qKRZjKCC/uuxwR6Pew1GvEXm+itUDCQeht55p01uXl
	LwPiys+JUdjbArLTxhTD6Knch6wIwRmiM0j1CmEGPSjaAjJfNrI95D24bXmYGsJE3jdE
	1qCUbVZue7O6T37N/9U9iyTbZ4UevKGbEgR9Mra4BaTXr8zWg3IDl5OLWU4FNyRvTTMf
	9PH/dToZKgNWnbLqKS/0OLK507CX+c0qKAQXz11SX5jSiAadqA3RS0laxoobgGJ93YRO
	2C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=8Mw77qPG9fd9FzZy9dXdJcPVigNa0ZKUjLv2FyOj5bo=;
	b=T7FE9jauzFVSusgOIiPuOioUztGng/g5KZHpmoORENyIryf0VP+y8eeeqMvcC7U1Gs
	lS2aYGe1K+O2Hj/+CMTX0Gi3/XY4BLm5gOHqVJBYeyFm+PFIg3pfYlvH5Z7yUhOL/gKx
	ELtk9EcvrdcYc2jn+bMFoOrW3kflJZ5uh3A5Omoy0oyLu6zA1Sfm8WLOz0YZQNRQLWXq
	hR7Fhe0Oa82B6j/3cmNI1l2NbzAP7pMetkH2ie9ZFWDo3dc239AdOuLh85gQ1AUcZk0V
	5m7ctAusevhOH+q+4965ixgXRdbc5F3pJnYiioV0W74zWQ+EsPwG1tvv2+A91tnh+kLJ
	lI4Q==
X-Gm-Message-State: APjAAAW5ndn7VrxzzNn257n/MkA0o5CsVJu5i/n5rU5/+k7TXFk95RKK
	AReHYAu4V8Kb9hyylC/s9n0=
X-Google-Smtp-Source: APXvYqxlqtFGZ2RvAkM7ydQvxfLjVPjjTXroNukTA4I34MXctckDwkHrjb27rH0FT0dxj4Xf6AE62A==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr18687284wrj.101.1554802024584; 
	Tue, 09 Apr 2019 02:27:04 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id
	x21sm21579340wrd.45.2019.04.09.02.27.03
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 02:27:03 -0700 (PDT)
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>, qemu-devel@nongnu.org,
	Yuval Shaia <yuval.shaia@oracle.com>
References: <20190407115839.25054-1-skrtbhtngr@gmail.com>
	<CAMzgYoODOUz8yJQH1=a_=e8HKEuRFv6UyX0Rost4NfWNxe91KQ@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <2651615a-5722-31f1-23e9-478eaad13099@gmail.com>
Date: Tue, 9 Apr 2019 11:28:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMzgYoODOUz8yJQH1=a_=e8HKEuRFv6UyX0Rost4NfWNxe91KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH RESEND v2 0/2] Move hvf_cpu_synchronize*
 calls to cpu_synchronize* functions
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
Message-ID: <20190409082807.QWX5LEAA0nrotiIU3RoZ2ZZfTuW4Tkfs8I1NT330SRw@z>



On 4/7/19 3:05 PM, Sukrit Bhatnagar wrote:
> Hi,
> Are the patches in good enough shape to be merged?

Hi Sukrit,

Where is the patch itself :) ?

Also be sure to add the maintainers to cc.
You can get them by running ./scripts/get_maintainers.pl script on your 
patch.

Please re-send it.

Thanks,
Marcel

> Thanks,
> Sukrit


