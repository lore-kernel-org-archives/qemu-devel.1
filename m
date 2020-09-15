Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C3CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BDE20829
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZa7HP6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BDE20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAon-0003Of-IB
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIAiD-0003Uk-Re
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:09:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23456
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIAiC-0007TS-1g
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600175371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3FUZGwUJ54kls1uv9RP3OQTIUsCXiRXxgioGVgyMyno=;
 b=iZa7HP6vn6ValvrlPrGDrPYZN21WIdOyxWQVAacf4wCOKORQmXLSR9JRc70I4frUzPgbal
 u1LF88pmO8eXP63fJzdDEl4DVurbTqDUohP3nCkUhmdjRDJWwMDnzAvO4Fbz0wFCynpThp
 7GKIFfhXuiAISoebypmp58bwbHecMF8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-7I56itOeN4mVnDIDSPnOLA-1; Tue, 15 Sep 2020 09:09:29 -0400
X-MC-Unique: 7I56itOeN4mVnDIDSPnOLA-1
Received: by mail-wr1-f70.google.com with SMTP id d9so1201269wrv.16
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 06:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1s3/kJsBvTZHbdDRJUzGWcAwKIrlKomtvLUMuQm3xks=;
 b=FutC1xK6l29zy9QNKzAbJNehfMvtulbDdcxWjLtvp/PEC1j18QpHkHm1/KYEQ/fLc4
 e3F2ubHeszHeTHaRK1KmZkj2h6aK0W48073SQI3sNDdsIG1bxBjhkX6aajlozm9nYPl1
 MsD+CylCnLY/tC8nGj15c3E54aRZ07sa6/pl2KWxh66StHVAvGnllPQEcebed9x0ps+7
 elKPrzVvej52eVmFFYzWHxgLwmtvu8LDy6hGLt9vn5qVqiOMuowQFmMweVOD4PIb1/ix
 NKWHtVt/WbsNKslnYAlIXTrsRh5L4AiJpeWJVzUGekQZzQPK3t9A60D6fdtrtEnMsykT
 OQAg==
X-Gm-Message-State: AOAM530nJf4H/MXeudr9OT0h0v2J2lsbZvIDw5CjZTmwF+E8zWgsR4ej
 C/SXC6yYx6xf3IuuVkgpJGcnWG/ucILzemje3eYc1UXRtgLv3G/eLgbDPv/mHX5kWABMZY1qToD
 dgmD1ORfCOFuiQ3M=
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr23432924wrn.347.1600175368488; 
 Tue, 15 Sep 2020 06:09:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxauVAnBwtuqrVNLBHU5h+LG1oPgKl7UxnS5TKK0od/uu7BogPoavUjuZYVOPUcVaSbfm+b9w==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr23432905wrn.347.1600175368359; 
 Tue, 15 Sep 2020 06:09:28 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q18sm25849637wre.78.2020.09.15.06.09.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 06:09:27 -0700 (PDT)
Subject: Re: [PATCH 12/15] spapr: Add a return value to spapr_nvdimm_validate()
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-13-groug@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <c63dd75a-2336-6724-dd27-26676c678da6@redhat.com>
Date: Tue, 15 Sep 2020 15:09:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914123505.612812-13-groug@kaod.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 05:35:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 2:35 PM, Greg Kurz wrote:
> As recommended in "qapi/error.h", return true on success and false on
> failure. This allows to reduce error propagation overhead in the callers.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  include/hw/ppc/spapr_nvdimm.h |  2 +-
>  hw/ppc/spapr.c                |  4 +---
>  hw/ppc/spapr_nvdimm.c         | 14 ++++++++------
>  3 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


