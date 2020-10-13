Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D347C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDB420797
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzZeO9fN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDB420797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFhd-00054O-VY
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSFeg-0001dG-MK; Tue, 13 Oct 2020 04:27:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSFef-0003sT-7V; Tue, 13 Oct 2020 04:27:34 -0400
Received: by mail-wr1-x442.google.com with SMTP id n18so22915626wrs.5;
 Tue, 13 Oct 2020 01:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=U/6SIzv+udIiDx5353Wz/cytuPb04leMRw/aIB8tFjs=;
 b=NzZeO9fN2tiRWL7EJSKbU9JyYE3Q29OyvNfz64T26Du0+l0efqC+9SlZBBp80hZDiP
 EqfNJhbS94Fr3z+li4IRANKoyIE9lKKYP9W0PG77Vg/kkgsVddcuwSsf+Ye11GyNkDoz
 HnSWWjkb/Ddpsi1vF5gdlwmGvpSfV6LRNwGKqy7Nepcrpfme1IXFMUbWMJFUUJrIGlAj
 1TSSbtgBEZCdyaF9iTc807SGHmpIEeSHJJugyC6WP1069SItJWFVpBaQQk5bq9QHMTS1
 s9vvbw2MLb9mjt3iUqboiQ79kjzvdmrP4tU6owVzeK9TGxUEs2Oq9rsZnZkIGqqY9kus
 onSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U/6SIzv+udIiDx5353Wz/cytuPb04leMRw/aIB8tFjs=;
 b=koZf9TmH/THoSEpeun6S9nSwvRo+X3qHQvGjuTcPVbtij+KasyQ3ZkuvYZ+MIycYtS
 dxBHyeDpaTBN0MAwIypiyhND+DGwlEOYMsNHsejdqGSaxTAtFmzIHtmAmcNGdk+TUSJP
 fNS4hjJ1Ktxi7XHR7XkyrGILXvQtcEoAW8FYZ6CFkDVOMoyVZymLMre4N358UVdFq0ZZ
 nhX8/8tcuKzU3sK+1bcqR8/gXBA87U/2xTjbJfHUG+gAwlMJNUyZfx0T8DCJmlwdbrvU
 mfRCrTZuyZLHNKnzxchR0ycYd5FLuXG76Td+japi4MyX9HtncfE+RMGn6/EaH0IP3aKH
 f75g==
X-Gm-Message-State: AOAM5307x3sCbR06j+P7NvBwRZ8TYV5x6TLR+THgUOw/iLtyfDJi9ZTD
 4I35laeec9xYujddGmAJQ3M=
X-Google-Smtp-Source: ABdhPJz5d7s0Orhi1JyMr/PVfczZahchmfz+6mUQTJ9FWE1GPNDVvCpODNuPliiQVryYCVwq3kD33Q==
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr35260086wrw.252.1602577650850; 
 Tue, 13 Oct 2020 01:27:30 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id k16sm11762637wmi.5.2020.10.13.01.27.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 01:27:30 -0700 (PDT)
Subject: Re: [PATCH 08/10] hw/isa: Add the ISA_IRQ_NET_DEFAULT definition
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20201011193229.3210774-1-f4bug@amsat.org>
 <20201011193229.3210774-9-f4bug@amsat.org>
 <20201013072359.t3q7q4ck3cggschm@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e74c18d1-773b-5824-eb02-143696e8ae80@amsat.org>
Date: Tue, 13 Oct 2020 10:27:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201013072359.t3q7q4ck3cggschm@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Corey Minyard <minyard@acm.org>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 9:23 AM, Gerd Hoffmann wrote:
> On Sun, Oct 11, 2020 at 09:32:27PM +0200, Philippe Mathieu-DaudÃƒÆ’Ã‚Â© wrote:
>> The network devices use IRQ #9 by default. Add this
>> default definition to the IsaIrqNumber enum.
> 
> IRQ #9 seems to be sort-of standard for acpi.  Not sure whenever that is
> actually written down somewhere.  IIRC in pre-ACPI days it was free
> like irq #5.

OK, I'll drop this patch.

Thanks,

Phil.

