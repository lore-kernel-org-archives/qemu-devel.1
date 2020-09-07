Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3575C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE423215A4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qca0+++q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE423215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFO7L-0001yF-3W
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 16:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFO6d-0001NX-6F
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:51:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29897
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFO6Y-0005re-Vn
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599511869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=K63RMpXAMZNFai7c+z6Y/TSjOeCOK/yAAjshME+zBXE=;
 b=Qca0+++qQb/P7ARpU95r5r0SEOl9Xx5jYQXc7jGbsTO8hF5xVbnH75JXIjbjj/54381kIG
 pSiV5RkVPG86HCn8VcDhpV8CTceA/OA9IYo9k8EkPkZhI3zzmWBWZMgeOn4UrARiEuaBHl
 EC+IWMJ9Vgi3TE2tz3fth7GtC/MPHsI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-u1bgVCtVN-GTDGBcXqCTZw-1; Mon, 07 Sep 2020 16:51:08 -0400
X-MC-Unique: u1bgVCtVN-GTDGBcXqCTZw-1
Received: by mail-wr1-f69.google.com with SMTP id g6so6100188wrv.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 13:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K63RMpXAMZNFai7c+z6Y/TSjOeCOK/yAAjshME+zBXE=;
 b=pSKRbtXynNdonvgG7+LzRg/y/Xch2ISMz2fxBylS5SLFWol33udevbbLeFsRJAhGF5
 B+AXGJeYur1giSdY6cqY/kFm+3AxqNQAiMc5d7S55sH8oqb9tF+5KjmnkFgGGgXE8P/q
 XEZCyFU7HBc1ms6Wc2WzJQuIMLEJMfOFziOrvrRLirTOS3z24DlzzAxirzEj+MtVaSYG
 ifO6YygjubcSTs7EyHwfEZeDZKG2asAZm3mIuy0PT9/KSZ6fJLPEHXuv2jCYbEYnRkFA
 JH1TSud6PcFuhRmkQxvKNN7U5QWBkGn6gZHQIUICVFs7eyj1IirhKGXsQkKxzosAF/Od
 FHzg==
X-Gm-Message-State: AOAM533TfxW0r5eiE7CvTtkYMg6CxlVrk2R3by2/Ld74eaQiGg/yEJI5
 st7QUx5MxYsQDcmzJfdOiXOek72fApawu7xr4+aEdEK46kl1xH9ZKz+YdDPf/SkB1wZMDh3fy6l
 606KCzwYgACHMRpo=
X-Received: by 2002:a1c:7d0c:: with SMTP id y12mr1025786wmc.103.1599511866754; 
 Mon, 07 Sep 2020 13:51:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymovX0fcQgkoIFW2O1etmWIAeVVrKlHLuQw2Na/c9b+4eddKKmLAm1T4jLonjGG/N4syF16g==
X-Received: by 2002:a1c:7d0c:: with SMTP id y12mr1025770wmc.103.1599511866527; 
 Mon, 07 Sep 2020 13:51:06 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l15sm30338966wrt.81.2020.09.07.13.51.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 13:51:06 -0700 (PDT)
Subject: Re: Where does these TPM flags comes from?
To: luoyonggang@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
References: <CAE2XoE_k-=TT8S3vjbf_4c0kR96NhZ87zmfrYBxbStXyeb=FLA@mail.gmail.com>
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
Message-ID: <5a758e6b-161b-878e-e7f2-70358c6d9369@redhat.com>
Date: Mon, 7 Sep 2020 22:51:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_k-=TT8S3vjbf_4c0kR96NhZ87zmfrYBxbStXyeb=FLA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 10:45 PM, 罗勇刚(Yonggang Luo) wrote:
> tpm_ss = ss.source_set()
> 
> tpm_ss.add(files('tpm_backend.c'))
> tpm_ss.add(files('tpm_util.c'))
> tpm_ss.add(when: 'CONFIG_TPM_PASSTHROUGH', if_true:
> files('tpm_passthrough.c'))
> tpm_ss.add(when: 'CONFIG_TPM_EMULATOR', if_true: files('tpm_emulator.c'))
> 
> softmmu_ss.add_all(when: 'CONFIG_TPM', if_true: tpm_ss)
> 
> I can not found the config for CONFIG_TPM_PASSTHROUGH  and 
> CONFIG_TPM_EMULATOR 

This device is available but disabled by default.

By default only the configurations defined in default-configs/
are built, but you can add customized configuration.

This allow you to add or reduce the set of features you want
your build to have.


