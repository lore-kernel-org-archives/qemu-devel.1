Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B77CC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F0F206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDLsXhup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F0F206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThwK-0004Do-Q6
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:19:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xadimgnik@gmail.com>) id 1jThmj-0007iG-6E
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <xadimgnik@gmail.com>) id 1jThke-0005Xa-GZ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:09:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jThkc-0005AP-VP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:07:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id t14so1298726wrw.12
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 01:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=ax/00jztm/qnemFteNHTg0gbhwqdcLui9LbTXg76E5k=;
 b=dDLsXhupuinNGpg5xkRKzJWfoxsiuGHHPtNhmNedrrz/A/+UvUbdHEW6K6E2UvY6ZT
 i5Ufo8hCxjCAwZffnWpqVNDwNV3Nr597TcrfkfmLekDJ4b28DLo3bSlMyNoAWcJcvLIK
 /1WnYwxr7+mLTANoSGBc8mZvLekY4CTZPzkSYbsfEXs5YegBY3OLNAOziopDNnOCQi+d
 Y9aF4A5sT52oDkS8HjKuvZMRrGQo2ZR9VEefITgfFVbXweXFYWvZr6iX4dgGfFfurCxu
 dayP7s5xzjgYf49ZjbtVoXHHdRUVkr6dJDbHD9oBbuhFacO7axo/YS+T1X0rVsiD1RPh
 W3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=ax/00jztm/qnemFteNHTg0gbhwqdcLui9LbTXg76E5k=;
 b=C5oYaGo7dikPBuMcqGRgIksxwWfovWG2m9zKCMEQyBhK0ZWeyyATnv4qhuWv4hfKGY
 g+JeBsT6hdLBKlCLEiVetfVqpV5DhVZI3EY/uTMNZzEMQfYhUfXtVt0iSu5tklcgGJ2W
 ze3m5GRkWHen+6e0Spm9CEfMS6XwaRRm+wBWPyrHvYwowR3TYd/N+kIXtVCYgK08DlC1
 rlP8qvaa5F7sjhC58f7FGxiVXtiqBaDde0U7ERQtURPmoBcgGhpVHzmDnOOg5CyGYpu/
 cp4Smn+6uiBMi2dQxbCKKYsv4pQyggl/6iQfcgP7sYIhe3vojNWmgp9vOgG2l686lFus
 1wtQ==
X-Gm-Message-State: AGi0Pubdm1D5IJUW9WppU+nofziqytvqZD+rBLxgBR+k/Bbx9M8Cix1+
 eojwGqp5IjI4qJgl69RIH4Y=
X-Google-Smtp-Source: APiQypI6cFaukOff+Om1OyGYSBYy0HdNoxXqnGGwg7wGAhZ/qZmmPxhAD0dd/UYBlieQpyB7HvLsrA==
X-Received: by 2002:a5d:6844:: with SMTP id o4mr1605691wrw.392.1588147645328; 
 Wed, 29 Apr 2020 01:07:25 -0700 (PDT)
Received: from CBGR90WXYV0 ([54.239.6.185])
 by smtp.gmail.com with ESMTPSA id v16sm6512863wml.30.2020.04.29.01.07.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Apr 2020 01:07:24 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: "'Grzegorz Uriasz'" <gorbak25@gmail.com>,
	<qemu-devel@nongnu.org>
References: <20200429030409.9406-1-gorbak25@gmail.com>
 <20200429030409.9406-2-gorbak25@gmail.com>
In-Reply-To: <20200429030409.9406-2-gorbak25@gmail.com>
Subject: RE: [PATCH v2 1/2] Fix undefined behaviour
Date: Wed, 29 Apr 2020 09:07:22 +0100
Message-ID: <002001d61dfd$37500210$a5f00630$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQFtlR//ELGf2l/FYLvu2IzrckebEAJdwmQ+qU3eScA=
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
Reply-To: paul@xen.org
Cc: artur@puzio.waw.pl, 'Stefano Stabellini' <sstabellini@kernel.org>,
 jakub@bartmin.ski, marmarek@invisiblethingslab.com,
 'Anthony Perard' <anthony.perard@citrix.com>, j.nowak26@student.uw.edu.pl,
 xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Grzegorz Uriasz <gorbak25@gmail.com>
> Sent: 29 April 2020 04:04
> To: qemu-devel@nongnu.org
> Cc: Grzegorz Uriasz <gorbak25@gmail.com>; =
marmarek@invisiblethingslab.com; artur@puzio.waw.pl;
> jakub@bartmin.ski; j.nowak26@student.uw.edu.pl; Stefano Stabellini =
<sstabellini@kernel.org>; Anthony
> Perard <anthony.perard@citrix.com>; Paul Durrant <paul@xen.org>; =
xen-devel@lists.xenproject.org
> Subject: [PATCH v2 1/2] Fix undefined behaviour
>=20
> This patch fixes qemu crashes when passing through an IGD device to =
HVM guests under XEN. The problem
> is that on almost every laptop
> reading the IGD ROM from SYSFS will fail, the reason for it is that =
the IGD rom is polymorphic and it
> modifies itself
> during bootup - this results in an invalid rom image - the kernel =
checks whether the image is valid
> and when that's not the case
> it won't allow userspace to read it. It seems that when the code was =
first written(xen_pt_load_rom.c)
> the kernel's back then didn't check
> whether the rom is valid and just passed the contents to userspace - =
because of this qemu also tries
> to repair the rom later in the code.
> When stating the rom the kernel isn't validating the rom contents so =
it is returning the proper size
> of the rom(32 4kb pages).
>=20
> This results in undefined behaviour - pci_assign_dev_load_option_rom =
is creating a buffer and then
> writes the size of the buffer to a pointer.
> In pci_assign_dev_load_option_rom under old kernels if the fstat would =
succeed then fread would also
> succeed - this means if the buffer
> is allocated the size of the buffer will be set. On newer kernels this =
is not the case - on all
> laptops I've tested(spanning a few
> generations of IGD) the fstat is successful and the buffer is =
allocated but the fread is failing - as
> the buffer is not deallocated
> the function is returning a valid pointer without setting the size of =
the buffer for the caller. The
> caller of pci_assign_dev_load_option_rom
> is holding the size of the buffer in an uninitialized variable and is =
just checking whether
> pci_assign_dev_load_option_rom returned a valid pointer.
> This later results in cpu_physical_memory_write(0xc0000, =
result_of_pci_assign_dev_load_option_rom,
> unitialized_variable) which
> depending on the compiler parameters, configure flags, etc... might =
crash qemu or might work - the xen
> 4.12 stable release with default configure
> parameters works but changing the compiler options slightly(for =
instance by enabling qemu debug)
> results in qemu crashing =C2=AF\_(;-;)_/=C2=AF
>=20
> The only situation when the original pci_assign_dev_load_option_rom =
works is when the IDG is not the

I think you mean IGD

> boot gpu - this won't happen on any laptop and
> will be rare on desktops.
>=20
> This patch deallocates the buffer and returns NULL if reading the =
VBIOS fails - the caller of the
> function then properly shuts down qemu.
> The next patch in the series introduces a better method for getting =
the vbios so qemu does not exit
> when pci_assign_dev_load_option_rom fails -
> this is the reason I've changed error_report to warn_report as whether =
a failure in
> pci_assign_dev_load_option_rom is fatal
> depends on the caller.
>=20
> Signed-off-by: Grzegorz Uriasz <gorbak25@gmail.com>

With the typo fixed...

Reviewed-by: Paul Durrant <paul@xen.org>


