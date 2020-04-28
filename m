Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AC6C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B30820663
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYDoaOI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B30820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTMTA-0006va-4L
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 05:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xadimgnik@gmail.com>) id 1jTMOf-0001tO-Ra
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <xadimgnik@gmail.com>) id 1jTMLa-00070b-PD
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:19:21 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:54903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jTLJe-0006q0-QA
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:10:07 -0400
Received: by mail-wm1-x32c.google.com with SMTP id h4so1651724wmb.4
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 01:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=tqa9n9EoSDAPwWeVvhR+Uj2qxGKno9fvpdj73k0ySF0=;
 b=gYDoaOI16qKm0ihSWCygBBdWCDnhE++szBYSLccatExDMbjbQ+PXEHfibgnsbzjFCb
 inUlb2LhfwjDteWTkbizCmhwEyo0A3czN2uPx0BjLsHLY5684Lz4ALiyPiVofW7yiMz6
 L3uBJkZnS3/O5gngb/WkEp3XYAET1+dSevY9G2Ozd7QdcD62nk4HCMiGRYYdv1Q7OlTA
 SwZ3LVlGvgUBXIktcyICxsN8tphHOac9MKQvpBsPgh34a59oVCU3fnH0CAJaAyIR/S7T
 0jA3CYcxKdl2SbMeBeZ2mzuaE4BRpEfnWZJpLWwKTom67tpY0GkFucaRewvCU6W66Hjs
 3hYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=tqa9n9EoSDAPwWeVvhR+Uj2qxGKno9fvpdj73k0ySF0=;
 b=QC7VD6onWBktOe2Mdpkdo2GIqFQT3QkX69l456St9z7XyZotzDRmA1RS12TZDN9Na6
 lUOh3IGjdO26ii/J9xV0TBbsOFZ7W5VRpQYQMSsDczaoTzINdifrR8FMmZ1hWLg8jZZV
 b2QnVjx+Z8scH3hbe8XazQPfL258iKQ2EqJKw6Ob/9uyD3L1RI3GE++KTxeIWW2CSOCz
 SttYYEFhMDraILaFvp7J0h8euvPg0s3g9TTdZ+UgG8skN0/X5zwtGusnPKfBrLNO4IvO
 0FFuIhUlhLW3lz9/xLerbj7fhJGbUixqxWGeQcHGXbxqK0kGRua72fOy5eBN6LMHYceh
 WUiQ==
X-Gm-Message-State: AGi0PuaS+O+dPT6sn2iwa+vDXugGbX0bzm5sq8CwgCl+lqd1bs+wMB1s
 Qcr8aC9+4lIWD9KyRBwJ1gM=
X-Google-Smtp-Source: APiQypI7ne91jSGdPfgFLjPDbWwiOo2xKnOh99cblKMQobaj588UxOZv1r75AYV27BnAwN7EilS/wg==
X-Received: by 2002:a05:600c:1008:: with SMTP id
 c8mr3067783wmc.14.1588061404689; 
 Tue, 28 Apr 2020 01:10:04 -0700 (PDT)
Received: from CBGR90WXYV0 ([54.239.6.185])
 by smtp.gmail.com with ESMTPSA id h13sm23315817wrs.22.2020.04.28.01.10.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 Apr 2020 01:10:04 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: "'Grzegorz Uriasz'" <gorbak25@gmail.com>,
	<qemu-devel@nongnu.org>
References: <20200428062847.7764-1-gorbak25@gmail.com>
 <20200428062847.7764-2-gorbak25@gmail.com>
In-Reply-To: <20200428062847.7764-2-gorbak25@gmail.com>
Subject: RE: [PATCH 1/2] Fix undefined behaviour
Date: Tue, 28 Apr 2020 09:10:02 +0100
Message-ID: <000001d61d34$6c0218f0$44064ad0$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQJZJJhe4DhOB0QFT+Ee5i7aNCDcTgF4qWDWp3xZsEA=
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::32c
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
Cc: artur@puzio.waw.pl, 'Stefano Stabellini' <sstabellini@kernel.org>,
 jakub@bartmin.ski, marmarek@invisiblethingslab.com,
 'Anthony Perard' <anthony.perard@citrix.com>, j.nowak26@student.uw.edu.pl,
 xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Grzegorz Uriasz <gorbak25@gmail.com>
> Sent: 28 April 2020 07:29
> To: qemu-devel@nongnu.org
> Cc: Grzegorz Uriasz <gorbak25@gmail.com>; marmarek@invisiblethingslab.com; artur@puzio.waw.pl;
> jakub@bartmin.ski; j.nowak26@student.uw.edu.pl; Stefano Stabellini <sstabellini@kernel.org>; Anthony
> Perard <anthony.perard@citrix.com>; Paul Durrant <paul@xen.org>; xen-devel@lists.xenproject.org
> Subject: [PATCH 1/2] Fix undefined behaviour
> 
> Signed-off-by: Grzegorz Uriasz <gorbak25@gmail.com>

I think we need more of a commit comment for both this and patch #2 to explain why you are making the changes.

  Paul 


