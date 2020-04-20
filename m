Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478E0C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF92206A1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuTm4AHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF92206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQcUv-000115-6n
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 15:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQcT2-0007fn-Pw
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQcT1-00033q-PM
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:52:32 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:33354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jQcT1-00032T-CE; Mon, 20 Apr 2020 15:52:31 -0400
Received: by mail-il1-x141.google.com with SMTP id q10so9790980ile.0;
 Mon, 20 Apr 2020 12:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NrxkcGoSw9f+9arw0MSGats/+AxX6hWZ0202mDIbBpU=;
 b=WuTm4AHFFid/BeHOBLnqSfe25/iZSVybNlLERABFND5z1PDXkX3HJb44iqmL6R86++
 pOkePpjGwc6YUwdu3plrfSbmmSQ5jU84nYs9Xft+3yDASt7EmaGADKUrCkl3b/SZXGPM
 7jKDk2LuiymsLYlG+p+V8luaskrJLVcJFNvb+JPOrZoRISSY30WtSVOn8cNbGaaW9Ga8
 17GE+djKzm7qwwAkMRZYLGmEG0QAH+DEDIcpcFRbOkJVB6yNC6ZhcKRe3LqZ4PN9try9
 rSmEapfCjzNMKF4SyMTQjawnCYBT2Z9l/MKJE+z3i6zTi5JUhKMvCyYrAhHvv5Fx1pu+
 h56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NrxkcGoSw9f+9arw0MSGats/+AxX6hWZ0202mDIbBpU=;
 b=U5OtKc2PjCa85YDZypnJtd+YKWscvoJCukrxvRXDJiu96Vh5se24L6UlZ7CXJrNqST
 ZxbQ3aJ0hNg3RcMKNZB2gjgVFia3kMsGKWpkGw/71Waays2mjIav1KafpZfS4zP888Cl
 JEHQrQiK4nulVcCAIIX8bXYe7Kir67RL6YWWaf+bsqHR0p4eZje7yW3wJSDiBrWqTLvz
 lmbf2G34xW1AAjNLltgmAE38rUoMftIRGghnY8MifeJFpx2NE1WuT06iunANjkxhImBa
 mQgmM/u7243/FbMYfzSZ3oUmUQCasnajQgn2zysh5Yr2A/bbb7A5IWYH/uCkyzBxrXMj
 Ym3Q==
X-Gm-Message-State: AGi0PuZ7LIKLee63Y5acL0a1/Ra1Qx6ApPS4zMLtP6xGcHMFTNFB4cLY
 uJk2SdF4SL4nn5dJtZm5TFDoQn8y8ezQXqKPXwV65q1D
X-Google-Smtp-Source: APiQypL2yv8G9qLA0OOX1Q/Zk6xLNIh/GkPmAqlCZb/s47kSOUQHlKFTlfIENiUoLXsVLBthH2q69B3VVySOf8CXAb4=
X-Received: by 2002:a92:d0c6:: with SMTP id y6mr18619565ila.227.1587412349988; 
 Mon, 20 Apr 2020 12:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200419162727.19148-1-edgar.iglesias@gmail.com>
 <20200419162727.19148-2-edgar.iglesias@gmail.com>
In-Reply-To: <20200419162727.19148-2-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Apr 2020 12:44:02 -0700
Message-ID: <CAKmqyKM7jyX538LdZT2dEznxLKwaVpGHCuhNtwuJxFJLtzOueg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] device_tree: Allow name wildcards in
 qemu_fdt_node_path()
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 19, 2020 at 9:27 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Allow name wildcards in qemu_fdt_node_path(). This is useful
> to find all nodes with a given compatibility string.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  device_tree.c                | 2 +-
>  include/sysemu/device_tree.h | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/device_tree.c b/device_tree.c
> index bba6cc2164..f5b4699aed 100644
> --- a/device_tree.c
> +++ b/device_tree.c
> @@ -308,7 +308,7 @@ char **qemu_fdt_node_path(void *fdt, const char *name, char *compat,
>              offset = len;
>              break;
>          }
> -        if (!strcmp(iter_name, name)) {
> +        if (!name || !strcmp(iter_name, name)) {
>              char *path;
>
>              path = g_malloc(path_len);
> diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
> index c16fd69bc0..7c53ef7634 100644
> --- a/include/sysemu/device_tree.h
> +++ b/include/sysemu/device_tree.h
> @@ -39,6 +39,9 @@ void *load_device_tree_from_sysfs(void);
>   * NULL. If there is no error but no matching node was found, the
>   * returned array contains a single element equal to NULL. If an error
>   * was encountered when parsing the blob, the function returns NULL
> + *
> + * @name may be NULL to wildcard names and only match compatibility
> + * strings.
>   */
>  char **qemu_fdt_node_path(void *fdt, const char *name, char *compat,
>                            Error **errp);
> --
> 2.20.1
>
>

