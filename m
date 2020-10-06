Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59926C4727D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2E7D20760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGvDltEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E7D20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPrxi-0002Gk-JD
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 14:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPrwH-0008TY-Fq
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26482)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPrwE-0007mz-PJ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602009829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4g4BA7Y0pIakV3phrNQoZVvs0BcJUXvDAVYOUnUZCo=;
 b=ZGvDltEJwmg0DkY0ZczvvVWUVt3jlra86MtMww63yZEYNQLAwKfDDmQhcIrdKXHfKlXaEG
 LHr5YxgjBkEdAixEmSNlJ841bsNojQi22TM/+04Agvyu8U31YLOHQYAWvrX6iE7O+MRX1m
 A2Pb4/qto6UL3NpKohUmWxZnRM5G4mQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-_G8mW_9AOm-BMCB966c-5w-1; Tue, 06 Oct 2020 14:43:47 -0400
X-MC-Unique: _G8mW_9AOm-BMCB966c-5w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4571101FFA9;
 Tue,  6 Oct 2020 18:43:46 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-60.ams2.redhat.com [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34E1119D7C;
 Tue,  6 Oct 2020 18:43:45 +0000 (UTC)
Subject: Re: [PULL 00/21] machine + QOM queue, 2020-10-05
To: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20201005211000.710404-1-ehabkost@redhat.com>
 <CAFEAcA_+4b4HHP_8BBqqy+QmoyF6Lx1jmuFvcsbW5THZQDrXww@mail.gmail.com>
 <20201006143637.GP7303@habkost.net> <20201006170418.67bc8ce6@redhat.com>
 <20201006172309.36585fe1@redhat.com>
 <42392f2d-c8b6-6a79-022b-ba8ca5e3ff46@redhat.com>
 <20201006181423.20931695@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b8e64d9b-dcc2-52b0-6902-1118d714b158@redhat.com>
Date: Tue, 6 Oct 2020 20:43:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201006181423.20931695@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
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
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/10/2020 18.14, Igor Mammedov wrote:
> On Tue, 6 Oct 2020 17:42:28 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> On 06/10/20 17:23, Igor Mammedov wrote:
>>> Looks like travis-ci lost previous authorizations to my github repo,
>>> but giving a new one didn't help.
>>>
>>> Something wrong with current QEMU master, travis-ci doesn't recognize QEMU repo a valid anymore.
>>>    
>>
>> Interesting, I use Travis->Gitlab integration and even though builds are
>> still triggered, they don't appear in the Gitlab CI page.  So the
>> configuration is okay, but something seems to be wrong on the Travis side.
> 
> If one enables access to all repositories on account, then even if travis-ci
> doesn't show QEMU repo as accessible one, it seems that there is a new build in
> 'received' state, maybe it will start building eventually.

It works for me (via my github account):

  https://travis-ci.com/github/huth/qemu/builds/188441775

... maybe it was just a temporary hickup?

Anyway, we do not test macOS on Travis anymore (see commit 22a231950c50d3), 
so this is likely not helpful for Eduardo's original problem... Cirrus-CI is 
the way to go if you need macOS test coverage.

  Thomas


