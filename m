Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBA4C76191
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D53F20665
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcRfJpL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D53F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqIfu-0006Ho-A8
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 10:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37468)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <suratiamol@gmail.com>) id 1hqIfj-0005jz-Lz
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <suratiamol@gmail.com>) id 1hqIfi-0001ny-Dr
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:55:15 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36318)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <suratiamol@gmail.com>)
 id 1hqIff-0001jr-Qr; Wed, 24 Jul 2019 10:55:12 -0400
Received: by mail-pg1-x541.google.com with SMTP id l21so21361527pgm.3;
 Wed, 24 Jul 2019 07:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=77god5ICMj55HlFoOQnpyOihsc4p3ZkyiH+3x1GSCmo=;
 b=OcRfJpL2+7mQuonu+v5O3xDE0DA2RH7Ye6VXS0WGY5wYQUoE4rWyenrdKUR0MkB8+l
 Kx9u8yEi4pkmXRSBrlLOZK6Na3RFs/JegVuixf64IwlsMeWeFylmpzTjuqJOyyZLTDQa
 BNZbDetRn6LocrQDpyNU8NzXWmjvsCZkql7VxuRsAk7/JJSxKNl1j6I+GGp1oel8Dzkz
 Cy3N3QMT/fbYTgRev9nkpWR1mS8ddFMoFCj45Wf7DhXDSIcYfMLi+5lYOHtztx9VkECK
 n4Y5kkmMSHg0XMeNUo42PMc3FD/WIz3IKVN/+UQSy0uoqRA7h1q4/EjlzZB01wBLFqU/
 ec/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=77god5ICMj55HlFoOQnpyOihsc4p3ZkyiH+3x1GSCmo=;
 b=TBnYxQ+Dq3sMunTfsbfNSm8Rs1N/yvDHjz+z6tbhe8uqDLnMKTFmfAGeiIv+saFAmq
 uMXZHwo75YzKb3kuNw78hDyl6v7lLbWOxpkZFR34s5ilVLtiZIVFoWtb+yQPsrPxe2wf
 9/V2xvRdsIcqWltiWH9t+cIGbEKRqGJvo30pGWjgmVUkZvt68H/hbpl3FgyraPn10C1S
 WlRKhcJRJ8TBKobpVGYjbYpgX1E6wV5i47fD16cRR0itnameEyP48H0HIFWIzCAkb6I6
 njTxvI5KASAD7D7y02PC8PoH/+VbnBL7iJjfCEmCfSfXsNtbJOqUT0TZ6BM/aRXDIoIM
 bOTA==
X-Gm-Message-State: APjAAAUOMPMBIkJ/eV5RZaKVy7icmYJmCXLVWI20UNBK0A34x8L2f4CJ
 /OPEqc6Em5X2Oe/m+RtmbL/Wbx67UhU=
X-Google-Smtp-Source: APXvYqx7sJbhFE6cbdApb399FIjUKZZhkn/FAeKDsMmWFgK73it/lDUvVbUrM6UYiMzpluQwSt/nxA==
X-Received: by 2002:aa7:8f24:: with SMTP id y4mr11592524pfr.36.1563980110478; 
 Wed, 24 Jul 2019 07:55:10 -0700 (PDT)
Received: from arch ([103.238.106.164])
 by smtp.gmail.com with ESMTPSA id o24sm91209369pfp.135.2019.07.24.07.55.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 24 Jul 2019 07:55:08 -0700 (PDT)
Date: Wed, 24 Jul 2019 20:25:04 +0530
From: Amol Surati <suratiamol@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190724145504.GA29378@arch>
References: <20190723090138.30623-1-clg@kaod.org>
 <20190724032308.GV25073@umbus.fritz.box>
 <0b80925b-c25b-04ee-2875-cbd155497a55@kaod.org>
 <20190724085730.GX25073@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190724085730.GX25073@umbus.fritz.box>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc/pnv: Generate phandle for
 the "interrupt-parent" property
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
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 24, 2019 at 06:57:30PM +1000, David Gibson wrote:
> On Wed, Jul 24, 2019 at 09:11:54AM +0200, Cédric Le Goater wrote:
> > On 24/07/2019 05:23, David Gibson wrote:
> > > On Tue, Jul 23, 2019 at 11:01:38AM +0200, Cédric Le Goater wrote:
> > >> Devices such as the BT or serial devices require a valid
> > >> "interrupt-parent" phandle in the device tree and it is currently
> > >> empty (0x0). It was not a problem until now but since OpenFirmare
> > >> started using a recent libdft (>= 1.4.7), petitboot fails to boot the
> > >> system image with error :
> > >>
> > >>    dtc_resize: fdt_open_into returned FDT_ERR_BADMAGIC
> > >>
> > >> Provide a phandle for the LPC bus.
> > >>
> > >> Suggested-by: Greg Kurz <groug@kaod.org>
> > >> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> > > 
> > > I've applied this, since it looks to be correct.
> > > 
> > > But.. can you connect the dots for me in how this being missing
> > > results in a BADMAGIC error??
> > 
> > Some binary called by petitboot segfaults when trying to kexec an image on 
> > a system with a bogus DT (generated by QEMU). I don't know exactly which one 
> > as I only see the error message above and the segv message in dmesg
> 
> Ok, I'm still not seeing how that gets you to a BADMAGIC error.

If I may interject, as this patch is related to the qemu bug:
https://bugs.launchpad.net/qemu/+bug/1826827.

The error is printed by dtc_resize in kexec.c from kexec-lite
(antonblanchard/kexec-lite).

There are two places where dtc_resize is called -
(1) initialize_fdt, when kexec is passed a dtb file.
(2) fdt_from_fs, when kexec must make dtc read /proc/device-tree to form
    a dtb.

If initialize_fdt is called with a file which is an invalid dtb, the
dtc_resize prints the FDT_ERR_BADMAGIC error.

Bug# 1826827 shows that dtc is one application that does
crash, although through the firing of an assertion, in the absence of
the mentioned properties. (fix to avoid the crash already checked into
dtc upstream, commit 8f69567622; to be released with dtc-v1.5.1).

Assuming that the crashing app (it is not known here what it is) is
supposed to create a dtb for kexec, and its crash leaves behind an
incomplete/invalid dtb file, the initialize_fdt might receive an invalid
dtb.


Another possibility for that error exists within the fdt_from_fs function,
but that needs a version of kexec-lite at least 5 years old, which is
unlikely to be used here I guess.



If this patch fixes both the crash and the error "dtc_resize: ....",
it is likely that dtc (or anything else which depends on libfdt) was the
cause of the crash, with dtc/libfdt version being < g8f69567622.


Thanks,
-amol

