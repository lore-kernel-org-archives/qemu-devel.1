Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153A7C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56CC620760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tr7ubuWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CC620760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPnaV-0002dE-Bh
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 10:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPnZe-0002C6-Rt
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 10:04:15 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:36086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPnZa-0002Aw-PM
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 10:04:14 -0400
Received: by mail-ej1-x62a.google.com with SMTP id qp15so17815334ejb.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xYpC694phh/ztw+4EH+BXHZyEzgFe66keSFFbvRq6og=;
 b=Tr7ubuWFtqy6lx+22tKCemNSA3Cs3gNUOFfhncu87/jR62rYG3/0Fw7JgsP8YzGbgW
 RV25x8G2pIR2QmhHAfpqQSAGqnxAWlmR+NId66IX7WQIhbqZGX01PEebDAyJnCnfrhAG
 wE5+ISNyGcna1VR0J9o/m5MmtNCoDcjDXJLg4/PP0LJfZ6za24K7DCiFzA+3OwOex7Ie
 TaNDa/xlVlqYWA+2OOno/3YDUEHidJgcU4PeLSNzr5hBr4jT0esxtFSmYGeS3cDAiKBU
 rYzNn0kxSY2/hCAFq9hb6TFb2NfHN+8c29WYMp8+USXig9VBwa0pYD5QcdaDXRItz1GA
 LOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xYpC694phh/ztw+4EH+BXHZyEzgFe66keSFFbvRq6og=;
 b=nz4hDj/I8ETgzDlMp39opVnAmicfcUm+BZKdTqVlU2FGi6gLS2V07HDLNFbQ2SvPIY
 No4mX9SteOd3+dX4whYAKpZuxG+TSlbnaihHWELBErYkPk2241HjebhoWjHQ2IHu8Df/
 fQus00bkmfygPFUsySIdCJd9tLmfY2bUIf1zRUaxoA92Gli65PRFKEAEZijACKU6QzMT
 9FAqUT8HBGmEMS87065iXlJcHYJxxQdqBQb3Llwu2AlDRsPesaRydspNHIUST0nEW5T9
 6lFyxkDSq3t3BfzACf23Z6NVtlL8hzR8LEn+LAYRvs9cC97SUWPXk7YCqTPa4GX8cLWJ
 Ozqg==
X-Gm-Message-State: AOAM530fZ41NIx/ax8RaiU2c6ZTpixmWvLE4CIZ4fxWpBhgQh75vfIcX
 UjaUet7b7DIn5ti1zjlIU7VZBb6P/QyU1yWvMyJGjg==
X-Google-Smtp-Source: ABdhPJz5NG4TX5d4gbvn9UZICb+wURKyJkbfTTPME5gX+q9PFUEoZJp6cLyQ3txq7Y49s9uyh6VNoiUsGfV5drSsJtk=
X-Received: by 2002:a17:906:60d6:: with SMTP id
 f22mr5415371ejk.250.1601993048125; 
 Tue, 06 Oct 2020 07:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201005211000.710404-1-ehabkost@redhat.com>
In-Reply-To: <20201005211000.710404-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Oct 2020 15:03:57 +0100
Message-ID: <CAFEAcA_+4b4HHP_8BBqqy+QmoyF6Lx1jmuFvcsbW5THZQDrXww@mail.gmail.com>
Subject: Re: [PULL 00/21] machine + QOM queue, 2020-10-05
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Oct 2020 at 22:10, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 36d9c2883e55c863b622b99f0ebb5143f00014=
01:
>
>   readthedocs: build with Python 3.6 (2020-10-05 16:30:45 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to fec5c4b6d3b7f3ffcfcbe1714e0405df6de2a222:
>
>   kernel-doc: Remove $decl_type=3D'type name' hack (2020-10-05 12:48:11 -=
0400)
>
> ----------------------------------------------------------------
> machine + QOM queue, 2020-10-05
>
> * QOM documentation fixes and cleanups (Eduardo Habkost)
> * user-mode: Prune build dependencies (Philippe Mathieu-Daud=C3=A9)
> * qom: Improve error message (Philippe Mathieu-Daud=C3=A9)
> * numa: hmat: require parent cache description before the next
>   level one (Igor Mammedov)
>
> ----------------------------------------------------------------

Compile failure on OSX:

../../hw/core/numa.c:429:20: error: format specifies type 'unsigned
char' but the argument has type 'int' [-Werror,-Wformat]
                   node->level - 1);
                   ^~~~~~~~~~~~~~~~
/Users/pm215/src/qemu-for-merges/include/qapi/error.h:319:35: note:
expanded from macro 'error_setg'
                        (fmt), ## __VA_ARGS__)
                         ~~~      ^~~~~~~~~~~
1 error generated.

thanks
-- PMM

