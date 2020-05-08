Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A314C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DC221473
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ok8vTtJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DC221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5cG-0004Lm-1g
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 12:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jX5OW-000203-8T
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:58:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52082
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jX5OV-0001n1-IO
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588953514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTUXMQmDa+FxahjGnXMPJb6FhVMxmy0XknlvBB2lhGQ=;
 b=Ok8vTtJAUFdC1uLeL/Lbo20UTpftEhSX9uINft8AC2Rh0VGh1+7xNr5Hc44LQMj7Ombsqg
 KQnovvVPQXnsGxakLZ9GqwNSKwRFpRx9AKROeeNPd3zUfuJwq8azpbvfYE3zjviChXlxnW
 uHl30cYyAZGf43wCe0yF/H1aL/NmcJ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-OOc9w4_gNbeLcm6-caDQdg-1; Fri, 08 May 2020 11:58:30 -0400
X-MC-Unique: OOc9w4_gNbeLcm6-caDQdg-1
Received: by mail-wm1-f69.google.com with SMTP id l21so5381340wmh.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wTUXMQmDa+FxahjGnXMPJb6FhVMxmy0XknlvBB2lhGQ=;
 b=tTbswJDxtLFP98SV6ezfKsMkIMBlI5sVet3eF7S2rJN/Ak1N7vxMXBCnhlh9Ypk39e
 7EGlIiOR+LGkCbNqaoe7Tn4KJmhfMJBAfOUfsxH+UwAyNehULW3E6J+90+V6tQ8Tz/HB
 ARUgM6Il5cbzTwB9MyuKETf7VeNhTJBYgZkPr8/OrvOrVxhEB3qswPRzLj5ygvu60pkm
 Dmc9gsBaL32t5zFJ8Of3AwzNue+8UyCdDEDZ00pshRTI9Wzy0IsPo+D+mlmT8iLmaTaO
 BOH9kQWvpa0/+D4eNCGUvC/fgTrPH7aAEtJR6lTfVRiKGGMJjEPV+Z0Ei9Zqd9qIBv19
 vbxQ==
X-Gm-Message-State: AGi0PubNPQieJwBcEGzWWa8fzWIWpetzZ5xjJUAPG9blv+amJdZU8smi
 7nQdk4y508H+CrqDv37h16wQi6Z8cOwfPLXrZg+/zZCPsZc/bUpvP/sRty1L1S7fTB7LyiiowGp
 LO9u0x8CLJrfktnQ=
X-Received: by 2002:a5d:684a:: with SMTP id o10mr3558669wrw.311.1588953509530; 
 Fri, 08 May 2020 08:58:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypL5Gcew3Hc3b6/iJVLsETDRJ3yUdT5UDlu52ZGXVLExvEV5jT6BSPcurOZC+DObynv9C82+dg==
X-Received: by 2002:a5d:684a:: with SMTP id o10mr3558646wrw.311.1588953509281; 
 Fri, 08 May 2020 08:58:29 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.138])
 by smtp.gmail.com with ESMTPSA id m1sm3379155wrx.44.2020.05.08.08.58.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 08:58:28 -0700 (PDT)
Subject: Re: [PATCH 0/4] memory: Add memory_region_msync() & make NVMe
 emulated device generic
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Beata Michalska <beata.michalska@linaro.org>
References: <20200508062456.23344-1-philmd@redhat.com>
 <9396e0cb-388a-e08e-c066-82a60708ecdc@redhat.com>
 <CADSWDzvECqOXzusk=tj8r4z-E5CDZn4TNG8PJ5pxLHAn3saOzA@mail.gmail.com>
 <500bd6f3-2b14-eda8-72e5-56c46b7860bd@redhat.com>
 <653758ab-468d-b6f8-0ca6-404a799e3928@redhat.com>
 <CAP+75-W=DVYQuh0bVMRdo=mK8nLA=4VmsjJfXfO+TBwBj+aw0A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <09b4b2f7-572c-08a5-d1d4-214609de8b85@redhat.com>
Date: Fri, 8 May 2020 17:58:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAP+75-W=DVYQuh0bVMRdo=mK8nLA=4VmsjJfXfO+TBwBj+aw0A@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Keith Busch <kbusch@kernel.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/05/20 17:35, Philippe Mathieu-Daudé wrote:
>> So I understand I can simply rename memory_region_writeback ->
>> memory_region_msync in patch #2.
> 
> (removing the mr->dirty_log_mask).
> 

Yes.

Paolo


