Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F24C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 11:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB5CD2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 11:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdlzB9CP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5CD2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jadih-0007Gx-0U
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 07:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jadhs-0006XF-5l
 for qemu-devel@nongnu.org; Mon, 18 May 2020 07:13:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56591
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jadhr-0005hh-IH
 for qemu-devel@nongnu.org; Mon, 18 May 2020 07:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589800394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UCfIlQydaij2SjlGv4c506nsNsyE9ecXqfPWb2n/UtA=;
 b=HdlzB9CPSxbl5dIWsTqCJAQJ/Lo3xi5UiJ4d+WSO1AsnN7z5H3F75XCYEXIh1Oh08OdKF2
 kBVnSGCxLFX4o7OVgpWV2mmUn6h9qwvdV4f0qCW14BeDxVhTtzUfcPt0AlIRhWG7CXurqp
 tk/hFzwRH3jkmPUnUa4eohRdwF5RVFc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-tiKXTDIBNMCG3MghwqpTdg-1; Mon, 18 May 2020 07:13:08 -0400
X-MC-Unique: tiKXTDIBNMCG3MghwqpTdg-1
Received: by mail-wr1-f69.google.com with SMTP id e14so5496446wrv.11
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 04:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UCfIlQydaij2SjlGv4c506nsNsyE9ecXqfPWb2n/UtA=;
 b=Bt7xIbGc7aIZwj+1+8nrBtLwoo6rnyC9y952P0RH525P/WVwwVxTmJR6I3H9ztJXdc
 F1D6HwK/NAs6tfCht31Qvc2mJ7Cyyg2tvmqElLRtHeWslviIglDvryFyrWTrol6/X8/Q
 2KUbMFb0eNv9bMwQ5cu2lgveapCX/skl7rWsDYqwFGliUBp2HSdtbWt0AU8E5qbVcaGV
 UXz9FJHVp69rfoxgqsCHnNW1RN0QPpq1Z1AZimXHf+XgymrDPP59cWo3CMtnjiFKufEL
 hLB7UKNUSh59KuCKh+doh7lcYoTdDVJIKI6xkxXa243gxOQn5WYsuJLUEs21YrvmsxQc
 oA5Q==
X-Gm-Message-State: AOAM533ekQNVF1VUbCxTkXt2bm/kpTIsgbvlPw0iWVMfRDkvRegc+ffk
 TdTwjKUkSBT1TU1MtArPXdH2p8sAobDHnc4ku1Flm2Ra82yGDCatZpFlOZoO9mh4mnWCfup10ni
 WvE+rzcPkBuFif0k=
X-Received: by 2002:a5d:6286:: with SMTP id k6mr14874029wru.123.1589800387165; 
 Mon, 18 May 2020 04:13:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyO5OsbUUbuewEGG289E5APdYBybuDQyOpAXDYwnKDzs+vx+XOJ9S2ul52Z3lq+lU5M+kVQA==
X-Received: by 2002:a5d:6286:: with SMTP id k6mr14873993wru.123.1589800386906; 
 Mon, 18 May 2020 04:13:06 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id f127sm16757511wmf.17.2020.05.18.04.13.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 04:13:06 -0700 (PDT)
Subject: Re: [PATCH 02/24] display/xlnx_dp: Fix to realize "i2c-ddc" and
 "aux-to-i2c-bridge"
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-3-armbru@redhat.com>
 <CAFEAcA-FKUHyG=bgJqPG49WZDXV8JGQqqZXOw49C8_h9mYS5iA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8daeec76-0851-54a3-d84b-67a6019eef85@redhat.com>
Date: Mon, 18 May 2020 13:13:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-FKUHyG=bgJqPG49WZDXV8JGQqqZXOw49C8_h9mYS5iA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 KONRAD Frederic <fred.konrad@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 12:30 PM, Peter Maydell wrote:
> On Mon, 18 May 2020 at 06:04, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> xlnx_dp_init() creates these two devices, but they're never realized.
>> Affects machine xlnx-zcu102.
>>
>> I wonder how this ever worked.  If the "device becomes real only on
>> realize" thing actually works, then we've always been missing these
>> two devices, yet nobody noticed.
> 
> It depends entirely on the implementation of the device.
> If it happens to do nothing in the realize method that
> matters (eg i2c-ddc has no realize method and does the limited
> amount of initialization it needs in instance_init) then the
> device will (by lucky accident) work just fine.
> 
> We should really ideally have an assert() in the DeviceClass
> reset that the device was realized, so we can keep this kind
> of bug out of the codebase. (Last time I looked it wasn't obvious
> exactly where to put the assert now that we have both legacy-reset
> and three-phase-reset, unfortunately.)

Your wish came true in the last patch of this series! #24:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg704239.html

> 
> thanks
> -- PMM
> 


