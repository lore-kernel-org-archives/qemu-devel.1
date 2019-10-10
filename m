Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A115C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 02:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7B220B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 02:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7B220B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iINlu-0003Uc-8P
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 22:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iINlH-00035y-M8
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 22:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iINlE-0002gr-Kj
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 22:01:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iINlE-0002gl-FB
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 22:01:00 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D1F82D6E4F
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 02:00:58 +0000 (UTC)
Received: by mail-pg1-f199.google.com with SMTP id d3so3231505pgv.9
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 19:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cAwJQl/7XOTRgWP5SxvsGl7RmNxnbBxBVyED0ajKBnM=;
 b=S2/GwvfMjlDmR+pK7K/+RUF3B4ca6mDfAt/vwT+PWDGv5TiowvJLI54Pk8mm4SV5Nt
 rEL/t5IIssZ48SshOEhPY5XTsIu8Uy7XNBdMykh0SDk6/Db12i18u4OlSRVZxG7HoZaK
 eqW0KOR7Uj4zFjQE668tEvBn3xoS8nCxpwScJA452HJq0849PHDWXwtT4eMZ+blv/g3k
 Hhq6rMOfMmjVVwQEEDtZaWRZqa9nIxNLpNRx8IPuWLYWdu5dJbB9h5HzXM4jokDeYOaV
 wCBL5VKI/fxLFgHJMQcosMkcabhGVuILPINbEJ+SAuK/7chWkTLREE8HRmTPhGg9WNC9
 6nZg==
X-Gm-Message-State: APjAAAWWYepXgepUHQ4CAZQxgZ6KPwKxeD7FFs9/Um0Z37oq1qBY3Ttm
 N3WBrK6GU+YqqcLz8lMUaYJ50FqJa/Lcl5tPCMEz5R5EnW+lS9pvxeuQTOun3mVrpbsot5IFtrF
 UIZLtll+teclom5Q=
X-Received: by 2002:a17:90a:aa81:: with SMTP id l1mr633001pjq.73.1570672857518; 
 Wed, 09 Oct 2019 19:00:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyHx/ioaOL9j2kaJr1a74gwXpcUmSiIUs0HxbgCgyZQ4Fx4V8ruPjptMh+Nua1b1UR8sJE36Q==
X-Received: by 2002:a17:90a:aa81:: with SMTP id l1mr632954pjq.73.1570672857174; 
 Wed, 09 Oct 2019 19:00:57 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a13sm5514252pfg.10.2019.10.09.19.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2019 19:00:56 -0700 (PDT)
Date: Thu, 10 Oct 2019 10:00:46 +0800
From: Peter Xu <peterx@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v2 0/2] migration/postcopy: cleanup related to postcopy
Message-ID: <20191010020046.GA18958@xz-x1>
References: <20191010011316.31363-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010011316.31363-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 10, 2019 at 09:13:14AM +0800, Wei Yang wrote:
> Refine a function name and handle on corner case related to PostcopyState.
> 
> v2:
>    * remove one unnecessary patch
>    * simplify corner case handling
> 
> Wei Yang (2):
>   migration/postcopy: rename postcopy_ram_enable_notify to
>     postcopy_ram_incoming_setup
>   migration/postcopy: check PostcopyState before setting to
>     POSTCOPY_INCOMING_RUNNING

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

