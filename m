Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB05CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 16:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D912084D
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 16:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D912084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQwAo-000116-Se
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 12:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iQw9D-0000VA-FB
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 12:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iQw9A-0002Fa-1A
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 12:21:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iQw99-000264-QJ
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 12:21:03 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E9D0B85536
 for <qemu-devel@nongnu.org>; Sat,  2 Nov 2019 16:21:00 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id t2so7407475wri.18
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2019 09:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wuMCUxRP1lAk5GwvAKDfq7V0e1MiDqG1nrYNKrrSOq4=;
 b=Xzg2WPj45L2o2H+KwkH7FgfT+1Z50y/b/oe7aNp5loZo3Dre6gARvJTwx4rRzr0V/D
 GrM5KNtBDnsgplJwGqkEJ/asjeui4BygYKeOnozR3H0lkB7zIUtsFlgCFkF6hjCv8lM5
 jT/86tjivbqR3NYtEMAYnBgq/VulsTF3hV+bYAKKsJP3N8kt3WD8WAm4up0nZtWlNAIE
 3Lz0VygXVY3EhxtL1OmDf3uEV0wOfjXIGlZRt5VO1EgAFLYa5wTrf5EZqqB6Qk78qJy8
 YAXRWPjxZu5IYzgUysYivgaPAcCNl8RFrUNeZPfXNPPC3PYkgDHgkP4ePRrM9urdRdKa
 E4RA==
X-Gm-Message-State: APjAAAWe1rKSMe7mNrHAvnhA+fchxGdLb59517Jg/irHpo5pLRPwOPfr
 gwEcY1sBPYWOwFTrfeOx4MELJcnXBL6p//n47gF5+YBM3bGJpa8JI+EV49NGH+g1eEsYTHX777y
 toup/pAvRts7/xso=
X-Received: by 2002:a1c:3b44:: with SMTP id i65mr14992069wma.1.1572711659684; 
 Sat, 02 Nov 2019 09:20:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzfhyyPavGiH1PSwta220GyIdOGae10Ml8kC20xVSyBWiCtsTuFFqHxTXvVnlBq8+5fwV41+A==
X-Received: by 2002:a1c:3b44:: with SMTP id i65mr14992049wma.1.1572711659527; 
 Sat, 02 Nov 2019 09:20:59 -0700 (PDT)
Received: from xz-x1.metropole.lan ([213.58.148.146])
 by smtp.gmail.com with ESMTPSA id v9sm9606220wrs.95.2019.11.02.09.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2019 09:20:58 -0700 (PDT)
Date: Sat, 2 Nov 2019 16:20:51 +0000
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC v2 12/22] intel_iommu: add present bit check for pasid
 table entries
Message-ID: <20191102162051.GB26023@xz-x1.metropole.lan>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-13-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1571920483-3382-13-git-send-email-yi.l.liu@intel.com>
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, yi.y.sun@intel.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 08:34:33AM -0400, Liu Yi L wrote:
> The present bit check for pasid entry (pe) and pasid directory
> entry (pdire) were missed in previous commits as fpd bit check
> doesn't require present bit as "Set". This patch adds the present
> bit check for callers which wants to get a valid pe/pdire.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

