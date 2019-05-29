Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B78CC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2388A20644
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2388A20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52366 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVx8p-00011N-CV
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 07:53:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVx7k-0000ZR-Ra
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVx7k-0002q2-1W
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:52:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVx7j-0002pF-Sh
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:52:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so1569786wrv.2
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 04:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ZTEG1A9hFh708M1zX5/vvmE2bvU1rDKOPizZbp8MrkQ=;
	b=QV79fpf/MoVAidREJxZSh9aRbfQpZwgaM8asd8S7gEbaAxDw6qc1hIuxK9gyEXznKl
	t+GFwPfzXs0Z1Pwqlwhudy8hfpdsANbkeEIqS6F6VY9GMfi5veHK1nHw7reodOprvnQU
	9g45PzgnE0FbDfmoLcae28ueluNrKQ2mPMAGdLaaWWVrZN6uvhTB/ph/s3DbQa6KJNg5
	1at2WNHpE4KlfZOkwbJajerxTuuz7LLsD8ktvupSwkJd5sf3tbnVsEfT0n2z1vlz+F2A
	ImZNK1y5B6IGBaFpLG5+WYgGKJM/MaACo62/iVUBX6Eu1EQ4TVZ+3QCdNMQjBk16+MyI
	XlBA==
X-Gm-Message-State: APjAAAVY+iLs4WcU+F9rBYpryPokWpZATrFc7EkyrtfFY75hLFSlx5+7
	shKrtSEGGoinxcIo0PZSTK2M2A==
X-Google-Smtp-Source: APXvYqz/ElahsejX4cbUA01QRYZiWudTpCLEKNNOEtsRQj6yNMBg93ffJK/w1Sz1W739uGDEFMC5LQ==
X-Received: by 2002:a5d:4b81:: with SMTP id b1mr56185324wrt.217.1559130722828; 
	Wed, 29 May 2019 04:52:02 -0700 (PDT)
Received: from [10.32.224.40] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
	[159.63.51.90]) by smtp.gmail.com with ESMTPSA id
	p17sm18162873wrq.95.2019.05.29.04.52.01
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 04:52:01 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190520124716.30472-1-kraxel@redhat.com>
	<20190520124716.30472-13-kraxel@redhat.com>
	<24daf870-9c97-d1e2-47b0-4713aaad38f2@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <699fa2ab-257d-66c8-6810-05cfd5a59280@redhat.com>
Date: Wed, 29 May 2019 13:52:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <24daf870-9c97-d1e2-47b0-4713aaad38f2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v3 12/14] tests/vm: netbsd autoinstall,
 using serial console
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/19 1:32 PM, Philippe Mathieu-Daudé wrote:
> On 5/20/19 2:47 PM, Gerd Hoffmann wrote:
>> Instead of fetching the prebuilt image from patchew download the install
>> iso and prepare the image locally.  Install to disk, using the serial
>> console.  Create qemu user, configure ssh login.  Install packages
>> needed for qemu builds.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> Reviewed-by: Kamil Rytarowski <n54@gmx.com>
>> Tested-by: Thomas Huth <thuth@redhat.com>
[...]
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 

And now:

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

