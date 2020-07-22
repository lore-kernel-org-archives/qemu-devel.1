Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0B6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:47:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52254206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jK0jFVvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52254206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyE9i-0001q4-Il
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jyE99-0001Qe-LA
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:46:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31768
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jyE97-0003pe-3l
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595422011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Z7LSGrbpZGWCGRkbJ78GZX93P5R8EarvueuC/qlm+w=;
 b=jK0jFVvYlKoM3rbc70BEWa+cPE+NYqZ7O5WDWz1VMKyQan8AMmfZbHtKB9upiyYdh5YuSs
 oy+rzI8izzzFyFtvLZ++MYPUqrYGyCykJkC/bmGL1CMtkVnCQjLRjmOKE+2b9KzezQfrlM
 uW4fXIBoakohhc9WMxGehK9GOi2gEgE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-yhPdxPbVOcWuqAZ7Q3L3kw-1; Wed, 22 Jul 2020 08:46:49 -0400
X-MC-Unique: yhPdxPbVOcWuqAZ7Q3L3kw-1
Received: by mail-qv1-f72.google.com with SMTP id v10so1333856qvm.17
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 05:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+Z7LSGrbpZGWCGRkbJ78GZX93P5R8EarvueuC/qlm+w=;
 b=c6o7K/WNMiOiWb9y4ymadBGwFil1M4S0NXH60YLgvfHpjFI0IAoW2IjRwcM7QnumjU
 KisFOicOTaUObDYgdSrI4Kd+1tSTzIXwre+rEJMEJzEc8fg7Aon1+cjOe6WnIZ2QUJOq
 AaUPM/f6A0mZDxVlgvf6IPP1tqKOE7EBhrRJuOGRYewcmIbAacQ9i2tTekfHJ/H7Gp+F
 r2kV70sMwgdLtIEIvvH0Fj4wX+hCeSWrbKKFXDJLzw27id4deCat1YvvZ0GyZ+LAlQwO
 mkFIwBIu9u1kbGCmK5fuh++HtN/pNkXi6geTq0S2DMMNbYZXG7prcOUG3mLeeBse34R7
 GcNg==
X-Gm-Message-State: AOAM532IzliE4bsDlVd4QsF92/1rXCDw2VjWtyky57Z7pwZ0668du/kt
 ZYSSJ28YEJgZlbzSd1JRR+9uE30amtImkkOgzWOiCJxZDg5wgbC5jxHJHFaHYCZdlFUZFYM8BYF
 JRD0N5QL/4jvItlo=
X-Received: by 2002:ac8:24fc:: with SMTP id t57mr35118040qtt.116.1595422009252; 
 Wed, 22 Jul 2020 05:46:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLrnO1KReuArldTvd65HpGZCd9JJEikc6sxfYJEoIpE2xqZHJAstUnn560QbBcmAnxorQtvA==
X-Received: by 2002:ac8:24fc:: with SMTP id t57mr35118027qtt.116.1595422009013; 
 Wed, 22 Jul 2020 05:46:49 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
 by smtp.gmail.com with ESMTPSA id i19sm4513543qkk.68.2020.07.22.05.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 05:46:48 -0700 (PDT)
Date: Wed, 22 Jul 2020 08:46:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/4] error: Strip trailing '\n' from error string
 arguments (again)
Message-ID: <20200722124646.GW535743@xz-x1>
References: <20200722084048.1726105-1-armbru@redhat.com>
 <20200722084048.1726105-3-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722084048.1726105-3-armbru@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
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
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 10:40:46AM +0200, Markus Armbruster wrote:
> Tracked down with scripts/coccinelle/err-bad-newline.cocci.
> 
> Cc: Peter Xu <peterx@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


