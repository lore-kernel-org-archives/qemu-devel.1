Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3458EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:16:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2FE206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmcDyWXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2FE206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jguPX-000497-9D
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 14:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jguOX-0003SD-Pr
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:15:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55241
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jguOW-0004RN-MJ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591294512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WfF+Xa5h14FzGsbBSZhnNx5t0QaPtmV2BjSeSWVfvFQ=;
 b=CmcDyWXiY++xLtoAtWRegVNJnVDlOu3HkqTS0+2z8kTWDZt0HeJJ1174koUtvRLnSlBIzb
 wENV1az8fqbRAMEj+zKccTAVPBx127nZWP+28rk9JfJmu9zOtEhOBheAP5wCVRA48aM+Jg
 VgS1MMFvqh7ZjbdAm5PrvUKv/S5CHmg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-kmOvRRsnMa6Y_v1PzwEwwA-1; Thu, 04 Jun 2020 14:15:09 -0400
X-MC-Unique: kmOvRRsnMa6Y_v1PzwEwwA-1
Received: by mail-wr1-f70.google.com with SMTP id f4so2736480wrp.21
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 11:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WfF+Xa5h14FzGsbBSZhnNx5t0QaPtmV2BjSeSWVfvFQ=;
 b=t3Zdd4kpDGjeGVxdUUzDWI+Z4Lnqdc0CGMyDJYxtyR3LNBpHRGky70S/A07QE8UhV5
 PrOBjaJLS6TIV5UC9pCnJz6KBSQEKbW8q31/Zcbm5KdyEHgBWLgSYSW9XA61tiQ4st7I
 79vdNRu8Q/7MdPGJ65TgUu43A3tsTVsEWLLQmwSXK9CGcBLTAtMNJc7JR9wi8zToTQfd
 ZSK6URugmNi0KAcc6AooDVj/NbLEHMzmcTgabEBz/AXKYoC/u4F8UChs7O9fKilgkUrH
 X347c9QER901xwLuSiofUd3JQNHeB+clVf7xITovujZaMW6Rujybf6TMoWk8SP6sJvDz
 D8Xg==
X-Gm-Message-State: AOAM532BB4sR9IWNI1ijfhyWtn+G6nIt3MFfJ0ncXyWlX6+WePsngFne
 HWDg4TQe8zY5Lr/h3LDJYOm8ZDIyVNe77PXl3MfQzxxtElPNCIufGWvsOmHduFkj3INnJoqyMRe
 YS9Itni6xDTRUCRc=
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr5524267wrx.411.1591294508110; 
 Thu, 04 Jun 2020 11:15:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhlnqcxoAsAHQcRo1z/xrYBhD25SwWgISjl/tM8Kht+LLVr1VYbRV6BOLsz/g66yBmC+XAqQ==
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr5524249wrx.411.1591294507793; 
 Thu, 04 Jun 2020 11:15:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb?
 ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
 by smtp.gmail.com with ESMTPSA id t14sm9809856wrb.94.2020.06.04.11.15.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 11:15:07 -0700 (PDT)
Subject: Re: [PATCH 05/13] i386: hvf: Use ins_len to advance IP
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
 <20200528193758.51454-6-r.bolshakov@yadro.com>
 <be9d6f5b-5297-459f-3192-26835fdac230@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed29b528-17bd-c418-067c-7e68c93f53c6@redhat.com>
Date: Thu, 4 Jun 2020 20:15:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <be9d6f5b-5297-459f-3192-26835fdac230@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/06/20 08:39, Philippe Mathieu-Daudé wrote:
>>                  simulate_wrmsr(cpu);
>>              }
>> -            RIP(env) += rvmcs(cpu->hvf_fd, VMCS_EXIT_INSTRUCTION_LENGTH);
>> +            RIP(env) += ins_len;
> I'd feel safer if you change ins_len to uint64_t first.
> 

Why?  It will never be more than 15 (it's also a 32-bit field in the VMCS).

Paolo


