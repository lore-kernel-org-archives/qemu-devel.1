Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848CAC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5197820663
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5197820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSLt4-0006CK-HE
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iSLrr-0005E4-DG
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iSLrp-0007vo-HZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:01:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8909)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iSLrp-0007uS-8n
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:01:01 -0500
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 256CD7C08B
 for <qemu-devel@nongnu.org>; Wed,  6 Nov 2019 14:00:59 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id b82so3329518qkc.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 06:00:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0LKmjm2kgwMLtFXnFKb46iWSmule+FGeOkfZ8vW8Tv8=;
 b=Xy4vDKNZNaKqkrh3p3m8HU5sTySRippHq7/RhBkAMUwkEZ2b7eP5rRwa+FdrbfDbWZ
 uk3sqARUx07I9zQ38U7K4VwjG5VPiwsdJePLgCQbmVmrB5Ebf6YvcHGPeqIhDro/XFOe
 uZ+3MDogLPZJ51LdqxWu5dK/ePV55suskTJ4sdwqjtVtiTI/VOC2067H6W115RXBj+Bz
 oWPNmlGWJL8NMlDVJNzOmKyeEPm5YYD4/p77D8UliTevUH0l825UYKAgxRqShSqPoR2e
 kkKO60uVpef3tZZ6civVPp6vhgnO5a2ROI4mW8lnk8i9wqMKGcvr6foxYf2Mn/e9uvZw
 Qq2g==
X-Gm-Message-State: APjAAAVwGGYdbBasjmuUU6jH2T0WGuWTOj6/h2hhbVXGDpihsFuvJJZ9
 otMRk6jp+kIRIYWGAUjCjzg2RuARP/aT20FEdVyvJgbPorRucIWxhSsSnIYPWlPHO0Pkvk+plfo
 RGG21ESie0giNST4=
X-Received: by 2002:ac8:70c9:: with SMTP id g9mr2408017qtp.389.1573048858442; 
 Wed, 06 Nov 2019 06:00:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqzYBwA9VHtXa0cwopfImD1a8xgyjvIhUBfTl2Jz+yDCyF5Y3ZWfBgQaIDmPXLlT1Q2nONAHyg==
X-Received: by 2002:ac8:70c9:: with SMTP id g9mr2407996qtp.389.1573048858156; 
 Wed, 06 Nov 2019 06:00:58 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id a137sm363522qkg.75.2019.11.06.06.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 06:00:57 -0800 (PST)
Date: Wed, 6 Nov 2019 09:00:55 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v2 10/22] intel_iommu: add virtual command capability support
Message-ID: <20191106140055.GA29717@xz-x1>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-11-git-send-email-yi.l.liu@intel.com>
 <20191101180544.GF8888@xz-x1.metropole.lan>
 <A2975661238FB949B60364EF0F2C25743A0EF337@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A0EF337@SHSMSX104.ccr.corp.intel.com>
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 06, 2019 at 12:40:41PM +0000, Liu, Yi L wrote:
> > 
> > Do you know what should happen on bare-metal from spec-wise that when
> > the guest e.g. writes 2 bytes to these mmio regions?
> 
> I've no idea to your question. It is not a bare-metal capability. Personally, I
> prefer to have a toggle bit to mark the full written of a cmd to VMCD_REG.
> Reason is that we have no control on guest software. It may write new cmd
> to VCMD_REG in a bad manner. e.g. write high 32 bits first and then write the
> low 32 bits. Then it will have two traps. Apparently, for the first trap, it fills
> in the VCMD_REG and no need to handle it since it is not a full written. I'm
> checking it and evaluating it. How do you think on it?

Oh I just noticed that vtd_mem_ops.min_access_size==4 now so writting
2B should never happen at least.  Then we'll bail out at
memory_region_access_valid().  Seems fine.

> 
> > 
> > > +        if (!vtd_handle_vcmd_write(s, val)) {
> > > +            vtd_set_long(s, addr, val);
> > > +        }
> > > +        break;
> > > +
> > >      default:
> > >          if (size == 4) {
> > >              vtd_set_long(s, addr, val);
> > > @@ -3617,7 +3769,8 @@ static void vtd_init(IntelIOMMUState *s)
> > >              s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
> > >          } else if (!strcmp(s->scalable_mode, "modern")) {
> > >              s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_PASID
> > > -                       | VTD_ECAP_FLTS | VTD_ECAP_PSS;
> > > +                       | VTD_ECAP_FLTS | VTD_ECAP_PSS | VTD_ECAP_VCS;
> > > +            s->vccap |= VTD_VCCAP_PAS;
> > >          }
> > >      }
> > >
> > 
> > [...]
> > 
> > > +#define VTD_VCMD_CMD_MASK           0xffUL
> > > +#define VTD_VCMD_PASID_VALUE(val)   (((val) >> 8) & 0xfffff)
> > > +
> > > +#define VTD_VCRSP_RSLT(val)         ((val) << 8)
> > > +#define VTD_VCRSP_SC(val)           (((val) & 0x3) << 1)
> > > +
> > > +#define VTD_VCMD_UNDEFINED_CMD         1ULL
> > > +#define VTD_VCMD_NO_AVAILABLE_PASID    2ULL
> > 
> > According to 10.4.44 - should this be 1?
> 
> It's 2 now per VT-d spec 3.1 (2019 June). I should have mentioned it in the cover
> letter...

Well you're right... I hope there won't be other "major" things get
changed otherwise it'll be really a pain of working on all of these
before things settle...

Thanks,

-- 
Peter Xu

