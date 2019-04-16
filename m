Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4337C282DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 09:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBAC20693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 09:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGv4AX+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBAC20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33987 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGKhu-0001Na-P6
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 05:48:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hGKgz-00010k-Us
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hGKgy-0008S5-Ih
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:47:53 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:41659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1hGKgv-0008P6-No; Tue, 16 Apr 2019 05:47:50 -0400
Received: by mail-qk1-x744.google.com with SMTP id o129so11688864qke.8;
	Tue, 16 Apr 2019 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language;
	bh=wk4/MbDlGZcywhffG+qbr3kiRHbtmy2IQ27HXjJzjuk=;
	b=vGv4AX+HsHwzu59ZeNnjtpG3MDk4sd3+hvWiMsqt2bbtvLJ0nl64cwsBBxvXYESW1/
	uzGvTiEZ/kG4KP9ImjjV4x9NYXUWfyIlLnDqOXN+qobSC9rHx4f75evM5C7LGgIHJgR0
	NZognRuiAquSZKEoAZnMpd5wtqkU6Sg4aqn8mH06murI+yM8xjnF+1zXjS9OGBJOts0S
	mh5XIqsdJKDHemoHdb/XN6e8mPD53zgJpdR1sgJirDlQoxbJmw+ig9qnLvErp0pHym+k
	NS8FpEtrqKn35ypY0pmQVLzlave9kq31VQh7JoD++WEfgrcHxPm+21QbN0rcXhIvOQuF
	zChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language;
	bh=wk4/MbDlGZcywhffG+qbr3kiRHbtmy2IQ27HXjJzjuk=;
	b=sIL7lpgoBej70jBHzdPxUKEFaXrhiRMX5twvjnCEQU9cwtXFeKUurW0Ki1FuZ+gHsq
	mA9MrToKqSh/FOudLBTTM8Iff9GAoRNq1FJcn+hpv6FolQHt25jpS+p6xfY2mwI6L2JP
	Mc5WXSQ6Kq/A+jKOn8zlcxoRqcsu8qgFnMqKkunRkvNVwgIXVtw/IEQM/taWAMNEO+xH
	j5AqQgWkIJA+zFooJJfbk1moPjF/lfigSUuTvcBXhHHSA/gAC5UH1vUocSFebFrygKtT
	jJArV2a8MKvvWjoDoF6OsrfkWHM+P1iLoSYf6G0omyN8gqYx19rUk0CgILm+zOWoKIe0
	eGBQ==
X-Gm-Message-State: APjAAAU31g8H0tHapBDdtCoqsSMWYf5g7tiKEbiRHRhYzDYIojPsj27A
	Wo7BKyReYV4804PFdL2fNxk=
X-Google-Smtp-Source: APXvYqzQsuUzWssjMrbOV3IEvFd9qIHNSswGyvf+zTSdLVkP00K95ckLpc4LCI+eBjCfINj5vwwV8w==
X-Received: by 2002:a05:620a:11:: with SMTP id
	j17mr62170084qki.111.1555408068254; 
	Tue, 16 Apr 2019 02:47:48 -0700 (PDT)
Received: from [192.168.15.40] ([191.19.239.91])
	by smtp.gmail.com with ESMTPSA id
	j93sm31918204qtd.82.2019.04.16.02.47.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 02:47:47 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190326211742.26140-1-danielhb413@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <00afefc4-7fd7-1f62-ea21-acb31ac79373@gmail.com>
Date: Tue, 16 Apr 2019 06:47:42 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190326211742.26140-1-danielhb413@gmail.com>
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::744
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 0/3] delete created files when
 block_crypto_co_create_opts_luks fails
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416094742.veeapmivMIGq-gUtBf-JFqjhbBFYo7VAgWFJlqedfj4@z>

Ping

On 3/26/19 6:17 PM, Daniel Henrique Barboza wrote:
> In this new interation, the following changes were made from
> the previous version [1]:
> - moved the 'generic' code from block.c to file-posix.c
> - moved the file delete call from qemu_img to the error path
> of block_crypto_co_create_opts_luks
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg06444.html
>
>
> Daniel Henrique Barboza (3):
>    block: introducing 'bdrv_co_delete_file' interface
>    block.c: adding bdrv_delete_file
>    crypto.c: cleanup created file when block_crypto_co_create_opts_luks
>      fails
>
>   block.c                   | 82 +++++++++++++++++++++++++++++++++++++++
>   block/crypto.c            | 31 +++++++++++++++
>   block/file-posix.c        | 28 +++++++++++++
>   include/block/block.h     |  3 ++
>   include/block/block_int.h |  6 +++
>   5 files changed, 150 insertions(+)
>

