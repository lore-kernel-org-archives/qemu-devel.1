Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A159C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6744B207ED
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSMxYU6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6744B207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiLtu-00018X-LJ
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 13:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiLt2-0000Tv-40
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:48:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49530
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiLt0-00026w-6F
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591638516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RA7Qd/e5WmDCYilM5DXtSv9b2bjfckDER4ZIDZrQRWk=;
 b=VSMxYU6HWKWEgB7uyjZ4UNYsNE/+WmDUnNXlwmTji95gk/xKBXpudKKs+CK6OV0/yJ1ljO
 lwBJwQ11dXqe7O8UoxLTMdCgnh93dqbP9dfxd5Mt1Bz9hqtM6CjUMiLZbV4gHcUDnVBNfj
 Bm/RrpUDznjiZW9jh4FUGsuqbVngNlE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-27kDuMM0PK6KTYONUhfkhg-1; Mon, 08 Jun 2020 13:48:33 -0400
X-MC-Unique: 27kDuMM0PK6KTYONUhfkhg-1
Received: by mail-wr1-f72.google.com with SMTP id o1so7415524wrm.17
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 10:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=RA7Qd/e5WmDCYilM5DXtSv9b2bjfckDER4ZIDZrQRWk=;
 b=hgEvPpC0vAg867kEc8QKenHApgg7KmjFr1n5M3OCLLkGDYMQAjJjvf7NZDRksAERAu
 LJmMafocOlZ0ovZavlumWTaUnOVrcEO2IrnMPSF4Cp4SgQ9ggfOfd50m9QEKqdwEssHS
 0V9qByFX8nNPdf3CAuFxBBZWWpe9Y2+u6vT17o6bsCFRmdmhr1uTidKs/SYjApmyz3ow
 3ImoY8Jn8HOFqy7Fwt7l3yStDmGAuBoz9iJ720q52uswCMNHwaFYHI+AHO6xIh0FqNa8
 pcN64gBUNAEZoMJ1Tu//YxIZa8Ub01gSK0eD2N+ozezO/EQHKS0v8JH+rPgH92p+6Wkf
 SjXQ==
X-Gm-Message-State: AOAM532YiuVS8CkHEdntz6CuIV93FCamlkwTFr9tT4HaWBw3LSPvS5j0
 aygA2gbdGtNGyiyFfxBVFcBzpkLmHJToNbuyyjAPZ9ws5USioy26fjKk4SKpjs/iUV9gM/7ES6o
 p2MZLz+69OXeAymg=
X-Received: by 2002:adf:a350:: with SMTP id d16mr25551664wrb.237.1591638511742; 
 Mon, 08 Jun 2020 10:48:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKzBoZhucif4Bn1vadsBvZYbTpYmo0zHXJBJOOZ3PyIHtI7ukueTz+C9xX0XzfKapwXDMTXg==
X-Received: by 2002:adf:a350:: with SMTP id d16mr25551649wrb.237.1591638511470; 
 Mon, 08 Jun 2020 10:48:31 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y80sm252772wmc.34.2020.06.08.10.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 10:48:30 -0700 (PDT)
Subject: Re: [PATCH v3 00/11] hw/sd/sdcard: Fix CVE-2020-13253 & cleanups
To: qemu-devel@nongnu.org
References: <20200605102230.21493-1-philmd@redhat.com>
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
Message-ID: <7a456fdc-eb53-063b-1d5e-24472b4057d5@redhat.com>
Date: Mon, 8 Jun 2020 19:48:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200605102230.21493-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 11:58:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@wdc.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On 6/5/20 12:22 PM, Philippe Mathieu-Daudé wrote:
> Patches 2 & 3 fix CVE-2020-13253.
> The rest are (accumulated) cleanups.
> 
> Supersedes: <20200604182502.24228-1-f4bug@amsat.org>
> 
> Philippe Mathieu-Daudé (11):
>   MAINTAINERS: Cc qemu-block mailing list
>   hw/sd/sdcard: Update coding style to make checkpatch.pl happy
>   hw/sd/sdcard: Do not switch to ReceivingData if address is invalid
>   hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
>   hw/sd/sdcard: Update the SDState documentation
>   hw/sd/sdcard: Simplify cmd_valid_while_locked()
>   hw/sd/sdcard: Constify sd_crc*()'s message argument
>   hw/sd/sdcard: Make iolen unsigned
>   hw/sd/sdcard: Correctly display the command name in trace events
>   hw/sd/sdcard: Display offset in read/write_data() trace events
>   hw/sd/sdcard: Simplify realize() a bit

I forgot to Cc you.

Since you already reviewed a bunch of SD patches in the
past, do you mind having a look a this series? It should
be quite trivial.

Thanks!

Phil.


