Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B490EC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 19:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89E6A2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 19:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=koconnor.net header.i=@koconnor.net header.b="OfaqrZxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E6A2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koconnor.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37428 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heOo3-0005e0-MR
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 15:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47119)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kevin@koconnor.net>) id 1heOlS-0004JB-AG
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 14:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin@koconnor.net>) id 1heOlR-0000Cu-71
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 14:59:58 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:36191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1heOlQ-0000C4-MM
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 14:59:57 -0400
Received: by mail-qt1-x843.google.com with SMTP id p15so8011919qtl.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 11:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koconnor.net; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=wSZKVWaU13Lldt+uoeDTm6X0Hu3SIy1ANPDm7fEqQGI=;
 b=OfaqrZxm5zAsN+c9/+aTqYgkhqQid3dOvb4D8Pz5KOmK5cePQ51vkN2Q+eZLzEYmIJ
 E5PFTMoQ7ozbF2PFUHW4oPzGXHAtysrKWW8R+VTE0cyDfKqzK+Cxq0RIEJrY6yFBckRH
 egVXAJYWPJxqncP+1UwV5P0mwOpYu/AKKjCdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=wSZKVWaU13Lldt+uoeDTm6X0Hu3SIy1ANPDm7fEqQGI=;
 b=iZJDz02p9TKCsWbTdkePXdQS0cpRSmVof+4n9AM6uicUfgGPM1AL2ObAWO9V3+eEVL
 y7ygZSGuFRwDD4+JMSRHbT2RiGtQaqrk8V35UGjErMm1wddn5Y4zQCWLxTLfoGtJmFUo
 Wb0IA+P5hahKk9oNKITYcdwzrZcsLIlx3qbwchl9IeHhxnBS3n1qrA/U+UQmtXZ1WD6B
 QGQ3597ygozx24xE1+d5IPCzqkwkfgUB8XZYSzg97z/Ry/AF93oZtVjpPyXPWLu3VV7Z
 EUJfY7TdoySNuZDdbXLK+WzjSnWl7Kz/fQmYVRdcQCFmyVMS9ckXCrdnQCL3gHe2nKDk
 ttYA==
X-Gm-Message-State: APjAAAXXJ9aV+c50ZgXsXVJ6Y+CL13ZLObIneGRr9idmjtVrfrdgkkx9
 1KGBV5ftHbFqdDK6v5OIKDamSA==
X-Google-Smtp-Source: APXvYqxbuycj8AMuhPv2e7m2bSQxqsw2tFrGhKVcsXI/iwqrDw1yA60dI9jklHBcs3RO425smNfkKA==
X-Received: by 2002:a0c:b04d:: with SMTP id l13mr46803805qvc.104.1561143595173; 
 Fri, 21 Jun 2019 11:59:55 -0700 (PDT)
Received: from localhost ([64.9.249.135])
 by smtp.gmail.com with ESMTPSA id l5sm2011268qte.9.2019.06.21.11.59.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 21 Jun 2019 11:59:54 -0700 (PDT)
Date: Fri, 21 Jun 2019 14:59:53 -0400
From: Kevin O'Connor <kevin@koconnor.net>
To: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-ID: <20190621185953.GA6620@morn.lan>
References: <20190619092352.23583-1-shmuel.eiderman@oracle.com>
 <20190619092352.23583-4-shmuel.eiderman@oracle.com>
 <20190620143749.GC17015@morn.lan>
 <62F1EBAB-C7E8-42D1-BB6F-22C4945E51B5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62F1EBAB-C7E8-42D1-BB6F-22C4945E51B5@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
Subject: Re: [Qemu-devel] [SeaBIOS] [PATCH v3 3/4] geometry: Add
 boot_lchs_find_*() utility functions
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 liran.alon@oracle.com, kraxel@redhat.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 21, 2019 at 08:42:28PM +0300, Sam Eiderman wrote:
> Sounds reasonable, how do purpose to deal with:
> 
> config BIOS_GEOMETRY
> config BOOTORDER
> 
> precompiler optouts?

I think you can stick them both under BOOTORDER.  That option is only
there in case someone wants to reduce the size of the SeaBIOS binary.
I can't think of a reasonable situation where one cares that much
about binary size, yet wants to override legacy disk translations..

> If we don’t need any of them we also don’t need to call “get_scsi_devpath", “get_ata_devpath”, “get_pci_dev_path”.
> 
> I’ll see what can be done. 

Thanks.
-Kevin

