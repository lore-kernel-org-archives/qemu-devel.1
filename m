Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B35CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 17:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17272085B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 17:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17272085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQahy-00087L-Py
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 13:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iQahL-0007fQ-Hi
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 13:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iQahI-00075d-LX
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 13:26:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45764)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iQahI-000743-DL
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 13:26:52 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1368D4E83C
 for <qemu-devel@nongnu.org>; Fri,  1 Nov 2019 17:26:51 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id f4so5865548wrj.12
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 10:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lYshMNMD074lqt0Gg9jN8T6k7Bw9MrDOl7A9NGI200I=;
 b=KmOLXTjvtEknRFldyZ3nRvtX+IqIxkJubG3cc5hytgRbvm5uO46AhIBgkAreB4H/vP
 bNFanoflYsgZHm4akKsr8yo2+muWie9UQw6U7/9kkurKXU9/Q5rYZYm3jc/gS55THQvy
 baSyYqlUcuT3j8CHNJYiz3GumzP26z9i/W1nWwHDN257Z4+8HBIzBXKxJgY0TWVgqKnE
 w79KJSuCY6Q+aB0M7g81fAJquWFd0SD63ZtrWvXmGLQyTHaMtLrIqK3RkyEm+iQ8KAI7
 e30dknqRB5nsl8dIvZnGYNkhp10SMPENFt5DMviZRSnYxRAsZ6k8kC85ZJJvgirozBc7
 hv3A==
X-Gm-Message-State: APjAAAWF5rfbMqDcBryZBKJnhR/gieosEu4/sqzJGe9tSRyPxXSdOTKv
 4Q9MvNA6Y7uuWJyUeDXF8zEUp7zARDEf/cNAxJJSO2ld83X+qS3po0SBQqy5d7u6VbWqOz3hMgF
 lVrGSfDJa1TT7Uiw=
X-Received: by 2002:a5d:490c:: with SMTP id x12mr8551901wrq.301.1572629209786; 
 Fri, 01 Nov 2019 10:26:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyeBQKScOYmEnkCvl0Q4sIZz/ZTgjjIPvlYo17THGClSuijIBO86k+SNVgCfmy98TH4LxZmOA==
X-Received: by 2002:a5d:490c:: with SMTP id x12mr8551876wrq.301.1572629209566; 
 Fri, 01 Nov 2019 10:26:49 -0700 (PDT)
Received: from xz-x1.metropole.lan (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id y2sm8113738wmy.2.2019.11.01.10.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 10:26:48 -0700 (PDT)
Date: Fri, 1 Nov 2019 18:26:21 +0100
From: Peter Xu <peterx@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC v2 09/22] vfio/pci: add iommu_context notifier for pasid
 alloc/free
Message-ID: <20191101172349.GE8888@xz-x1.metropole.lan>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-10-git-send-email-yi.l.liu@intel.com>
 <20191029121544.GS3552@umbus.metropole.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191029121544.GS3552@umbus.metropole.lan>
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, Liu Yi L <yi.l.liu@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com, pbonzini@redhat.com,
 yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 29, 2019 at 01:15:44PM +0100, David Gibson wrote:
> > +union IOMMUCTXPASIDReqDesc {
> > +    struct {
> > +        uint32_t min_pasid;
> > +        uint32_t max_pasid;
> > +        int32_t alloc_result; /* pasid allocated for the alloc request */
> > +    };
> > +    struct {
> > +        uint32_t pasid; /* pasid to be free */
> > +        int free_result;
> > +    };
> > +};
> 
> Apart from theproblem with writable fields, using a big union for
> event data is pretty ugly.  If you need this different information for
> the different events, it might make more sense to have a separate
> notifier chain with a separate call interface for each event type,
> rather than trying to multiplex them together.

I have no issue on the union definiion, however I do agree that it's a
bit awkward to register one notifier for each event.

Instead of introducing even more notifier chains, I'm thinking whether
we can simply provide a single notifier hook for all the four events.
After all I don't see in what case we'll only register some of the
events, like we can't register alloc_pasid() without registering to
free_pasid() because otherwise it does not make sense..  And also you
have the wrapper struct ("IOMMUCTXEventData") which contains the event
type, so the notify() hook will know which message is this.

A side note is that I think you don't need the
IOMMUCTXEventData.length.  If you see the code, vtd_bind_guest_pasid()
does not even initialize length right now, and I think it could still
work only because none of the vfio notify() hook
(e.g. vfio_iommu_pasid_bind_notify) checks that length...

-- 
Peter Xu

