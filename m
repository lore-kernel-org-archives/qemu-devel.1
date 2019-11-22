Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E84C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8871F2070E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEtVdhLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8871F2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY6ts-0005Nn-L2
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iY6tH-0004vW-8m
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iY6tG-0008Eh-8R
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:14:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60939
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iY6tG-0008E9-4T
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574421257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYux4idtFsv9xluyBvVpQnhRVfP9V8bVsWNc6UWFX8c=;
 b=ZEtVdhLvjp22GA3Vg3iEgo2bxRnfSJpY8dzvEvvS72JkEBcjMM+FpFa30YgMxJVgXZHA3L
 MPEC4WiaUXABP6kOmpIeiQ8adg/4/cljux7sOVa4TxgEOy2gEOKY/UWZ81CQ99jF7KwW3/
 GZkDSR6u6oJrV7qmZeO2nj3BnZzlKwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-AD4tA_xiOH6m_Gi6uAIW0w-1; Fri, 22 Nov 2019 06:14:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1192618B9FC2;
 Fri, 22 Nov 2019 11:14:13 +0000 (UTC)
Received: from [10.36.118.121] (unknown [10.36.118.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AD745E7B0;
 Fri, 22 Nov 2019 11:14:11 +0000 (UTC)
Subject: Re: [PATCH 2/4] s390x: Cleanup cpu resets
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191122075218.23935-1-frankja@linux.ibm.com>
 <20191122075218.23935-3-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4793f8ae-a709-2a41-ea71-4197a026b58a@redhat.com>
Date: Fri, 22 Nov 2019 12:14:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122075218.23935-3-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: AD4tA_xiOH6m_Gi6uAIW0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[...]

>  =20
>   #if !defined(CONFIG_USER_ONLY)
> @@ -473,9 +459,9 @@ static void s390_cpu_class_init(ObjectClass *oc, void=
 *data)
>   #if !defined(CONFIG_USER_ONLY)
>       scc->load_normal =3D s390_cpu_load_normal;
>   #endif
> -    scc->cpu_reset =3D s390_cpu_reset;
> -    scc->initial_cpu_reset =3D s390_cpu_initial_reset;
> -    cc->reset =3D s390_cpu_full_reset;
> +    scc->cpu_reset =3D s390_cpu_reset_normal;
> +    scc->initial_cpu_reset =3D s390_cpu_reset_initial;

What about having only one function here

scc->cpu_reset(), where you directly pass in the reset type

instead of scc->cpu_reset/scc->initial_cpu_reset?

> +    cc->reset =3D s390_cpu_reset_clear;
>       cc->class_by_name =3D s390_cpu_class_by_name,
>       cc->has_work =3D s390_cpu_has_work;
>   #ifdef CONFIG_TCG
>=20


--=20

Thanks,

David / dhildenb


