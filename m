Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3156C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306DF217BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qumFi1qs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306DF217BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iac1V-0005VM-BY
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 03:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iabwH-0003Jt-MI
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iabwA-0001zC-1X
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:47:39 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iabw9-0001p4-MX
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:47:37 -0500
Received: by mail-wm1-x341.google.com with SMTP id g206so13307362wme.1
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 00:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UVBQLEKfaFdSn/e7USK+YLFra3tFxKPS/6RQ/2cEfBI=;
 b=qumFi1qsfujYyoyQJBvrLhNGqOvQccAOl3vpJm6jlS18hzTl5R6seiL6CoXBn/wuR/
 /OWiZg17I6X1rMQHA2juuGIBUcgzF5yb8Qoub9THowLhqqQnOE4xXEKzA8aeP2hAWzS9
 HnOWZrQeu3MlqpgepNTc3LHysMiyYOJuuWgwITIvS2cAPrurHYhoBPICfZqMzkunPYCd
 c/5goQMe54LJv8jr2YU9/Bm2f3mUa2KPbIty954OnOuzFb5UkabL1PJP7d6iffNTBFib
 rB/Jy3COVBr/QeBQC1VM00Q3LXIIw8mZbO5T+CNpb9FaQLVP+10q1Rog8wRiR4XiuhLs
 EWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UVBQLEKfaFdSn/e7USK+YLFra3tFxKPS/6RQ/2cEfBI=;
 b=l8ZSmf/iHmT89rQ324SgtD0tN3D3XAN5v+jhSEOkKU0EsBaLS/qqK9o83TjUsImf/x
 nhs46qH5SRmuaZxCTZbD9exyuh+oHdgvSWmgARzREauCWCN7CFnsXzZI6+hNjgh+IdW8
 N4rn2LAeuKFPjd6DOxA5ceVbrBKf8EuE2lbhfMke8JKK3f9aDrgdBXJ58K9AmQ5f/Sm1
 +yov4pox1um3NqOEuunXjUCgq4Bkw4mp7POFSluKrlbZPLdiWODOY9eTRZhnBKvrxnVe
 hXTAzLnXm+GyivOpayaAcTM0M9Jx8tUffaC5JE7BweHrwkctRyigTHKzcBkqlvYvx1K9
 q8Qw==
X-Gm-Message-State: APjAAAUbe7Mw9HW+u78k33kbrq5RjxAJxvMebBUFXUpwb7cF00FDtvrN
 f3ik+MfTKWMEO38rrWWc8VY/DtVlJ5Fn3sjQSk0T9gZ1
X-Google-Smtp-Source: APXvYqy1lRvIwPRnOIgdHbyl37CyxOBVxOc0lbqb5+yipjk/kscQwWFzlLjtKjhP2+Trd3sEg5rOJpabEIk6FzNeSS8=
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr13280396wmh.5.1575017254145; 
 Fri, 29 Nov 2019 00:47:34 -0800 (PST)
MIME-Version: 1.0
References: <20191004102051.19738-1-marcandre.lureau@redhat.com>
In-Reply-To: <20191004102051.19738-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 29 Nov 2019 12:47:21 +0400
Message-ID: <CAJ+F1C+Fq3WE7a=9XeOrifjRj3DzxXsGJ7mwVatDqMmd91FuKg@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Add dbus-vmstate
To: QEMU <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

On Fri, Oct 4, 2019 at 3:23 PM Marc-Andr=C3=A9 Lureau
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

ping

(there is a minor vmstate_register() change required in patch 2 for
the next rebase)


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

