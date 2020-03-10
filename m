Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AA6C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DD620675
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4WZgoQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DD620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBioy-0007ty-Oh
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 13:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBinp-0006t6-1D
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBinm-0004zs-5d
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:36:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41798
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBinm-0004xj-0N
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583861781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0HC5r4ghxSnjMxPxWqxXam/Z+Uk2Oq1QVaqrXsg3fNY=;
 b=W4WZgoQrAvH0fvpV6sKtXoTKy6NjebA0iVZWG9/FVMgboE9HRGAHUoOqaEPM7NZz4jBvMr
 RKNKR+IKsJZqC8AN+B4SHhwqzpQkvRaIpkYRknKWQfWi48AVLZprjzBa+pynZkpv68d1uB
 9PSwfh5zx1PHyIt3L8ft/4VT2VMWCMM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-zCfr6WGSP02OODTiOWiMbg-1; Tue, 10 Mar 2020 13:36:18 -0400
X-MC-Unique: zCfr6WGSP02OODTiOWiMbg-1
Received: by mail-qk1-f198.google.com with SMTP id 22so10240514qkc.7
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 10:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=giwhGLp8guIXgqbbrxvV8TYfPgv5rDSSUhCgwfmwVxI=;
 b=IBKd32JlNZhYOKawVUS9veEZVSNF3NkL7tWjvfgjIuUBtot8d42ZB1ddBVeNnp7hbA
 A5jn+0bnxFCCb+/1BEhRCqWe1X+4i6JGS/SGBdUpZbdvmLbKbccKI2MfIoScn6fTG7I0
 9InMQFLjH/3VqaKNXvry0kd35z0HNRf0cecCjojWSq9nL4W/1npsqeJPqV0o2YfJDBzY
 oXFTP0fg54rud9Yl0hWqfDKfn6L2OwFCBp65ofHh7BY6d8WfCNsqrGrUSYrd+wnVT9kX
 Lao8HY9DT9WWCUCAF8A0+UBhPSj5C53Hw87RBufq5f+1r8l8MNHq5Ci7SKwy5gtFXcu8
 8FGg==
X-Gm-Message-State: ANhLgQ0WHlj7s7buxB7ExkbK8L6ifZd4BFAmUG85HSjqLsogWMhtRRQU
 QDGQI4yl1FmkjwUc9t3haYfiS4Tz8I6JyAHeNHMjqfKK1FM/SojDVpBfWNnSeIkc4lF21s8tzBE
 Iz/w1aO4U9xsLxTw=
X-Received: by 2002:a37:6592:: with SMTP id z140mr5739129qkb.257.1583861777686; 
 Tue, 10 Mar 2020 10:36:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsD2C2mgiQUAGbwdnFJNz6T6zV5d1Rik9bNJToQ8GgKehJlda17ziuu8lwLC6nmWwpjNRgx9Q==
X-Received: by 2002:a37:6592:: with SMTP id z140mr5739106qkb.257.1583861777365; 
 Tue, 10 Mar 2020 10:36:17 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id n190sm2460354qkb.93.2020.03.10.10.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 10:36:16 -0700 (PDT)
Date: Tue, 10 Mar 2020 13:36:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
Message-ID: <20200310125426-mutt-send-email-mst@kernel.org>
References: <20200310081144-mutt-send-email-mst@kernel.org>
 <43b5d99e-70f2-39dc-1a12-e6c6d9e75d5a@oracle.com>
 <20200310082730-mutt-send-email-mst@kernel.org>
 <506ba498-ba50-9415-18b3-bcaff1561c55@oracle.com>
 <20200310084758-mutt-send-email-mst@kernel.org>
 <1f4766b2-9683-8ebf-752e-a0378bb0cbc3@oracle.com>
 <20200310094350-mutt-send-email-mst@kernel.org>
 <6d3c248f-f8fe-754d-59e5-8f2740a55263@oracle.com>
 <20200310104713-mutt-send-email-mst@kernel.org>
 <8c856884-a5f1-d522-b0be-9edee6623ca4@oracle.com>
MIME-Version: 1.0
In-Reply-To: <8c856884-a5f1-d522-b0be-9edee6623ca4@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 06:39:33PM +0200, Liran Alon wrote:
> > > Isn't enum invented exactly for enumerating all possible values of a =
field?
> > No - it just assigns names to constants. If you then proceed not to use
> > the names, then it's pointless.
> It's not. It exactly lists all the various possible values.

That's not factually correct in this case. In C, enum does not
necessarily list all possible values generally. Neither is it always
used like this in QEMU. Neither does it do it in this case, nothing
prevents user from sticking any single-byte value in the property.

> Giving new names to existing terminology that can be matched against
> existing guest code which interface with your device emulation is what
> requires guesswork.
> Using names matching the guest code driver is what doesn't require guessw=
ork
> and is more intuitive to understand.

Yes, it's sometimes helpful to match guest driver since that helps debug
the whole stack. There's literally nothing to help debug here though.
But if you feel strongly, here's a conversation starter.
But it raises some questions that need to be answered
properly:


/*
 * Virtual Machine eXecutable type (VMX).
 *
 * Most guests are fine with the default.
 *
 * Some legacy guests hard-code a given type.

^ Is this the real reason we are including this option?
Because if it is how is it helpful to add link to
the open-source drivers? These likely are not legacy ...


 * See https://github.com/vmware/open-vm-tools/blob/master/open-vm-tools/li=
b/include/vm_vmx_type.h
 * for an up-to-date list of values.
 * To help locate relevant portions of guest driver code
 * and debug guest failures, enum names from the above header
 * are listed below:
 *
 * Reasonable options:
 * 0 - unset? - see VMX_TYPE_UNSET

=09=09=09^^^ Note as you know what this is, please write it up.

 * 1 - VMware Express (deprecated) - see VMX_TYPE_UNSET
 * 2 - VMware ESX server - see VMX_TYPE_EXPRESS
 * 3 - VMware Server (deprecated) - see VMX_TYPE_WGS
 * 4 - VMware Workstation - see VMX_TYPE_WORKSTATION
 * 5 - ACE 1.x (deprecated) - see VMX_TYPE_WORKSTATION_ENTERPRISE
 */
DEFINE_PROP_UINT8("vm-executable-type", VMPortState, vm_executable_type, 2)=
,


Maybe above is OK, if above questions can be addressed.



> Let's agree that I will fix coding convention issue (VMX_Type -> VMXType)
> and link to open-vm-tools but remain with the enum.
> And see what other maintainers have to see about this on v2.

Sorry, if you don't address my comments from v1 please do not expect me
to review v2.  I also feel strongly about proper attribution.  Ignoring
original license on vmport.c making it depend on "GPL v2 but not later"
bits for cosmetic reasons just isn't right.


--=20
MST


