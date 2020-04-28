Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABFAC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 12:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5B3206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 12:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwXMbRm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5B3206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTPUE-0004Lt-KK
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 08:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xadimgnik@gmail.com>) id 1jTPQa-00079g-O3
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <xadimgnik@gmail.com>) id 1jTPQZ-00053s-UJ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:33:32 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jTPQZ-00053T-DI
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:33:31 -0400
Received: by mail-wm1-x341.google.com with SMTP id x4so2559435wmj.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 05:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=xS+yLt7ge8xiOU6IbkcdYZBC50HgTxf9aJlIZ1nJYHo=;
 b=pwXMbRm965oGRSmqS9QK6ybMcOArhlrKCxr6DUbrardiaOo/WWT13yRtOgrbRol+zY
 fl8GqfcIV7wsXMVM2uX8XxUhi6emqs5bILfBJklf0XHrf6fGiM0qLEMoQjZbhevdJqaG
 cYmuGk2qAPtONV4+MKK5x6/G5G5S0wXtp9OmXak/eWwzEldSUyWK+7tPMy5NcYw6HwVZ
 0Ije/o8dTJ3zSrPQtcEdse7cXhCTxrL280SYxqoHc+kruGRkU1aS3vugv/5KYAfu17Pc
 eidJoS07uuovyaJnoVWpW2pEV82hHKTKCFg4O5mDl/50yPoOkje/1qiQFdzgtpGJX1Yh
 Rung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=xS+yLt7ge8xiOU6IbkcdYZBC50HgTxf9aJlIZ1nJYHo=;
 b=UDgu449fIwpE+ldeR51ECyTdEzt47OOFhIm6gBDAWjKTNmmyuBimDC7IJ7JIqkwD7y
 VGttUUpkCbQVXCJ5y33EIuHNpxwBJrNfhhnBr4tptapF0lO/quRwxkovIzR3EiZfVUlm
 Bhnfo3muJko6nnBit3E0uVmUXMhrMdyQXXRc0nKNHXwNJnTuNuxZWlHZDXar1r/3UuZ/
 IKuajJgOImfmE+pC1CwoN+5rBHe9dLTF627wdQQUHe6PXMejr5T7kIgulaoF5OfYiuzr
 hZ7o9C2eqw1jd540Txn2mJAUSrA8NapfPujhCGkJkz6dBVvvmZYg/6dapQPtw74Xx4Pz
 AIjA==
X-Gm-Message-State: AGi0PubhVIv/6SJas8urJi+EuTwz5hMuaUw0a2YKt/Gv8iRN6qe+ojpz
 ScKDw02uQdCAhoWS39q7pTI=
X-Google-Smtp-Source: APiQypJb9wVCnw5brzV8/l7uPCSh68KOalMqsEymBwz9CA88NFzc/Eqb4BKGTikR72h8Jw8/LAix7Q==
X-Received: by 2002:a1c:f609:: with SMTP id w9mr4291826wmc.123.1588077209864; 
 Tue, 28 Apr 2020 05:33:29 -0700 (PDT)
Received: from CBGR90WXYV0 ([54.239.6.186])
 by smtp.gmail.com with ESMTPSA id t67sm3404801wmg.40.2020.04.28.05.33.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 Apr 2020 05:33:29 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: <paul@xen.org>, "'Artur Puzio'" <artur@puzio.waw.pl>,
 "'Grzegorz Uriasz'" <gorbak25@gmail.com>, <qemu-devel@nongnu.org>
References: <20200428062847.7764-1-gorbak25@gmail.com>
 <20200428062847.7764-2-gorbak25@gmail.com>
 <000001d61d34$6c0218f0$44064ad0$@xen.org>
 <90a8b709-c506-92e2-800c-e1558f18df94@puzio.waw.pl>
 <000901d61d59$1edbe270$5c93a750$@xen.org>
In-Reply-To: <000901d61d59$1edbe270$5c93a750$@xen.org>
Subject: RE: [PATCH 1/2] Fix undefined behaviour
Date: Tue, 28 Apr 2020 13:33:27 +0100
Message-ID: <000a01d61d59$38898600$a99c9200$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQJZJJhe4DhOB0QFT+Ee5i7aNCDcTgF4qWDWAdBYvl8CjAnLpgJCzKCMp0eqVnA=
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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
Reply-To: paul@xen.org
Cc: 'Stefano Stabellini' <sstabellini@kernel.org>, jakub@bartmin.ski,
 marmarek@invisiblethingslab.com, 'Anthony Perard' <anthony.perard@citrix.com>,
 j.nowak26@student.uw.edu.pl, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Paul Durrant <xadimgnik@gmail.com>
> Sent: 28 April 2020 13:33
> To: 'Artur Puzio' <artur@puzio.waw.pl>; 'Grzegorz Uriasz' <gorbak25@gmail.com>; qemu-devel@nongnu.org
> Cc: marmarek@invisiblethingslab.com; jakub@bartmin.ski; j.nowak26@student.uw.edu.pl; 'Stefano
> Stabellini' <sstabellini@kernel.org>; 'Anthony Perard' <anthony.perard@citrix.com>; xen-
> devel@lists.xenproject.org
> Subject: RE: [PATCH 1/2] Fix undefined behaviour
> 
> > -----Original Message-----
> > From: Artur Puzio <artur@puzio.waw.pl>
> > Sent: 28 April 2020 10:41
> > To: paul@xen.org; 'Grzegorz Uriasz' <gorbak25@gmail.com>; qemu-devel@nongnu.org
> > Cc: marmarek@invisiblethingslab.com; jakub@bartmin.ski; j.nowak26@student.uw.edu.pl; 'Stefano
> > Stabellini' <sstabellini@kernel.org>; 'Anthony Perard' <anthony.perard@citrix.com>; xen-
> > devel@lists.xenproject.org
> > Subject: Re: [PATCH 1/2] Fix undefined behaviour
> >
> > On 28.04.2020 10:10, Paul Durrant wrote:
> > >> -----Original Message-----
> > >> From: Grzegorz Uriasz <gorbak25@gmail.com>
> > >> Sent: 28 April 2020 07:29
> > >> To: qemu-devel@nongnu.org
> > >> Cc: Grzegorz Uriasz <gorbak25@gmail.com>; marmarek@invisiblethingslab.com; artur@puzio.waw.pl;
> > >> jakub@bartmin.ski; j.nowak26@student.uw.edu.pl; Stefano Stabellini <sstabellini@kernel.org>;
> > Anthony
> > >> Perard <anthony.perard@citrix.com>; Paul Durrant <paul@xen.org>; xen-devel@lists.xenproject.org
> > >> Subject: [PATCH 1/2] Fix undefined behaviour
> > >>
> > >> Signed-off-by: Grzegorz Uriasz <gorbak25@gmail.com>
> > > I think we need more of a commit comment for both this and patch #2 to explain why you are making
> > the changes.
> > >
> > >   Paul
> >
> > I agree Grzegorz should improve the commit messages. In the mean time
> > see email with subject "[PATCH 0/2] Fix QEMU crashes when passing IGD to
> > a guest VM under XEN", it contains quite detailed explanation for both
> > "Fix undefined behaviour" and "Improve legacy vbios handling" patches.
> >
> 
> Ok. Can you please make sure maintainers are cc-ed on patch #0 too.
> 

Actually they are, sorry. My MUA is playing tricks on me.

  Paul


