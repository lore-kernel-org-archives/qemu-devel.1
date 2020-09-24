Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D698AC4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE6D207C4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iw5pT74z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE6D207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLcPg-0003SH-3I
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 21:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bleal@redhat.com>) id 1kLZZx-0004DT-7H
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 18:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <bleal@redhat.com>) id 1kLZZu-00026R-R3
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 18:19:04 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600985941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=taBdjaJbsenKEM5rEWzmilDSKLagLISaT1drTXH73L0=;
 b=Iw5pT74zuzkg396b5IRTLqLpnOMzn6Xidx7ItThO01n1Uo+0lFWzXmUjQUnQZuWJHjgSey
 ctjhPZ25l0TqzIhJ+SSlMe4oLk2CRsnlcVLPUfZIC1T4cc7ux0U26PKp3jIdrpUOyB9PHl
 xiBxEYLNYVrU5ld3y9DmuoQW0tWTmW8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-5_RvRe0gPEy2rVhydf2Igg-1; Thu, 24 Sep 2020 18:17:52 -0400
X-MC-Unique: 5_RvRe0gPEy2rVhydf2Igg-1
Received: by mail-qv1-f70.google.com with SMTP id l1so458842qvr.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 15:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=taBdjaJbsenKEM5rEWzmilDSKLagLISaT1drTXH73L0=;
 b=HAvUJalGR1QiBhvBocVDxzAO7jQvewQqSsw9VQ4iWoScQQH6eQtFUOWpkl+deSEgVG
 MHSgrffDrCd6kaHk1GDVStFu0BV7BMpX/utNQnDvoOexk9yEymqGBbs9S4tp3em1DKB5
 0zxgFc2bDHCSqMSJK10lr0x4GG9g/5MUFxvjzWOplnviaoxY/vAwxC41A2UFtUYYRG4E
 CwiPXu9u9UWz2bqk8fq+YTCzGi+LmdqwiJe9hjU0R4O455D8RzhUo74eAFajnEFDKTCb
 SfdoNA0nRYIIIzC/30LHVXww3jYy/Qw++CopzbxtoveInAg8NlX4K9QdHzvwlQxe+ONZ
 +PAA==
X-Gm-Message-State: AOAM531/Zadx0nYCqMpBy4mdSdxr9wmj8+HuwQI3XjBw5v3c/Q4k4CFs
 MHLtUt/8D7ziov+ra/wJM/KJZjgZmhQh6S2es/+xtVtOIj0vIvc4XxAP92E5xmpEFQP0mdLNrG1
 aBFFk/2NUFz+zLC4=
X-Received: by 2002:a0c:80c3:: with SMTP id 61mr1497777qvb.13.1600985871642;
 Thu, 24 Sep 2020 15:17:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIS8AOj95JU4XV0H6+nHkZRcclo2CFIYLn5i5e4VqAzrr/7xbwVZtFyAdMVDo5GHZWv9QSTA==
X-Received: by 2002:a0c:80c3:: with SMTP id 61mr1497760qvb.13.1600985871444;
 Thu, 24 Sep 2020 15:17:51 -0700 (PDT)
Received: from localhost ([191.162.212.107])
 by smtp.gmail.com with ESMTPSA id j88sm619650qte.96.2020.09.24.15.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 15:17:50 -0700 (PDT)
Date: Thu, 24 Sep 2020 19:17:47 -0300
From: Beraldo Leal <bleal@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 04/38] qapi: Prefer explicit relative imports
Message-ID: <20200924221747.mxs56b5inzblu7ui@laptop.redhat>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-5-jsnow@redhat.com>
 <20200923131825.GD191229@localhost.localdomain>
 <294a050e-9c8a-952e-b58f-8c11f2e75570@redhat.com>
 <20200924192550.GB347036@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200924192550.GB347036@localhost.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bleal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=bleal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 24 Sep 2020 20:45:14 -0400
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 03:25:50PM -0400, Cleber Rosa wrote:
> On Wed, Sep 23, 2020 at 01:12:09PM -0400, John Snow wrote:
> > On 9/23/20 9:18 AM, Cleber Rosa wrote:
> > > Relative imports are a source of heated debates, but when properly
> > > used in a self contained module like here, they are very posititive
> > > IMO.
> > 
> > Still? I know they were loathed pre-3.5, but in my subjective experience
> > they behave the nicest overall in the modern python dialect.
> > 
> > What are the downsides?
> > 
> > --js
> 
> I'll just invite Beraldo to the discussion and let the fun begin :).

Nice try, Cleber! ;)
 
Well, relative imports are supported by Guido, so I'm not here to say
different. There are some use-cases.

I'm not fully aware of the qapi context and big picture here, but I
guess that depends on how you would like to use your package/scripts.

Some may say that one "downside" is that relative imports are not as
readable as absolute ones. But reading the 04/38 PATH description by
jsnow, yes, looks like using relative imports is one valid option here.

I prefer to use my scripts as packages inside venvs, and I use to have a
setup.py, with absolute imports whenever possible, and when in
development mode, make use of `python3 setup.py develop` which will
create the "links" for me. 

--
Beraldo


