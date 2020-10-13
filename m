Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE3BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083DA208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM/+EFyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083DA208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSGQo-0000b6-TY
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 05:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSGPh-0008Sw-Qn
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 05:16:09 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:41250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSGPg-0002Kw-CC
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 05:16:09 -0400
Received: by mail-yb1-xb43.google.com with SMTP id x20so15584451ybs.8
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 02:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SK41yRsGVxc4M0PhAezGMQH0ULOJ2u2q3OSQ7lbD/TM=;
 b=XM/+EFyxUSQZKkQtTY7oi7IBOmcWgO1xLDMwJMOb7iooRo01Go+xQo+6mt96+OoMz2
 NZ807/mZaBOcHHtZF2g+ZApiDYQofw1tWnskDou1ouYYGVjkOLeduWESLr52LUxcSK9Z
 KTFAj+7cPLJmjAmmrpRIQ4S4VR36zNEN7RpCtWQkIB8vhjdYnctZQ/0Hqb/44db7ucsV
 zw5AeYfLZnO+yAbuMck+TBn2uRAH6+aXTegbJrawi0UmB63E4wAiJto7f4VJ6bQpPeH/
 oTlpoByB2E1CZLSVuV2nRkrfOGL6qZ+11G7FV1le7+SUNPc9YDIWhAtZLWAkBXLV7FDn
 OGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SK41yRsGVxc4M0PhAezGMQH0ULOJ2u2q3OSQ7lbD/TM=;
 b=BjQkCUOjroomKPrTSSXcQeJoCygDb1KgMhb5X9gjAOKBK3UtxPCYLyPxiByVE2osRl
 rwLYZGCfmNseQ85NQm8TPt/u9atFxwRVeEkvjqA6A/aVX06pn7/ctGYagZ73w28Ms1VG
 fDhJUBi/XDF8VNZRahsgTnkb/2cZTSIIHxfVQ/28a4VH9cG3j9y+CunnjzAtZ9kKZkzT
 4itik6rXq95zGHXypWY5Aq1EkrGljZUGvTO9yfPxRIkkzhkV58kOlvIvEjwMyeScSAot
 4oPoufx/z9SKZFDcthdEZvNiIKMHhtl7FTZD/xh1OWkptc7GE+TdZ2mIbYAIsE8LL3+n
 5l3A==
X-Gm-Message-State: AOAM530e1SarP527dumE9BIMLnNT/M2B+kiRFVmugn2NkOQapKZWqbkD
 pOT8xKDON5naSjE3839gktsbK3EGZHj+qf6kqH0=
X-Google-Smtp-Source: ABdhPJw9S4DsjWtC+wGEP5c7VejlbFi/JRKth/lVL+3cmKPVT0C8TJ/dyCguZsBSej7uYbLpy4g29LdJ4BnRCBjeN3A=
X-Received: by 2002:a25:520a:: with SMTP id g10mr19486363ybb.152.1602580567379; 
 Tue, 13 Oct 2020 02:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201009175123.249009-1-jsnow@redhat.com>
 <20201009175123.249009-2-jsnow@redhat.com>
In-Reply-To: <20201009175123.249009-2-jsnow@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 13 Oct 2020 17:15:56 +0800
Message-ID: <CAEUhbmWJ62viai9C7_zfx-do7DW0Mh_xjT7G8a8p+mdi9tCfkw@mail.gmail.com>
Subject: Re: [PATCH 1/3] python: add mypy config
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 10, 2020 at 1:54 AM John Snow <jsnow@redhat.com> wrote:
>
> Formalize the options used for checking the python library. You can run
> mypy from the directory that mypy.ini is in by typing `mypy qemu/`.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/mypy.ini | 4 ++++
>  1 file changed, 4 insertions(+)
>  create mode 100644 python/mypy.ini
>
> diff --git a/python/mypy.ini b/python/mypy.ini
> new file mode 100644
> index 00000000000..7a70eca47c6
> --- /dev/null
> +++ b/python/mypy.ini
> @@ -0,0 +1,4 @@
> +[mypy]
> +strict = True
> +python_version = 3.6
> +warn_unused_configs = True
> \ No newline at end of file

Missing "\n" at the end of file

Regards,
Bin

