Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57B7CA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E58C20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQQv3izY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E58C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNesr-0008C4-VY
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iNdtT-0007CJ-Uq
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iNdtS-0003do-9q
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:15:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37290)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iNdtS-0003d8-2D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:15:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id e11so17584428wrv.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wcYGRdE7UgsyvougaG7GUPlX4d+kse0aR02f7E/2K2I=;
 b=EQQv3izY1bruJpnTkhqS8lI08mlMzPDOqHZ/41WceFjG1r8AjDkXMgWVedqaNBCwnB
 21CrHObLcv4/O8Ula2/HAMExPnCWB8BP9tQ36v8YJxpnVlNTpG75IPlNaLD1sIjlYWdQ
 GvVt74J9ywxJYoG7FhGd/bczRcDV4ycbMTYIueupSRdnDlwjrtECxTSDUlnvbXsTAT2o
 6Mp1KKEyzQ4waiE7LL+Z4EJG68lJv4pYxZBtgavDb88Dkn+t/HFayAnutxsFj8mleN3y
 qC61dPwuTROKPmxd9rQAF6n+QholMUXUy4QG8RYRbrg1VuS45e/lpqtMku/wcflY2YPL
 0gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wcYGRdE7UgsyvougaG7GUPlX4d+kse0aR02f7E/2K2I=;
 b=DCOeQshhipcHXvkVzWRQNUjdodwhIn+5yjvdCg7ZEPSPafmBZMd4dH1worRl7YXqMM
 xfl8lnmGmNnjgRN8LYMoTztE6wmTDiHYZqPySXxW9u1oEXf+brNawSam3x/YD+pG2oLT
 mtzWuFDX0mXWuHroiD0iYd5tqORl+IzhCELLMlph70gTrM5XO2JoyDmfQnmlKQMqmcey
 jgoGVSkBY1+EakTC5cb7xw9Q0emwjsDmGREf5+mpjf2dGIzUMQdWgCGB2nN4B4MmNTeH
 MIF2qnxjLEb5wKHcqLj9SwjIGDD8BdfPdnEb4Bafh6BNvtTyeaqcw/ODgdOKGbT2Kfkw
 sOCA==
X-Gm-Message-State: APjAAAW3WO3rdc7x5b3QNppi6bU7mWVdP6akQfbF9PHnxselQFyz6b2y
 Z65JUWa/t290czLK+myr5f7wTSG96uYJKqonsbt3I+ph
X-Google-Smtp-Source: APXvYqwSMKAd32Fesbsdpez/7/FV0yssjJFkoejSXkK/qxm57elDEe+MW5gKftfGKK/9PmVjNzxfKb1KpkAj75/I3YY=
X-Received: by 2002:a5d:6cc3:: with SMTP id c3mr4078250wrc.202.1571926510033; 
 Thu, 24 Oct 2019 07:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191004102051.19738-1-marcandre.lureau@redhat.com>
In-Reply-To: <20191004102051.19738-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 24 Oct 2019 16:14:57 +0200
Message-ID: <CAJ+F1C+Sp-xCyr2KZgEfGXM3TJxjTq9Oh2pu6X-J03E-XrLvUQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Add dbus-vmstate
To: QEMU <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Oct 4, 2019 at 1:23 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> With external processes or helpers participating to the VM support, it
> becomes necessary to handle their migration. Various options exist to
> transfer their state:
> 1) as the VM memory, RAM or devices (we could say that's how
>    vhost-user devices can be handled today, they are expected to
>    restore from ring state)
> 2) other "vmstate" (as with TPM emulator state blobs)
> 3) left to be handled by management layer
>
> 1) is not practical, since an external processes may legitimatelly
> need arbitrary state date to back a device or a service, or may not
> even have an associated device.
>
> 2) needs ad-hoc code for each helper, but is simple and working
>
> 3) is complicated for management layer, QEMU has the migration timing
>
> The proposed "dbus-vmstate" object will connect to a given D-Bus
> address, and save/load from org.qemu.VMState1 owners on migration.
>
> Thus helpers can easily have their state migrated with QEMU, without
> implementing ad-hoc support (such as done for TPM emulation)
>
> D-Bus is ubiquitous on Linux (it is systemd IPC), and can be made to
> work on various other OSes. There are several implementations and good
> bindings for various languages.  (the tests/dbus-vmstate-test.c is a
> good example of how simple the implementation of services can be, even
> in C)
>
> dbus-vmstate is put into use by the libvirt series "[PATCH 00/23] Use
> a slirp helper process".
>
> v5:
> - trying to fix patchew/ci: install dbus-daemon in containers, skip
>   test if unavailable
>
> v4:
> - add Daniel security scenarios to the D-Bus document
> - misc doc improvements
> - add "util: add dbus helper unit" patch, with
>   qemu_dbus_get_queued_owners()
> - add "configure: add GDBUS_CODEGEN", explaining why gio-unix is
>   required when available
> - silence the expected failing tests
> - update copyright headers, MAINTAINERS
> - add r-b/a-b tags
> - rebased
>
> (Note: patchew dbus test fails for unclear reasons, but I can't
> reproduce locally nor on travis)
>
> v3:
> - after various discussions on helper processes, we settled on a
>   preference for having a bus for communications. This version is
>   actually v1 updated.
> - added a dbus.rst document to describe D-Bus recommendations for QEMU
> - added dbus-vmstate-daemon.sh to play with the dbus-daemon configuration
>   (although it is not very useful in the context of a single UID)
> - added a new vmstate interface, so that any object can implement
>   VMStateDescription, and converted dbus-vmstate
> - added "migration: fix vmdesc leak on vmstate_save() error"
> - convert to g_auto
>
> v2:
> - D-Bus is most common and practical through a bus, but it requires a
>   daemon to be running. I argue that the benefits outweight the cost
>   of running an extra daemon in v1 in the context of multi-process
>   qemu, but it is also possible to connect in p2p mode as done in this
>   new version.
>
> Marc-Andr=C3=A9 Lureau (8):
>   vmstate: add qom interface to get id
>   vmstate: replace DeviceState with VMStateIf
>   docs: start a document to describe D-Bus usage
>   util: add dbus helper unit
>   Add dbus-vmstate object
>   configure: add GDBUS_CODEGEN
>   dockerfiles: add dbus-daemon to some of latest distributions
>   tests: add dbus-vmstate-test
>

