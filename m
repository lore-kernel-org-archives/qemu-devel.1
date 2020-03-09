Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FAEC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A3E22525
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKRzF7LF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A3E22525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBIKF-0002vS-A4
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 09:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jBIJZ-0002Me-NZ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jBIJY-0004z4-Pr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:19:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43297
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jBIJY-0004ym-NA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583759964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=24e40OWtoXL19M1KR38kXSnQakErSNYqXxfOktpXQA8=;
 b=CKRzF7LFlFAj9AF0QU+BUdCt3lI5mNjHM2d+Cb1VfdK+wtrU2be/SlCTWorEo8o0Wn812L
 KJljLyZS2aE6v0wAgkYwKipLVjJAcWxP0NnRPaL8RsLMpUqOPVIPL65aA6X1YthLbO1xl9
 fpRMncHOCkxYVvhylv7bppQTfrKLIP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-RAFLMdiAOvq6ei8v5-yfrw-1; Mon, 09 Mar 2020 09:19:20 -0400
X-MC-Unique: RAFLMdiAOvq6ei8v5-yfrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71D74969FA;
 Mon,  9 Mar 2020 13:19:19 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-206-77.brq.redhat.com [10.40.206.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 111051001DD8;
 Mon,  9 Mar 2020 13:19:17 +0000 (UTC)
Date: Mon, 9 Mar 2020 14:19:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "=?UTF-8?Q?bauerchen?=(=?UTF-8?Q?=E9=99=88=E8=92=99=E8=92=99?=)"
 <bauerchen@tencent.com>
Subject: Re: [PATCH] mem-prealloc: initialize cond and mutex(Internet mail)
Message-ID: <20200309141914.0b9ad42f@Igors-MacBook-Pro>
In-Reply-To: <4976eaee60934e458e105bebe20d4d18@tencent.com>
References: <20200306085014.120669-1-borntraeger@de.ibm.com>
 <20200309110331.3ef650a9@redhat.com>
 <13a05c3e-e374-8411-952d-05f4312ad6c0@redhat.com>
 <d37b122a-1980-32f3-6c06-89e5ef2a4807@de.ibm.com>
 <4976eaee60934e458e105bebe20d4d18@tencent.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 mhartmay <mhartmay@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 pbonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 11:16:10 +0000
bauerchen(=E9=99=88=E8=92=99=E8=92=99) <bauerchen@tencent.com> wrote:

> Thanks, =C2=A0in fact,do_touch_pages is called just when vm starts up, bu=
t using init flag and Gonce maybe more elegant !
> if needed,I can submit a new patch !=20
> thanks very much!

it's called from os_mem_prealloc() -> touch_all_pages() which is called
at least once per an instance of hotsmem backend. So if several backends
are used then it should be called several times.
The same applies when a hostmem backend is added during runtime (hotplug)


