Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB9FC4CECE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7779B21907
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7779B21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA9Bk-0006qO-IV
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 04:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iA96W-00046D-QZ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iA96U-0000Cn-Up
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:44:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iA96U-0000BX-G2
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:44:54 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 64189369C4
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 08:44:53 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id t65so1931832pfd.14
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 01:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=h8oq30RQJxmg908FL16/wdaVgaMtq4xBSgU4I2DD0Wk=;
 b=KrBNfCOvl5KFGL8rYASaOyY74qsYOf+uZeJFzWogQST16ich/7nan/vDTmusYk7Abb
 9yoqFo9vOS/Qo1kb0QPEGsrM4O8GdUN+wK9ugnABCnwYZlpyI6V6CZ5hIM+ttSV2d0JV
 okzdbXEX/HK76WNEppRUBc/jPGsK5LN4ti5u+/geNzRmYzZI6IUmmZ5cAZR+PN/jDx4N
 /STgAyyMPReOzwJnND3G6OBHFzQPGO2LYJ22Bdbl/GEgxNeB8DIbHyubvYE/wqNzjaqj
 85CNfqXgq55pKDF8W33VCaWpTxqcDHXEVI2H/hITfaQ2/3IOiQRXSudGqnhKFLz1HhDR
 26rQ==
X-Gm-Message-State: APjAAAWtMV4y47UaJQHCIwL0WxLMl/5nUloL3WwtgHcldjI0svC8ajaV
 AqW8AgO88ldSNAECSm5YeAQg4PjvEd2BNFdMOjrmycK/jvh+zviatuR4YihT5Lg56NdE7deKR0v
 qpeI0NkpVXtrw//8=
X-Received: by 2002:a63:505:: with SMTP id 5mr2167979pgf.297.1568709892828;
 Tue, 17 Sep 2019 01:44:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxP7QE98ap6hFYzvifRsnetLme1kUp9C07mNgJUQcN4JA7x6LtvyGRiRkzDRLh/x4OxrwePvA==
X-Received: by 2002:a63:505:: with SMTP id 5mr2167964pgf.297.1568709892598;
 Tue, 17 Sep 2019 01:44:52 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p68sm4149085pfp.9.2019.09.17.01.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 01:44:51 -0700 (PDT)
Date: Tue, 17 Sep 2019 16:44:42 +0800
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190917084442.GE30562@xz-x1>
References: <20190916132347.30676-1-imammedo@redhat.com>
 <20190916132347.30676-3-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190916132347.30676-3-imammedo@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 2/2] s390: do not call
 memory_region_allocate_system_memory() multiple times
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 16, 2019 at 09:23:47AM -0400, Igor Mammedov wrote:
> PS:
> I don't have access to a suitable system to test it.

Hmm I feel like it would be good to have series like this to be at
least smoke tested somehow...

How about manually setup a very small max memslot size and test it on
x86?  IMHO we'd test with both KVMState.manual_dirty_log_protect to be
on & off to make sure to cover the log_clear() code path.  And of
course to trigger those paths we probably need migrations, but I
believe local migrations would be enough.

And since at it, I'm thinking whether we should start assert() in some
way in memory_region_allocate_system_memory() to make sure it's not
called twice from now on on any board.

Regards,

-- 
Peter Xu