ping, any chance to get it merged before freeze?

thanks

>  MAINTAINERS                              |  12 +
>  backends/Makefile.objs                   |   4 +
>  backends/dbus-vmstate.c                  | 496 +++++++++++++++++++++++
>  configure                                |   7 +
>  docs/interop/dbus-vmstate.rst            |  74 ++++
>  docs/interop/dbus.rst                    | 104 +++++
>  docs/interop/index.rst                   |   2 +
>  hw/block/onenand.c                       |   2 +-
>  hw/core/Makefile.objs                    |   1 +
>  hw/core/qdev.c                           |  21 +-
>  hw/core/vmstate-if.c                     |  23 ++
>  hw/ide/cmd646.c                          |   2 +-
>  hw/ide/isa.c                             |   2 +-
>  hw/ide/piix.c                            |   2 +-
>  hw/ide/via.c                             |   2 +-
>  hw/misc/max111x.c                        |   2 +-
>  hw/net/eepro100.c                        |   4 +-
>  hw/nvram/eeprom93xx.c                    |   4 +-
>  hw/ppc/spapr_drc.c                       |   9 +-
>  hw/ppc/spapr_iommu.c                     |   4 +-
>  hw/s390x/s390-skeys.c                    |   2 +-
>  include/hw/vmstate-if.h                  |  40 ++
>  include/migration/register.h             |   4 +-
>  include/migration/vmstate.h              |  10 +-
>  include/qemu/dbus.h                      |  18 +
>  migration/savevm.c                       |  20 +-
>  stubs/vmstate.c                          |   4 +-
>  tests/Makefile.include                   |  23 +-
>  tests/dbus-vmstate-daemon.sh             |  95 +++++
>  tests/dbus-vmstate-test.c                | 399 ++++++++++++++++++
>  tests/dbus-vmstate1.xml                  |  12 +
>  tests/docker/dockerfiles/centos7.docker  |   1 +
>  tests/docker/dockerfiles/debian10.docker |   1 +
>  tests/docker/dockerfiles/fedora.docker   |   1 +
>  tests/docker/dockerfiles/ubuntu.docker   |   1 +
>  util/Makefile.objs                       |   3 +
>  util/dbus.c                              |  55 +++
>  37 files changed, 1428 insertions(+), 38 deletions(-)
>  create mode 100644 backends/dbus-vmstate.c
>  create mode 100644 docs/interop/dbus-vmstate.rst
>  create mode 100644 docs/interop/dbus.rst
>  create mode 100644 hw/core/vmstate-if.c
>  create mode 100644 include/hw/vmstate-if.h
>  create mode 100644 include/qemu/dbus.h
>  create mode 100755 tests/dbus-vmstate-daemon.sh
>  create mode 100644 tests/dbus-vmstate-test.c
>  create mode 100644 tests/dbus-vmstate1.xml
>  create mode 100644 util/dbus.c
>
> --
> 2.23.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

