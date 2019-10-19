Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0759CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 03:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B78222C5
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 03:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JetWt7N8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B78222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLfZ6-0001us-MH
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 23:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iLfYH-0001TS-9w
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 23:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iLfYE-0002VH-NP
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 23:37:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47576
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iLfYE-0002Tj-B9
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 23:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571456225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ckGVdbjKZ9e89LIkDI68z6En2vDhdAR8jIu752L2up0=;
 b=JetWt7N81goWzk5Uej8OYxdzfjkR7+O8kTuZd/ahPDCWripnViiLZnB4yjH1bHVnGoQjEY
 7rX32nWuQzGj2x4sP5KFNa7fyn4hX1lbSbqBomUzQoI3i+h1r8RSijAHddN8omqHY4npyl
 WstxikBFv/xf8C2xMOraXDiczx5uwm8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-v_MgnS0fPaWqyNs9n42T3g-1; Fri, 18 Oct 2019 23:37:03 -0400
Received: by mail-pg1-f200.google.com with SMTP id d3so5604045pgv.9
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 20:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HacGt9Y6DJpD7oTGq5KC678ilrZfUKzrBrh06SWM+KE=;
 b=lCRAe7/PaexJ/Ihp6lMdcxBzrga/7K2cauv3Wn7KZbKQA/fjH5PpT3S1hdOPfYBfCc
 Tpcp90SMxQIcdnWMe+oyI6Tz3LkpTw7R5MD0L73R/dtVlqQFeizZ7gzpSAZRxtt6syoN
 NI1mKxOL+MUs3I4bA4gvX3QLeki46nuyAaohItz1n6XhXr3/rcBAwpMugJYP3GNmL2iA
 QfvyyHD+pt4t7Vc7Pjlf8xruuRIEcYE5iksWQU2OdprfDDW5GKYf6QdzsZI1fYV3Gu1q
 YBNFfc9vFcY/qGZu04xNh5Yme7z4UI3D4f/4mcMf8BexC/eB4UroAesd789Qk1dKyWtW
 0iPg==
X-Gm-Message-State: APjAAAUc1Mi23yfgrVS4Ktx6X4pjpWftu5eCdS9r3XyJWSgr2MZqAxIn
 dhrm25aiE1Qe3vmL/pk1NHcTgWKZdJnwqmDqs6LOA2Y9AvKGZhyfh173H8bqhp5sSaA52+VimiN
 4EHHGV0qT9rXPl+A=
X-Received: by 2002:a63:394:: with SMTP id 142mr13439463pgd.375.1571456222296; 
 Fri, 18 Oct 2019 20:37:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxcgxCemckuuEDZXDU3P1uwDvF6/qDcyMgBza7Emy9r3hXl/WChhjvO6S4kE1CuFKu/yVdWZg==
X-Received: by 2002:a63:394:: with SMTP id 142mr13439431pgd.375.1571456221865; 
 Fri, 18 Oct 2019 20:37:01 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o64sm16189258pjb.24.2019.10.18.20.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 20:37:00 -0700 (PDT)
Date: Sat, 19 Oct 2019 11:36:51 +0800
From: Peter Xu <peterx@redhat.com>
To: Jintack Lim <incredible.tack@gmail.com>
Subject: Re: Using virtual IOMMU in guest hypervisors other than KVM and Xen?
Message-ID: <20191019033651.GA9478@xz-x1>
References: <CAHyh4xisBvQ+-p5R6Wj0po17-3EOkKsALzRysHU+R=mprbdjtg@mail.gmail.com>
 <20191015024947.GC8666@xz-x1>
 <CAHyh4xgzqMuWR7moxPfWZarED5HtPcu3LmnTHMe7CpwScHa4Eg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHyh4xgzqMuWR7moxPfWZarED5HtPcu3LmnTHMe7CpwScHa4Eg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: v_MgnS0fPaWqyNs9n42T3g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 03:01:22PM -0700, Jintack Lim wrote:
> On Mon, Oct 14, 2019 at 7:50 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Oct 14, 2019 at 01:28:49PM -0700, Jintack Lim wrote:
> > > Hi,
> >
> > Hello, Jintack,
> >
> Hi Peter,
>=20
> > >
> > > I'm trying to pass through a physical network device to a nested VM
> > > using virtual IOMMU. While I was able to do it successfully using KVM
> > > and Xen guest hypervisors running in a VM respectively, I couldn't do
> > > it with Hyper-V as I described below. I wonder if anyone have
> > > successfully used virtual IOMMU in other hypervisors other than KVM
> > > and Xen? (like Hyper-V or VMware)
> > >
> > > The issue I have with Hyper-V is that Hyper-V gives an error that the
> > > underlying hardware is not capable of doing passthrough. The exact
> > > error message is as follows.
> > >
> > > Windows Power-shell > (Get-VMHost).IovSupportReasons
> > > The chipset on the system does not do DMA remapping, without which
> > > SR-IOV cannot be supported.
> > >
> > > I'm pretty sure that Hyper-V recognizes virtual IOMMU, though; I have
> > > enabled iommu in windows boot loader[1], and I see differences when
> > > booing a Windows VM with and without virtual IOMMU. I also checked
> > > that virtual IOMMU traces are printed.
> >
> > What traces have you checked?  More explicitly, have you seen DMAR
> > enabled and page table setup for that specific device to be
> > pass-throughed?
>=20
> Thanks for the pointers. I checked that DMAR is NOT enabled. The only
> registers that Windows guest accessed were Version Register,
> Capability Register, and Extended Capability Register. On the other
> hand, a Linux guest accessed other registers and enabled DMAR.
> Here's a link to the trace I got using QEMU 4.1.0. Do you see anything
> interesting there?
> http://paste.ubuntu.com/p/YcSyxG9Z3x/

Then I feel like Windows is reluctant to enable DMAR due to lacking of
some caps.

>=20
> >
> > >
> > > I have tried multiple KVM/QEMU versions including the latest ones
> > > (kernel v5.3, QEMU 4.1.0) as well as two different Windows servers
> > > (2016 and 2019), but I see the same result. [4]
> > >
> > > I'd love to hear if somebody is using virtual IOMMU in Hyper-V or
> > > VMware successfully, especially for passthrough. I also appreciate if
> > > somebody can point out any configuration errors I have.
> > >
> > > Here's the qemu command line I use, basically from the QEMU vt-d
> > > page[2] and Hyper-v on KVM from kvmforum [3].
> > >
> > > ./qemu/x86_64-softmmu/qemu-system-x86_64 -device
> > > intel-iommu,intremap=3Don,caching-mode=3Don -smp 6 -m 24G -M
> >
> > Have you tried to use 4-level IOMMU page table (aw-bits=3D48 on latest
> > QEMU, or x-aw-bits=3D48 on some old ones)?  IIRC we've encountered
> > issues when trying to pass the SVVP Windows test with this, in which
> > 4-level is required.  I'm not sure whether whether that is required in
> > general usages of vIOMMU in Windows.
>=20
> I just tried the option you mentioned, but it didn't change anything.
> BTW, what version of Windows was it?

Sorry I don't remember that. I didn't do the test but I was just
acknowledged that with it the test passed.  I assume you're using the
latest QEMU here because I know Windows could require another
capability (DMA draining) and it should be on by default in latest
qemu master.

At that time the complete cmdline to pass the test should be:

  -device intel-iommu,intremap=3Don,aw-bits=3D48,caching-mode=3Doff,eim=3Do=
n

I also don't remember on why caching-mode needs to be off at that
time (otherwise SVVP fails too).

--=20
Peter Xu


