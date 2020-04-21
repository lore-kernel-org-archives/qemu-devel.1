Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179C3C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E9820672
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caeA6dut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E9820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQqOG-0007B3-1y
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 06:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQqNT-0006W8-GH
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQqNR-0005qv-TB
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:43:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22417
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jQqNR-0005m3-Cq
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587465819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kH/F0axOrC/o+aiFlg2n2ZV58NVvWjU2DpJUR2+XN+8=;
 b=caeA6dutoTIwKsepQgkzCi99gGHkntXAJE3L4tEepouJeJzTHuAm5E1geZ6U7Sh8Rq+zAr
 LJyo5m1Dc9G4cJd0kldbYp2swdVem62Phai18x54T/D/UvvI61TlGhQMU0u+a+uVhTKah+
 nLV996kmY0jD4Dt7BuKPZxCdV3yo6Jo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-SvskckoVMdeHzyUbBmmU6Q-1; Tue, 21 Apr 2020 06:43:37 -0400
X-MC-Unique: SvskckoVMdeHzyUbBmmU6Q-1
Received: by mail-qk1-f198.google.com with SMTP id i2so7183095qkl.5
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 03:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ELz7qIcneEuECgFv7IAnbU8vwsmSq1t1SLmxdkwXQYk=;
 b=gZA9Tf7f6/Bgj8BxnlLDn5ZuObpW9O7ssKGYRhFO2rgMHoHdDu/S73rjGVAKC2B/sX
 j2Sd557vIUwjtxMfvDouvsB7Oc2KYx5mFX9iajJnixCd6ZGW2zrikaMaLB+57Fpn0opR
 WEPDiAISmOiKpn5jU4JALOfOh2YLgtIknhrIzKGdJ+HjESD30Y0G8z3Pu0K+0PgFc7DE
 z3Ubva7H+2IeLJmcgfWyfG4z7fZgHt5w0QI+noDdHMBl7Imm/eUyleca5b68FyIbCaB5
 4qY7flX5b28xwSePKmtv9GB6mFjWxPfqJcjA2iYBwkuh1w+/21X3Yu/rfDwZrTLaHTnr
 b3IA==
X-Gm-Message-State: AGi0PuYBuDuNLXvr+mN49zPtMfk61jWN+O6qUGe5+5CqbZJZe9aiv3CE
 njTGSXW/5PVRt7h0Bx4WFhmmcTvdOUJCHBeJ48FlTlirLLc7UMoQs+Uv0DJ1Obbaof72vu61jel
 JlhP8ci9k+AM7CPQ=
X-Received: by 2002:a0c:ba83:: with SMTP id x3mr20073652qvf.83.1587465817435; 
 Tue, 21 Apr 2020 03:43:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypIlkyaQ5VTbEH1zvGTcOL8186o8zbgMXKehohvdWN4GRBnk1baM/wfWSmbkc++/Eh1H6Q1+Zg==
X-Received: by 2002:a0c:ba83:: with SMTP id x3mr20073631qvf.83.1587465817201; 
 Tue, 21 Apr 2020 03:43:37 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id q6sm1508266qte.72.2020.04.21.03.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 03:43:36 -0700 (PDT)
Date: Tue, 21 Apr 2020 06:43:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Question on memory commit during MR finalize()
Message-ID: <20200421104334.GC420399@xz-x1>
References: <20200420210049.GA420399@xz-x1>
 <fe73a74b-2324-68a5-a37f-530a6bb03ebc@redhat.com>
 <20200420233115.GB420399@xz-x1>
 <5ed295a3-9e4a-0dca-adc6-5361dc78a83c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5ed295a3-9e4a-0dca-adc6-5361dc78a83c@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Devel Mailing List <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 21, 2020 at 11:43:36AM +0200, Paolo Bonzini wrote:
> On 21/04/20 01:31, Peter Xu wrote:
> >>
> >> However, instead of memory_region_transaction_commit,
> >> memory_region_finalize probably should do something like
> >>
> >>     --memory_region_transaction_depth;
> >>     assert (memory_region_transaction_depth ||
> >> =09    (!memory_region_update_pending &&
> >>              !ioeventfd_update_pending));
> > Ah I see; this makes sense.
> >=20
> > And finally I found the problem, which is indeed the bug in my own tree=
 - I
> > forgot to remove the previous changes to flush the dirty ring during me=
m
> > removal (basically that's run_on_cpu() called during a memory commit, t=
hat will
> > wrongly release the BQL without being noticed).
> >=20
> > Besides above assert, I'm thinking maybe we can also assert on somethin=
g like:
> >=20
> >   !(memory_region_transaction_depth || memory_region_update_pending ||
> >     ioeventfd_update_pending)
> >=20
> > When releasing BQL (unlock, or qemu_cond_wait() on BQL, which should co=
ver
> > run_on_cpu()), so that we can identify misuse of BQL easier like this.
>=20
> Asserting invariants around lock release are an interesting concept, but
> I'm not sure where to insert them exactly.  But it would be great if you
> would like to introduce an assert_empty_memory_transaction() function
> with the assertion I quoted above.

Let me give it a shot later today. :)

--=20
Peter Xu


