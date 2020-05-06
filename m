Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CA9C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C381B20575
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alx8fz6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C381B20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWJLD-0002x3-Uc
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jWJKI-0002Qt-Lu
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:39:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57075
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jWJKG-0006dZ-E4
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588768738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pSRobJhoI1Cc8VP9suUtZXRJ9rns6OZoWuWlrqzsnOU=;
 b=alx8fz6BKLpBsEJDr1VXVarqTzk4E4TExAxk8yXp/IyW21LUR16hqp0qEu6sAM38A+upbC
 DLMY5TuuNxvBsHDFuomufaHzTFjlET2Pz8WPZnoQZM6eBsJ5Jt+Fi8mk8EMLDPwujPVUE8
 +sR0Q8WLXUAzb+E/lmPtgnAP1UUucfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-Cj_GaBJoOKWvB13UcloPYA-1; Wed, 06 May 2020 08:38:57 -0400
X-MC-Unique: Cj_GaBJoOKWvB13UcloPYA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA3E819200C0;
 Wed,  6 May 2020 12:38:55 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B2706443E;
 Wed,  6 May 2020 12:38:41 +0000 (UTC)
Date: Wed, 6 May 2020 14:38:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 03/13] acpi: rtc: use a single crs range
Message-ID: <20200506143839.2439cc3f@redhat.com>
In-Reply-To: <20200506083902.shumz2k3v5cbo6dl@sirius.home.kraxel.org>
References: <20200505113843.22012-1-kraxel@redhat.com>
 <20200505113843.22012-4-kraxel@redhat.com>
 <20200505152410.69d576f8@redhat.com>
 <20200506083902.shumz2k3v5cbo6dl@sirius.home.kraxel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:02:22
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 6 May 2020 10:39:02 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
> 
> > >      crs = aml_resource_template();
> > >      aml_append(crs, aml_io(AML_DECODE16, RTC_ISA_BASE, RTC_ISA_BASE,
> > > -                           0x10, 0x02));
> > > +                           0x10, 0x08));
> > >      aml_append(crs, aml_irq_no_flags(RTC_ISA_IRQ));
> > > -    aml_append(crs, aml_io(AML_DECODE16, RTC_ISA_BASE + 2, RTC_ISA_BASE + 2,
> > > -                           0x02, 0x06));  
> > can we just drop the later range as unused? (I don't see where it's actually initialized)  
> 
> I'd rather follow what physical hardware is doing here
> for better compatibility ...

maybe add comment here why it doesn't match IO range that RTC actualy provides,
otherwise it's looks very confusing

> 
> take care,
>   Gerd
> 


