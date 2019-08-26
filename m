Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFE6C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 18:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CAC72070B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 18:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjpkV5x/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CAC72070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2K6Z-0004Wz-L1
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 14:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sbarreto.gabriel@gmail.com>) id 1i2K5j-0003zs-2p
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 14:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbarreto.gabriel@gmail.com>) id 1i2K5i-0003kX-1A
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 14:51:47 -0400
Received: from mail-yw1-xc2d.google.com ([2607:f8b0:4864:20::c2d]:37992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sbarreto.gabriel@gmail.com>)
 id 1i2K5h-0003iB-T1
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 14:51:45 -0400
Received: by mail-yw1-xc2d.google.com with SMTP id f187so7002799ywa.5
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=V5HshfmMMCTeore+kErp46y1hC6DwZiqbcJz8Mqncuc=;
 b=bjpkV5x/ksfSAIQRkqJ7sxdllW3CvhV4M84EKb0EGq2Kwv1j7EdxC7zOgAqmrAz4Gz
 810lxQqBVlKYvaddCFLo4MSTkbzRCn81GwWB3r/Fjp75LQjNhJFSr1ztEbsfHIchlaB+
 Oti4K4eXfbSY6aW0fFs40VVaSyHqukvEJbmsNTSK+aUkmAIwmKga6mx5pytgi3Ly8vP2
 x+8NDtAkO23mGmJdlRxcVdfqRzqLeM/7Oh9F0KvSgLs4gH/lGc3nZLf0TbzdhuXW6wYj
 5P/N293eved983wsIon3GwuQmBFeXEZCV1M4iRojF1zq2OqWMXvdP75nTC3nIa5+2KiJ
 XmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=V5HshfmMMCTeore+kErp46y1hC6DwZiqbcJz8Mqncuc=;
 b=W6BsZXlTHwdTD/MKOfYO3t4QQ+S9D3mQqdLiV4HQRZHiWj6fYBTZ8xQ5qYivpC01um
 Vmhmaq7igHBPQlUYa7MhFOj3OCd27rbri0lINK0JiXQcRUyfKzNH63/4koy/4fc2fjdk
 sVukoxPXSe+dQl+NU6FQvvhFtGwUpVm6gWm+BG9ZOGjPXmUbbFaK0AdFMvqpT8J1FDuA
 Ks+DFbOOFX4FZvudPHCPiY6xTGHx1HvtyQTjGlL1uLH9RtJlUPbG0Mrybko3vOZ/eGfa
 N43Hamj9Yesl+4LBBiycbrqjK+WcURLT1iXpVpkhP8V2E4knYF41JhUfe5GKJq3d3H3Z
 hhGA==
X-Gm-Message-State: APjAAAUYqMOgOqE5x6DcCjiS37e1ayfvE1r4mza2noBap1AsMkuLKUWf
 A6NdntM4e2kifPzSG2k+2PUnZ/jg9+GjuAnCqcI=
X-Google-Smtp-Source: APXvYqzJeWZttP140NedhuCRYoLKR2kELTqdlteekFfwjbOlv/mDffsK/Ds3sFG3iImQ/eFsxpX/ourQNzg58btU/jk=
X-Received: by 2002:a0d:ff85:: with SMTP id
 p127mr13441849ywf.424.1566845504539; 
 Mon, 26 Aug 2019 11:51:44 -0700 (PDT)
MIME-Version: 1.0
From: Gabriel Barreto <sbarreto.gabriel@gmail.com>
Date: Mon, 26 Aug 2019 15:51:33 -0300
Message-ID: <CAJzA9zP0GnZ17_YSxUhAGFrD_fCM-R=rxEVN5y9V-5-5zTsnVw@mail.gmail.com>
To: ehabkost@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c2d
Subject: [Qemu-devel] GSoC project: API Documentation Generation links and
 comments
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

I've uploaded to my github repository=C2=B9 the work done so far. Using
Peter's patches as a starting point, we were able to generate
kernel-docs documentation for some of QEMU's APIs. After studying the
available options, we found a nice solution to publish the
documentation online and keep it updated, using Github Pages and
Travis CI. The idea is to use QEMU's Github mirror, updating the
documentation (located on a gh-pages branch) with every push done to
the master branch. I've implemented this and it's available at a
Github Page=C2=B2 on a gh-pages branch managed by travis jobs. The default
theme needs better structure, but a search in existing documentation
is possible as an out-of-the-box feature. My work is not done yet, as
I still need to rebase my commits to obtain a proper format for RFCs
and figure out a better alternative to deal with the massive number of
warnings that happen when generating the documentation. I'll keep
working on it and welcome any feedback from you. I'm available to
answer all questions you might have.


[1] https://github.com/gsb16/qemu
[2] https://gsb16.github.io/qemu/


Kind Regards,
Gabriel Barreto

