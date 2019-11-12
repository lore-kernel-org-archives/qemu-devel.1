Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555B3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2354121783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXAbDQwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2354121783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUUXt-0007e6-8P
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 06:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iUUWk-0006fC-1p
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iUUWi-0003Yf-Tn
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:40:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51550
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iUUWi-0003YZ-QL
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573558804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Czj4Vh2n/O7w/8czCcpZM028DgSGKAZ3jM+SVX/GaQo=;
 b=JXAbDQwL1kG8p4JgDDSkRwiy00ADjsGAg1DdcDecmbeCV1VeKUkyDNzPtI6uoFC/z70l28
 ui9P4x+HXcfDrlRn1/cEAM3BuX1siP9lyzlFtxlHKUGPgrGLjdDFn8L0pOW3foMYk6qYcF
 9VIsCn6IwhiqmzrSbm481NYbIZbUXBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-0V8abUSpPlOEZwmbCOolIQ-1; Tue, 12 Nov 2019 06:40:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC1301800DFD;
 Tue, 12 Nov 2019 11:40:00 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-124.ams2.redhat.com
 [10.36.116.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0280661071;
 Tue, 12 Nov 2019 11:39:50 +0000 (UTC)
Subject: Re: [qemu-web PATCH] Add device fuzzing blog post
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20191107091136.359965-1-stefanha@redhat.com>
 <1233611027.10012683.1573119684999.JavaMail.zimbra@redhat.com>
 <CAJSP0QVMCyYND7GrhUUCF_c9XOd=2ODRdV_s_K=afJ96XMz=pA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9313c9d8-440c-03d9-4050-064c0a2b7ced@redhat.com>
Date: Tue, 12 Nov 2019 12:39:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAJSP0QVMCyYND7GrhUUCF_c9XOd=2ODRdV_s_K=afJ96XMz=pA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 0V8abUSpPlOEZwmbCOolIQ-1
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
Cc: Manuel Egele <megele@bu.edu>, qemu-devel <qemu-devel@nongnu.org>,
 Alexander Oleinik <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/11/2019 16.48, Stefan Hajnoczi wrote:
> On Thu, Nov 7, 2019 at 10:43 AM Thomas Huth <thuth@redhat.com> wrote:
>>
>> ----- Original Message -----
>>> From: "Stefan Hajnoczi" <stefanha@redhat.com>
>>> Sent: Thursday, November 7, 2019 10:11:36 AM
>>>
>>> This blog post covers the device fuzzing GSoC project that Alexander
>>> Olenik did in 2019.
[...]
>> Seems like the images are missing ... can you please attach them?
>=20
> The commit is available with .png files here:
> https://github.com/stefanha/qemu-web/commit/49efe1b254460a92c6348e1981caf=
3e1320782f8
>=20
> I moved the authorship information into the author: field.

The article is online now:

 https://www.qemu.org/2019/11/07/device-fuzzing/

Thanks,
 Thomas


