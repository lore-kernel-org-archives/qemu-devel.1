Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206B7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF233206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rnq/3/fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF233206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTl4-0006tr-6F
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtTjn-0005sm-WE
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:25:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52662
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtTjl-0007Up-Iv
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594290303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Idqzh8EDTjXy/MXSQQSsscZD6q6G0CxwcbuIrdldq3k=;
 b=Rnq/3/fay4GTPK1qnMj4jBCLX98IrXtwozyAMeHZkQj4IZbduje6DxIDsZPZ7hIkMRXzDp
 +nv2o+KGX25axKADdMMlpZEKQ5oJLgVUP9a1oBGiRXLmVyxCLTzY+lq8VGD/a+Hzfedy3R
 U7WFENgGPUiewZzdq7ZRRnG/iCe0koA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-SbPZx4PJOq6z7KrMKkZZzw-1; Thu, 09 Jul 2020 06:24:59 -0400
X-MC-Unique: SbPZx4PJOq6z7KrMKkZZzw-1
Received: by mail-wr1-f70.google.com with SMTP id j16so1614485wrw.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 03:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Idqzh8EDTjXy/MXSQQSsscZD6q6G0CxwcbuIrdldq3k=;
 b=Kl+I/zpsLzt2kt3C2YqP7EEe0bPyTy815aW1KSXAi2SW2bp7xaEAL4QaFsxmmSbiGB
 rt7e+c+BepnrFBo/0AS3pTsvLghsCMh3a1+nMUBZoN816JyCrD+LaBumXFfqzh/lhpoT
 BWVUQqTjTeHq4UvxIvLXGhApLzsJ5y7dkIuD1t+tCNm+9zcPwfJkdiWbZJ/L6ZuXUvO5
 J69V2riXYMSwzJvXngW9D/VU7JZ45EArg482dM7jMxFWvuzyQvDUKyaV1JyrAeF2Aksc
 mCWZFRxHytfvs9G3uzTtij8MYwOkRALFe4LNKQ5A4KOuPpC6BHtuXRITX2/nHgCa85HJ
 UHYA==
X-Gm-Message-State: AOAM533Kfkm6nduqIZ8Ip2KTtZFz46J8L/KZO54uZ4qvDjoQdabB0HSv
 PbOHTKwj5iO25knGl2cAdXrmOrsOTv+1zHusgSQJC1oLGfqcQ0hGjyCbbrMvtaK9lTioZSxVI8H
 G+b66eDWN4KAQ/CQ=
X-Received: by 2002:a1c:6308:: with SMTP id x8mr14101007wmb.92.1594290298454; 
 Thu, 09 Jul 2020 03:24:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEhJj8IClyHDCO8pV1DfZrv7fvVGWi1uD2YWQ549T11gozD1j1kfqtLaKUsJvjZK5fG/ypoQ==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr14100977wmb.92.1594290298186; 
 Thu, 09 Jul 2020 03:24:58 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 138sm17929395wmb.1.2020.07.09.03.24.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 03:24:57 -0700 (PDT)
Subject: Re: [PATCH] cpu: Add starts_halted() method
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <87y2nu3nxq.fsf@morokweng.localdomain>
 <c53b36b7-ee7b-bb66-8220-cce788fd631d@redhat.com>
 <20200708100038.GG18595@umbus.fritz.box>
 <CAFEAcA9V7Uha9-rz+JY-5HkazCWuTk1vkLnw1m9Lw-bXXKbkvw@mail.gmail.com>
 <20200708152540.GZ7276@habkost.net>
 <CAFEAcA8mFM-O=mgCQHNz4TNB5N3Trid2o95s0Nx7JVp_q_dSrw@mail.gmail.com>
 <20200708160316.GA7276@habkost.net>
 <CAFEAcA89ueUQuVPC9O9xqbBBDEzdXmbCLL69OHvk0MJ=VvSnbw@mail.gmail.com>
 <20200708173620.GB780932@habkost.net>
 <CAFEAcA_bLs+PzjfmCaHQQ3z1BrQ9Uack_Qj7Za-dJwtHWu=8kw@mail.gmail.com>
 <20200708213240.GC780932@habkost.net> <87k0zdz8ud.fsf@morokweng.localdomain>
 <87imexz7v6.fsf@morokweng.localdomain>
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
Message-ID: <973a6add-715d-319b-0e69-f0c78ef5a7d4@redhat.com>
Date: Thu, 9 Jul 2020 12:24:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87imexz7v6.fsf@morokweng.localdomain>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:33:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 5:26 AM, Thiago Jung Bauermann wrote:
> 
> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> 
>> I'm seeing the vcpu being KVM_RUN'd too early twice during hotplug.
>> Both of them are before cpu_reset() and ppc_cpu_reset().
> 
> Hm, rereading the message obviously the above is partially wrong. The
> second case happens during ppc_cpu_reset().
> 
>> Here's the second:
>>
>> #0  in qemu_cpu_kick_thread ()
>> #1  in qemu_cpu_kick ()
>> #2  in queue_work_on_cpu ()
>> #3  in async_run_on_cpu ()
>> #4  in tlb_flush_by_mmuidx ()
>> #5  in tlb_flush ()
>> #6  in ppc_tlb_invalidate_all ()
>> #7  in ppc_cpu_reset ()
>> #8  in device_transitional_reset ()
>> #9  in resettable_phase_hold ()
>> #10 in resettable_assert_reset ()
>> #11 in device_set_realized ()

Dunno if related, might be helpful:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg686477.html

>> #12 in property_set_bool ()
>> #13 in object_property_set ()
>> #14 in object_property_set_qobject ()
>> #15 in object_property_set_bool ()
>> #16 in qdev_realize ()
>> #17 in spapr_realize_vcpu ()
>> #18 in spapr_cpu_core_realize ()
>> #19 in device_set_realized ()
>> #20 in property_set_bool ()
>> #21 in object_property_set ()
>> #22 in object_property_set_qobject ()
>> #23 in object_property_set_bool ()
>> #24 in qdev_realize ()
>> #25 in qdev_device_add ()
>> #26 in qmp_device_add ()
> 


