Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B10C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517F320671
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DkUpgVcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517F320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfxQC-0006EL-JR
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxPX-0005cH-29
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:16:19 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:38368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxPU-0005vz-Te
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:16:17 -0400
Received: by mail-pl1-x632.google.com with SMTP id m7so763148plt.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 20:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6vwdZtJMYIy5H75dzhNT2X27UM1ZC8bhL7w9ePOSU7U=;
 b=DkUpgVcA4ocMJ3P6LDdPJF2w2nlgpDXJf4KD43TmyrCUK/17aiwh/EDXZ8Pbf/Ikw3
 +LaHWWMwnLWIXLHFNu6UnsiY0/UpjkHlndRdJNXwq4ycQdcUS3FvUlZbARiLBtQHUYjy
 BVRVfH8FAEYi4uwHnfxMHeXubEZI4LDoPiSGkjIA3oRCQKPM9xmDTJ8xrgj4m9ApGmJq
 EOVucwEetRCstU8Vix5n8KhPP60i3WlyYJIuwjCFfL52EhORvrBzPdFqUHginKKqVpA6
 1s1Fv2pctgnmB111PNZDA8seKNEDJzS6kBkoRvOgd/z7Z0KBDCcG7P8OQcCqjeCqG7mo
 ZHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6vwdZtJMYIy5H75dzhNT2X27UM1ZC8bhL7w9ePOSU7U=;
 b=BL15K9DKJmJ+lBetQz9RTTW2ADZ8VJysiB0aPx2iffrmlhXNwSsmfuR4z+qJny4sDO
 UO0BLCrceCcyK3xtJ8Ky32mlB+vZ0iXLXS4bsv5t+1tln88v+fBiDW+RARDly0yNQqP2
 Tkr0DzqXPklBWDgAo7qcjg0sI3jb+4sXw6zHjKUN4KuUmOQG+Fg8XJ6Tx8WN/MOlzZxf
 DU8c1Izls0RiRxy8AtcCEK4OcG7ytuPF9rjElHvsU2NBsrh2TFjKWsSlpWpkus7eFSum
 WPuILpakmRINmLxTWlUZQVmzAKaThcib796o+NGGrTAxFiptPIsjPGyu/t7XP+286ZF5
 8yMA==
X-Gm-Message-State: AOAM532WCyinr6uJxcTfp6+4G4qP93UIwD7FsbY7UqZ3YNkFoyeWuPvH
 jvDNvvdEwlz7O+IKgbuCGOSX4A==
X-Google-Smtp-Source: ABdhPJx44UFfX+t1vNjTWxJU2WH3P2v7BuF8Sg+OatY+uEu13V3i6KaN3tFTA8tLmrDCjUg7erFDuw==
X-Received: by 2002:a17:90b:b14:: with SMTP id
 bf20mr2897250pjb.231.1591067775270; 
 Mon, 01 Jun 2020 20:16:15 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gd1sm748295pjb.14.2020.06.01.20.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 20:16:14 -0700 (PDT)
Subject: Re: [RFC v2 08/18] target/i386: sev: Remove redundant handle field
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, frankja@linux.ibm.com, dgilbert@redhat.com,
 pair@us.ibm.com
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-9-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2de86b15-8a79-3609-8101-c9cc4dcaf255@linaro.org>
Date: Mon, 1 Jun 2020 20:16:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521034304.340040-9-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 8:42 PM, David Gibson wrote:
> The user can explicitly specify a handle via the "handle" property wired
> to SevGuestState::handle.  That gets passed to the KVM_SEV_LAUNCH_START
> ioctl() which may update it, the final value being copied back to both
> SevGuestState::handle and SEVState::handle.
> 
> AFAICT, nothing will be looking SEVState::handle before it and
> SevGuestState::handle have been updated from the ioctl().  So, remove the
> field and just use SevGuestState::handle directly.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/i386/sev.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


