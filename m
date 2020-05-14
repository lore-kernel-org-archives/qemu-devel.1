Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8F6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6DD206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/w9V1dY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6DD206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZAZQ-0005b6-RJ
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 05:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jZAYQ-0004wF-OI
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:53:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22507
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jZAYP-0002VU-VA
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589450004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D9bQ/+wADHy8k8J1S1DOC1vh6nehYdWd0tEA0ASmkQY=;
 b=K/w9V1dYdIdGVZcYG5NYn7BiVJvGmWN8Y7R2Gh4x3pEOszYV/CP2LXHLTGAO5QA5X/V8QY
 shAiP0oAqsBS9lxi13l5A5ufub5yGC+AAMUuTPump20ZWyqzYqWA7p1t9IegyEEA0e10JM
 Hmj21CkeJv76i0Pl1UcyHIyCF3zYZic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-pcbXPw7rPAe5hiPMoGAKpQ-1; Thu, 14 May 2020 05:53:23 -0400
X-MC-Unique: pcbXPw7rPAe5hiPMoGAKpQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBE1F8014D7;
 Thu, 14 May 2020 09:53:21 +0000 (UTC)
Received: from localhost (unknown [10.40.208.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC44661F50;
 Thu, 14 May 2020 09:53:08 +0000 (UTC)
Date: Thu, 14 May 2020 11:53:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 1/3] acpi: Move build_tpm2() in the generic part
Message-ID: <20200514115304.6ddb5e34@redhat.com>
In-Reply-To: <3dfdf504-7fc2-40cf-8387-c4abb8133792@redhat.com>
References: <20200505144419.29174-1-eric.auger@redhat.com>
 <20200505144419.29174-2-eric.auger@redhat.com>
 <20200506063314.4qvnyfonjixcknuj@kamzik.brq.redhat.com>
 <20200506055747-mutt-send-email-mst@kernel.org>
 <20200512161447.07b76de2@redhat.com>
 <3dfdf504-7fc2-40cf-8387-c4abb8133792@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>,
 gshan@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, marcandre.lureau@redhat.com,
 eric.auger.pro@gmail.com, lersek@redhat.com, ardb@kernel.org,
 stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 May 2020 17:59:25 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Igor,
> 
> On 5/12/20 4:14 PM, Igor Mammedov wrote:
> > On Wed, 6 May 2020 05:58:25 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> >> On Wed, May 06, 2020 at 08:33:14AM +0200, Andrew Jones wrote:  
> >>> I realize this function is just getting moved, but maybe it should get
> >>> converted to the build_append* API while being moved?    
> >>
> >> I'd rather refactoring was done in a separate patch -
> >> easier to review.  
> > maybe first convert and then move
> > 
> > PS:
> > me wonders if we have test with TPM enabled, if not maybe it's time to add them
> > i.e. first goes testcase in bios-tables and then refactoring/moving
> > in that case review is simpler.  
> Do you mean tests checking the ACPI table content when TPM is
> instantiated? I don't think so otherwise it would have failed I guess.
yes, I've meant that.

> Otherwise we have functional tests with TPM (MMIO access), ie qtest
> tests  tpm-tis-device-test and tpm-tis-device-swtpm-test.
> 
> Thanks
> 
> Eric
> > 
> >   


