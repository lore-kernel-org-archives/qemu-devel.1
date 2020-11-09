Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F375C388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D6720665
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/ruN8aA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D6720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcBCi-0004qT-Le
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcB6S-0004yI-U0
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:37:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcB6Q-0008Hj-K9
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604943433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V3rsvQ0nTlyfIPUiXUaAfVpJQpeOyjdCBeeQHrb5wmg=;
 b=Z/ruN8aAftYYOOG4KDuAil8ykloJkKuVb/qPcLugd9heerLyeHiuKHF0PwKUqzRNJY41em
 mT7Rqo/irXxxwzWNwWIO7+qwUlox6CH9OIcENZ6aD79M/nxGYz/sta+EI3yGJzBZ0oJQWr
 OHA5K1iMKmxokDbkmy9o7YqgdqEFbBs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-uELiVd7dOhyjP4Cj9dq4Aw-1; Mon, 09 Nov 2020 12:37:10 -0500
X-MC-Unique: uELiVd7dOhyjP4Cj9dq4Aw-1
Received: by mail-wr1-f71.google.com with SMTP id b6so4584112wrn.17
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 09:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V3rsvQ0nTlyfIPUiXUaAfVpJQpeOyjdCBeeQHrb5wmg=;
 b=d+dVgQuahzCNU0auCnEolAGLitN2wAju4e7bhypJsB1VxpOszBjY7vJ3sA1478fEZM
 TonrzXaSArBh4L9luckA2nIN+TpJqA1uAaLYlCbAiFZbDruF0l//GrKsWjivNXx4aO0i
 gypinH7C32b25cnQ3JtNm7vGjXaSkqta7DEbY7P23kusMD5BaWVkRRFDMUjFHELoz4q5
 R8Xuhif7LY4OTJ4ajn4vR/8QVE5qI4II951WToS3EjmUp8+GcbgnUz8h/FMU52IDw5GI
 0w1qxirmjAX4/wd9xvItlsJ+FCkmrPraP3SgWWkTNXLcNV2WjBPA7YrL0TRLpNtZx6ht
 mgaQ==
X-Gm-Message-State: AOAM532OyVrzhAJ9eaw4B7tdVo+R+GZBEQLt64giS2NgeslBXlSOChhs
 k9ZwxUCKP58QVsOtpZaz5HLx4zKWgLiDJ9ozgF78yMzqeACVcOi3k3WsFcMlT1/XXt2GoNt2VnT
 4cbNWlX132MZj1II=
X-Received: by 2002:a1c:7418:: with SMTP id p24mr288071wmc.36.1604943428580;
 Mon, 09 Nov 2020 09:37:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWffaTmSBXXYD2XYhVzQ5zDbyNgGE7oq35b7UpJEpdpySML3PvIJ+Bo5lBJgErv2jBt6wZpg==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr288056wmc.36.1604943428419;
 Mon, 09 Nov 2020 09:37:08 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id u81sm143881wmb.27.2020.11.09.09.37.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 09:37:07 -0800 (PST)
Subject: Re: [RFC v1 09/10] i386: split cpu.c and defer x86 models registration
To: Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Wenchao Wang <wenchao.wang@intel.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20201109172755.16500-1-cfontana@suse.de>
 <20201109172755.16500-10-cfontana@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dd812d5d-061b-de7d-4e43-259a7d3f44ad@redhat.com>
Date: Mon, 9 Nov 2020 18:37:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201109172755.16500-10-cfontana@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Paul Durrant <paul@xen.org>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Dario Faggioli <dfaggioli@suse.com>,
 Cameron Esfahani <dirty@apple.com>, haxm-team@intel.com,
 Colin Xu <colin.xu@intel.com>, Anthony Perard <anthony.perard@citrix.com>,
 Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/20 18:27, Claudio Fontana wrote:
> Defer the x86 models registration to MODULE_INIT_ACCEL_CPU, so that 
> accel-specific types can be used as parent types for all cpu models. Use 
> the generic TYPE_X86_CPU only if no accel-specific specialization is 
> enabled.

Can we use an accel-specific ops struct, and avoid having accel-specific 
types?  Having dynamic types like these would make it very hard to build 
a schema of QOM objects.

Paolo


