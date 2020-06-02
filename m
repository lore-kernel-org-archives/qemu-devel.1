Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA96BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 04:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7882F2072F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 04:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sahlaM7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7882F2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfyJD-00086P-Ll
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 00:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfyIU-0007HP-Ty
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 00:13:06 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:32894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfyIT-0001Zf-UT
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 00:13:06 -0400
Received: by mail-pf1-x42b.google.com with SMTP id b201so347644pfb.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 21:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9C8sK7Z2iF5WZmXCdljq9UJarqXxzuQGuzldUteLfsk=;
 b=sahlaM7ti5bs8lO2uTOUjgxFq1xmKRy1UGkDnJlZ6nr/gikZ/+zAc8TCyyY68zNWQZ
 jX+TDQqahuET+Jbc0FGEijrGFiyWCo1r+Qkieo/eenHbzqmfnqf33Jb81q+oT3n+jQuu
 aaQfwZmUVV7W8WX5Xf0Zcr2nmz+w/zBKP1Ao4N5TvpR1KJ7uMxoHl+e+sLzi4ZQeRaim
 25EvTfg3OzrWSJj5ooe54Oj1QDBETXJsyMSRtK4WK87d3spTwLkBFsc9egGiSKOfM48H
 udQPuMDlUZ80K/wEDhFkXgfCjPnb8wTw9+QpeSengpfzDoxU8v0Zgu/y5kJ0DFhBK82c
 D7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9C8sK7Z2iF5WZmXCdljq9UJarqXxzuQGuzldUteLfsk=;
 b=X38zpw8TQXzznOlq5JY6SW7FxoocCTcr41xFFNCBAhz4HA1ReobenoV8AhKBG81mlE
 cFsCAiiXMbaDiTJtAFf4PCSh1D/HLvVo6aREbsbu9mBNCwnQtDGiHqogZ4YjR81w/1Vu
 bFDeCo93Pu/EF/gk4iS+SJInQe4nE+aAV2ivRTfzIClvzfivomeRElHdCzsMZszdIaJx
 b2J+rS7akuDBL9F8APwfm3vNsHqfI43YUPM/eLRTdRBDeYbahc3EYl7PHspn6kjPQVAi
 fxzH5SqUdh6P+/mJAmtyh6qvO7XM8JwFIiHrCiteh+5gaXTfmT6rEFeCouFe9nJJ6n5w
 THTQ==
X-Gm-Message-State: AOAM532Fhb6HOoJ/8MKJiGX3jCi2ziYnFXktUaTh5BsXPRvEZPIrM/m1
 gcvpv2ciJrqZEKGE3DXCuwS3Jg==
X-Google-Smtp-Source: ABdhPJxuproyx+Jtcb5T0D00dglHw9itroS8M9KLORXTfNi0jyEhrPfmuq/46Vk4x0Ks8dzkUc7hVg==
X-Received: by 2002:a63:6345:: with SMTP id x66mr21801616pgb.156.1591071184407; 
 Mon, 01 Jun 2020 21:13:04 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 67sm833902pfg.84.2020.06.01.21.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 21:13:03 -0700 (PDT)
Subject: Re: [RFC v2 15/18] guest memory protection: Decouple kvm_memcrypt_*()
 helpers from KVM
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, frankja@linux.ibm.com, dgilbert@redhat.com,
 pair@us.ibm.com
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-16-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eed92a20-3e0b-76c3-3ed0-3b467f12cf52@linaro.org>
Date: Mon, 1 Jun 2020 21:13:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521034304.340040-16-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 5/20/20 8:43 PM, David Gibson wrote:
> The kvm_memcrypt_enabled() and kvm_memcrypt_encrypt_data() helper functions
> don't conceptually have any connection to KVM (although it's not possible
> in practice to use them without it).

Yet?

I would expect TCG implementations of these interfaces eventually, for
simulation of such hardware.  Or are we expecting *this* interface to be used
only with kvm/any-other-hw-accel, as the nested guest inside of the outermost
tcg qemu that's simulating hardware that supports...

Anyway, the actual code looks ok.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

