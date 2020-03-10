Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E115CC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F2920727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bou5sFLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F2920727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBixX-0006Ey-VN
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 13:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBiw3-0005KK-N8
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBiw2-0003UF-Lz
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:44:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31230
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBiw2-0003Sm-HT
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583862294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOuS9//iN54hR9nw0SJO+V8YGl+/21dvhxnq1semqYY=;
 b=Bou5sFLrA0kp4tJ+P3dcmZJPf6N6Hwo5fik8hdWLf9BRb+SYZcqSzysRuYvqWGj59bE6o9
 wQtQQMd5CSFTcL1gEs++ax7ibwlm7fu52kBSplhfQNaRuT1tJ/yjakzdevazCQYjNIW3Du
 M+YYTY2NNPHm66veHtHbp2e/lxUCVX0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-Kg_-qrbbNomueFn9kIkYZg-1; Tue, 10 Mar 2020 13:44:52 -0400
X-MC-Unique: Kg_-qrbbNomueFn9kIkYZg-1
Received: by mail-qt1-f197.google.com with SMTP id a21so3280504qto.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 10:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ebNxDcfawfpeXi1uA2wiiv4qFZ0A00/gAVfsWEDurvw=;
 b=RhaEVTEl2SREpMVqr2mFcKaPFOWNiuZrZOXwlSQkJq2Lz5fBYhzufKjdRCd4lTT61z
 F70Xqvw1DiXdkuQj4Wmj+1pnKU/muhMyihZGL1ke6iC+IKjF/5Shb6iHU4pJ5yBP2xu3
 mVF61Q3XNVhw7H0EalzFs7Fh8x7Yig3u4B45LTDGWAMD9zmpdNj2fWekbpE6LLumIlw/
 a0ZQ9Lid4QEuLDRggcxfcOsONk+uG4pCNraAyxXp0YYMICYbwIpc8poTJR7oUpVrf/M6
 Cndqdxvdfo98kPhSwEOjq0tk5ZMVMxy4dAWmI6nYYIu24GWTtGnlzFE43Dnfh6kr36af
 hC6g==
X-Gm-Message-State: ANhLgQ2gsEtWDMF/n5iKTyLaoCOSJPGBI+N0+m1BLlmhRjPeMzhuC1R2
 tow5Xfr0safK/of7uxNjS3ZxmrDsiHx8ZRlLX/5j7Qi0oUNA//vgBaR/waqBG403zJxACJaepf9
 33HzTLdwXUqoliyo=
X-Received: by 2002:a0c:e58e:: with SMTP id t14mr19534609qvm.131.1583862292109; 
 Tue, 10 Mar 2020 10:44:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuL5LV8Fxfq0qVvDYHgaVW/yMA7lO1XDsk4nlh++FmMhGJzRmRsP6gA81JgjxJ7oRemVOxtuQ==
X-Received: by 2002:a0c:e58e:: with SMTP id t14mr19534600qvm.131.1583862291901; 
 Tue, 10 Mar 2020 10:44:51 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id 79sm24658605qkf.129.2020.03.10.10.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 10:44:50 -0700 (PDT)
Date: Tue, 10 Mar 2020 13:44:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v2 00/16]:  hw/i386/vmport: Bug fixes and improvements
Message-ID: <20200310133932-mutt-send-email-mst@kernel.org>
References: <20200310165332.140774-1-liran.alon@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200310165332.140774-1-liran.alon@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: nikita.leshchenko@oracle.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 06:53:16PM +0200, Liran Alon wrote:
> Hi,
>=20
> This series aims to fix several bugs in VMPort and improve it by supporti=
ng
> more VMPort commands and make command results more configurable to
> user via QEMU command-line.
>=20
> This functionality was proven to be useful to run various VMware VMs
> when attempting to run them as-is on top of QEMU/KVM.
>=20
> For more details, see commit messages.

Well two versions in one day and some review comments weren't addressed.
Some people do this, try to wear the maintainers out by sheer volume.
It works sometimes but it's not a nice tactic. I personally think it's
worth taking the time to think harder about ways to address all
comments, not try to dismiss them.

Thanks!

> Regards,
> -Liran
>=20
> v1->v2:
> * Fix coding convention [Patchew Bot & MST].
> * Create new header file for vmport.h [MST].
> * Move KVM_APIC_BUS_FREQUENCY from linux-headers/asm-x86/kvm.h
>   auto-generated header [MST]
> * Elaborate more that vmx-version refers to the VMware userspace
>   VMM in commit message. [MST]
> * Use le32_to_cpu() on BIOS_UUID vmport command. [MST]
> * Introduce VMPort compatability version property to maintain migration
>   compatibility. [MST]


