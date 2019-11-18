Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6102CC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F2920727
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gP17jQPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F2920727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWfP7-0000QI-9B
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 06:41:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iWfNs-0007cv-Vp
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iWfNr-0007Yv-VJ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:39:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37181
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iWfNr-0007YH-RC
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574077195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=HCiNPJK5K/6ImtDdczshCqsvQJzhMwbFVAvNEy0gSX8=;
 b=gP17jQPjmH8eoEdDTEhO4IqHrCcdG325hqBfTSQStK4JGttGkAzahvy+s0ckLzM6Y9H5lV
 sWI5+ufnVeck+gRExkK35sAcDKn/h3n/JTWHCxQ5TjpqH3RnqaA1rir+MfYfymuJPO6Hj/
 mAEe1+LqUJeRMeMESQPP5N0pUntoGbI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-wD9bLCMdOySlRDHXFeQcKg-1; Mon, 18 Nov 2019 06:39:50 -0500
Received: by mail-wr1-f71.google.com with SMTP id y3so15138082wrm.12
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 03:39:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xhrJrjU8Sb08VpuF7TCXlJtzglRFNis7wSjpksv502A=;
 b=NjknnSSa5sPzAT4BoXfm2LTfiRfBdiCz6hSpFrrG8dsWo0BrAWY6KeSqw6+2Bq3kX0
 juIOl8ZcO0j6QP58bkNt63q0TVsXxYtKvfyoBjyFwqrmvGIlrWgGAXEeSIyjVc0UmCgl
 vUz5Lkuwx2fS7H/8Bgv6m/5w8V+pHcyy0Gzyd8U753xwnjbYF7R2e1s03vgbyW+nfkBa
 QIsOpID+Xj79EJ4Qbm7decjP3Bz7CC73DSjyf38qv+Bj+6dj5fQlYDwIAZ1heV2u221z
 FT3FZ+CLmT+M4o8Q33mBb7at0d9GAM73lMWssl/fpTrBcc2I0aGz24tf0XdHYGTajVXj
 MT1w==
X-Gm-Message-State: APjAAAVrijWuzDSdZJktJJKk1XSYITR7PKg/FabaWv6HXr0bYcZfgKO/
 kJ/fAg2HEGGNphMHF6NULwq+QlT/031ufR+Q4oDD9RIGQVxCMtqi0kPHQHRNaGA6SCuAmzQ2bBd
 pJJt3enRos0Ojw3I=
X-Received: by 2002:adf:8543:: with SMTP id 61mr20961968wrh.171.1574077189681; 
 Mon, 18 Nov 2019 03:39:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqz++Feiutme8gCZgXvbdDwiIqm9Zj2SPZJYb+VXKhWO6Z2DaOBjEAJDpz1Mj2VTZsOkOgDayw==
X-Received: by 2002:adf:8543:: with SMTP id 61mr20961939wrh.171.1574077189344; 
 Mon, 18 Nov 2019 03:39:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc?
 ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
 by smtp.gmail.com with ESMTPSA id z11sm26951444wrg.0.2019.11.18.03.39.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2019 03:39:48 -0800 (PST)
Subject: Re: [PATCH 02/16] vl: extract accelerator option processing to a
 separate function
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-3-git-send-email-pbonzini@redhat.com>
 <5e5a4b1e-4ada-11f6-c551-c15de2404e7f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <941e7b95-8125-00b3-ab63-29b1697070bf@redhat.com>
Date: Mon, 18 Nov 2019 12:39:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5e5a4b1e-4ada-11f6-c551-c15de2404e7f@redhat.com>
Content-Language: en-US
X-MC-Unique: wD9bLCMdOySlRDHXFeQcKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/11/19 11:58, Thomas Huth wrote:
>> +static void configure_accelerators(void)
>> +{
>> +    qemu_opts_foreach(qemu_find_opts("icount"),
>> +                      do_configure_icount, NULL, &error_fatal);
>> +
>> +    qemu_opts_foreach(qemu_find_opts("accel"),
>> +                      do_configure_accelerator, NULL, &error_fatal);
>> +}
>
> vl.c is already quite overcrowded ... maybe you could add the new code
> to accel/accel.c instead? Just my 0.02 =80.

I liked the idea of keeping all command line parsing in vl.c, especially
because all the ugliness for backwards compatibility can then be
confined there.

Paolo


