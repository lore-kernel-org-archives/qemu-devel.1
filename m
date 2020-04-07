Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABEFC2BB55
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D321F2075E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHlBaotT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D321F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLqgx-0003TM-02
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 12:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLqXD-0006lO-En
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLqXB-0005fF-T9
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:53:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21523
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLqXB-0005eO-LK
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586274785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5gjgbplPVNjSw6yeDCD9HK/ITP33mRWm+N1A4dqtmE=;
 b=YHlBaotTQBxQeQeR9N/9qGmbD3jbHlOe1ZfzQcgLpZhY9UnfmsXxMQD6VxeoQ1m8wnR2iX
 LXsEyAlyuXO7ItMM+p4IE1SunJfJGnXCx9v4hRiTi09rvRysDlNAAG1SRH00pWIPL2GF/D
 cL87W2yH6dG/9OWv2f7f/mkBhAzm2oo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-cL-lBxeZMY-31Qq2FPWLRg-1; Tue, 07 Apr 2020 11:53:03 -0400
X-MC-Unique: cL-lBxeZMY-31Qq2FPWLRg-1
Received: by mail-wr1-f69.google.com with SMTP id 88so2198944wrq.4
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 08:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X5gjgbplPVNjSw6yeDCD9HK/ITP33mRWm+N1A4dqtmE=;
 b=GZA9FbepcNlVyFN3nSUOJOgfHOhWh5XuvisB0q2UMJc+pdircNJluL6MjXOwG6Hwbv
 DkcMF5JrEi2ze+ygELMLwfewKqTURs1jS/+2Mi+VvU8NULQ+anmgqWkv4Sqa8p2lBrmI
 ha1Ttrs80q3eee7jY4u7d3YbcDwaQsmfDDk3T9lGiFIb3/IRVorepZUHV5tZdZSmqL+g
 2/INOUlVKG4GR9Tkaipu8LpmICL6BGywc0pfUo3JXjisDqXCaHWbBhIThCNIy7b/C+3Z
 qlSqmj8YGu8+Q0xN5MbQqu0Ftw55j+rXyxA3+zrZDm3zuK5FNxjSm/LK7tp/fIpG55DS
 7mWw==
X-Gm-Message-State: AGi0PubV41uJ4u2aa3cNaED4Kn5FbniHVaId97lGx9DzeIONuJUf51W3
 jpVeHitos1/T8Adw8YGYPpIsm7oPzhEeKdqmsrICki4pEV5fnbEYZsQbHOFyWOI2a7/JSJ9EETY
 QJBtvR+d9OCxwUe8=
X-Received: by 2002:adf:f8d2:: with SMTP id f18mr1020361wrq.139.1586274781866; 
 Tue, 07 Apr 2020 08:53:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypKW+RJ0xQgoE0IUYSEWszWLNEIvL1Xo2pDJu/X6HP/16/9/n/vZklnSJw8TbGB9x+b9ykRVxg==
X-Received: by 2002:adf:f8d2:: with SMTP id f18mr1020296wrq.139.1586274780902; 
 Tue, 07 Apr 2020 08:53:00 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id p3sm11055825wrq.97.2020.04.07.08.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 08:53:00 -0700 (PDT)
Subject: Re: [PATCH 2/5] atomics: update documentation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200407140746.8041-1-pbonzini@redhat.com>
 <20200407140746.8041-3-pbonzini@redhat.com>
 <25ba1237-510d-cf4a-2b4f-c5fa1d715976@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bfec4cbd-bbbc-40ec-554b-53b0ffa38ba0@redhat.com>
Date: Tue, 7 Apr 2020 17:52:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <25ba1237-510d-cf4a-2b4f-c5fa1d715976@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: fangying1@huawei.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/04/20 17:25, Richard Henderson wrote:
> On 4/7/20 7:07 AM, Paolo Bonzini wrote:
>> +- release operations will appear to happen, with respect to the other
>> +  components of the system, after all the LOAD or STORE operations
>> +  specified afterwards.
> "specified before", not after for release.

Not the only one such pasto (e.g. "operations coming after
``atomic_store_release()`` can still be reordered before it", the text
said "after").  I have fixed all of them.

Paolo


