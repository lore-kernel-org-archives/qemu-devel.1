Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890ACC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57DCE24677
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UI4x/W8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DCE24677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBd61-0007qe-It
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jBd5F-0007OO-4L
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jBd5E-0005pn-1U
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:30:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23601
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jBd5D-0005kz-Tz
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583839799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D9PhCD2vPwq9NRyj2C1llpqbUakIYIcCDGN6vcvjYAI=;
 b=UI4x/W8i0Zre0eR3xjHxKWS6eEiMbas3PqmxybOFu3N6QWhVY1Em7eFRcxtIGVosPWCInf
 t7DxbdDFnz9MRL7c2/c9iwLf0fzvAV389vtimeOBbh4zK/2llykb+sTw5EztSuFQAI6yPT
 BfSFMShSxEg8rrUc/t05h0qnIDlSwEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-v3d_g3YWOiavnPewOtQc0Q-1; Tue, 10 Mar 2020 07:29:55 -0400
X-MC-Unique: v3d_g3YWOiavnPewOtQc0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39D3D1922960;
 Tue, 10 Mar 2020 11:29:54 +0000 (UTC)
Received: from [10.3.116.177] (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C247860BF3;
 Tue, 10 Mar 2020 11:29:53 +0000 (UTC)
Subject: Re: [PATCH] docs: Add RX target.
To: Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20200308130637.37651-1-ysato@users.sourceforge.jp>
 <e6ccf136-cf93-865d-31bb-4463b65416a9@redhat.com>
 <b075c69c2528772f9f047baba7adc368@users.sourceforge.jp>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6d90fc45-6d99-af60-bca0-0a84b91d0408@redhat.com>
Date: Tue, 10 Mar 2020 06:29:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <b075c69c2528772f9f047baba7adc368@users.sourceforge.jp>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 11:28 PM, Yoshinori Sato wrote:

>>> +++ b/docs/system/targets.rst
>>> @@ -17,3 +17,4 @@ Contents:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 target-arm
>>> =C2=A0=C2=A0=C2=A0=C2=A0 target-m68k
>>> =C2=A0=C2=A0=C2=A0=C2=A0 target-xtensa
>>> +=C2=A0=C2=A0 target-rx
>>
>> Is it worth keeping this list alphabetically sorted?
>=20
> It was not in alphabetical order, it was added at the last. Is it better=
=20
> to arrange in alphabetical order?

The 3 lines of context was alphabetical, but looking at the whole file,=20
the overall list is not. So sticking yours last is fine after all.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


