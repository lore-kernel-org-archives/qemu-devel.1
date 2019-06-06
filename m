Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA93C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A9A2070B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSRqDM0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A9A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60129 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYrwQ-00072N-5a
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 08:56:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1hYrvh-0006dh-VO
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1hYrvh-0001aB-3K
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:55:41 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:41192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
	id 1hYrve-00007s-PD; Thu, 06 Jun 2019 08:55:38 -0400
Received: by mail-ed1-x543.google.com with SMTP id p15so3172667eds.8;
	Thu, 06 Jun 2019 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=qKOB3VuDlc0WnIjDjWXfVQ61z9FILkUE5p8n5dJH9dc=;
	b=HSRqDM0tkQEmFFNFlL+unjNbBWQvoAG9/CnVf9n/vhMBtPRbMmamPTPhForYIxZ/+p
	YITM5We/y5Z7jboRF8rImjP+C9bE/ARn2Fcy18nnX3b3vARt5GdLxj5Nj1NUbudBB4mw
	QMPTdw3mgrxxFWdNiuMQ8KU0rFPQATrvSzcouoYwvvUzlqXO9fb/GJJyJZqTBz2vuGGM
	HQ1exyIVdRoGkirKhgqbbPx+ZLwtAW0TJgxqEgpg/3+m9uzztzEJ+hLcX65x6Ba7QC95
	uqt09xDzHxNGFO+HWUo/evxK7wis2IeEMkE0hTou+rHmU3mQZn7JR9mJL40FGJXsHAUy
	XB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=qKOB3VuDlc0WnIjDjWXfVQ61z9FILkUE5p8n5dJH9dc=;
	b=gtP/d2ht8WORSFuUplVwpUOqzJHUe75QyEtXC1ue25QO/LfHYVbuz7zfrPLj1ITyl2
	qXDXlLsBmEb8pmQ3WmPG2gDFOzT/hj1QO+L+gyLgSV625dyAdC7m4NHM3RY70e4+478i
	vwNNs3ifiCzLoB0ROzPLeanbjkhZq4x6AdCQSE6jKgyVmdiWuUKMIJ7oWaZIaQVppo33
	thXk2pND1idhbgDfhJACjz5vXsWkt8Knjy5gzkvQN6kRxYmYnz9orS7pmDmeo61pRr2o
	IqAJHbWzVSzBSAqQTPUZGE/oXOgQYAjxQh91DIQmY8CtRnzVOIEGlEbBF1u4NbhRauXo
	lO6Q==
X-Gm-Message-State: APjAAAWbyLisiREqSTawxxuf3/h78o6AVTXE4UGhsYOEbku3IZGzIaZ7
	+Em5Mq4jTbIygIwl/Z0T5pchLkNXsPww8bHFWt0=
X-Google-Smtp-Source: APXvYqwjGUkmJZOkoFUulGipThJG9uhva1jCC8X3EQmGowTjLHtn4+oDhgAMnT9rbETTeWhhvwY4vvSABAX2ppalOCU=
X-Received: by 2002:a17:906:1f55:: with SMTP id
	d21mr40274342ejk.87.1559825725039; 
	Thu, 06 Jun 2019 05:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <1559119921-6098-1-git-send-email-bmeng.cn@gmail.com>
	<CAKmqyKNAL8KtVgfCx6yhaNYEL=_wnZ5Vf1eSjxwtg0x6_q+UHw@mail.gmail.com>
	<CAEUhbmXLr3zXhbphXRvqfyW1FH9qo3yoPwnFoRoYNtbwkrBBKw@mail.gmail.com>
In-Reply-To: <CAEUhbmXLr3zXhbphXRvqfyW1FH9qo3yoPwnFoRoYNtbwkrBBKw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 6 Jun 2019 20:55:13 +0800
Message-ID: <CAEUhbmUAKoFPqBLVW4FHmiESaF8fqEtjqDb1LKf4ivG3g2z0ZQ@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH] riscv: virt: Correct pci "bus-range"
 encoding
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
	Palmer Dabbelt <palmer@sifive.com>,
	"open list:RISC-V" <qemu-riscv@nongnu.org>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 30, 2019 at 11:36 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Alistair,
>
> On Thu, May 30, 2019 at 11:14 AM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Wed, May 29, 2019 at 1:52 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > The largest pci bus number should be calculated from ECAM size,
> > > instead of its base address.
> > >
> > > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >
> > This seems ok, can you maybe explain what this fixes?
> >
>
> The logic is wrong, as the commit message said. With current wrong
> logic, the largest pci bus number encoded in "bus-ranges" property was
> wrongly set to 0x2ff in this case. Per pci spec, the bus number should
> not exceed 0xff.
>

Ping?

