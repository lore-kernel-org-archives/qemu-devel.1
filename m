Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB973C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A772075E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHxSLj5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A772075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxNE-0006f9-OG
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAxM0-0005tO-2f
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:28:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40814
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAxLy-0006D5-Kj
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598455725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qv3x2T4bhkSmSkSgh4x5t8Cmxd7N0NQqOf4BLHJwBL8=;
 b=SHxSLj5UpSM2v+wWqScMikZ9b36/GUwshLky18Ct2zxHDmZGCZFqOc3WaX+U6/3OUU2Vfz
 9x2KoQW2Y/gWHMmPJY/R3fSd2KY6sxLl4Y3tSCAys7TMLYX8Y+MIGrx45wNU+dsdNS8Tpt
 ehn7yc7VficN9wEw7Vtpy9aerB/8kbc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-18QPukacPUyDSrXwL-JKfw-1; Wed, 26 Aug 2020 11:28:43 -0400
X-MC-Unique: 18QPukacPUyDSrXwL-JKfw-1
Received: by mail-ej1-f72.google.com with SMTP id f13so1141180ejt.16
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qv3x2T4bhkSmSkSgh4x5t8Cmxd7N0NQqOf4BLHJwBL8=;
 b=hFTEhBDz9nmy0VHxxE9eHG99RJSY1DHavhnLz61qPDXA0+7Kk/qflYsQUqYZQQGlrF
 r/s5zIMct9OLwWw9TQAyzwRqbvNb3uIjpJ/wMG//mPstxU1IxaW/Y1T/XCrPr4/6m5aG
 1yoMRCwDAXoU6CuO6UDeRiBfAjE9CaA4Yfsz3TxxjYRPy9f6lHDJ/CmgsYST7iIBDFG8
 iVnhyzfE9AsRu8AUWJrx0zISxu0WqrlbrkixOfTFWXRGkAp8mdfnIeF5Fubb74uaiiws
 mMb7FQOdj9/LtDAT5YlyQPz1ivXYN4m0EakzEFbGT0UAKiukMfx2hrPNR3iS0XUv1CqZ
 JC7g==
X-Gm-Message-State: AOAM532zLUKFljkDbl+yjRn2yKn9UW0xzXeB78UFG30Ley6NvyXBInRc
 a4fSszCQxSdbIwRuTOtaZKH3pBwukzGkHXIQgPaBCRF2O9t0ohptqdTscbEc0cBD49z4RSBE0bw
 ihZbxsAf3uXBPE8CBfI/rwSww2x3EYlo=
X-Received: by 2002:a17:907:693:: with SMTP id
 wn19mr7018564ejb.121.1598455721755; 
 Wed, 26 Aug 2020 08:28:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgQZD7WliIrlx0zzrBEJPQSnROtQ2PwALR8mQjCTtNNbnPqlop60xph4Y1s6oxeSojPLKqnN/pdZ0cbv4TbA8=
X-Received: by 2002:a17:907:693:: with SMTP id
 wn19mr7018547ejb.121.1598455721546; 
 Wed, 26 Aug 2020 08:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151006.80-1-luoyonggang@gmail.com>
In-Reply-To: <20200826151006.80-1-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Aug 2020 17:28:30 +0200
Message-ID: <CABgObfYdjLouNp8ZvqHmB-xsOJdUgxv3zJL4A1GKuWggh7fnbA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] meson: Fixes the ninjatool issue that E$$: are
 generated in Makefile.ninja
To: luoyonggang@gmail.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 01:10:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 5:12 PM <luoyonggang@gmail.com> wrote:
>
> From: Yonggang Luo <luoyonggang@gmail.com>
>
> SIMPLE_PATH_RE should match the full path token.
> Or the $ and : contained in path would not matched if the path are start with C:/ and E:/

I don't understand this, SIMPLE_PATH_RE is used with re.match which
only matches at the beginning of the string. Can you send me your
build.ninja file offlist?

Thanks,

Paolo


