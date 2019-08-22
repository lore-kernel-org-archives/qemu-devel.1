Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB34C3A59E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 03:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F03921848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 03:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F03921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0dw7-0005rh-Gj
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 23:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i0dvC-0005HZ-PB
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 23:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i0dvB-0005Ng-5M
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 23:37:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i0dvA-0005NM-W6
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 23:37:57 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D32736899
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 03:37:55 +0000 (UTC)
Received: by mail-pg1-f200.google.com with SMTP id m19so2431366pgv.7
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 20:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=72+m9LFHQRCdyhPRunmB0nwVh3nqfS0bTiyOT0Gx/W4=;
 b=jYPbkzKuXFQNdzBCh1QkHep3WN8Dsy7AIXj/Hjye1jzfNYImB2bm+HIFEPqAtJbrZd
 e552MZ4rpOWCJoi2eeGTyUi4oFXI8ObKGm/t+Nd/rrOa9kewjSgq85+pYYfO36e0eU3b
 yzsQfR80bPKVzxltB9vM6TmYPFo85QkPagrRVkNUQfQHewnw7/P4vLH4qoMZhmWEKS6X
 xEYD88mFBYcyKG3QxnSUXCnj0v4qMdkVqMdUGzPRahZ6CjWJ6uaBy7Z/DJ7dKeYeo2j8
 AYa2OWlzL2E+O2gCH46YOabLyK3m81Tb/RGdQ3lrgxO4dK6EW1UV9v/C45VjS66SPgG2
 SJAA==
X-Gm-Message-State: APjAAAXao4Ripq1gZkErruqGWZMp7UwwE9FdI88hhVt1Q0jfvL+REwKg
 TPfIAEh3P+X77DdUH71Uk1GwAbYY4cyd0xG5P5EVikX1W3NuSSiEfzFIa3DWZ+HJV2pEyMeUsHo
 Aa5rG6M9vHs+gEuw=
X-Received: by 2002:a65:5b8e:: with SMTP id i14mr31800863pgr.188.1566445074675; 
 Wed, 21 Aug 2019 20:37:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwG0A+oZ7bSNakaZ2zolUd1nVJdRMdCD0i2aYJhSaCjSxPIgVPlWcbNLqzkXHTbDxNYvX43RQ==
X-Received: by 2002:a65:5b8e:: with SMTP id i14mr31800853pgr.188.1566445074415; 
 Wed, 21 Aug 2019 20:37:54 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j12sm23946216pff.4.2019.08.21.20.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 20:37:53 -0700 (PDT)
Date: Thu, 22 Aug 2019 11:37:44 +0800
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190822033744.GB7461@xz-x1>
References: <20190821155327.25208-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821155327.25208-1-berrange@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] tests: make filemonitor test more robust
 to event ordering
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 21, 2019 at 04:53:27PM +0100, Daniel P. Berrang=C3=A9 wrote:
> The ordering of events that are emitted during the rmdir
> test have changed with kernel >=3D 5.3. Semantically both
> new & old orderings are correct, so we must be able to
> cope with either.
>=20
> To cope with this, when we see an unexpected event, we
> push it back onto the queue and look and the subsequent
> event to see if that matches instead.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Thanks for fixing it!

Tested-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu

