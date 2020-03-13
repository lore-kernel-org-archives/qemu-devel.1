Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE4CC5ACBF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 09:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03FF2073E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 09:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsxp0wlQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03FF2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCgku-0000db-6K
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 05:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jCgj7-00062a-4i
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jCgj5-0000Il-BI
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:35:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39762
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jCgj5-0000Fh-5M
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584092129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6QONFVL31dn4a5WaWws7Lyy3oKhCx4xrGr+nCVIN6wM=;
 b=hsxp0wlQ8SnxvLL06uppr3D5UY9LWf1LhK3EiQdVYzgdPHUBDNnQwTpeTBiW9X7EPKX1Pc
 guNDSsBYvDhwNk31qfXL6nWAeqoiXqmqTcexw17/ElceDZ/DY3pZKe1vNU/j4T3JVQiXlF
 8wQj7suVLD1wNBhldjNL1XWhNYKWcic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-YBbNXAnaPUCxss5KuNGulA-1; Fri, 13 Mar 2020 05:35:27 -0400
X-MC-Unique: YBbNXAnaPUCxss5KuNGulA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F660189CD02;
 Fri, 13 Mar 2020 09:35:26 +0000 (UTC)
Received: from localhost (ovpn-200-60.brq.redhat.com [10.40.200.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46C84909FD;
 Fri, 13 Mar 2020 09:35:20 +0000 (UTC)
Date: Fri, 13 Mar 2020 10:35:18 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
Message-ID: <20200313103518.072e1edc@redhat.com>
In-Reply-To: <1cd97deb-be90-5698-a99a-14bd4918a82d@oracle.com>
References: <20200311170826.79419-1-liran.alon@oracle.com>
 <20200311162509-mutt-send-email-mst@kernel.org>
 <92564357-25c1-0a0f-537b-6902f45a88d0@oracle.com>
 <20200312012859-mutt-send-email-mst@kernel.org>
 <8cab6eba-22bc-a62e-d4a8-e2138b815a01@oracle.com>
 <20200312080602-mutt-send-email-mst@kernel.org>
 <adbb172c-a6b2-f2a5-3f35-dbc353e4f716@oracle.com>
 <20200312173527.3a218dc0@redhat.com>
 <1cd97deb-be90-5698-a99a-14bd4918a82d@oracle.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Elad Gabay <elad.gabay@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 20:48:48 +0200
Liran Alon <liran.alon@oracle.com> wrote:

> On 12/03/2020 18:35, Igor Mammedov wrote:
> > On Thu, 12 Mar 2020 14:55:50 +0200
> > Liran Alon <liran.alon@oracle.com> wrote:
> >  
> >> On 12/03/2020 14:19, Michael S. Tsirkin wrote:  
> >>> On Thu, Mar 12, 2020 at 01:30:01PM +0200, Liran Alon wrote:  
> >>>> On 12/03/2020 8:12, Michael S. Tsirkin wrote:  
> >>>>> On Thu, Mar 12, 2020 at 01:20:02AM +0200, Liran Alon wrote:  
> >>>>>> But this is just a good practice in general and in the past it was said by
> >>>>>> maintainers that this is one of the main reasons that ACPI and SMBIOS
> >>>>>> generation have moved from SeaBIOS to QEMU.  
> >>>>> I think a flag to disable this might make sense though. For example,
> >>>>> some guests might behave differently and get broken.  
> >>>> Right. That's why I think it's a good practice to have this flag and tie it
> >>>> to machine-type.  
> >>> Tying things to the machine type is not what I had in mind.
> >>> A separate flag would also be helpful so users can tweak this
> >>> for new machine types, too.  
> >> I think it's unnecessary, given how common WAET ACPI table is exposed by
> >> default by other hypervisors.
> >>
> >> But if you insist, I can add such flag on a separate commit in v2...
> >> Where do you want to have such flag? It cannot be a property of some
> >> qdev object.
> >> So you want to add a new QEMU_OPTION_no_weat in vl.c?  
> > If it doesn't break any windows guests we probably don't need an option.
> > Can you test if old guests are booting fine with new table, to confirm
> > that it's fine? (starting with XPsp3)  
> 
> Old guests boot fine with the new WAET table.
> We are running with this table in production for many years with many 
> Windows XP guests (and much more esoteric guests)
> 
> Just to verify, I've just now run it with a WinXP SP3 VM and it works 
> just fine.
> So should I remove the flag completely or remain with the current 
> functionality I have that makes sure WAET is only exposed on new 
> machine-types?
In this case I'd drop flag.

> 
> -Liran
> 
> >>>> Guest-visible changes shouldn't be exposed to old machine-types.  
> >>> Well almost any change in qemu is guest visible to some level.
> >>> Even optimizations are guest visible.
> >>> We made changes in ACPI without versioning in the past but I'm not
> >>> opposed to versioning here. However in that case pls do add a bit
> >>> of documentation about why this is done here.  
> >> I remember that maintainers have explicitly specified that ACPI/SMBIOS
> >> should not be changed between machine-types.
> >> This have been one of the reasons to move ACPI/SMBIOS generation from
> >> SeaBIOS to QEMU control.
> >>
> >> What can of documentation you want me to add and where?
> >> The only thing I can say is that I tie it to machine-type because I do
> >> not think a given machine-type should suddenly change BIOS exposed info
> >> to guest.
> >> But that's kinda generic. I haven't found similar documentation in other
> >> ACPI-disable flags to copy from (E.g. do_not_add_smb_acpi).
> >>  
> >>> What I am asking about is whether we need a flag to disable
> >>> this as part of the stable interface.  
> >> I personally think not. But if you think otherwise, can you provide
> >> guidance of where you suggest to add this flag?
> >> As the only place I see fit is adding a new QEMU_OPTION_no_weat.  
> 


