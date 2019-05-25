Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290B9C07542
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13AC2075E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbdLhPQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13AC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43098 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUYGk-00046L-Tc
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 11:07:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hUYDR-0001xK-B5
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hUYDQ-00027Y-Am
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:04:09 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hUYDQ-00026N-4k
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:04:08 -0400
Received: by mail-oi1-x242.google.com with SMTP id t187so9097514oie.10
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=WYsKR72pd1AS/3fpwnIpedRqbJ2R8rcYh0JxXVlQQCk=;
	b=vbdLhPQCgmL5lBkLVO2+3P6nPbawYzpaW2SU1rh2UKbRQHd9gCWpJeyhSe88bUbktX
	gholQ3NfCCZ6I0+zVD97EZPSlFRL3/gVqT1i6AfT6KM1BbumV62Nyvh2tKsXJIJ7GH8H
	hOQDuGslQCXUDAykf3mIxUcq9B3DxDj4aunPsJ6tYozdiImBJQVK12N3Z7IfxHQZdoRc
	POQfLHreSCYh/iHNtdsJYreY5YrsN7Xpb63BL4oFwVnj/Le+YLfuxZJEnGNInQcSR5Kz
	AGTvWAh/rKI+V3peksaWqsOi0bOH6gphf4413AXVQ7EOC+69QNDdtSE/Fn3ao6xNQr0c
	3rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=WYsKR72pd1AS/3fpwnIpedRqbJ2R8rcYh0JxXVlQQCk=;
	b=CogvAsoruTW+Vk/tke1kCOUcze7zvxBtNNDJM0+r++LrKFMi1kcr0nflc0+3N7yIl/
	CzMuLwvdX/ePKB+Jg+hEeDFL0vYqhlutQ5tz/LtChQH43pBI1q/7f4LZSF3eP0Q6p5Wu
	ejPKaBiixYp/0wcmzWsLoYrpQdDBp3cULPsEVFU3qQBbzh9Fbwa+EwpK8QZK0Ll0coHn
	Fm6j1L5RbSDXtkjQVlPvjahR/7fJNDGyRhYh9cIWjeymCX4OeI2+Ma3XYE2JuaKA/fBm
	05pJrwhjHsS3O44FvTMPmYJ3J/ZsjVmnYhQj8yr7sfgjBJkkEzztWMM+ez+BCz86mYqR
	9ZaQ==
X-Gm-Message-State: APjAAAXo5xMDarZdZA2zyAkTKuocRbvJn9sqtqb1ljyHZN1wHPoDKU9W
	bevo7p7fmNCwrLgmub4y8gmRBNlJc7AMWfkJGEZJfA==
X-Google-Smtp-Source: APXvYqy+w7wO5xzCyqdVNHNUGr+yHa9zu4C/xNTdg1dF6BxwSPzYmllvn7+GNGJrH9AiGGcvenf0VngNsh9KWYx6uQE=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr9944421oib.170.1558796646940; 
	Sat, 25 May 2019 08:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <51df31ee-54a1-d7be-bef4-71ae003b8811@redhat.com>
	<3fab9e76-53ad-2de7-45df-eb69c8604709@redhat.com>
	<016edc53-278e-cc58-0061-d2c5de80afd2@de.ibm.com>
	<1ddf0d83-ce0c-f1c9-065d-ff88ddb9293b@redhat.com>
	<60d1bf3d-659c-d199-6592-d3659702d754@redhat.com>
	<d38b05af-effc-97a1-0b4a-a0d44a13f769@de.ibm.com>
In-Reply-To: <d38b05af-effc-97a1-0b4a-a0d44a13f769@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 May 2019 16:03:55 +0100
Message-ID: <CAFEAcA9K+d+LM5SfDrX0Ljwq8zWQdmJAM4R4cdHhF+tM1F13LQ@mail.gmail.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] hw/s390x/ipl: Dubious use of qdev_reset_all_fn
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
	qemu-s390x <qemu-s390x@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 May 2019 at 20:47, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> While this patch is certainly ok, I find it disturbing that qdev devices are being resetted,
> but qom devices not.

It's not a qdev-vs-QOM thing. Anything which is a DeviceState
has a reset method, but only devices which are somewhere
rooted in the bus-tree that starts with the "main system
bus" (aka sysbus) get reset by the vl.c-registered "reset
everything on the system bus". Devices which are SysBusDevice
get auto-parented onto the sysbus, and so get reset. Devices
like PCI devices or SCSI devices get put onto the PCI
bus or the SCSI bus, and those buses are in turn children
of some host-controller device which is on the sysbus, so
they all get reset. The things that don't get reset are
"orphan" devices which are neither (a) of a type that gets
automatically parented onto a bus like SysBusDevice nor
(b) put specifically onto some other bus.

CPU objects are the other common thing that doesn't get
reset 'automatically'.

Suggestions for how to restructure reset so this doesn't
happen are welcome... "reset follows the bus hierarchy"
works well in some places but is a bit weird in others
(for SoC containers and the like "follow the QOM
hierarchy" would make more sense, but I have no idea
how to usefully transition to a model where you could
say "for these devices, follow QOM tree for reset" or
what an API for that would look like).

thanks
-- PMM

