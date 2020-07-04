Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BCEC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 19:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E4820870
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 19:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mindspring.com header.i=@mindspring.com header.b="Sw0fFAxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E4820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mindspring.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jro9T-0007lu-Jb
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 15:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jro8s-0007It-M8
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 15:48:06 -0400
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:53508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jro8q-0000eD-Tq
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 15:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
 s=dk12062016; t=1593892084; bh=luFYW3Sk3oQA6l5wuV/Th3LSkrQ91nv8qPcy
 cKm7voE=; h=Received:Message-ID:Date:From:User-Agent:MIME-Version:
 To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:
 X-Originating-IP; b=Sw0fFAxA1q4qu+K2eBAkPFeNVj2bzpZp9DQ5nAuBK6Q+11
 WJTxbij69/nyypZNzVhoziK8cSD+XsTM6oykqfmGQuw/olllrmMtQJvEiCfwG9Nf40W
 0M6mS+ojMoXF8ZTqABntkXmOvvr4JQlQtwxROKBaIIX7nDQReN55trLDajAruv9thSr
 mb2LVJsBYeb19YAIzlunD+nkyrrxZ4XNN2Hku1C/EKKlV4sCQ7vkIP4SrlNfZjkpxel
 ro/QC7EI9WnA9bLUVIcSolsE3QMdLS6Wegz3UjqndzKDBuSyxZrXWDx/5wBDZIA34Qy
 L6v4GT/vf2i3dv6XJ33b5GJVk3+Q==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
 s=dk12062016; d=mindspring.com;
 b=Gyy6voKeHelccapawfl/zdZnxk3QuH6IBDMSt56NGsVFgmx01ydks/PsMhz7Oil4HPtiILRxFeapDTWPtg5Z3pbFz6vrYZ9FnMnUtKr8zCGDqG3BGa0/6uHrnvRyWZw73RrCSvpzs97rBTdzotAXbyX4OnjmHBogwiVMMNMBVElfEepkERfj979qkowThy4oscwrc1MF0hHmM6OpcLBnVeIJRj21uuPSy/LBFiXFRvmjKP+D3LYbWoigpe7Kft4ezuNOBkjJ/ABO4/I1dPIuTyxIFZ6hUo/xgURt+tNa+UNCGkyzKA3u0LG4Qgd26u8ilnI9jI42f3RofZCyadRo4g==;
 h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:X-Originating-IP;
Received: from [8.9.81.230] (helo=[192.168.0.78])
 by elasmtp-kukur.atl.sa.earthlink.net with esmtpa (Exim 4)
 (envelope-from <denber@mindspring.com>)
 id 1jro8n-0003Qa-Hn; Sat, 04 Jul 2020 15:48:01 -0400
Message-ID: <5F00DCF1.9040109@mindspring.com>
Date: Sat, 04 Jul 2020 15:48:01 -0400
From: Michele Denber <denber@mindspring.com>
User-Agent: Mozilla/5.0 (X11; SunOS sun4v;
 rv:10.0.7) Gecko/20121005 Thunderbird/10.0.7
MIME-Version: 1.0
To: =?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: gmake in Solaris 11.4: TFR missing
References: <20200702143955.678-1-thuth@redhat.com>
 <5EFE07BC.6040407@mindspring.com>
 <1e699fdc-639e-ef8a-313f-7e665cad868c@redhat.com>
 <5EFE5291.6030300@mindspring.com>
 <975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com>
 <5EFF5DFC.2060006@mindspring.com>
 <CAFEAcA81y59yaOCW=QONy9EKv6Fdkkwb=XGJ786-N5du2+P9NQ@mail.gmail.com>
 <5EFF7DD7.1000605@mindspring.com> <5EFFA499.7050008@mindspring.com>
 <3474053c-12d7-cf4a-5470-62845c166127@redhat.com>
 <5F00A1ED.6040909@mindspring.com>
 <69adae2a-8c3c-ec17-08f4-c2109b1d0993@amsat.org>
In-Reply-To: <69adae2a-8c3c-ec17-08f4-c2109b1d0993@amsat.org>
Content-Type: multipart/alternative;
 boundary="------------010102000809080404090600"
X-ELNK-Trace: 17a948d2f1835c375e89bb4777695beb24867385ea7beca5381d0a1d30daf95d9ddf457528d68a7f350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 8.9.81.230
Received-SPF: pass client-ip=209.86.89.65; envelope-from=denber@mindspring.com;
 helo=elasmtp-kukur.atl.sa.earthlink.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 15:48:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Peter Tribble <peter.tribble@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------010102000809080404090600
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Update: actually, after using it for a bit, it appears that XP runs at 
about the same speed in 5.0 as it did in 2.12.  It's just the initial 
boot that's very slow.  Does this message (which I discovered hiding 
under the QEMU window) have anything to do with it?

(qemu:27712): Gtk-WARNING **: Could not load a pixbuf from 
/org/gtk/libgtk/theme/Adwaita/assets/bullet-symbolic.svg.
This may indicate that pixbuf loaders or the mime database could not be 
found.


             - Michele


--------------010102000809080404090600
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Update: actually, after using it for a bit, it appears that XP runs
    at about the same speed in 5.0 as it did in 2.12.  It's just the
    initial boot that's very slow.  Does this message (which I
    discovered hiding under the QEMU window) have anything to do with
    it?<br>
    <small><font face="Courier New, Courier, monospace"><br>
        (qemu:27712): Gtk-WARNING **: Could not load a pixbuf from
        /org/gtk/libgtk/theme/Adwaita/assets/bullet-symbolic.svg.<br>
        This may indicate that pixbuf loaders or the mime database could
        not be found.</font></small><br>
    <br>
    <br>
                - Michele<br>
    <br>
  </body>
</html>

--------------010102000809080404090600--

