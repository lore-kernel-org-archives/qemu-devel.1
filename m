Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6983CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 12:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D29206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 12:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+TNZlSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D29206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jedpa-0004Sp-B5
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 08:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jedow-00042D-2D
 for qemu-devel@nongnu.org; Fri, 29 May 2020 08:09:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22660
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jedou-00016R-J1
 for qemu-devel@nongnu.org; Fri, 29 May 2020 08:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590754142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G7Oj2+Z6HCruLNZVCo7FAQr8Pq7rats2Ecqb+f8WBGE=;
 b=P+TNZlSW9DK+3+GO1vx1Pf+IqHjhenVHFtX4ZYtP+7Va0FbWdOvzU73+pRT897z+uAKjxY
 MRF7xxr14oKYWRU7J9NKOPMI7VpV/WV06K6ZtkuTZnUEMx45wIBXSruIqFw6Nt7nbToVKF
 s2rjEBOtE1IsY5t0JxmOxjl/ZB0dGaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-ApQfdc6jPPe2KOtUdQ1tZw-1; Fri, 29 May 2020 08:09:01 -0400
X-MC-Unique: ApQfdc6jPPe2KOtUdQ1tZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DAC5461
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 12:09:00 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-152.ams2.redhat.com
 [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E24CD784AF;
 Fri, 29 May 2020 12:08:55 +0000 (UTC)
Subject: Re: [PATCH v7 4/5] crypto: Add tls-cipher-suites object
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
References: <20200528173141.17495-1-philmd@redhat.com>
 <20200528173141.17495-5-philmd@redhat.com>
 <81c61004-cccc-2ece-91a7-de96012a8ebf@redhat.com>
 <20200529111840.GE2755532@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3ca0c0ec-8b21-d7c5-776f-01502282d821@redhat.com>
Date: Fri, 29 May 2020 14:08:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200529111840.GE2755532@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/29/20 13:18, Daniel P. Berrangé wrote:
> On Fri, May 29, 2020 at 01:09:22PM +0200, Laszlo Ersek wrote:
>> On 05/28/20 19:31, Philippe Mathieu-Daudé wrote:
>> (2) We need an actual commit message for this patch. How about the
>> following -- I have liberally stolen and edited comments that Daniel
>> made earlier in the Red Hat Bugzilla:
>>
>> ---v--- ---v--- ---v--- ---v---
>> On the host OS, various aspects of TLS operation are configurable. In
>> particular it is possible for the sysadmin to control the TLS
>> cipher/protocol algorithms that applications are permitted to use.
>>
>> * Any given crypto library has a built-in default priority list defined by
>>   the distro maintainer of the libary package (or by upstream).
>>
>> * The "crypto-policies" RPM (or equivalent host OS package) provides a
>>   config file such as "/etc/crypto-policies/config", where the sysadmin
>>   can set a high level (library-independent) policy.
>>
>>   The "update-crypto-policies --set" command (or equivalent) is used to
>>   translate the global policy to individual library representations,
>>   producing files such as "/etc/crypto-policies/back-ends/*.config". The
>>   generated files, if present, are loaded by the various crypto libraries
>>   to override their own built-in defaults.
>>
>>   For example, the GNUTLS library may read
>>   "/etc/crypto-policies/back-ends/gnutls.config".
>>
>> * A management application (or the QEMU user) may overide the system-wide
>>   crypto-policies config via their own config, if they need to diverge
>>   from the former.
>>
>> Thus the priority order is "QEMU user config" > "crypto-policies system
>> config" > "library built-in config".
>>
>> Introduce the "tls-cipher-suites" object for exposing the ordered list of
>> permitted TLS cipher suites from the host side to the firmware, via
>> fw_cfg. The list is represented as an array of IANA_TLS_CIPHER objects.
>> The firmware uses the IANA_TLS_CIPHER array for configuring guest-side
>> TLS, for example in UEFI HTTPS Boot.
>>
>> The priority at which the host-side policy is retrieved is given by the
>> "priority" property of the new object type. For example,
>> "priority=@SYSTEM" may be used to refer to
>> "/etc/crypto-policies/back-ends/gnutls.config" (given that QEMU uses
>> GNUTLS).
>> ---^--- ---^--- ---^--- ---^---
>>
>> (3) I think I have now at least formed an idea about where we should
>> document -fw_cfg / "gen_id" in the *manual*.
>>
>> The various -object types are already documented extensively; namely in
>> section "Generic object creation". Thus, I think we should document
>> "tls-cipher-suites" there -- near the already existent "-object tls-*"
>> ones.
>>
>> I suggest including a manual update to that effect. I think we can mostly
>> copy the suggested commit message into the manual as well.
>>
>> And then, we can include the new "-fw_cfg" command line option (with
>> "gen_id") *right there*. Consequently, we won't need to modify the
>> existent "-fw_cfg" documentation bits (about "file" and "string") under
>> section "Debug/Expert options".
>>
>> Dan: please comment!
> 
> I don't really have anything else to say. More docs == better

Thanks! Just wanted to be sure I wasn't suggesting something egregious.

Laszlo


