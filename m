Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661B3C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EDBD22314
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoqMuNi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDBD22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itthk-0006Su-0a
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itsy7-0004lF-O3
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itsy4-0005sg-3v
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:49:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53564
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itsy4-0005sS-0Z
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579610955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j16BY1ExozpDd2ZSPDVQCHjV1Bzl6Q3iawKnH/+R+gA=;
 b=XoqMuNi9PvOcZVb63wmv0ZIemBg6T3fWGo16asPpSz17FyDNFY0Fx549QB+D+8qDI7wW6/
 ifrzY4Wg/q79EZQYlbB6W3pRusZ6TtbTCP6FroZxqRSFqqczcLEyISZWE/WpEfDFNpbbDO
 62Z7F+X5HDsEGGz2Ntc61sXZ5lYaQCw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-iCMV9QniNrC-tIRyTLh4SA-1; Tue, 21 Jan 2020 07:49:12 -0500
Received: by mail-wm1-f69.google.com with SMTP id t4so574828wmf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 04:49:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E97v31GmUIyD1HqZDyf42Q2vE3cZl1MX5D1MTjXp2BM=;
 b=F0d+hW3bOKx7z56pWTHmddceKaPvcA8oxcO2Xm8KJcEBxQcg8Ex35P8Zj/XSbSgWbI
 mJxfibTf+JyzZpBIuY5X6thFsZwpDBrWXBzY+Vqn6YPwuBPzaDMhoPN/fsFJ3JXKDTsQ
 vE+45Z6oilqIZPRbBh/D9Y0uSWBNdm2SlZdGQqaydtPHm7bz8LbXH36noUmGqv5g+RJ+
 Yru7+arXg0d3EWLmy1neDm0+y0f/Zj9cL+mAoNrdf528/Wvyr3Fh5B1fby68kJvodk5v
 prrucmHjsnUdclq3+ewXhuS4v2aQe6tTNRMLINrv2vI7T6Xd84r+C0Wn1fuVn9Hx4Alh
 4siw==
X-Gm-Message-State: APjAAAXD8WANnwCBSM1H+QpPViOOYmUNsEaFtSt+NtPI6P849M0Lje+W
 I4ckbxQPGH0T8DHoqbmyQRnGfXUZtS8Xc+ecL3yZKvRQLlaL6GNYs+IuD56T8oHrPLzk7WWZ7fJ
 cvPjMrUjA4M9V+IA=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr4181984wmi.101.1579610951077; 
 Tue, 21 Jan 2020 04:49:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqzd43yL/DHXZkigzu2jcacvpfVjthJNmuCiLOz0L8x2xr2O4pfMjHIBJM4iutKSWq1/T3+HZQ==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr4181947wmi.101.1579610950784; 
 Tue, 21 Jan 2020 04:49:10 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id x14sm3655841wmj.42.2020.01.21.04.49.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 04:49:10 -0800 (PST)
Subject: Re: [PATCH v2 00/10] Cleanups around the 'current_machine' global
 variable
To: Markus Armbruster <armbru@redhat.com>
References: <20200121110349.25842-1-philmd@redhat.com>
 <87ftg9dlht.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <99a930d1-542e-8f0d-6a9a-79e306181f77@redhat.com>
Date: Tue, 21 Jan 2020 13:49:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87ftg9dlht.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: iCMV9QniNrC-tIRyTLh4SA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Like Xu <like.xu@linux.intel.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 1:47 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> v1 was "Replace current_machine by qdev_get_machine()":
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg669611.html
>>
>> But Markus objected, see:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg670122.html
>> and older discussion:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg611338.html
>>
>> This series salvage patches from v1, and add other trivial cleanups.
>>
>> Can the ARM/PPC/S390 patches could go via their own tree, and the
>> rest via Paolo's 'misc' tree?
>>
>> Supersedes: <20200109152133.23649-1-philmd@redhat.com>
>=20
> Separating off uncontroversial patches is always a good idea.  These all
> look okay to me on first glance, with one minor remark on PATCH 7.  I
> think you got or are likely to get competent review for all of them.  If
> you need me to have a closer look, just ask.

Good :) Thanks!


