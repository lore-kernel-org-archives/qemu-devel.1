Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98738C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 21:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56BBC2080F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 21:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/9mJAI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BBC2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icFT8-0006XN-GA
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 16:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1icECN-0005SQ-3s
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1icE8w-0005nA-L4
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:47:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57417
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1icE8w-0005UP-Dt
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575402445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=tbMEAHiFy7XFWeVlX4QTOir5+0K65Ylqavn7tlg+oMA=;
 b=T/9mJAI0Te81Z5sQmwxZ7zC7d8n1NbCDjlsxmBoXyZxM83SDmbSWh9nVGCPYP8D3FLdSKw
 sDSTGspqIKxlCu8YkS1EHDsG5Z+b32BhRN8NsKwv7nwNSYXmPJCR1Fdqk54HGVzpGG3oZV
 iXBdGMkWH1RboPydsxKmwkstrh8D4HI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-1xbv3QD2OMqxG8LBtuHnBA-1; Tue, 03 Dec 2019 14:47:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D56E800D53;
 Tue,  3 Dec 2019 19:47:23 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F4A95DA2C;
 Tue,  3 Dec 2019 19:47:21 +0000 (UTC)
Subject: Re: [PATCH 3/7] tests/Makefile: Remove 'tests/' and '$(EXESUF)' from
 the check-qtest variables
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190910185839.19682-1-thuth@redhat.com>
 <20190910185839.19682-4-thuth@redhat.com> <87immx9pqk.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c4773e4a-0abd-7db5-b14d-d7b49e8f1478@redhat.com>
Date: Tue, 3 Dec 2019 20:47:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87immx9pqk.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 1xbv3QD2OMqxG8LBtuHnBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/12/2019 20.24, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> It's much easier if we simply add the folder prefix and the exe suffix
>> later via a substitution instead.
>=20
> I guess it took too long for me to get around to this as I'm hit with a
> merge conflict. Is there likely to be a re-base soon?

I'm planning to rebase during the 5.0 development cycle, but I haven't
started that work yet. Anyway, no need to review this version anymore, I
guess.

 Thomas


