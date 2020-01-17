Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C6CC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932C32072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMNz7AXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932C32072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isQeo-0006no-PZ
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 07:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1isQdv-0006Ad-Kr
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1isQds-00015i-1v
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:22:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52587
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1isQdr-00015K-UH
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579263743;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpHevimTNIgXNn75EoLBhQl5RqqxCNM0g0Bp/KckbKU=;
 b=CMNz7AXD2rAmUgZGroSi/rdpRHA9WpriRofGVmImXuQwcjqPZfHSopWU1kLvfuWh0850mS
 v4SWX5GX3Acpe5yvdEGzyngFR1SOjJh6XSNfoZX+Ql7VfHlrD3Wy0RKyTyarAQage/kfKn
 Q9lZ/rtukOivF4zj0dYtuHoLfEqRAd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-vJZmTY0mOkOBTWwvrivQfw-1; Fri, 17 Jan 2020 07:22:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 752ED18AAFA9;
 Fri, 17 Jan 2020 12:22:17 +0000 (UTC)
Received: from redhat.com (ovpn-117-238.ams2.redhat.com [10.36.117.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB8D7845A9;
 Fri, 17 Jan 2020 12:22:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/30] Migration pull patches (take 4)
In-Reply-To: <CAFEAcA_n21bu1gk0fqbzSr7iwurYCVR+wS7-RpDAJWnrYdVQ5g@mail.gmail.com>
 (Peter Maydell's message of "Fri, 17 Jan 2020 12:05:16 +0000")
References: <20200114125254.4515-1-quintela@redhat.com>
 <CAFEAcA_n21bu1gk0fqbzSr7iwurYCVR+wS7-RpDAJWnrYdVQ5g@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 17 Jan 2020 13:22:10 +0100
Message-ID: <87tv4u2ryl.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: vJZmTY0mOkOBTWwvrivQfw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On Tue, 14 Jan 2020 at 12:53, Juan Quintela <quintela@redhat.com> wrote:
>>
>> The following changes since commit 3c8a6575985b1652b45bfa670b5e1907d642c=
fa0:
>>
>>   Merge remote-tracking branch
>> 'remotes/kraxel/tags/usb-20200113-pull-request' into staging
>> (2020-01-13 14:19:57 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/juanquintela/qemu.git tags/migration-pull-pull-requ=
est
>>
>> for you to fetch changes up to b039b02c25d1725cf0296721d98e35e024468b20:
>>
>>   migration: Support QLIST migration (2020-01-14 13:45:29 +0100)
>>
>> ----------------------------------------------------------------
>> Migration pull request (take 4)
>>
>> - both patches for x32 archs in
>> - reorder the pages to make git bisect happy
>>
>> Thanks a lot to Daniel for helping with the bugs.  Twice.
> (processes started 45 mins ago, unreaped processes in zombie state.)
>
> It looks like the multifd/tcp test fails, but doesn't manage to
> actually turn the failure into the test case exiting:
>
> /i386/migration/multifd/tcp: qemu-system-i386: -accel kvm: invalid
> accelerator kvm
> qemu-system-i386: falling back to tcg
> qemu-system-i386: -accel kvm: invalid accelerator kvm
> qemu-system-i386: falling back to tcg
> qemu-system-i386: multifd_send_sync_main: multifd_send_pages fail
> qemu-system-i386: failed to save SaveStateEntry with id(name): 3(ram)
> qemu-system-i386: Unable to write to socket: Broken pipe
> qemu-system-i386: Unknown combination of migration flags: 0
> qemu-system-i386: error while loading state section id 3(ram)
> qemu-system-i386: load of migration failed: Invalid argument
> [hangs here]
>
> I think you need to find a system which has 32-bit ram_addr_t
> and test this, because this is about the fourth time round
> for this patchset failing on this configuration.

That is arm32 bits at the moment, right?

Later, Juan.


