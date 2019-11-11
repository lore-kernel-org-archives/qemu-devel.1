Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3E8C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A6E21925
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ux0SFKFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A6E21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUAQ3-0002J4-FX
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 09:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iUAPO-0001pQ-5L
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iUAPM-0004yq-At
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:11:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30213
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iUAPM-0004yV-5C
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573481467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1jdDujaBjB4ZuqhhDFpi+IouYG8WnS5A05F/VjT/Jqo=;
 b=Ux0SFKFyp/0RzHVE+LrasmxCj/XgTevhP+NjJVPu3zO7HYUPThygqysyBUvBtCLGPg9IuM
 HsNStXvgb/xee9suGPyiGZhryLPImGfdne3DfpYV1f5+HX8Hhh3d8UtT3XGvKLq7pCh+mO
 JIZHge7M+n0uiHzcLybuRouLPqUVrkM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-0UquGRCBNryXD7WXKv0-kA-1; Mon, 11 Nov 2019 09:09:58 -0500
Received: by mail-wm1-f70.google.com with SMTP id y133so6271096wmd.8
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 06:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=za0IVuBhC751vDb+jH605+kiTqYQHCdmnWQAJzB5+IY=;
 b=nVnaFPN61xiyXvE0ePJHTnmY4lUmmzTxZZ8f0eiLEPLhZXtKndtpvtM3oJIwQRSKLk
 PBm3anvoV2u1Cvksp5dnS21wbi2QIQ5zALDuJ/CA1mGMv7WxcM0K3Zmh+v2GgSWg5QIn
 NhIfqTgn6spR1+8QmcbP0hKrTxPSJTcw5GcXdAyR4uquKsLtCkYUwIvAT+S5FAL8tNKG
 hc4Dwpqid1MU7yih4CsiDIvgcZw5J3nVQcym/zQQV0Ubx6Lqc1NptqTObXPnqKxQGPHH
 TIHHGz5F81J26XkOXZV1c0iC+1hAQCZzQjCm962omNb1WGQ4lZfG/7QMa/IdI6mwrszI
 DZBA==
X-Gm-Message-State: APjAAAX7ERDmmHoaaF6U6gH5acbYj/8u8lD+tZemwLRdGEj0z3ewpEY2
 rflUcxAnX6LWMTHGIHXYxOaATN8r3QjH8g66Dwcg6SGrswSKF2dMXyiZgQI8xT00HS+rhpmEcCA
 d/PAGaw/WRt8pK3o=
X-Received: by 2002:a7b:cf36:: with SMTP id m22mr21349854wmg.96.1573481397716; 
 Mon, 11 Nov 2019 06:09:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNtOooJZLnMT/2813fX5feOQ8iaT2DnY9Cqt/v6jlBb7Itg5xE42ItI2036ivkRqbHyj1ExQ==
X-Received: by 2002:a7b:cf36:: with SMTP id m22mr21349835wmg.96.1573481397505; 
 Mon, 11 Nov 2019 06:09:57 -0800 (PST)
Received: from [192.168.3.122] (p5B0C62A5.dip0.t-ipconnect.de. [91.12.98.165])
 by smtp.gmail.com with ESMTPSA id
 n1sm18083852wrr.24.2019.11.11.06.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2019 06:09:56 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] s390x: Properly fetch and test the short psw on diag308
 subc 0/1
Date: Mon, 11 Nov 2019 15:09:55 +0100
Message-Id: <6177C7E2-50B9-493D-B42F-A1DCC5C3F36E@redhat.com>
References: <99a1b443-1bf5-e21b-dcdd-6feafd6d9b6f@linux.ibm.com>
In-Reply-To: <99a1b443-1bf5-e21b-dcdd-6feafd6d9b6f@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: 0UquGRCBNryXD7WXKv0-kA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 11.11.2019 um 14:52 schrieb Janosch Frank <frankja@linux.ibm.com>:
>=20
> =EF=BB=BFOn 11/5/19 9:07 PM, David Hildenbrand wrote:
>>> On 05.11.19 20:34, Janosch Frank wrote:
>>> On 11/5/19 8:29 PM, David Hildenbrand wrote:
>>>> On 05.11.19 19:44, Janosch Frank wrote:
> [...]
>> Note: For TCG we miss many of these validity checks. For KVM, most=20
>> should be triggered when running the VCPU AFAIK (that means, we don't=20
>> have to check for any other scenarios here). Checking for the special=20
>> case as given in the programming note should be sufficient.
>>=20
>>=20
>> I'll have to think about how to best handle that for TCG (mazbe what I=
=20
>> proposed works). We could ignore TCG for now and add a TODO. Then, just=
=20
>> wrap the exception in a "if (kvm_enabled())". You could also document=20
>> why we only have to check for this very specific bit and not the other=
=20
>> bits (handled by HW later).
>>=20
>=20
> After some discussion I got an interesting answer:
> For KVM we need to expand the short psw and invert bit 12.
> The next SIE entry will automatically report a PIC 6.

He, that=E2=80=98s a nice trick.

>=20
> I'd propose that I'll fix this patch and send a v2 and you can fix TCG :)

Yes please. Perform the conversion unconditionally and add a comment - we s=
hould add the same checks when running the TCG main loop after modifying th=
e PSW mask.

>=20


