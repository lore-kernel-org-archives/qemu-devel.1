Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBA0C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF5F23600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7SYx142"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF5F23600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOKv-0006fp-P5
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLNkr-0001DU-TV
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLNkq-00005P-3G
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600940490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3UIDDXrWPt/8IT3GWfjXpmZPSgKdbEold03bB26u6Kk=;
 b=F7SYx142GCjKJIUQNrrmq6nPEjvXacX502ExV2ksmTEkJTFwAmbbudiTJFZMEEKA9uRgK4
 aTOlkUU4o04ZuCb5UWXRQrUqUVafsbGJ0Q1TjXuwkIGmWO6k0rRcjmJqmR+lMvdU5FyHbH
 34MElGbWtoNQ1ZvfbuY+CQGZVrbJBrc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-rMj6goxmPP2l8vaNPWOOxg-1; Thu, 24 Sep 2020 05:41:29 -0400
X-MC-Unique: rMj6goxmPP2l8vaNPWOOxg-1
Received: by mail-wr1-f69.google.com with SMTP id h4so1022668wrb.4
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 02:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3UIDDXrWPt/8IT3GWfjXpmZPSgKdbEold03bB26u6Kk=;
 b=hbk0M9QfbLphuDLGKRBbP6uCj0pFPXAg5iz0bF8KPSAZOSZzMRZnP+JrNPQnjFACO/
 EK3Wm1XCGACYNPd7R7HRJOvjTWxGwO4VfcdwuezkB5C50TqfYe9xWc9TGsz/BkUIlJ0Y
 mPeOutRZESgpA7rgGmrKMs+mxiAlufmn6bzWKHr6XuZi8eukOUYE5YWPcACRJa299HpH
 5Woq7OS2JCfdqoPoIV+V087NdGtrt99eMtftfi/IpApTSQsfN0L8Eth8G5OQfGL8ow5K
 5VGi/AE4fvxtol60A65T0EmOOgICFuenUiIv0UBFaV27hkGY+Mtb2F19n4uKll8IKCNr
 tIXg==
X-Gm-Message-State: AOAM532QTJhXywWzWa/jt7JR0+Fa9m2sopCcxJxPAAE2mjL5AkYKjA/c
 gDhR8le8NpCwNy6nVFWqW8J60UZDd/gFKaGKbMHaBUEK1EtHi33INB5EUH4MMh26aDzns3Zzu3+
 8+oj29+o/7TyhSyk=
X-Received: by 2002:adf:ec87:: with SMTP id z7mr4470719wrn.57.1600940487519;
 Thu, 24 Sep 2020 02:41:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdYRhcxvRkrIG+nuUaTFB5Fol4gEclmz5ba0kmguCUihbua0evtqa4zR8bRIKIQShEvcudKA==
X-Received: by 2002:adf:ec87:: with SMTP id z7mr4470704wrn.57.1600940487370;
 Thu, 24 Sep 2020 02:41:27 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id h8sm2892324wrw.68.2020.09.24.02.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 02:41:26 -0700 (PDT)
Date: Thu, 24 Sep 2020 05:41:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [RFC PATCH v3 6/7] hw/acpi/ich9: Set ACPI PCI hot-plug as default
Message-ID: <20200924053950-mutt-send-email-mst@kernel.org>
References: <20200924070013.165026-1-jusual@redhat.com>
 <20200924070013.165026-7-jusual@redhat.com>
 <20200924113345.21c8749e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200924113345.21c8749e@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Ani Sinha <ani@anisinha.ca>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 11:33:45AM +0200, Igor Mammedov wrote:
> On Thu, 24 Sep 2020 09:00:12 +0200
> Julia Suvorova <jusual@redhat.com> wrote:
> 
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> 
> I'd drop this patch for now.
> mgmt can turn it on for Windows guests to workaround
> its native hotplug issues.

It's not just windows either, the hack we have in the hotplug code is an
example of a linux issue.  I'd rather not let management worry about
which type of hotplug is in use. Nothing here sets any policy, this is
strictly a mechanism thing.

> > ---
> >  hw/acpi/ich9.c | 2 +-
> >  hw/i386/pc.c   | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> > index 987f23e388..c67c20de4e 100644
> > --- a/hw/acpi/ich9.c
> > +++ b/hw/acpi/ich9.c
> > @@ -425,7 +425,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
> >      pm->disable_s3 = 0;
> >      pm->disable_s4 = 0;
> >      pm->s4_val = 2;
> > -    pm->use_acpi_hotplug_bridge = false;
> > +    pm->use_acpi_hotplug_bridge = true;
> >  
> >      object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
> >                                     &pm->pm_io_base, OBJ_PROP_FLAG_READ);
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index b55369357e..5de4475570 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -101,6 +101,7 @@ GlobalProperty pc_compat_5_1[] = {};
> >  const size_t pc_compat_5_1_len = G_N_ELEMENTS(pc_compat_5_1);
> >  
> >  GlobalProperty pc_compat_5_0[] = {
> > +    { "ICH9-LPC", "acpi-pci-hotplug-with-bridge-support", "off" },
> >  };
> >  const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
> >  


