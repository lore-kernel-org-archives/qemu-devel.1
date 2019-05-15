Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E22C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 19:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A462084E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 19:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A462084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profihost.ag
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41446 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQzXd-0004Gq-1I
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 15:26:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1hQzWQ-0003Ty-8S
	for qemu-devel@nongnu.org; Wed, 15 May 2019 15:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1hQzWO-0006x6-D6
	for qemu-devel@nongnu.org; Wed, 15 May 2019 15:25:02 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:28009)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1hQzWN-0006uz-1F
	for qemu-devel@nongnu.org; Wed, 15 May 2019 15:25:00 -0400
Received: (qmail 31774 invoked from network); 15 May 2019 21:24:56 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.242.2.6]) (185.39.223.5)
	(smtp-auth username hostmaster@profihost.com, mechanism plain)
	by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with
	(ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA;
	Wed, 15 May 2019 21:24:56 +0200
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <7c80a63c-a7ce-1e83-650b-0b8343563127@profihost.ag>
	<20190515175431.GM4751@redhat.com>
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <06774837-bd36-7f7a-e5f5-e2e81da8d7d5@profihost.ag>
Date: Wed, 15 May 2019 21:24:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515175431.GM4751@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic]
X-Received-From: 178.250.10.56
Subject: Re: [Qemu-devel] cpu.fail / MDS fixes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Am 15.05.19 um 19:54 schrieb Daniel P. Berrangé:
> On Wed, May 15, 2019 at 07:13:56PM +0200, Stefan Priebe - Profihost AG wrote:
>> Hello list,
>>
>> i've updated my host to kernel 4.19.43 and applied the following patch
>> to my qemu 2.12.1:
>> https://bugzilla.suse.com/attachment.cgi?id=798722
>>
>> But my guest running 4.19.43 still says:
>> Vulnerable: Clear CPU buffers attempted, no microcode; SMT Host state
>> unknown
>>
>> while the host says:
>> Vulnerable: Clear CPU buffers attempted, SMT Host state unknown
> 
> That suggests your host OS hasn't got the new microcode installed
> or has not loaded it.

No it does not. A not loaded Microcode looks like this:
Vulnerable: Clear CPU buffers attempted, no microcode; SMT vulnerable

but in my case it is:
Mitigation: Clear CPU buffers; SMT vulnerable

on the host as hyper threading is still enabled.

> You want the host to report that it is Mitigated, and for the
> host's /proc/cpuinfo to report "md-clear" exists.
> 
>> I expected the guest can use the new microcode.
> 
> You've not said what CPU model you've given to the guest.
> 
> You need either "-cpu host", or if using a named CPU model
> you need to explicitly turn on the "md-clear" feature
> (and all previous fixes)
> 
>    eg  "-cpu Haswell,+spec-ctrl,+ssbd,+md-clear"
hah yes you're true i need to specifiy +md-clean

Thanks!

> Regards,
> Daniel
> 

