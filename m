Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFF2C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:15:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15AAC207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UfinMCVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AAC207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieMcw-0004uV-9L
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 12:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ieMcG-0004R8-GG
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:14:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ieMcD-0007nv-2P
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:14:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44033
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ieMcC-0007nQ-RE
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575911671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dXZMNv73nKmonOUjIHaSzxbVhsmw7lnRmSjwGpyU07E=;
 b=UfinMCVKOea12k0x6Bzh9xS62I0L7GtKQTq91XOk5JBAO4TSV3fOObjJ5mJ6itPLFS6GpF
 0tw6ndUtZhKVbCga3hEew/KYTqVKzh8Ls3hP09OlbDHZ6S1sXbSlVOO7SXlH1Yp5HASv38
 aztSp0yXbd7n5fx1/DAH/LYvytFqSE0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-m-ygRJd5Oi2y3qNJvpw97w-1; Mon, 09 Dec 2019 12:14:27 -0500
Received: by mail-wr1-f69.google.com with SMTP id c17so7733030wrp.10
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 09:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8uy1pvxcLMWuh5Fj6ktCa1cb7x5XmOLsXFvCljOnfMU=;
 b=oYs//3kHbVEwH7iD9UbNJpuNXY+d9l0ZjcCUi9w+/F39w5GcMdgt2QtTuX9TQNDO8m
 fp+xvTrhEA2ZwHh/gYCATZ8rSdvFOFQexAwINTgHTI1aQv0JoPdd8fhU0MU6omzJQ/vp
 JzJ8g1xy9f8AT5RHnbN8DeHsCTNl7fogjpIZZZ5f39miZyy15yrWuRokwCcAKsqZVWhd
 zOxAB+F9YD7c8uaFsMIieRCQ5D/GJmcPbFvfoGlreIFwcflVwOc4PEIL64fg17MjVnMW
 PIf/n9aGwyeyh3dhBGqkCZGpQIAp6FIJfqe6FY3Ns+G53HLr2pNHoUohEkyO1Dqglkh7
 aQAQ==
X-Gm-Message-State: APjAAAVXHl4tbNkigeiFkfHYTyt6894soizj2tmSl/LgfuryjkFWaNT3
 a9J3EVuftLcxxjr57JIRyZKHoH0WmRtAImuV//BFhKVPnK9qaBnkWBFr2mZub/HUgO9/e+tHuSa
 nF9mbZiFEVAAfDrY=
X-Received: by 2002:a05:6000:367:: with SMTP id
 f7mr3263161wrf.174.1575911666576; 
 Mon, 09 Dec 2019 09:14:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyvz5PuqGfU50/Z3gEat8qW/TgDxrLxJH9vUnZLNsRIqstmyx+LBb5EOiqzbbOHcCyBglo4A==
X-Received: by 2002:a05:6000:367:: with SMTP id
 f7mr3263135wrf.174.1575911666328; 
 Mon, 09 Dec 2019 09:14:26 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id m7sm111177wrr.40.2019.12.09.09.14.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 09:14:25 -0800 (PST)
Subject: Re: [PATCH v2 11/18] qom: add object_new_with_class
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-12-git-send-email-pbonzini@redhat.com>
 <66eaa7a6-e238-172b-f502-39c90bb166c4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ee3f0384-3070-e1fa-eb36-1809c08dca46@redhat.com>
Date: Mon, 9 Dec 2019 18:14:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <66eaa7a6-e238-172b-f502-39c90bb166c4@redhat.com>
Content-Language: en-US
X-MC-Unique: m-ygRJd5Oi2y3qNJvpw97w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/12/19 16:31, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/9/19 4:01 PM, Paolo Bonzini wrote:
>> =C2=A0 =C2=A0 /**
>> + * object_new_with_class:
>> + * @klass: The class to instantiate.
>> + *
>> + * This function will initialize a new object using heap allocated
>> memory.
>> + * The returned object has a reference count of 1, and will be freed
>> when
>> + * the last reference is dropped.
>> + *
>> + * Returns: The newly allocated and instantiated object.
>> + */
>> +Object *object_new_with_class(ObjectClass *klass);
>=20
> The function name bugs me... Pick your poison?
>=20
> =C2=A0 object_new_by_class
> =C2=A0 object_new_of_class
> =C2=A0 object_new_for_class
> =C2=A0 object_new_from_class
> =C2=A0 object_new_with_class
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

From and with both make sense, I just picked the one consistent with
object_new_with_type.

Paolo


