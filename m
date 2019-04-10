Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EB9C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 19:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723622070D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 19:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMiBkjVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723622070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36861 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEJ1H-0001aQ-9l
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 15:36:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEIuX-0004sO-6p
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEIrM-0003Sj-H3
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:26:14 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hEIrK-0003RC-EQ
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:26:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id v14so3832786wmf.2
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=E6H8WPSVoFz/sHa0NX7WsrqHU3zM97MbzirSWpDdiPo=;
	b=ZMiBkjVUcdHHX3CPs+fYDDEid5ODNbd0plAP/3GIk0ssuQPfwreaFJY4LUogvnpS+V
	quB0CgluVYT3gBJ3/REdaRImmt0V7EZNa3JD4xxUR2R9F0JtVumV7mNAmQtAndDlFdp7
	XwT62NaHefiiCcI8gNBcvxlKwX3CLMzNt5Uq+LE/U1w6VmfogVfx8hkya8ZEYdbXpR4z
	vjBn1UlpRY5Zd7MFlHgT1mZ7qCUYEiyEzB66OF49qoETlm0OaxuXKogg4Jdq1hcmPK8C
	Vx7ElmtrTOAF+7tAt9J24vqm+gewWVdyZrE6j/wLf6SZ4HktJM4fL+BDUh8c6dYBa+0X
	0HEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=E6H8WPSVoFz/sHa0NX7WsrqHU3zM97MbzirSWpDdiPo=;
	b=PvYNNFqFgnCBO0kpNx2/d5SqZGn5aKJAx1LVtTm1R5eySPjZfKjBXZzqTx4hj+bfyA
	ztRXCrEnt/+zGVk3nFpI/NV5ckb96ojGVmc5G0c6TB0e85f7kL5SapcvyKD2aJWaJz5R
	h0qXu/2Y8j4Wey4nNSmoZz6m4t/5ZjHynnG/iBx6KvVHIrMEqm+jiCSA4XrG7dXbLzC5
	zoNLGGdK/M0ExZr0IdZu1ha0sA7kckzq9J/JwPfFhHLY0IvNm7FM3CO12Lc4ePXvDAsO
	LeRKM7/pLhPKL1CIqs9oMkn6ElAv17ctk1VBfkexQwB4ml/ZuNDHgIXMALY05sAIlXvZ
	dd6A==
X-Gm-Message-State: APjAAAVJomX12xmKZ35bSBpQZXIYJFA5buzg2FgEif+1wO9VNM0w966o
	GtNuqNwu3M4LLCXGe/nhj79SMjQcmMYECM7xUlo=
X-Google-Smtp-Source: APXvYqwCnHNsLEZ3XVc2f1RyQ58y65ykc0ByVEsRfZDDxLVJZzcMrqr9WyUuHNGBLFQxFk4cG3r7DwjtBqyWhgHFDas=
X-Received: by 2002:a1c:c181:: with SMTP id r123mr3847418wmf.13.1554924369044; 
	Wed, 10 Apr 2019 12:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190401111843.54528-1-ybettan@redhat.com>
	<20190409131734.GE16944@stefanha-x1.localdomain>
	<1871f593-ec5b-fede-7da5-a7ae78056249@redhat.com>
In-Reply-To: <1871f593-ec5b-fede-7da5-a7ae78056249@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 10 Apr 2019 20:25:57 +0100
Message-ID:
 <CAJSP0QWYS+UHmXyvhtLcLW9iumfi29Fa7AJdGPC9OwagwekWmg@mail.gmail.com>
To: Yoni Bettan <ybettan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [RFC-PATCH] Introducing virtio-example device.
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Amnon Ilan <ailan@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410192557.VS3kyxOzZeAa5z1X8IIKdFSE0AlSOKC7DExTvsVSJTE@z>

On Wed, Apr 10, 2019 at 4:45 PM Yoni Bettan <ybettan@redhat.com> wrote:
> On 4/9/19 4:17 PM, Stefan Hajnoczi wrote:
> > On Mon, Apr 01, 2019 at 02:18:43PM +0300, Yoni Bettan wrote:
> > There are multiple problems with the code, but the larger issue is that
> > this example device is just helping people shoot themselves in the foot
> > more easily.
>
>
> If you can point me to those problem I will be glad so I can update the
> code and understand those problems you are talking about.

Please see Eduardo's reply.  I didn't review much since he already
pointed out many things.

One thing he didn't mention:
+    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));

The return value can be NULL.  Spurious notifications could happen so
the code shouldn't crash when this returns NULL.

I apologize for the critical replies.  What you're doing is valuable.
I think explaining the VIRTIO device model and the order in which
things are done will lead to higher quality devices so I'm making a
lot of noise about it :).

Stefan

