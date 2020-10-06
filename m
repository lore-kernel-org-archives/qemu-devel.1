Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75578C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B4C206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpJVxB/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B4C206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpA4-0005BG-0B
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 11:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPp6q-00034b-KD
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPp6p-0008RV-0n
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601998954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HhiFqcRFVCUz3bgcxsIPZcQZmWGvxr1JUfWyirfIeAs=;
 b=XpJVxB/uZySlUv5unraUWceSdyzGst9xlx4DSP2noAN99LuCY9CYPEHxjw0gPdQRdDoMiW
 sfCxPBubPK99vkJTylytgr+kab7M6WOKeUDTYsHMUCxXNh4mKE+gwnFI6ae35tpC81YY53
 q9XZHSnRD8EZj3dTWJrFtaV4P6EhsqI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-3IBwmHYtNv6riH_qK4pg_g-1; Tue, 06 Oct 2020 11:42:33 -0400
X-MC-Unique: 3IBwmHYtNv6riH_qK4pg_g-1
Received: by mail-wr1-f70.google.com with SMTP id b2so5464414wrs.7
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 08:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HhiFqcRFVCUz3bgcxsIPZcQZmWGvxr1JUfWyirfIeAs=;
 b=cnDFoLNJ4HsoA8vlynGxBAaqtwm7GAa0k4M9VA2+gwoksZsp4+BKj4/vAkXQY6J372
 esLSFsIJHX0dWnxcYA/Sl6BdDVkTLSSL3uvQCb7qDtuQIMuuiqZnPbWbm+xfJVqOd4pP
 /cmrPN1uiBQaZe5nK/UQfTvTGlsVpfLpc+zJ26wi4tnCll4HtzGW7oNyGp/DgoLqw3F/
 GPoxbp0Yz8+Ft/a/vammrn9OOPYZ9f5BG4K2tm7N6G9LEAVKr8P275qy4grUbYbhD9uv
 pve+o5rUqkw2FvIRBr4iEJwu4IEdS+MigT+oEKYys2lpc71+3+Hqd85dWWw/peAWtu/w
 OY/g==
X-Gm-Message-State: AOAM533WcZAFwnJOd7HTuHxT2LnTaCANdiN9vL01TLnw2KdfOiXl9TMV
 k0r0Bkbe8Fp7kP1AUuaFXvMR2RtkO5DJy7FsDfQ94OnMnjJKEEzSS0U8ZoH0xfJIXKH4bCfaYJl
 MNWEZR+4AQThI0LA=
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr5481915wmj.130.1601998951696; 
 Tue, 06 Oct 2020 08:42:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZvmEq35dPYerZ2Pw2gdQuMRhBw1+Lp7g8Xq7rxGzoCPfpbtN/E4fB2a07EHPbz3zWANDRTg==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr5481899wmj.130.1601998951479; 
 Tue, 06 Oct 2020 08:42:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e?
 ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id u63sm4857963wmb.13.2020.10.06.08.42.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 08:42:30 -0700 (PDT)
Subject: Re: [PULL 00/21] machine + QOM queue, 2020-10-05
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20201005211000.710404-1-ehabkost@redhat.com>
 <CAFEAcA_+4b4HHP_8BBqqy+QmoyF6Lx1jmuFvcsbW5THZQDrXww@mail.gmail.com>
 <20201006143637.GP7303@habkost.net> <20201006170418.67bc8ce6@redhat.com>
 <20201006172309.36585fe1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <42392f2d-c8b6-6a79-022b-ba8ca5e3ff46@redhat.com>
Date: Tue, 6 Oct 2020 17:42:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006172309.36585fe1@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/10/20 17:23, Igor Mammedov wrote:
> Looks like travis-ci lost previous authorizations to my github repo,
> but giving a new one didn't help.
> 
> Something wrong with current QEMU master, travis-ci doesn't recognize QEMU repo a valid anymore.
> 

Interesting, I use Travis->Gitlab integration and even though builds are
still triggered, they don't appear in the Gitlab CI page.  So the
configuration is okay, but something seems to be wrong on the Travis side.

Paolo


