Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B56C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E63621BF6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZ+7Yslt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E63621BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNw9-0006wa-Ei
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54726)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvNu5-0004mF-U8
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvNu0-0004rp-Iu
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:31:02 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:42883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvNtu-0004lC-NM
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:30:55 -0400
Received: by mail-pl1-x62a.google.com with SMTP id ay6so41397883plb.9
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pCpCz+CvOCQ4pr1rksowSTze+rOo02yQPlaBVcHqATE=;
 b=XZ+7YslttNOCrt7toERtmFJPyciz+nlLvKU+YMjuaKFeRqjyiTNJhpHnxCBA656sv5
 bXm9lc6HoVEsiYbeBFc5D1YUYCZ1DL3Mz54Mu7QB1zOf3pQm/CErkxyPK4hFFd/E2VOf
 l3ASNiZQFQVF6qKGV/KonB+hx+5hF+qoIAOsTVl52DCvyeKxpAb/6ha/4FQd5+UTR1r1
 l+Sw1Q+wryV/0jsnRdS19fFEnG9eY5PNMZ3PJb1Noi/QFkqdr1GDxJuPR9JZegDVV1ZA
 ZxOsjL58c+r99JCaLAs0+ab+rWmV7PC/7XE3JCbCWv9G1sRw30q1h4eGIFHWlliDZtIW
 Mc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pCpCz+CvOCQ4pr1rksowSTze+rOo02yQPlaBVcHqATE=;
 b=VhRlV0ZcExfg40DtfqUjsjLGLjKQxLbzqZxRRmItPjeU+RNPdxwieUREmhRzGsVMSo
 ulCaG4iogzjzm24DT4AoG9xB7cBCRS4ESkmKJq4pJE059TPm+1WHXVVRb0s97yey1Rc4
 o4k2rVEDGTC977C6vMUv6e2jgf1u2k1qL5LJzodmu9GSH6j6eUDnpqsF8LJ8yLcONwOY
 zFnsBmPP+0YBt3SHwk95UhIE1ul/Yo3jpne9zXI+wg9bwAO+d1ZsPBpamtvhReUYC4HD
 aUScjSRuPTly6Gg/1S1cjsqLh4wD9MMIjoQkUJd/DoCVvpJmMC+iR+j38ORCO9Ja2nnp
 Peqw==
X-Gm-Message-State: APjAAAVxg7dswXKVq9jioxXaOb8M735itFt2n6vUgOGTnyFmfAjNCCT8
 M40TV1R4fIgIj2BTU7+qiIwGbQ==
X-Google-Smtp-Source: APXvYqyzEKXZhyWbZHS9mUCJhdYcCK08eh017J9JqBLo284jw3umKEd2sQYd69ZxwNR55VZOhXHr6A==
X-Received: by 2002:a17:90a:d3d4:: with SMTP id
 d20mr533420pjw.28.1565191850899; 
 Wed, 07 Aug 2019 08:30:50 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r12sm75560234pgb.73.2019.08.07.08.30.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 08:30:50 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>
 <1565166407497.21726@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ebba4aef-c264-53c2-a503-e82219a2df35@linaro.org>
Date: Wed, 7 Aug 2019 08:30:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565166407497.21726@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62a
Subject: Re: [Qemu-devel] [PATCH v6 03/26] memory: Introduce size_memop
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, imammedo@redhat.com, sagark@eecs.berkeley.edu,
 david@redhat.com, jasowang@redhat.com, palmer@sifive.com,
 mark.cave-ayland@ilande.co.uk, laurent@vivier.eu, keith.busch@intel.com,
 jcmvbkbc@gmail.com, frederic.konrad@adacore.com, pbonzini@redhat.com,
 kraxel@redhat.com, edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn,
 pburton@wavecomp.com, marex@denx.de, robh@kernel.org, hare@suse.com,
 sstabellini@kernel.org, berto@igalia.com, proljc@gmail.com,
 qemu-block@nongnu.org, arikalo@wavecomp.com, jslaby@suse.cz, deller@gmx.de,
 mst@redhat.com, magnus.damm@gmail.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, mreitz@redhat.com, hpoussin@reactos.org,
 joel@jms.id.au, anthony.perard@citrix.com, xen-devel@lists.xenproject.org,
 rth@twiddle.net, philmd@redhat.com, green@moxielogic.com, atar4qemu@gmail.com,
 antonynpavlov@gmail.com, jiri@resnulli.us, ehabkost@redhat.com,
 minyard@acm.org, sw@weilnetz.de, alistair@alistair23.me, chouteau@adacore.com,
 b.galvani@gmail.com, eric.auger@redhat.com, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, peter.chubb@nicta.com.au, yuval.shaia@oracle.com,
 stefanha@redhat.com, marcandre.lureau@redhat.com, shorne@gmail.com,
 sundeep.lkml@gmail.com, jsnow@redhat.com, david@gibson.dropbear.id.au,
 kwolf@redhat.com, crwulff@gmail.com, qemu-riscv@nongnu.org,
 xiaoguangrong.eric@gmail.com, i.mitsyanko@gmail.com, lersek@redhat.com,
 cohuck@redhat.com, alex.williamson@redhat.com, Andrew.Baumann@microsoft.com,
 jcd@tribudubois.net, andrew@aj.id.au, michael@walle.cc,
 paul.durrant@citrix.com, qemu-ppc@nongnu.org, huth@tuxfamily.org,
 amarkovic@wavecomp.com, kbastian@mail.uni-paderborn.de, jan.kiszka@web.de,
 stefanb@linux.ibm.com, andrew.smirnov@gmail.com, aurelien@aurel32.net,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/19 1:26 AM, tony.nguyen@bt.com wrote:
> +/* Size in bytes to MemOp.  */
> +static inline MemOp size_memop(unsigned size)
> +{
> +    /*
> +     * FIXME: No-op to aid conversion of memory_region_dispatch_{read|write}
> +     * "unsigned size" operand into a "MemOp op".
> +     */
> +    return size;
> +}
> +

Return type should remain unsigned until patch 11.
Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


