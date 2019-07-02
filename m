Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A5FC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70DC2089C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70DC2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiEbT-0000LN-2t
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 04:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59338)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiEak-00086U-7c
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiEag-0001yI-7k
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:56:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiEae-0001te-Tv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:56:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so37671wma.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 01:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oSjvuz2rugAVIKLouuWDhPV3/dlyDm58XcPPJ0cZhBo=;
 b=AOfhCDe+3OIKw3EWLz0OBOL8QfSDd4jrY0BfdwPSYQDx8Pa2VPKLf+vdu1wnP4+zY0
 YC0Nm4NZ1dxTHrai6MkzzIyCildzExFH+mx4qTh73TfB9yDwOOD+5NgmVYU/JPN6k+uA
 tyZRbXgATel/hawgz3czv2UqSeTVe1qf8XnnEEhYGFkv+l3QYmkm+25JX0YSptslI85c
 +Ag+NuafWW0q4w22j7SaqtpE4QWjeSne3OH+Nb4W+5iLqTtLKNY7DfW6fIYh4oizbRcn
 lV8KenJzat41ru1F2KZHdDq1FQ+05natOldrsQeqyN5Gav7HaTE+tyvona66B42q+qrD
 5i9g==
X-Gm-Message-State: APjAAAVByI4RXve2zZNAnjsirYQklkR7IGBV1n/PPg04Z9QvIwqaki4F
 RXkuwyhGsj37ZmOXpwTqHx+GbQ==
X-Google-Smtp-Source: APXvYqzavQsjjanmDdSOSqbEFW+E/L9Dab2/hQCjCa0+hFGKBaQ1bWB2WZtkeUrG080nEDOorBtCGg==
X-Received: by 2002:a05:600c:da:: with SMTP id
 u26mr2551980wmm.108.1562057790847; 
 Tue, 02 Jul 2019 01:56:30 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id 66sm1984331wma.11.2019.07.02.01.56.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 01:56:30 -0700 (PDT)
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com,
 David Hildenbrand <david@redhat.com>
References: <20190701190819.25388-1-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <78aa3a5a-9d29-c29d-64e4-ca16a69f4de4@redhat.com>
Date: Tue, 2 Jul 2019 10:56:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190701190819.25388-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] tests: Update DSDT ACPI table for arm/virt
 board with PCDIMM related changes
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

On 7/1/19 9:08 PM, Eric Auger wrote:
> PCDIMM hotplug addition updated the DSDT. Update the reference table.

Can you point the commit sha1 please?

> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  tests/data/acpi/virt/DSDT | Bin 18476 -> 18493 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)
> 
> diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
> index 20e85c7f89f645c69935c615c07084e221419960..1a5c3e5243c78eb25345fdf7ffa442afec3c5c28 100644
> GIT binary patch
> delta 172
> zcmZ28fpPByMlP3Nmk?VI1_q{Y6S<_BIvO{s=eSSi^^mWRZt~=a(Tfjuig$N)iRXy-
> z@O0sIbPn(|FfcS`;D`?ea)A;+mUB?BARiZZCmRDZqb36bLnT9WgKLnhI|B~`0|zG;
> zOLQYQi0kYc?CPT+ViNBf7Q$Ho;v_5(n_Qj1$iNt*&kVB1*CW8$H`v*4fdEjLhl`1U
> Ni>WOjJjjWw0RY`tDw+TQ
> 
> delta 134
> zcmdlxfpN_QMlP3Nmk=Ef1_q{ziCof5?F}2%bKIpo*xdvC4LIUGJY9GlgM2*<49pA}
> zIN}{$f+og`c`$P_2rw{ovN13+sxvS!RDxt&Jq4Ay6ndl?7@-g-A<n=c$sh-0Ff)LR
> Z11c2ZjdwLLW@rlt4|3vam^{&45den68LI#Q
> 

