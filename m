Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC54C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14392176D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqrKQdNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14392176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iafOa-0006MN-8T
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 07:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iafCy-000621-D5
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iafCo-0003Yd-O2
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:17:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iafCo-0003Oo-GY
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575029819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ehL1TBSpMC2zAAXwakO3rzn2yDlHMfwNBgc5A6BXaM=;
 b=cqrKQdNyFbUUM1JctuO/4K5CVmPj+hV3nqb2fN+CxVsxB/kc5cAoDXVBMOYMCGmn4R92dk
 DK/5WrhkZ/ywiH1jhRniabak2cJB9s4fzIOJ0twvlwvZByrXZjXXMJXzMJJjJo6OiqEihY
 AOpCxURIHXYcuAFz283DTwqW6hV1kiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-PMpgVkG6NQiJqHIjpzHp4w-1; Fri, 29 Nov 2019 07:16:58 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24BF380183C;
 Fri, 29 Nov 2019 12:16:57 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC1D05C1BB;
 Fri, 29 Nov 2019 12:16:53 +0000 (UTC)
Date: Fri, 29 Nov 2019 13:16:52 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] Add -mem-shared option
Message-ID: <20191129131652.6683b769@redhat.com>
In-Reply-To: <04dadf85-cd35-fd37-9642-8087cba625bd@redhat.com>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191128141518.628245-3-marcandre.lureau@redhat.com>
 <20191128172807.788e6aeb@redhat.com>
 <CAJ+F1CLZxhMf-bOAB4sVfuB1yaUMqiO70-ogpKVS3CqfC7y5KA@mail.gmail.com>
 <20191129110703.2b15c541@redhat.com>
 <04dadf85-cd35-fd37-9642-8087cba625bd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: PMpgVkG6NQiJqHIjpzHp4w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 11:11:09 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 29/11/19 11:07, Igor Mammedov wrote:
> >>> So user who wants something non trivial could override default
> >>> non-numa behavior with
> >>>   -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on \
> >>>   -machine memdev=mem
> >>> or use any other backend that suits theirs needs.    
> >> That's nice, but not as friendly as a simple -mem-shared.  
> > (I still do not like idea of convenience options but it won't
> > get onto the way much if implemented as "global property" to memdev,
> > so I won't object if there is real demand for it)  
> 
> I agree with Igor, we should always think about the generic ("object
> model") options and only then add convenience option.
> 
> It looks like the remaining point is to decide between "-m memdev" and
> "-machine memdev".

I'm still entertaining idea, to use -device pc-dimm|some_ram_dev
for main RAM but that's not generic enough so I'd probably post
'-machine memdev' variant for now and think some more on -device
(we can add front-end re-factoring if necessary on top).

As for "-m", I'd make it just an alias that translates
 -m/mem-path/mem-prealloc
combination to appropriate '-object' for '-machine memdev' consumption.
That should cover compat purposes for old machines and the rest of
-m options (maxmem/slots) would be aliased to appropriate machine options.

That will allow us to get rid of ad-hoc '-m' parser. After that it would
be possible to deprecate '-m' in favor of machine properties, but that
probably will get quite a push back so unless I find compelling reason
to do it I won't care much as '-m' would be a lightweight shim over
machine properties.

> 
> Paolo
> 


