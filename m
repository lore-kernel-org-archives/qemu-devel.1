Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9DFC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0234E20E65
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEhZ/SMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0234E20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcApp-0006wT-0I
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcAnl-00059f-Ih
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcAnj-0001z6-8E
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604942274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bk9TRqbHoDaQFLjOz+ZQwrThs9Qtbwj0JY8lzsvEfPk=;
 b=FEhZ/SMCz/N2UMq7QgMzyzM1qrW+1jnf+TD6Sn5FwewRq1X9Qf0Mbl41Jwr0vQFjbn5wyd
 IAWB+tSTLAXw6L7zUBn3W5Al7NzAn0LEGLkRAIxtqcO3U/s7ZeXVTbj3r20T83x6q9m49E
 fQjzCGVQIO57djV4p1uw9Vm6JCVxWaE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-ZWowo924MUiYtzZMhLe5lQ-1; Mon, 09 Nov 2020 12:17:52 -0500
X-MC-Unique: ZWowo924MUiYtzZMhLe5lQ-1
Received: by mail-wr1-f71.google.com with SMTP id k1so3266864wrg.12
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 09:17:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bk9TRqbHoDaQFLjOz+ZQwrThs9Qtbwj0JY8lzsvEfPk=;
 b=llvW00FuJJz8AkRAAu/bnMf225fqkAkXA4QpetdAK/81l+/Cv/fZ2q/z4Yd16AN3Jp
 6AkybRypISR0pTlFLWVaGo0VlwmeJuXPBlutaj0/4THzQ/lQpBrml/DQ8qu/IkAJeF+C
 S2TIycuaGo7aIctTDpb0JwQjSSfyDAeRT+elkNxfOb5y2PrXeCmzQ2Yh1jnLxy5N7NdW
 PK3ukJ6LZtYGbbxpMFihCAt+cDYdaZKE9AX7WeJuwbQeE1RygqkBB5u2X73VuNHiRHHU
 GbRhKeYYdzoun1ECzs5RX4prGJgV7r36QUCJnsVdF6yjBkTCxQ5YBKpLh+QoQZofBCCn
 HBcA==
X-Gm-Message-State: AOAM53243FG1e+DE5KJ40snlPHSrUhboqGVOKJPJ1xg/+FAFSUOqGLKC
 0IstQvUrH8JBwx0G5G6/eJEjowMsebPoP0JDmIzfruiC+nNWxp7WYtRbUYn7QB6dX3Eq/x6M/ar
 tup+8gOaxx5dN0bY=
X-Received: by 2002:adf:9b95:: with SMTP id d21mr18325108wrc.335.1604942270635; 
 Mon, 09 Nov 2020 09:17:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyax26Hg1lYbhqgeJHrDV3gMm4SNBSfn5pvVPXJSa0cwidr6ym2x6uD8sa4DNC8BekKXlUEuQ==
X-Received: by 2002:adf:9b95:: with SMTP id d21mr18325093wrc.335.1604942270462; 
 Mon, 09 Nov 2020 09:17:50 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id s4sm7103902wro.10.2020.11.09.09.17.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 09:17:49 -0800 (PST)
To: Markus Armbruster <armbru@redhat.com>
References: <20201109133931.979563-1-pbonzini@redhat.com>
 <20201109133931.979563-5-pbonzini@redhat.com>
 <87wnyu4gf9.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/6] qemu-option: clean up id vs. list->merge_lists
Message-ID: <736a0053-83b9-3510-82ad-99ea59ea00fe@redhat.com>
Date: Mon, 9 Nov 2020 18:17:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87wnyu4gf9.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/20 17:56, Markus Armbruster wrote:
> Just like any other QemuOptsList, "machine" may have any number of
> QemuOpts.  The ones with non-null ID happen to be ignored silently.
> Known[*] trap for the unwary.
> 
> Are these all singletons?

They are never qemu_opts_find'd with non-NULL id, so I'd say they are.

> If lists>merge_lists, you no longer check id_wellformed().  Easy enough
> to fix: lift the check before this conditional.

Intentional: we always error with INVALID_PARAMETER, so it's pointless 
to check if the id is well-formed.

> After the patch:
> 
>     id        fail_if_exists  merge_lists  |  return
>     non-null  don't care      true         |  fail
>     null      don't care      true         |  existing or else new opts
>     non-null  false           false        |  abort
>     non-null  true            false        |  new opts / fail if exist
>     null      don't care      false        |  new opts
> 
> Still too many 

Discounting the case that aborts as it's not user-controlled (it's 
"just" a matter of inspecting qemu_opts_create callers), the rest can be 
summarized as:

- merge_lists = false: singleton opts with NULL id; non-NULL id fails

- merge_lists = true: always return new opts; non-NULL id fails if dup

> [*] Known to the QemuOpts cognoscenti, whose number could be
> embarrasingly close to one.

Maybe not one, but a single hand certainly has a surplus of fingers.

Paolo


