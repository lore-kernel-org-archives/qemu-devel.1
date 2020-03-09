Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B32C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1AF20409
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQGflBXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1AF20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBGyo-00059w-QV
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 07:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1jBGy7-0004UF-TG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1jBGy6-0001NE-Rm
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:53:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41229
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1jBGy6-0001N7-Oi
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583754790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KBLLFAeCjCkZQxE+M1dfsu6NPU5v8sNcOYuqxDc862s=;
 b=QQGflBXBpx2J68ymxNczKzdGm73jYA7UBlHrF7t4rg58bM2RJ5NEJLvQ+oj5zL7bjCoqob
 AmgzGFcxLUsFznSDNYRjP3FENgDknJlLSS/OlwzDh3HL+MpGRtI+WzBLom6l6xPYWrYRW1
 7S+WyToNxBsbTYFrGJ3GHfvf6KX4DlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-0VGg1kgrM-SYTigNxxjiNg-1; Mon, 09 Mar 2020 07:53:06 -0400
X-MC-Unique: 0VGg1kgrM-SYTigNxxjiNg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 815AD1401;
 Mon,  9 Mar 2020 11:53:04 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2F1F1001B30;
 Mon,  9 Mar 2020 11:52:59 +0000 (UTC)
Date: Mon, 9 Mar 2020 12:52:56 +0100
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 07/13] arm/arm64: ITS:
 its_enable_defaults
Message-ID: <20200309115256.beb3uwc2lyukavey@kamzik.brq.redhat.com>
References: <20200309102420.24498-1-eric.auger@redhat.com>
 <20200309102420.24498-8-eric.auger@redhat.com>
 <20200309113914.pg5522tvwazgrfec@kamzik.brq.redhat.com>
 <73691fc7-45f3-6274-019f-aa5b0d2a0c1b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73691fc7-45f3-6274-019f-aa5b0d2a0c1b@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, yuzenghui@huawei.com, alexandru.elisei@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 09, 2020 at 12:45:34PM +0100, Auger Eric wrote:
> >> -	for_each_present_cpu(cpu) {
> >> +	for (cpu = 0; cpu < nr_cpus; cpu++) {
> > 
> > You don't mention this change in the changelog.
> Hey, you can see the changelog is pretty long already & accurate. But
> you're right I missed that one and listing those changes too would have
> avoided me to put those changes in that patch.
> 
>  What's wrong with
> > using for_each_present_cpu() here?
> As you encouraged me to move the alloc into the it, I tried to do so but
> then discovered this was feasible for such kind of issue. At init time,
> CPUs have nott booted yet.

They may not have booted, but for_each_present_cpu() should still work
because the present mask is initialized at setup() time before the unit
test even starts.

Thanks,
drew


