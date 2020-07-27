Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F36C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 08:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736FA206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 08:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOBW6XAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736FA206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzynF-0001Vl-CX
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 04:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jzym6-0000NL-3e
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 04:46:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54761
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jzyld-0006nn-HP
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 04:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595839552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=6kScuG/A9wpiNSWW0hlW+UiUPqPI9tnySsBCzyQQbD8=;
 b=eOBW6XAdzKVPk9Pa7dHM+bSY5dtyRGjNbHO69QpAm80KJczhsWC0s6XjRjf9/m34JOWXQN
 Wk3oyQP2epa8IgWx6hI/1crjxIlEYVGFQ5Uyvg0jtvDHexSjIAQO+B0aQVw/2VLlNcApRk
 YQunlbWOyh45imqwaAv3E18MNxyiQXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-Zfrd9P2aP423FDOuDDYcaQ-1; Mon, 27 Jul 2020 04:45:49 -0400
X-MC-Unique: Zfrd9P2aP423FDOuDDYcaQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AC761940925;
 Mon, 27 Jul 2020 08:45:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-156.ams2.redhat.com [10.36.112.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91E3F10013C0;
 Mon, 27 Jul 2020 08:45:46 +0000 (UTC)
Subject: Re: [PATCH 2/3] cirrus.yml: Compile macOS and FreeBSD with -Werror
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200724143220.32751-1-thuth@redhat.com>
 <20200724143220.32751-3-thuth@redhat.com>
 <20200724144651.GG3146350@redhat.com>
 <506e2579-410e-8553-6cbf-508793bb35a0@redhat.com>
 <20200724164901.GO3146350@redhat.com>
 <5257b25f-62e8-4585-15f9-87ab5b99cf2d@redhat.com>
 <CAFEAcA8gVHy3101-fyVw45q=QegRGOv_k3yA40MkeseL5vhawA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b131214e-9fd2-80bf-5212-0adf1fcf973f@redhat.com>
Date: Mon, 27 Jul 2020 10:45:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8gVHy3101-fyVw45q=QegRGOv_k3yA40MkeseL5vhawA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/07/2020 10.30, Peter Maydell wrote:
> On Mon, 27 Jul 2020 at 06:44, Thomas Huth <thuth@redhat.com> wrote:
>> Sounds like it could be done, indeed. But I wonder whether we really
>> really want to silence the warnings here? We'd hide the information to
>> the users that sasl is apparently disliked by Apple and might get
>> removed on macOS in the future.
>>
>> Maybe we should rather change the "configure" script to disable sasl by
>> default on macOS unless the user explicitely specified --enable-vnc-sasl ?
> 
> Does the Homebrew packaging of QEMU depend on and use a Homebrew
> packaged sasl, or rely on the system sasl ?

I don't have a Mac, but looking at
https://github.com/Homebrew/homebrew-core/blob/master/Formula/qemu.rb it
seems like they don't do anything special with regards to vnc ... so I
guess the answer is "they use system sasl" ?

 Thomas


