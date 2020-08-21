Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27197C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49D620735
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXcT55Mi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49D620735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9DYM-0000Nv-0h
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 16:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k9DXk-0008OJ-BN
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 16:21:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29931
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k9DXh-0006Ie-TN
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 16:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598041299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xKHuuxWNTmhnT5f4rmQY10C0hGrWah9ThneXvxGLBOs=;
 b=fXcT55Mi/a0ONkmCBclLQv5Cnb7dxK6SbUBLWi6YVMCOkvmedwhIaGqc9wM6mRirQijPwp
 hWHXfRcJLQkJBpJQNfDY0J8JEDIBfZcRKPPMbDx8RHHTCaFKp56z9/JMyrPCNLkZSBgn+F
 LOgcVy/Sp6YpbjEBQOfleQ4Rkcp7QGE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-Wpjxp7PUPjaCLwOoqZhqcQ-1; Fri, 21 Aug 2020 16:21:37 -0400
X-MC-Unique: Wpjxp7PUPjaCLwOoqZhqcQ-1
Received: by mail-wr1-f69.google.com with SMTP id o10so925250wrs.21
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 13:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xKHuuxWNTmhnT5f4rmQY10C0hGrWah9ThneXvxGLBOs=;
 b=czLZ1QqNEGvPyHqlpWU5BjYGzTTLNm4zrIiNtiXm6/h0CWfcqsPzMkzODvncxmZyiF
 Bd7qIgYfKu5Xut9sYll6XpE6Jduqg/jc2r1lQ6NhDZnb4B1Rp/53x3xm8zFfzFaerAPc
 w4+91xaxftOJ4PqRH9AunALmqZ1HkQzp1PPkDjB3xASqnk2vNsswphOvyZSnb4ICOgsP
 tAc/K25F0WH6CBJGm7NXvofpFrEdwqpddT+sLx7QucWRYstSDBd6iVL8pdAw+RE67tPn
 fdjjgmNEJ2KBefs5x/xPlCDYRxsWVl7PcEsbuW36P4Sm1HpPc452ZdIEb1y1QTRGebkY
 NQJQ==
X-Gm-Message-State: AOAM533wRRG+oYr/fkuvR+F3g4r9RtR88MZNvDbqSQ0fS8O5aLMzLybF
 01P42qBffJLRpnqMOWTtLTQ2GPW3K7HsIaRpixZyjFmBtaV+EDOeG9os4P/qNa0cA15OlwwLSx+
 rRdCM0X90d3FurAk=
X-Received: by 2002:a7b:c452:: with SMTP id l18mr2067573wmi.13.1598041296288; 
 Fri, 21 Aug 2020 13:21:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+JP8nf824+RINSedlj0fFNlRDT60fWhn12glX3xfstvCau5bvpfQ72qJ0DoGGnsOfSf8FWw==
X-Received: by 2002:a7b:c452:: with SMTP id l18mr2067561wmi.13.1598041296022; 
 Fri, 21 Aug 2020 13:21:36 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id y142sm7742938wmd.3.2020.08.21.13.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 13:21:35 -0700 (PDT)
Date: Fri, 21 Aug 2020 22:21:32 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2] configure: silence 'shift' error message in
 version_ge()
Message-ID: <20200821202132.ftstmvfh3gltgnrk@steredhat>
References: <20200821163312.98184-1-sgarzare@redhat.com>
 <27abc546-0edc-caa1-32be-ac5d6cff79e4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <27abc546-0edc-caa1-32be-ac5d6cff79e4@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 01:18:54PM -0500, Eric Blake wrote:
> On 8/21/20 11:33 AM, Stefano Garzarella wrote:
> > If there are less than 2 arguments in version_ge(), the second
> > 'shift' prints this error:
> >      ../configure: line 232: shift: shift count out of range
> > 
> > Let's skip it if there are no more arguments.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v2:
> > - do not shift if there are no more arguments [Peter]
> > ---
> >   configure | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/configure b/configure
> > index 4e5fe33211..5f5f370e2c 100755
> > --- a/configure
> > +++ b/configure
> > @@ -229,7 +229,7 @@ version_ge () {
> >           set x $local_ver1
> >           local_first=${2-0}
> >           # shift 2 does nothing if there are less than 2 arguments
> > -        shift; shift
> > +        shift; test $# -gt 0 && shift
> 
> 
> That works.  Or you could go with the shorter one-liner:
> 
> shift ${2:+2}

yeah, it is better!

I'll send v3.

Thanks,
Stefano


