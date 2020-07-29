Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3E1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88ADA2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dq/DTCnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88ADA2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0mwY-0008L9-RZ
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 10:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k0mvh-0007tD-JC
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:19:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59228
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k0mvf-0000AC-Uk
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596032373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BmS2RlYrl+PbMo9pPHbJPyMO6CfOjBkoI5DF4uwMlSE=;
 b=dq/DTCnb06IeVSvI+qBzxeIhz+qO8OT3F3H/Nt3SPG6j9UlipK+k9gQivnYLYtyK1iyhYz
 bP7AoNpWzZc51t02cYqpPxR26SaE7B69FZHNslFxJE8LFzebgNrHYWDRGYfk/auUDBidHj
 4NDE4azz3Kl/c9z5DXEv0/FhsxhjX2w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-tb5p44U0MwO3DWdLa_Z94w-1; Wed, 29 Jul 2020 10:19:28 -0400
X-MC-Unique: tb5p44U0MwO3DWdLa_Z94w-1
Received: by mail-wr1-f71.google.com with SMTP id z12so6753200wrl.16
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 07:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BmS2RlYrl+PbMo9pPHbJPyMO6CfOjBkoI5DF4uwMlSE=;
 b=tFkYQAn9C545dRNfLwZTC9E0Af+072xg371XpoJhyNSmzkiGGCi0fDKXbk1aqtFMTy
 ef+HMUHd/SFqtI+xZNur7MOiUOKt/XjbcBtZe60kbzMtBoWXW3Sj+JCXUZk7NoECzAxc
 7AqdevRfgcjngmpOLM0cav2YFtuceiacFF1KOzOFT5LrbDYKrnAJvlbsuyYDRt/gkSQW
 +ze78RSwhTnfPo1a8lv+ChvT1BVlF5WCgz9ezq4iuUgUdJxHcpgePZaii5/f+g8Ir3wW
 iJnFH/CPoH6r8sA0jvDoKvHv6ikgAa20XppNCEsZc5wUq53rVoB9tokKRhGAz9kr2QeF
 d3DA==
X-Gm-Message-State: AOAM532confmowjpgZupVIokk5sPfLDmNHLrmO+SNfDdknUs+Vevyj9c
 aD+kYI7nZym5c2JMDIxA/6eIEGQVc38QLBTo8lxFeKgXlOymbYMJKvMWFsED5aUPW113eelRglp
 4Gekx6+HS0cLqKRs=
X-Received: by 2002:a5d:424f:: with SMTP id s15mr31985490wrr.342.1596032367196; 
 Wed, 29 Jul 2020 07:19:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrZY5uvNZl0bCzrnShvjNMW4QjC00D9E1b7HdNYb19QqepARkcMJ6Xafk//g0k/zBMhoY5kg==
X-Received: by 2002:a5d:424f:: with SMTP id s15mr31985475wrr.342.1596032367009; 
 Wed, 29 Jul 2020 07:19:27 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id t11sm5550442wrs.66.2020.07.29.07.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 07:19:26 -0700 (PDT)
Date: Wed, 29 Jul 2020 10:19:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: Adding VHOST_USER_PROTOCOL_F_CONFIG_MEM_SLOTS to 5.1 release notes
Message-ID: <20200729101851-mutt-send-email-mst@kernel.org>
References: <CAFubqFvm=k0FyELUd=rYK7CO=Dxns-jVxy4UGqfGfXPFNT1cFw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFubqFvm=k0FyELUd=rYK7CO=Dxns-jVxy4UGqfGfXPFNT1cFw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 09:16:10PM -0600, Raphael Norwitz wrote:
> Hi mst,
> 
> Looking at the current changelog
> https://wiki.qemu.org/ChangeLog/5.1#virtio, I don't see any mention of
> the VHOST_USER_PROTOCOL_F_CONFIG_MEM_SLOTS protocol feature. It is a
> user visible change so shouldn't we add a note?
> 
> Thanks,
> Raphael

I didn't look at updating the changelog yet.
Would be great if you could write up new vhost user things.

-- 
MST


