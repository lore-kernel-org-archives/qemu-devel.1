Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FDBC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46AF20723
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dU01LtNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46AF20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdAvY-00082x-Tq
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdAuh-0007Oe-Jj
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:04:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44321
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdAug-000679-Sr
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590404698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7MsL3+kXII9bb2SiLV/5/Xb65b4QmmJXwmb+O4HFbA=;
 b=dU01LtNs9wyHwFcTSJZ+NXP1ok1h+DBpmNcf9YVyBkU6b+rdfOvGKU/YeerVa5DkAFMpgc
 E5RAamDBq+st28geCNYllWgzLfDE8xlpveWkpVvgww1syN8FGE/MbDJtZXQycCrpJVSfYe
 tT7lb6Xr9EjV3W2oV7h11GatyiLn+iA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-72sH34k7NlWpDI9pFyxbYw-1; Mon, 25 May 2020 07:04:56 -0400
X-MC-Unique: 72sH34k7NlWpDI9pFyxbYw-1
Received: by mail-ed1-f69.google.com with SMTP id f10so7315812edn.10
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 04:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q7MsL3+kXII9bb2SiLV/5/Xb65b4QmmJXwmb+O4HFbA=;
 b=hfJi+miNk9QNI1eRnV8muuz9bIFjUUlKxa0tKvXCdjA0U1blN5prnNzxHY1WJhuW4S
 58HqtG/65P27ojcjgv09uU/WeWZT/YEXDxZk1FC/+/XDj3/VIqzI666XVPZOpuFjOTID
 Geb/2Teh8KYnx0/CtI0LOIJCv46WJM0Is/gp9uDRJGAaHsuZe1q01yezdb63HMXJtRBw
 Fa/pqLF6Ep+sL5HphWfYi3zabaZ1wfwzHP3v+Vx32Q7kfsCYBgYWzjbXYqdM0ffI3ExI
 tT0hNYovnjrjKcX3MjHiw3qQmsw233t03Mn7ewqDTjedvbnDwtR5QeOjGkmGYpn6BauE
 QeqA==
X-Gm-Message-State: AOAM530OBIw1rF6Dwxmtt1LXs+IQVfrJkkvm1JyCRqSrD3I7e/KJoscX
 gN0rq6Un0z55Q9A81ain3/hB0scNE5CJUeMnKQnRzhE0lp/hrODlDVgNXOcu9U5llxqEHYH96o/
 qn/OtEBrUXAhTKSo=
X-Received: by 2002:a17:906:c401:: with SMTP id
 u1mr17780048ejz.151.1590404695145; 
 Mon, 25 May 2020 04:04:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpEcq2NhhrHhizPJiN84XfRrAcI8e9brAT0DhVh0/jdJclIAq+H4J6MdeB9TkPI/8lN8yQFA==
X-Received: by 2002:a17:906:c401:: with SMTP id
 u1mr17780031ejz.151.1590404694969; 
 Mon, 25 May 2020 04:04:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8?
 ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
 by smtp.gmail.com with ESMTPSA id u26sm14867932eje.35.2020.05.25.04.04.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 04:04:54 -0700 (PDT)
Subject: Re: [PATCH v6 1/3] memory: drop guest writes to read-only ram device
 regions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Yan Zhao <yan.y.zhao@intel.com>
References: <20200430080744.31232-1-yan.y.zhao@intel.com>
 <20200430080946.31286-1-yan.y.zhao@intel.com>
 <CAFEAcA-8NH_4ZV0J9urBZdQWmqOe-Nyy4y2gLAjTJ08MpfFY0g@mail.gmail.com>
 <9dd7f00b-1199-1097-80d4-1b700c0f28d6@redhat.com>
 <20200525011853.GB8867@joy-OptiPlex-7040>
 <f836eeb3-0655-2842-2e8a-b8a42710a765@redhat.com>
 <229ec974-1939-31d8-3516-12e7b8fee27f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f1c43064-7a47-3fb5-8114-ff223ad9f0d3@redhat.com>
Date: Mon, 25 May 2020 13:04:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <229ec974-1939-31d8-3516-12e7b8fee27f@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 02:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, xin.zeng@intel.com,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/05/20 12:54, Philippe Mathieu-Daudé wrote:
>> Not all of them, only those that need to return MEMTX_ERROR.  I would
>> like some guidance from Peter as to whether (or when) reads from ROMs
>> should return MEMTX_ERROR.  This way, we can use that information to
>> device  what the read-only ram-device regions should do.
> Is it only device-specific or might it be partly arch/machine-specific
> (depending on the bus it is mapped)?

Good point, I think that could be handled by propagating the error up in
the memory region hierarchy (i.e. the cached AddressSpaceDispatch radix
tree is used in the common case, but when you have a failure you
percolate it up through the whole hierarchy since that's not a fast path).

Paolo


