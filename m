Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CC6C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:01:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB4E20848
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB4E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNGCA-00062i-Kk
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 10:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kNGAS-0005DN-Ia
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:59:44 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:34899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kNGAQ-0004A0-Ky
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=/6jbIRjUAtVZGGk6gEYrACTLQuHei87M+7UfjHxjsLs=; b=nGUS9tRipgxyuo3hpvpRsY8ETE
 3hFpqgb614l0CQZNokZh+gDGqtw+VH8g/VPhtZpvLDlBV5QT7knBTPMJsKiLVsvx2He4oXpz9aWyR
 IgamL7pKWnzD89L0Z+8LQeTGWQNFw/w/aqpZCl0haVCss2uHNDMuujIViEAXMQhE7RFTlSEenmHKr
 aRC6DIB6pSEkJ9Lylpf/gocxrX/yz7orjg/mgpXDYv0e3m9vMx5KGeLRYN7a1b5B6/Ln5EVEpJUwA
 kpAg5uyqXnKch6qpHxmx1axAkHSNDiEzhQ1GuYr3w054LpDA1JLEN8g50j7jo9A+BFAY9+6xrJEAD
 gRvKeqO3uvgWsIg14kv3/5dzXIlz0IKK5hZ3vZhYj0ZIUCtf4j+8Kw2FNvPlT8NkxyesNkSn1slb+
 uhMyyzjgvvBnVgiepNPZ4jfipnThTzHUenB16p2mvxwLLjqtMbVMA57lyOrnbNyNvBdMzXMCIZcJ5
 1oKOImZocRc4jVN0LGMXkKvpxNpuVhgKJwiKN74E/rcp+tu8CLxPCsb0tO52sT7qR0CnvnV9/5vj3
 IsMNRoI1IZ/ycOw+CKs6d7zH5N1gspyDawemnIQBLiLaoo5kLGfxehtdx4EaA6t3XEHeQIXd0M3oi
 mvkXPErL245YI/9aSCKHNvrQbQY/KO7oIXND+xvfc=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Vivek Goyal <vgoyal@redhat.com>, "Venegas Munoz,
 Jose Carlos" <jose.carlos.venegas.munoz@intel.com>,
 "cdupontd@redhat.com" <cdupontd@redhat.com>,
 virtio-fs-list <virtio-fs@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Shinde, Archana M" <archana.m.shinde@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: virtiofs vs 9p performance(Re: tools/virtiofs: Multi threading
 seems to hurt performance)
Date: Tue, 29 Sep 2020 15:59:34 +0200
Message-ID: <6044656.UxkCsAYsKb@silver>
In-Reply-To: <20200929134942.GC220516@redhat.com>
References: <20200918213436.GA3520@redhat.com> <2302525.O3mciSdnpG@silver>
 <20200929134942.GC220516@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 09:28:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Dienstag, 29. September 2020 15:49:42 CEST Vivek Goyal wrote:
> > Depends on what's randomized. If read chunk size is randomized, then yes,
> > you would probably see less performance increase compared to a simple
> > 'cat foo.dat'.
> 
> We are using "fio" for testing and read chunk size is not being
> randomized. chunk size (block size) is fixed at 4K size for these tests.

Good to know, thanks!

> > If only the read position is randomized, but the read chunk size honors
> > iounit, a.k.a. stat's st_blksize (i.e. reading with the most efficient
> > block size advertised by 9P), then I would assume still seeing a
> > performance increase.
> 
> Yes, we are randomizing read position. But there is no notion of looking
> at st_blksize. Its fixed at 4K. (notice option --bs=4k in fio
> commandline).

Ah ok, then the results make sense.

With these block sizes you will indeed suffer a performance issue with 9p, due 
to several thread hops in Tread handling, which is due to be fixed.

Best regards,
Christian Schoenebeck



