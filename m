Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29220C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7FC2467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iILCadHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7FC2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6upI-0006ub-SZ
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:26:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j6unt-0006Dr-2r
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:24:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j6unk-0007PU-Ss
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:24:36 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j6unk-0007HR-FU
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:24:28 -0500
Received: by mail-oi1-x244.google.com with SMTP id q84so2671625oic.4
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=PgEZv9FtHJ4z8ARb4iL6WATlUn6vle9qGW5VWOkNqDY=;
 b=iILCadHdgyc4NFY3TlMy4UPYHbFjq4irYwaKR0v8qr8ea1MKnSdVOcvTA0WGy+L35S
 2Bz3XIsvM20v26Tl8U/0ZhtsLrnBPbxnoSM3nRNyRjTNzd80dCmg7UQu4eq59tn+7fEh
 xPrgFGiPw+oVMHHk+ahe+k8ColsSl8z+TGIpkXfzilHtZ7xFycPbLjvThKSFi5nABtxS
 EkqCv9V9xWQfMdI32FvcS8aatfCBMRmcSjVnw5TbYeudKYoMVFwrMuTzs1YGgxFr1PWE
 Nqve2GAg/RdrRgVsBep+7UEHJaxftmMatpoD2y31DBBsua+52BN3/ZUZgy3iiZtnHChM
 lYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=PgEZv9FtHJ4z8ARb4iL6WATlUn6vle9qGW5VWOkNqDY=;
 b=On6LUw8pirDNMptordEKQTK8FTzSVKbee7iGWORvwMlE9Ewx2zyTvSprPgNQYcPmEc
 RmeWmJIyUO+NCb0WjfVmqwwwaiufXOfIWtYQ/RNNYGtwrqe2f4Vyjl5bBgWuo+yLZakv
 g50KshULPatY+pDjwmn1ZY1nmQx7zVFIYlNdoNm5Xz0nnDir8WodiNLUgSS2WTuncHZi
 7IoAFE/TEDFtlUkb+lu5KyAaPBQN6UwxUHEhzev26etVoa/GW/ifWreSGGFdANo64Goa
 zT/y7GPPWRr02+VSq8W/2ZFfswM4IcCpeMjMhHHllTPUtiXCbFZyTyHu+WSgDOh8BvJR
 6S7A==
X-Gm-Message-State: APjAAAXOTUla0L+qUcPd0XhQIDG0WBSwmkf1ZTna5KjDkZsEe2sesMDa
 ajx/u2SmaWToYfPDgJcia+jL46S0qkOZrsJH7gE=
X-Google-Smtp-Source: APXvYqwF3q8m3RGDwlGXsgYCV+xCewAbRc+o/iDlAqGePX8YVWOGtbwAqVA4lPtUfHgQU4mnmMF8zbaJpGjli0K056c=
X-Received: by 2002:aca:5844:: with SMTP id m65mr2712647oib.136.1582716266015; 
 Wed, 26 Feb 2020 03:24:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Wed, 26 Feb 2020 03:24:25 -0800 (PST)
In-Reply-To: <20200225154121.21116-5-peter.maydell@linaro.org>
References: <20200225154121.21116-1-peter.maydell@linaro.org>
 <20200225154121.21116-5-peter.maydell@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 26 Feb 2020 12:24:25 +0100
Message-ID: <CAL1e-=h3O+HG-EFbdn3w0yrZo78t=6nuQe_MRk7b8OuwA1kfuw@mail.gmail.com>
Subject: Re: [PATCH 4/4] docs: Convert qemu-deprecated.texi to rST
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d0ed8c059f78d87f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d0ed8c059f78d87f
Content-Type: text/plain; charset="UTF-8"

On Tuesday, February 25, 2020, Peter Maydell <peter.maydell@linaro.org>
wrote:

> > Convert the documentation of deprecated features to rST.
>
>

s/depcreated/deprecated

at two places below (unless there is (and suitable in the context) an
english word "depcreated", that is not known to me).

Aleksandar


> We put the whole of this document into the system manual, though
> technically a few parts of it apply to qemu-img or qemu-nbd which are
> otherwise documented in tools/.
>
> We only make formatting fixes, except for one use of 'appendix' which
> we change to 'section' because this isn't an appendix in the Sphinx
> manual.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  Makefile                   |   2 +-
>  MAINTAINERS                |   2 +-
>  docs/system/deprecated.rst | 446 +++++++++++++++++++++++++++++++++++++
>  docs/system/index.rst      |   1 +
>  qemu-deprecated.texi       | 386 --------------------------------
>  qemu-doc.texi              |   4 -
>  6 files changed, 449 insertions(+), 392 deletions(-)
>  create mode 100644 docs/system/deprecated.rst
>  delete mode 100644 qemu-deprecated.texi
>
> diff --git a/Makefile b/Makefile
> index 28749d20401..ec4a4be8355 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1115,7 +1115,7 @@ txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt
> docs/interop/qemu-ga-ref.txt
>  qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
>         qemu-options.texi \
>         qemu-option-trace.texi \
> -       qemu-deprecated.texi qemu-monitor.texi \
> +       qemu-monitor.texi \
>         qemu-monitor-info.texi \
>         docs/qemu-cpu-models.texi
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 195dd58cac1..546f2b83017 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2787,7 +2787,7 @@ F: contrib/gitdm/*
>
>  Incompatible changes
>  R: libvir-list@redhat.com
> -F: qemu-deprecated.texi
> +F: docs/system/deprecated.rst
>
>  Build System
>  ------------
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> new file mode 100644
> index 00000000000..1eaa559079b
> --- /dev/null
> +++ b/docs/system/deprecated.rst
> @@ -0,0 +1,446 @@
> +Deprecated features
> +===================
> +
> +In general features are intended to be supported indefinitely once
> +introduced into QEMU. In the event that a feature needs to be removed,
> +it will be listed in this section. The feature will remain functional
> +for 2 releases prior to actual removal. Deprecated features may also
> +generate warnings on the console when QEMU starts up, or if activated
> +via a monitor command, however, this is not a mandatory requirement.
> +
> +Prior to the 2.10.0 release there was no official policy on how
> +long features would be deprecated prior to their removal, nor
> +any documented list of which features were deprecated. Thus
> +any features deprecated prior to 2.10.0 will be treated as if
> +they were first deprecated in the 2.10.0 release.
> +
> +What follows is a list of all features currently marked as
> +deprecated.
> +
> +System emulator command line arguments
> +--------------------------------------
> +
> +``-machine enforce-config-section=on|off`` (since 3.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``enforce-config-section`` parameter is replaced by the
> +``-global migration.send-configuration={on|off}`` option.
> +
> +``-no-kvm`` (since 1.3.0)
> +'''''''''''''''''''''''''
> +
> +The ``-no-kvm`` argument is now a synonym for setting ``-accel tcg``.
> +
> +``-usbdevice`` (since 2.10.0)
> +'''''''''''''''''''''''''''''
> +
> +The ``-usbdevice DEV`` argument is now a synonym for setting
> +the ``-device usb-DEV`` argument instead. The deprecated syntax
> +would automatically enable USB support on the machine type.
> +If using the new syntax, USB support must be explicitly
> +enabled via the ``-machine usb=on`` argument.
> +
> +``-drive file=json:{...{'driver':'file'}}`` (since 3.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The 'file' driver for drives is no longer appropriate for character or
> host
> +devices and will only accept regular files (S_IFREG). The correct driver
> +for these file types is 'host_cdrom' or 'host_device' as appropriate.
> +
> +``-net ...,name=``\ *name* (since 3.1)
> +''''''''''''''''''''''''''''''''''''''
> +
> +The ``name`` parameter of the ``-net`` option is a synonym
> +for the ``id`` parameter, which should now be used instead.
> +
> +``-smp`` (invalid topologies) (since 3.1)
> +'''''''''''''''''''''''''''''''''''''''''
> +
> +CPU topology properties should describe whole machine topology including
> +possible CPUs.
> +
> +However, historically it was possible to start QEMU with an incorrect
> topology
> +where *n* <= *sockets* * *cores* * *threads* < *maxcpus*,
> +which could lead to an incorrect topology enumeration by the guest.
> +Support for invalid topologies will be removed, the user must ensure
> +topologies described with -smp include all possible cpus, i.e.
> +*sockets* * *cores* * *threads* = *maxcpus*.
> +
> +``-vnc acl`` (since 4.0.0)
> +''''''''''''''''''''''''''
> +
> +The ``acl`` option to the ``-vnc`` argument has been replaced
> +by the ``tls-authz`` and ``sasl-authz`` options.
> +
> +``QEMU_AUDIO_`` environment variables and ``-audio-help`` (since 4.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``-audiodev`` argument is now the preferred way to specify audio
> +backend settings instead of environment variables.  To ease migration to
> +the new format, the ``-audiodev-help`` option can be used to convert
> +the current values of the environment variables to ``-audiodev`` options.
> +
> +Creating sound card devices and vnc without ``audiodev=`` property (since
> 4.2)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> '''''''''''''''''''
> +
> +When not using the deprecated legacy audio config, each sound card
> +should specify an ``audiodev=`` property.  Additionally, when using
> +vnc, you should specify an ``audiodev=`` propery if you plan to
> +transmit audio through the VNC protocol.
> +
> +``-mon ...,control=readline,pretty=on|off`` (since 4.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``pretty=on|off`` switch has no effect for HMP monitors, but is
> +silently ignored. Using the switch with HMP monitors will become an
> +error in the future.
> +
> +``-realtime`` (since 4.1)
> +'''''''''''''''''''''''''
> +
> +The ``-realtime mlock=on|off`` argument has been replaced by the
> +``-overcommit mem-lock=on|off`` argument.
> +
> +``-numa node,mem=``\ *size* (since 4.1)
> +'''''''''''''''''''''''''''''''''''''''
> +
> +The parameter ``mem`` of ``-numa node`` is used to assign a part of
> +guest RAM to a NUMA node. But when using it, it's impossible to manage
> specified
> +RAM chunk on the host side (like bind it to a host node, setting bind
> policy, ...),
> +so guest end-ups with the fake NUMA configuration with suboptiomal
> performance.
> +However since 2014 there is an alternative way to assign RAM to a NUMA
> node
> +using parameter ``memdev``, which does the same as ``mem`` and adds
> +means to actualy manage node RAM on the host side. Use parameter
> ``memdev``
> +with *memory-backend-ram* backend as an replacement for parameter ``mem``
> +to achieve the same fake NUMA effect or a properly configured
> +*memory-backend-file* backend to actually benefit from NUMA configuration.
> +In future new machine versions will not accept the option but it will
> still
> +work with old machine types. User can check QAPI schema to see if the
> legacy
> +option is supported by looking at MachineInfo::numa-mem-supported
> property.
> +
> +``-numa`` node (without memory specified) (since 4.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Splitting RAM by default between NUMA nodes has the same issues as ``mem``
> +parameter described above with the difference that the role of the user
> plays
> +QEMU using implicit generic or board specific splitting rule.
> +Use ``memdev`` with *memory-backend-ram* backend or ``mem`` (if
> +it's supported by used machine type) to define mapping explictly instead.
> +
> +``-mem-path`` fallback to RAM (since 4.1)
> +'''''''''''''''''''''''''''''''''''''''''
> +
> +Currently if guest RAM allocation from file pointed by ``mem-path``
> +fails, QEMU falls back to allocating from RAM, which might result
> +in unpredictable behavior since the backing file specified by the user
> +is ignored. In the future, users will be responsible for making sure
> +the backing storage specified with ``-mem-path`` can actually provide
> +the guest RAM configured with ``-m`` and QEMU will fail to start up if
> +RAM allocation is unsuccessful.
> +
> +RISC-V ``-bios`` (since 4.1)
> +''''''''''''''''''''''''''''
> +
> +QEMU 4.1 introduced support for the -bios option in QEMU for RISC-V for
> the
> +RISC-V virt machine and sifive_u machine.
> +
> +QEMU 4.1 has no changes to the default behaviour to avoid breakages. This
> +default will change in a future QEMU release, so please prepare now. All
> users
> +of the virt or sifive_u machine must change their command line usage.
> +
> +QEMU 4.1 has three options, please migrate to one of these three:
> + 1. ``-bios none`` - This is the current default behavior if no -bios
> option
> +      is included. QEMU will not automatically load any firmware. It is up
> +      to the user to load all the images they need.
> + 2. ``-bios default`` - In a future QEMU release this will become the
> default
> +      behaviour if no -bios option is specified. This option will load the
> +      default OpenSBI firmware automatically. The firmware is included
> with
> +      the QEMU release and no user interaction is required. All a user
> needs
> +      to do is specify the kernel they want to boot with the -kernel
> option
> + 3. ``-bios <file>`` - Tells QEMU to load the specified file as the
> firmwrae.
> +
> +``-tb-size`` option (since 5.0)
> +'''''''''''''''''''''''''''''''
> +
> +QEMU 5.0 introduced an alternative syntax to specify the size of the
> translation
> +block cache, ``-accel tcg,tb-size=``.  The new syntax deprecates the
> +previously available ``-tb-size`` option.
> +
> +``-show-cursor`` option (since 5.0)
> +'''''''''''''''''''''''''''''''''''
> +
> +Use ``-display sdl,show-cursor=on`` or
> + ``-display gtk,show-cursor=on`` instead.
> +
> +QEMU Machine Protocol (QMP) commands
> +------------------------------------
> +
> +``change`` (since 2.5.0)
> +''''''''''''''''''''''''
> +
> +Use ``blockdev-change-medium`` or ``change-vnc-password`` instead.
> +
> +``migrate_set_downtime`` and ``migrate_set_speed`` (since 2.8.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Use ``migrate-set-parameters`` instead.
> +
> +``migrate-set-cache-size`` and ``query-migrate-cache-size`` (since 2.11.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> '''''''''''''''
> +
> +Use ``migrate-set-parameters`` and ``query-migrate-parameters`` instead.
> +
> +``query-block`` result field ``dirty-bitmaps[i].status`` (since 4.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``status`` field of the ``BlockDirtyInfo`` structure, returned by
> +the query-block command is deprecated. Two new boolean fields,
> +``recording`` and ``busy`` effectively replace it.
> +
> +``query-block`` result field ``dirty-bitmaps`` (Since 4.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``dirty-bitmaps`` field of the ``BlockInfo`` structure, returned by
> +the query-block command is itself now deprecated. The ``dirty-bitmaps``
> +field of the ``BlockDeviceInfo`` struct should be used instead, which is
> the
> +type of the ``inserted`` field in query-block replies, as well as the
> +type of array items in query-named-block-nodes.
> +
> +Since the ``dirty-bitmaps`` field is optionally present in both the old
> and
> +new locations, clients must use introspection to learn where to anticipate
> +the field if/when it does appear in command output.
> +
> +``query-cpus`` (since 2.12.0)
> +'''''''''''''''''''''''''''''
> +
> +The ``query-cpus`` command is replaced by the ``query-cpus-fast`` command.
> +
> +``query-cpus-fast`` ``arch`` output member (since 3.0.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``arch`` output member of the ``query-cpus-fast`` command is
> +replaced by the ``target`` output member.
> +
> +``cpu-add`` (since 4.0)
> +'''''''''''''''''''''''
> +
> +Use ``device_add`` for hotplugging vCPUs instead of ``cpu-add``.  See
> +documentation of ``query-hotpluggable-cpus`` for additional
> +details.
> +
> +``query-events`` (since 4.0)
> +''''''''''''''''''''''''''''
> +
> +The ``query-events`` command has been superseded by the more powerful
> +and accurate ``query-qmp-schema`` command.
> +
> +chardev client socket with ``wait`` option (since 4.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Character devices creating sockets in client mode should not specify
> +the 'wait' field, which is only applicable to sockets in server mode
> +
> +Human Monitor Protocol (HMP) commands
> +-------------------------------------
> +
> +The ``hub_id`` parameter of ``hostfwd_add`` / ``hostfwd_remove`` (since
> 3.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> '''''''''''''''''
> +
> +The ``[hub_id name]`` parameter tuple of the 'hostfwd_add' and
> +'hostfwd_remove' HMP commands has been replaced by ``netdev_id``.
> +
> +``cpu-add`` (since 4.0)
> +'''''''''''''''''''''''
> +
> +Use ``device_add`` for hotplugging vCPUs instead of ``cpu-add``.  See
> +documentation of ``query-hotpluggable-cpus`` for additional details.
> +
> +``acl_show``, ``acl_reset``, ``acl_policy``, ``acl_add``, ``acl_remove``
> (since 4.0.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> '''''''''''''''''''''''''''
> +
> +The ``acl_show``, ``acl_reset``, ``acl_policy``, ``acl_add``, and
> +``acl_remove`` commands are deprecated with no replacement. Authorization
> +for VNC should be performed using the pluggable QAuthZ objects.
> +
> +Guest Emulator ISAs
> +-------------------
> +
> +RISC-V ISA privledge specification version 1.09.1 (since 4.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The RISC-V ISA privledge specification version 1.09.1 has been deprecated.
> +QEMU supports both the newer version 1.10.0 and the ratified version
> 1.11.0, these
> +should be used instead of the 1.09.1 version.
> +
> +System emulator CPUS
> +--------------------
> +
> +RISC-V ISA CPUs (since 4.1)
> +'''''''''''''''''''''''''''
> +
> +The RISC-V cpus with the ISA version in the CPU name have been
> depcreated. The
> +four CPUs are: ``rv32gcsu-v1.9.1``, ``rv32gcsu-v1.10.0``,
> ``rv64gcsu-v1.9.1`` and
> +``rv64gcsu-v1.10.0``. Instead the version can be specified via the CPU
> ``priv_spec``
> +option when using the ``rv32`` or ``rv64`` CPUs.
> +
> +RISC-V ISA CPUs (since 4.1)
> +'''''''''''''''''''''''''''
> +
> +The RISC-V no MMU cpus have been depcreated. The two CPUs:
> ``rv32imacu-nommu`` and
> +``rv64imacu-nommu`` should no longer be used. Instead the MMU status can
> be specified
> +via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
> +
> +System emulator devices
> +-----------------------
> +
> +``ide-drive`` (since 4.2)
> +'''''''''''''''''''''''''
> +
> +The 'ide-drive' device is deprecated. Users should use 'ide-hd' or
> +'ide-cd' as appropriate to get an IDE hard disk or CD-ROM as needed.
> +
> +``scsi-disk`` (since 4.2)
> +'''''''''''''''''''''''''
> +
> +The 'scsi-disk' device is deprecated. Users should use 'scsi-hd' or
> +'scsi-cd' as appropriate to get a SCSI hard disk or CD-ROM as needed.
> +
> +System emulator machines
> +------------------------
> +
> +mips ``r4k`` platform (since 5.0)
> +'''''''''''''''''''''''''''''''''
> +
> +This machine type is very old and unmaintained. Users should use the
> ``malta``
> +machine type instead.
> +
> +``pc-1.0``, ``pc-1.1``, ``pc-1.2`` and ``pc-1.3`` (since 5.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +These machine types are very old and likely can not be used for live
> migration
> +from old QEMU versions anymore. A newer machine type should be used
> instead.
> +
> +``spike_v1.9.1`` and ``spike_v1.10`` (since 4.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The version specific Spike machines have been deprecated in favour of the
> +generic ``spike`` machine. If you need to specify an older version of the
> RISC-V
> +spec you can use the ``-cpu rv64gcsu,priv_spec=v1.9.1`` command line
> argument.
> +
> +Device options
> +--------------
> +
> +Emulated device options
> +'''''''''''''''''''''''
> +
> +``-device virtio-blk,scsi=on|off`` (since 5.0.0)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.
> VIRTIO 1.0
> +and later do not support it because the virtio-scsi device was introduced
> for
> +full SCSI support.  Use virtio-scsi instead when SCSI passthrough is
> required.
> +
> +Note this also applies to ``-device virtio-blk-pci,scsi=on|off``, which
> is an
> +alias.
> +
> +Block device options
> +''''''''''''''''''''
> +
> +``"backing": ""`` (since 2.12.0)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +In order to prevent QEMU from automatically opening an image's backing
> +chain, use ``"backing": null`` instead.
> +
> +``rbd`` keyvalue pair encoded filenames: ``""`` (since 3.1.0)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Options for ``rbd`` should be specified according to its runtime options,
> +like other block drivers.  Legacy parsing of keyvalue pair encoded
> +filenames is useful to open images with the old format for backing files;
> +These image files should be updated to use the current format.
> +
> +Example of legacy encoding::
> +
> +  json:{"file.driver":"rbd", "file.filename":"rbd:rbd/name"}
> +
> +The above, converted to the current supported format::
> +
> +  json:{"file.driver":"rbd", "file.pool":"rbd", "file.image":"name"}
> +
> +Related binaries
> +----------------
> +
> +``qemu-img convert -n -o`` (since 4.2.0)
> +''''''''''''''''''''''''''''''''''''''''
> +
> +All options specified in ``-o`` are image creation options, so
> +they have no effect when used with ``-n`` to skip image creation.
> +Silently ignored options can be confusing, so this combination of
> +options will be made an error in future versions.
> +
> +Backwards compatibility
> +-----------------------
> +
> +Runnability guarantee of CPU models (since 4.1.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Previous versions of QEMU never changed existing CPU models in
> +ways that introduced additional host software or hardware
> +requirements to the VM.  This allowed management software to
> +safely change the machine type of an existing VM without
> +introducing new requirements ("runnability guarantee").  This
> +prevented CPU models from being updated to include CPU
> +vulnerability mitigations, leaving guests vulnerable in the
> +default configuration.
> +
> +The CPU model runnability guarantee won't apply anymore to
> +existing CPU models.  Management software that needs runnability
> +guarantees must resolve the CPU model aliases using te
> +``alias-of`` field returned by the ``query-cpu-definitions`` QMP
> +command.
> +
> +While those guarantees are kept, the return value of
> +``query-cpu-definitions`` will have existing CPU model aliases
> +point to a version that doesn't break runnability guarantees
> +(specifically, version 1 of those CPU models).  In future QEMU
> +versions, aliases will point to newer CPU model versions
> +depending on the machine type, so management software must
> +resolve CPU model aliases before starting a virtual machine.
> +
> +
> +Recently removed features
> +=========================
> +
> +What follows is a record of recently removed, formerly deprecated
> +features that serves as a record for users who have encountered
> +trouble after a recent upgrade.
> +
> +QEMU Machine Protocol (QMP) commands
> +------------------------------------
> +
> +``block-dirty-bitmap-add`` "autoload" parameter (since 4.2.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The "autoload" parameter has been ignored since 2.12.0. All bitmaps
> +are automatically loaded from qcow2 images.
> +
> +Related binaries
> +----------------
> +
> +``qemu-nbd --partition`` (removed in 5.0.0)
> +'''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``qemu-nbd --partition $digit`` code (also spelled ``-P``)
> +could only handle MBR partitions, and never correctly handled logical
> +partitions beyond partition 5.  Exporting a partition can still be
> +done by utilizing the ``--image-opts`` option with a raw blockdev
> +using the ``offset`` and ``size`` parameters layered on top of
> +any other existing blockdev. For example, if partition 1 is 100MiB
> +long starting at 1MiB, the old command::
> +
> +  qemu-nbd -t -P 1 -f qcow2 file.qcow2
> +
> +can be rewritten as::
> +
> +  qemu-nbd -t --image-opts driver=raw,offset=1M,size=
> 100M,file.driver=qcow2,file.file.driver=file,file.file.filename=file.qcow2
> diff --git a/docs/system/index.rst b/docs/system/index.rst
> index 887bef92f40..7d09abca954 100644
> --- a/docs/system/index.rst
> +++ b/docs/system/index.rst
> @@ -14,6 +14,7 @@ Contents:
>  .. toctree::
>     :maxdepth: 2
>
> +   deprecated
>     managed-startup
>     qemu-block-drivers
>     security
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> deleted file mode 100644
> index 0671c26c806..00000000000
> --- a/qemu-deprecated.texi
> +++ /dev/null
> @@ -1,386 +0,0 @@
> -@node Deprecated features
> -@appendix Deprecated features
> -
> -In general features are intended to be supported indefinitely once
> -introduced into QEMU. In the event that a feature needs to be removed,
> -it will be listed in this appendix. The feature will remain functional
> -for 2 releases prior to actual removal. Deprecated features may also
> -generate warnings on the console when QEMU starts up, or if activated
> -via a monitor command, however, this is not a mandatory requirement.
> -
> -Prior to the 2.10.0 release there was no official policy on how
> -long features would be deprecated prior to their removal, nor
> -any documented list of which features were deprecated. Thus
> -any features deprecated prior to 2.10.0 will be treated as if
> -they were first deprecated in the 2.10.0 release.
> -
> -What follows is a list of all features currently marked as
> -deprecated.
> -
> -@section System emulator command line arguments
> -
> -@subsection -machine enforce-config-section=on|off (since 3.1)
> -
> -The @option{enforce-config-section} parameter is replaced by the
> -@option{-global migration.send-configuration=@var{on|off}} option.
> -
> -@subsection -no-kvm (since 1.3.0)
> -
> -The ``-no-kvm'' argument is now a synonym for setting ``-accel tcg''.
> -
> -@subsection -usbdevice (since 2.10.0)
> -
> -The ``-usbdevice DEV'' argument is now a synonym for setting
> -the ``-device usb-DEV'' argument instead. The deprecated syntax
> -would automatically enable USB support on the machine type.
> -If using the new syntax, USB support must be explicitly
> -enabled via the ``-machine usb=on'' argument.
> -
> -@subsection -drive file=json:@{...@{'driver':'file'@}@} (since 3.0)
> -
> -The 'file' driver for drives is no longer appropriate for character or
> host
> -devices and will only accept regular files (S_IFREG). The correct driver
> -for these file types is 'host_cdrom' or 'host_device' as appropriate.
> -
> -@subsection -net ...,name=@var{name} (since 3.1)
> -
> -The @option{name} parameter of the @option{-net} option is a synonym
> -for the @option{id} parameter, which should now be used instead.
> -
> -@subsection -smp (invalid topologies) (since 3.1)
> -
> -CPU topology properties should describe whole machine topology including
> -possible CPUs.
> -
> -However, historically it was possible to start QEMU with an incorrect
> topology
> -where @math{@var{n} <= @var{sockets} * @var{cores} * @var{threads} <
> @var{maxcpus}},
> -which could lead to an incorrect topology enumeration by the guest.
> -Support for invalid topologies will be removed, the user must ensure
> -topologies described with -smp include all possible cpus, i.e.
> -  @math{@var{sockets} * @var{cores} * @var{threads} = @var{maxcpus}}.
> -
> -@subsection -vnc acl (since 4.0.0)
> -
> -The @code{acl} option to the @code{-vnc} argument has been replaced
> -by the @code{tls-authz} and @code{sasl-authz} options.
> -
> -@subsection QEMU_AUDIO_ environment variables and -audio-help (since 4.0)
> -
> -The ``-audiodev'' argument is now the preferred way to specify audio
> -backend settings instead of environment variables.  To ease migration to
> -the new format, the ``-audiodev-help'' option can be used to convert
> -the current values of the environment variables to ``-audiodev'' options.
> -
> -@subsection Creating sound card devices and vnc without audiodev=
> property (since 4.2)
> -
> -When not using the deprecated legacy audio config, each sound card
> -should specify an @code{audiodev=} property.  Additionally, when using
> -vnc, you should specify an @code{audiodev=} propery if you plan to
> -transmit audio through the VNC protocol.
> -
> -@subsection -mon ...,control=readline,pretty=on|off (since 4.1)
> -
> -The @code{pretty=on|off} switch has no effect for HMP monitors, but is
> -silently ignored. Using the switch with HMP monitors will become an
> -error in the future.
> -
> -@subsection -realtime (since 4.1)
> -
> -The @code{-realtime mlock=on|off} argument has been replaced by the
> -@code{-overcommit mem-lock=on|off} argument.
> -
> -@subsection -numa node,mem=@var{size} (since 4.1)
> -
> -The parameter @option{mem} of @option{-numa node} is used to assign a
> part of
> -guest RAM to a NUMA node. But when using it, it's impossible to manage
> specified
> -RAM chunk on the host side (like bind it to a host node, setting bind
> policy, ...),
> -so guest end-ups with the fake NUMA configuration with suboptiomal
> performance.
> -However since 2014 there is an alternative way to assign RAM to a NUMA
> node
> -using parameter @option{memdev}, which does the same as @option{mem} and
> adds
> -means to actualy manage node RAM on the host side. Use parameter
> @option{memdev}
> -with @var{memory-backend-ram} backend as an replacement for parameter
> @option{mem}
> -to achieve the same fake NUMA effect or a properly configured
> -@var{memory-backend-file} backend to actually benefit from NUMA
> configuration.
> -In future new machine versions will not accept the option but it will
> still
> -work with old machine types. User can check QAPI schema to see if the
> legacy
> -option is supported by looking at MachineInfo::numa-mem-supported
> property.
> -
> -@subsection -numa node (without memory specified) (since 4.1)
> -
> -Splitting RAM by default between NUMA nodes has the same issues as
> @option{mem}
> -parameter described above with the difference that the role of the user
> plays
> -QEMU using implicit generic or board specific splitting rule.
> -Use @option{memdev} with @var{memory-backend-ram} backend or @option{mem}
> (if
> -it's supported by used machine type) to define mapping explictly instead.
> -
> -@subsection -mem-path fallback to RAM (since 4.1)
> -Currently if guest RAM allocation from file pointed by @option{mem-path}
> -fails, QEMU falls back to allocating from RAM, which might result
> -in unpredictable behavior since the backing file specified by the user
> -is ignored. In the future, users will be responsible for making sure
> -the backing storage specified with @option{-mem-path} can actually provide
> -the guest RAM configured with @option{-m} and QEMU will fail to start up
> if
> -RAM allocation is unsuccessful.
> -
> -@subsection RISC-V -bios (since 4.1)
> -
> -QEMU 4.1 introduced support for the -bios option in QEMU for RISC-V for
> the
> -RISC-V virt machine and sifive_u machine.
> -
> -QEMU 4.1 has no changes to the default behaviour to avoid breakages. This
> -default will change in a future QEMU release, so please prepare now. All
> users
> -of the virt or sifive_u machine must change their command line usage.
> -
> -QEMU 4.1 has three options, please migrate to one of these three:
> - 1. ``-bios none`` - This is the current default behavior if no -bios
> option
> -      is included. QEMU will not automatically load any firmware. It is up
> -      to the user to load all the images they need.
> - 2. ``-bios default`` - In a future QEMU release this will become the
> default
> -      behaviour if no -bios option is specified. This option will load the
> -      default OpenSBI firmware automatically. The firmware is included
> with
> -      the QEMU release and no user interaction is required. All a user
> needs
> -      to do is specify the kernel they want to boot with the -kernel
> option
> - 3. ``-bios <file>`` - Tells QEMU to load the specified file as the
> firmwrae.
> -
> -@subsection -tb-size option (since 5.0)
> -
> -QEMU 5.0 introduced an alternative syntax to specify the size of the
> translation
> -block cache, @option{-accel tcg,tb-size=}.  The new syntax deprecates the
> -previously available @option{-tb-size} option.
> -
> -@subsection -show-cursor option (since 5.0)
> -
> -Use @option{-display sdl,show-cursor=on} or
> - @option{-display gtk,show-cursor=on} instead.
> -
> -@section QEMU Machine Protocol (QMP) commands
> -
> -@subsection change (since 2.5.0)
> -
> -Use ``blockdev-change-medium'' or ``change-vnc-password'' instead.
> -
> -@subsection migrate_set_downtime and migrate_set_speed (since 2.8.0)
> -
> -Use ``migrate-set-parameters'' instead.
> -
> -@subsection migrate-set-cache-size and query-migrate-cache-size (since
> 2.11.0)
> -
> -Use ``migrate-set-parameters'' and ``query-migrate-parameters'' instead.
> -
> -@subsection query-block result field dirty-bitmaps[i].status (since 4.0)
> -
> -The ``status'' field of the ``BlockDirtyInfo'' structure, returned by
> -the query-block command is deprecated. Two new boolean fields,
> -``recording'' and ``busy'' effectively replace it.
> -
> -@subsection query-block result field dirty-bitmaps (Since 4.2)
> -
> -The ``dirty-bitmaps`` field of the ``BlockInfo`` structure, returned by
> -the query-block command is itself now deprecated. The ``dirty-bitmaps``
> -field of the ``BlockDeviceInfo`` struct should be used instead, which is
> the
> -type of the ``inserted`` field in query-block replies, as well as the
> -type of array items in query-named-block-nodes.
> -
> -Since the ``dirty-bitmaps`` field is optionally present in both the old
> and
> -new locations, clients must use introspection to learn where to anticipate
> -the field if/when it does appear in command output.
> -
> -@subsection query-cpus (since 2.12.0)
> -
> -The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
> -
> -@subsection query-cpus-fast "arch" output member (since 3.0.0)
> -
> -The ``arch'' output member of the ``query-cpus-fast'' command is
> -replaced by the ``target'' output member.
> -
> -@subsection cpu-add (since 4.0)
> -
> -Use ``device_add'' for hotplugging vCPUs instead of ``cpu-add''.  See
> -documentation of ``query-hotpluggable-cpus'' for additional
> -details.
> -
> -@subsection query-events (since 4.0)
> -
> -The ``query-events'' command has been superseded by the more powerful
> -and accurate ``query-qmp-schema'' command.
> -
> -@subsection chardev client socket with 'wait' option (since 4.0)
> -
> -Character devices creating sockets in client mode should not specify
> -the 'wait' field, which is only applicable to sockets in server mode
> -
> -@section Human Monitor Protocol (HMP) commands
> -
> -@subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove'
> (since 3.1)
> -
> -The @option{[hub_id name]} parameter tuple of the 'hostfwd_add' and
> -'hostfwd_remove' HMP commands has been replaced by @option{netdev_id}.
> -
> -@subsection cpu-add (since 4.0)
> -
> -Use ``device_add'' for hotplugging vCPUs instead of ``cpu-add''.  See
> -documentation of ``query-hotpluggable-cpus'' for additional details.
> -
> -@subsection acl_show, acl_reset, acl_policy, acl_add, acl_remove (since
> 4.0.0)
> -
> -The ``acl_show'', ``acl_reset'', ``acl_policy'', ``acl_add'', and
> -``acl_remove'' commands are deprecated with no replacement. Authorization
> -for VNC should be performed using the pluggable QAuthZ objects.
> -
> -@section Guest Emulator ISAs
> -
> -@subsection RISC-V ISA privledge specification version 1.09.1 (since 4.1)
> -
> -The RISC-V ISA privledge specification version 1.09.1 has been deprecated.
> -QEMU supports both the newer version 1.10.0 and the ratified version
> 1.11.0, these
> -should be used instead of the 1.09.1 version.
> -
> -@section System emulator CPUS
> -
> -@subsection RISC-V ISA CPUs (since 4.1)
> -
> -The RISC-V cpus with the ISA version in the CPU name have been
> depcreated. The
> -four CPUs are: ``rv32gcsu-v1.9.1``, ``rv32gcsu-v1.10.0``,
> ``rv64gcsu-v1.9.1`` and
> -``rv64gcsu-v1.10.0``. Instead the version can be specified via the CPU
> ``priv_spec``
> -option when using the ``rv32`` or ``rv64`` CPUs.
> -
> -@subsection RISC-V ISA CPUs (since 4.1)
> -
> -The RISC-V no MMU cpus have been depcreated. The two CPUs:
> ``rv32imacu-nommu`` and
> -``rv64imacu-nommu`` should no longer be used. Instead the MMU status can
> be specified
> -via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
> -
> -@section System emulator devices
> -
> -@subsection ide-drive (since 4.2)
> -
> -The 'ide-drive' device is deprecated. Users should use 'ide-hd' or
> -'ide-cd' as appropriate to get an IDE hard disk or CD-ROM as needed.
> -
> -@subsection scsi-disk (since 4.2)
> -
> -The 'scsi-disk' device is deprecated. Users should use 'scsi-hd' or
> -'scsi-cd' as appropriate to get a SCSI hard disk or CD-ROM as needed.
> -
> -@section System emulator machines
> -
> -@subsection mips r4k platform (since 5.0)
> -
> -This machine type is very old and unmaintained. Users should use the
> 'malta'
> -machine type instead.
> -
> -@subsection pc-1.0, pc-1.1, pc-1.2 and pc-1.3 (since 5.0)
> -
> -These machine types are very old and likely can not be used for live
> migration
> -from old QEMU versions anymore. A newer machine type should be used
> instead.
> -
> -@subsection spike_v1.9.1 and spike_v1.10 (since 4.1)
> -
> -The version specific Spike machines have been deprecated in favour of the
> -generic ``spike`` machine. If you need to specify an older version of the
> RISC-V
> -spec you can use the ``-cpu rv64gcsu,priv_spec=v1.9.1`` command line
> argument.
> -
> -@section Device options
> -
> -@subsection Emulated device options
> -
> -@subsubsection -device virtio-blk,scsi=on|off (since 5.0.0)
> -
> -The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.
> VIRTIO 1.0
> -and later do not support it because the virtio-scsi device was introduced
> for
> -full SCSI support.  Use virtio-scsi instead when SCSI passthrough is
> required.
> -
> -Note this also applies to ``-device virtio-blk-pci,scsi=on|off'', which
> is an
> -alias.
> -
> -@subsection Block device options
> -
> -@subsubsection "backing": "" (since 2.12.0)
> -
> -In order to prevent QEMU from automatically opening an image's backing
> -chain, use ``"backing": null'' instead.
> -
> -@subsubsection rbd keyvalue pair encoded filenames: "" (since 3.1.0)
> -
> -Options for ``rbd'' should be specified according to its runtime options,
> -like other block drivers.  Legacy parsing of keyvalue pair encoded
> -filenames is useful to open images with the old format for backing files;
> -These image files should be updated to use the current format.
> -
> -Example of legacy encoding:
> -
> -@code{json:@{"file.driver":"rbd", "file.filename":"rbd:rbd/name"@}}
> -
> -The above, converted to the current supported format:
> -
> -@code{json:@{"file.driver":"rbd", "file.pool":"rbd",
> "file.image":"name"@}}
> -
> -@section Related binaries
> -
> -@subsection qemu-img convert -n -o (since 4.2.0)
> -
> -All options specified in @option{-o} are image creation options, so
> -they have no effect when used with @option{-n} to skip image creation.
> -Silently ignored options can be confusing, so this combination of
> -options will be made an error in future versions.
> -
> -@section Backwards compatibility
> -
> -@subsection Runnability guarantee of CPU models (since 4.1.0)
> -
> -Previous versions of QEMU never changed existing CPU models in
> -ways that introduced additional host software or hardware
> -requirements to the VM.  This allowed management software to
> -safely change the machine type of an existing VM without
> -introducing new requirements ("runnability guarantee").  This
> -prevented CPU models from being updated to include CPU
> -vulnerability mitigations, leaving guests vulnerable in the
> -default configuration.
> -
> -The CPU model runnability guarantee won't apply anymore to
> -existing CPU models.  Management software that needs runnability
> -guarantees must resolve the CPU model aliases using te
> -``alias-of'' field returned by the ``query-cpu-definitions'' QMP
> -command.
> -
> -While those guarantees are kept, the return value of
> -``query-cpu-definitions'' will have existing CPU model aliases
> -point to a version that doesn't break runnability guarantees
> -(specifically, version 1 of those CPU models).  In future QEMU
> -versions, aliases will point to newer CPU model versions
> -depending on the machine type, so management software must
> -resolve CPU model aliases before starting a virtual machine.
> -
> -
> -@node Recently removed features
> -@appendix Recently removed features
> -
> -What follows is a record of recently removed, formerly deprecated
> -features that serves as a record for users who have encountered
> -trouble after a recent upgrade.
> -
> -@section QEMU Machine Protocol (QMP) commands
> -
> -@subsection block-dirty-bitmap-add "autoload" parameter (since 4.2.0)
> -
> -The "autoload" parameter has been ignored since 2.12.0. All bitmaps
> -are automatically loaded from qcow2 images.
> -
> -@section Related binaries
> -
> -@subsection qemu-nbd --partition (removed in 5.0.0)
> -
> -The ``qemu-nbd --partition $digit'' code (also spelled @option{-P})
> -could only handle MBR partitions, and never correctly handled logical
> -partitions beyond partition 5.  Exporting a partition can still be
> -done by utilizing the @option{--image-opts} option with a raw blockdev
> -using the @code{offset} and @code{size} parameters layered on top of
> -any other existing blockdev. For example, if partition 1 is 100MiB
> -long starting at 1MiB, the old command:
> -
> -@code{qemu-nbd -t -P 1 -f qcow2 file.qcow2}
> -
> -can be rewritten as:
> -
> -@code{qemu-nbd -t --image-opts driver=raw,offset=1M,size=
> 100M,file.driver=qcow2,file.file.driver=file,file.file.
> filename=file.qcow2}
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 7798e072a1c..6bb1fd54c03 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -40,8 +40,6 @@
>  * QEMU System emulator for non PC targets::
>  * QEMU User space emulator::
>  * System requirements::
> -* Deprecated features::
> -* Recently removed features::
>  * Supported build platforms::
>  * License::
>  * Index::
> @@ -2834,8 +2832,6 @@ added with Linux 4.5 which is supported by the major
> distros. And even
>  if RHEL7 has kernel 3.10, KVM there has the required functionality there
>  to make it close to a 4.5 or newer kernel.
>
> -@include qemu-deprecated.texi
> -
>  @node Supported build platforms
>  @appendix Supported build platforms
>
> --
> 2.20.1
>
>
>

--000000000000d0ed8c059f78d87f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, February 25, 2020, Peter Maydell &lt;<a href=3D"mailto:=
peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">&gt; Convert the documentation of deprecated featu=
res to rST.<br>
<br></blockquote><div><br></div><div><br></div><div><span style=3D"color:rg=
b(34,34,34);font-size:14px;line-height:22.1200008392334px">s/depcreated/</s=
pan>deprecated</div><div><br></div><div>at two places below (unless there i=
s (and suitable in the context) an english word &quot;depcreated&quot;, tha=
t is not known to me).</div><div><br></div><div>Aleksandar</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
We put the whole of this document into the system manual, though<br>
technically a few parts of it apply to qemu-img or qemu-nbd which are<br>
otherwise documented in tools/.<br>
<br>
We only make formatting fixes, except for one use of &#39;appendix&#39; whi=
ch<br>
we change to &#39;section&#39; because this isn&#39;t an appendix in the Sp=
hinx<br>
manual.<br>
<br>
Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
">peter.maydell@linaro.org</a>&gt;<br>
---<br>
=C2=A0Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +-<br>
=C2=A0docs/system/deprecated.rst | 446 ++++++++++++++++++++++++++++++<wbr>+=
++++++<br>
=C2=A0docs/system/index.rst=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0qemu-deprecated.texi=C2=A0 =C2=A0 =C2=A0 =C2=A0| 386 ----------------=
--------------<wbr>--<br>
=C2=A0qemu-doc.texi=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 =C2=A04 -<br>
=C2=A06 files changed, 449 insertions(+), 392 deletions(-)<br>
=C2=A0create mode 100644 docs/system/deprecated.rst<br>
=C2=A0delete mode 100644 qemu-deprecated.texi<br>
<br>
diff --git a/Makefile b/Makefile<br>
index 28749d20401..ec4a4be8355 100644<br>
--- a/Makefile<br>
+++ b/Makefile<br>
@@ -1115,7 +1115,7 @@ txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/=
interop/qemu-ga-ref.txt<br>
=C2=A0qemu-doc.html <a href=3D"http://qemu-doc.info" target=3D"_blank">qemu=
-doc.info</a> qemu-doc.pdf qemu-doc.txt: \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-options.texi \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-option-trace.texi \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-deprecated.texi qemu-monitor.texi \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-monitor.texi \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-monitor-info.texi \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 docs/qemu-cpu-models.texi<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 195dd58cac1..546f2b83017 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -2787,7 +2787,7 @@ F: contrib/gitdm/*<br>
<br>
=C2=A0Incompatible changes<br>
=C2=A0R: <a href=3D"mailto:libvir-list@redhat.com">libvir-list@redhat.com</=
a><br>
-F: qemu-deprecated.texi<br>
+F: docs/system/deprecated.rst<br>
<br>
=C2=A0Build System<br>
=C2=A0------------<br>
diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst<br>
new file mode 100644<br>
index 00000000000..1eaa559079b<br>
--- /dev/null<br>
+++ b/docs/system/deprecated.rst<br>
@@ -0,0 +1,446 @@<br>
+Deprecated features<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+In general features are intended to be supported indefinitely once<br>
+introduced into QEMU. In the event that a feature needs to be removed,<br>
+it will be listed in this section. The feature will remain functional<br>
+for 2 releases prior to actual removal. Deprecated features may also<br>
+generate warnings on the console when QEMU starts up, or if activated<br>
+via a monitor command, however, this is not a mandatory requirement.<br>
+<br>
+Prior to the 2.10.0 release there was no official policy on how<br>
+long features would be deprecated prior to their removal, nor<br>
+any documented list of which features were deprecated. Thus<br>
+any features deprecated prior to 2.10.0 will be treated as if<br>
+they were first deprecated in the 2.10.0 release.<br>
+<br>
+What follows is a list of all features currently marked as<br>
+deprecated.<br>
+<br>
+System emulator command line arguments<br>
+-----------------------------<wbr>---------<br>
+<br>
+``-machine enforce-config-section=3Don|off`<wbr>` (since 3.1)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The ``enforce-config-section`` parameter is replaced by the<br>
+``-global migration.send-configuration=3D{<wbr>on|off}`` option.<br>
+<br>
+``-no-kvm`` (since 1.3.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The ``-no-kvm`` argument is now a synonym for setting ``-accel tcg``.<br>
+<br>
+``-usbdevice`` (since 2.10.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The ``-usbdevice DEV`` argument is now a synonym for setting<br>
+the ``-device usb-DEV`` argument instead. The deprecated syntax<br>
+would automatically enable USB support on the machine type.<br>
+If using the new syntax, USB support must be explicitly<br>
+enabled via the ``-machine usb=3Don`` argument.<br>
+<br>
+``-drive file=3Djson:{...{&#39;driver&#39;:&#39;file&#39;<wbr>}}`` (since =
3.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The &#39;file&#39; driver for drives is no longer appropriate for characte=
r or host<br>
+devices and will only accept regular files (S_IFREG). The correct driver<b=
r>
+for these file types is &#39;host_cdrom&#39; or &#39;host_device&#39; as a=
ppropriate.<br>
+<br>
+``-net ...,name=3D``\ *name* (since 3.1)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The ``name`` parameter of the ``-net`` option is a synonym<br>
+for the ``id`` parameter, which should now be used instead.<br>
+<br>
+``-smp`` (invalid topologies) (since 3.1)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+CPU topology properties should describe whole machine topology including<b=
r>
+possible CPUs.<br>
+<br>
+However, historically it was possible to start QEMU with an incorrect topo=
logy<br>
+where *n* &lt;=3D *sockets* * *cores* * *threads* &lt; *maxcpus*,<br>
+which could lead to an incorrect topology enumeration by the guest.<br>
+Support for invalid topologies will be removed, the user must ensure<br>
+topologies described with -smp include all possible cpus, i.e.<br>
+*sockets* * *cores* * *threads* =3D *maxcpus*.<br>
+<br>
+``-vnc acl`` (since 4.0.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The ``acl`` option to the ``-vnc`` argument has been replaced<br>
+by the ``tls-authz`` and ``sasl-authz`` options.<br>
+<br>
+``QEMU_AUDIO_`` environment variables and ``-audio-help`` (since 4.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;<wbr>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The ``-audiodev`` argument is now the preferred way to specify audio<br>
+backend settings instead of environment variables.=C2=A0 To ease migration=
 to<br>
+the new format, the ``-audiodev-help`` option can be used to convert<br>
+the current values of the environment variables to ``-audiodev`` options.<=
br>
+<br>
+Creating sound card devices and vnc without ``audiodev=3D`` property (sinc=
e 4.2)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;<wbr>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+When not using the deprecated legacy audio config, each sound card<br>
+should specify an ``audiodev=3D`` property.=C2=A0 Additionally, when using=
<br>
+vnc, you should specify an ``audiodev=3D`` propery if you plan to<br>
+transmit audio through the VNC protocol.<br>
+<br>
+``-mon ...,control=3Dreadline,pretty=3D<wbr>on|off`` (since 4.1)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The ``pretty=3Don|off`` switch has no effect for HMP monitors, but is<br>
+silently ignored. Using the switch with HMP monitors will become an<br>
+error in the future.<br>
+<br>
+``-realtime`` (since 4.1)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The ``-realtime mlock=3Don|off`` argument has been replaced by the<br>
+``-overcommit mem-lock=3Don|off`` argument.<br>
+<br>
+``-numa node,mem=3D``\ *size* (since 4.1)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The parameter ``mem`` of ``-numa node`` is used to assign a part of<br>
+guest RAM to a NUMA node. But when using it, it&#39;s impossible to manage=
 specified<br>
+RAM chunk on the host side (like bind it to a host node, setting bind poli=
cy, ...),<br>
+so guest end-ups with the fake NUMA configuration with suboptiomal perform=
ance.<br>
+However since 2014 there is an alternative way to assign RAM to a NUMA nod=
e<br>
+using parameter ``memdev``, which does the same as ``mem`` and adds<br>
+means to actualy manage node RAM on the host side. Use parameter ``memdev`=
`<br>
+with *memory-backend-ram* backend as an replacement for parameter ``mem``<=
br>
+to achieve the same fake NUMA effect or a properly configured<br>
+*memory-backend-file* backend to actually benefit from NUMA configuration.=
<br>
+In future new machine versions will not accept the option but it will stil=
l<br>
+work with old machine types. User can check QAPI schema to see if the lega=
cy<br>
+option is supported by looking at MachineInfo::numa-mem-<wbr>supported pro=
perty.<br>
+<br>
+``-numa`` node (without memory specified) (since 4.1)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+Splitting RAM by default between NUMA nodes has the same issues as ``mem``=
<br>
+parameter described above with the difference that the role of the user pl=
ays<br>
+QEMU using implicit generic or board specific splitting rule.<br>
+Use ``memdev`` with *memory-backend-ram* backend or ``mem`` (if<br>
+it&#39;s supported by used machine type) to define mapping explictly inste=
ad.<br>
+<br>
+``-mem-path`` fallback to RAM (since 4.1)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+Currently if guest RAM allocation from file pointed by ``mem-path``<br>
+fails, QEMU falls back to allocating from RAM, which might result<br>
+in unpredictable behavior since the backing file specified by the user<br>
+is ignored. In the future, users will be responsible for making sure<br>
+the backing storage specified with ``-mem-path`` can actually provide<br>
+the guest RAM configured with ``-m`` and QEMU will fail to start up if<br>
+RAM allocation is unsuccessful.<br>
+<br>
+RISC-V ``-bios`` (since 4.1)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+QEMU 4.1 introduced support for the -bios option in QEMU for RISC-V for th=
e<br>
+RISC-V virt machine and sifive_u machine.<br>
+<br>
+QEMU 4.1 has no changes to the default behaviour to avoid breakages. This<=
br>
+default will change in a future QEMU release, so please prepare now. All u=
sers<br>
+of the virt or sifive_u machine must change their command line usage.<br>
+<br>
+QEMU 4.1 has three options, please migrate to one of these three:<br>
+ 1. ``-bios none`` - This is the current default behavior if no -bios opti=
on<br>
+=C2=A0 =C2=A0 =C2=A0 is included. QEMU will not automatically load any fir=
mware. It is up<br>
+=C2=A0 =C2=A0 =C2=A0 to the user to load all the images they need.<br>
+ 2. ``-bios default`` - In a future QEMU release this will become the defa=
ult<br>
+=C2=A0 =C2=A0 =C2=A0 behaviour if no -bios option is specified. This optio=
n will load the<br>
+=C2=A0 =C2=A0 =C2=A0 default OpenSBI firmware automatically. The firmware =
is included with<br>
+=C2=A0 =C2=A0 =C2=A0 the QEMU release and no user interaction is required.=
 All a user needs<br>
+=C2=A0 =C2=A0 =C2=A0 to do is specify the kernel they want to boot with th=
e -kernel option<br>
+ 3. ``-bios &lt;file&gt;`` - Tells QEMU to load the specified file as the =
firmwrae.<br>
+<br>
+``-tb-size`` option (since 5.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;<br>
+<br>
+QEMU 5.0 introduced an alternative syntax to specify the size of the trans=
lation<br>
+block cache, ``-accel tcg,tb-size=3D``.=C2=A0 The new syntax deprecates th=
e<br>
+previously available ``-tb-size`` option.<br>
+<br>
+``-show-cursor`` option (since 5.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+Use ``-display sdl,show-cursor=3Don`` or<br>
+ ``-display gtk,show-cursor=3Don`` instead.<br>
+<br>
+QEMU Machine Protocol (QMP) commands<br>
+-----------------------------<wbr>-------<br>
+<br>
+``change`` (since 2.5.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+Use ``blockdev-change-medium`` or ``change-vnc-password`` instead.<br>
+<br>
+``migrate_set_downtime`` and ``migrate_set_speed`` (since 2.8.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;<wbr>&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+Use ``migrate-set-parameters`` instead.<br>
+<br>
+``migrate-set-cache-size`` and ``query-migrate-cache-size`` (since 2.11.0)=
<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;<wbr>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;<br>
+<br>
+Use ``migrate-set-parameters`` and ``query-migrate-parameters`` instead.<b=
r>
+<br>
+``query-block`` result field ``dirty-bitmaps[i].status`` (since 4.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;<wbr>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The ``status`` field of the ``BlockDirtyInfo`` structure, returned by<br>
+the query-block command is deprecated. Two new boolean fields,<br>
+``recording`` and ``busy`` effectively replace it.<br>
+<br>
+``query-block`` result field ``dirty-bitmaps`` (Since 4.2)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The ``dirty-bitmaps`` field of the ``BlockInfo`` structure, returned by<br=
>
+the query-block command is itself now deprecated. The ``dirty-bitmaps``<br=
>
+field of the ``BlockDeviceInfo`` struct should be used instead, which is t=
he<br>
+type of the ``inserted`` field in query-block replies, as well as the<br>
+type of array items in query-named-block-nodes.<br>
+<br>
+Since the ``dirty-bitmaps`` field is optionally present in both the old an=
d<br>
+new locations, clients must use introspection to learn where to anticipate=
<br>
+the field if/when it does appear in command output.<br>
+<br>
+``query-cpus`` (since 2.12.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The ``query-cpus`` command is replaced by the ``query-cpus-fast`` command.=
<br>
+<br>
+``query-cpus-fast`` ``arch`` output member (since 3.0.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The ``arch`` output member of the ``query-cpus-fast`` command is<br>
+replaced by the ``target`` output member.<br>
+<br>
+``cpu-add`` (since 4.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+Use ``device_add`` for hotplugging vCPUs instead of ``cpu-add``.=C2=A0 See=
<br>
+documentation of ``query-hotpluggable-cpus`` for additional<br>
+details.<br>
+<br>
+``query-events`` (since 4.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The ``query-events`` command has been superseded by the more powerful<br>
+and accurate ``query-qmp-schema`` command.<br>
+<br>
+chardev client socket with ``wait`` option (since 4.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+Character devices creating sockets in client mode should not specify<br>
+the &#39;wait&#39; field, which is only applicable to sockets in server mo=
de<br>
+<br>
+Human Monitor Protocol (HMP) commands<br>
+-----------------------------<wbr>--------<br>
+<br>
+The ``hub_id`` parameter of ``hostfwd_add`` / ``hostfwd_remove`` (since 3.=
1)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;<wbr>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;<br>
+<br>
+The ``[hub_id name]`` parameter tuple of the &#39;hostfwd_add&#39; and<br>
+&#39;hostfwd_remove&#39; HMP commands has been replaced by ``netdev_id``.<=
br>
+<br>
+``cpu-add`` (since 4.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+Use ``device_add`` for hotplugging vCPUs instead of ``cpu-add``.=C2=A0 See=
<br>
+documentation of ``query-hotpluggable-cpus`` for additional details.<br>
+<br>
+``acl_show``, ``acl_reset``, ``acl_policy``, ``acl_add``, ``acl_remove`` (=
since 4.0.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;<wbr>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The ``acl_show``, ``acl_reset``, ``acl_policy``, ``acl_add``, and<br>
+``acl_remove`` commands are deprecated with no replacement. Authorization<=
br>
+for VNC should be performed using the pluggable QAuthZ objects.<br>
+<br>
+Guest Emulator ISAs<br>
+-------------------<br>
+<br>
+RISC-V ISA privledge specification version 1.09.1 (since 4.1)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;<wbr>&#39;&#39;<br>
+<br>
+The RISC-V ISA privledge specification version 1.09.1 has been deprecated.=
<br>
+QEMU supports both the newer version 1.10.0 and the ratified version 1.11.=
0, these<br>
+should be used instead of the 1.09.1 version.<br>
+<br>
+System emulator CPUS<br>
+--------------------<br>
+<br>
+RISC-V ISA CPUs (since 4.1)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The RISC-V cpus with the ISA version in the CPU name have been depcreated.=
 The<br>
+four CPUs are: ``rv32gcsu-v1.9.1``, ``rv32gcsu-v1.10.0``, ``rv64gcsu-v1.9.=
1`` and<br>
+``rv64gcsu-v1.10.0``. Instead the version can be specified via the CPU ``p=
riv_spec``<br>
+option when using the ``rv32`` or ``rv64`` CPUs.<br>
+<br>
+RISC-V ISA CPUs (since 4.1)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The RISC-V no MMU cpus have been depcreated. The two CPUs: ``rv32imacu-nom=
mu`` and<br>
+``rv64imacu-nommu`` should no longer be used. Instead the MMU status can b=
e specified<br>
+via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.<br>
+<br>
+System emulator devices<br>
+-----------------------<br>
+<br>
+``ide-drive`` (since 4.2)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The &#39;ide-drive&#39; device is deprecated. Users should use &#39;ide-hd=
&#39; or<br>
+&#39;ide-cd&#39; as appropriate to get an IDE hard disk or CD-ROM as neede=
d.<br>
+<br>
+``scsi-disk`` (since 4.2)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The &#39;scsi-disk&#39; device is deprecated. Users should use &#39;scsi-h=
d&#39; or<br>
+&#39;scsi-cd&#39; as appropriate to get a SCSI hard disk or CD-ROM as need=
ed.<br>
+<br>
+System emulator machines<br>
+------------------------<br>
+<br>
+mips ``r4k`` platform (since 5.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;<br>
+<br>
+This machine type is very old and unmaintained. Users should use the ``mal=
ta``<br>
+machine type instead.<br>
+<br>
+``pc-1.0``, ``pc-1.1``, ``pc-1.2`` and ``pc-1.3`` (since 5.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;<wbr>&#39;&#39;<br>
+<br>
+These machine types are very old and likely can not be used for live migra=
tion<br>
+from old QEMU versions anymore. A newer machine type should be used instea=
d.<br>
+<br>
+``spike_v1.9.1`` and ``spike_v1.10`` (since 4.1)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;<br>
+<br>
+The version specific Spike machines have been deprecated in favour of the<=
br>
+generic ``spike`` machine. If you need to specify an older version of the =
RISC-V<br>
+spec you can use the ``-cpu rv64gcsu,priv_spec=3Dv1.9.1`` command line arg=
ument.<br>
+<br>
+Device options<br>
+--------------<br>
+<br>
+Emulated device options<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+``-device virtio-blk,scsi=3Don|off`` (since 5.0.0)<br>
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<wbr>^^^^^^^^^^^^^^^^^^^<br>
+<br>
+The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.=C2=A0 =
VIRTIO 1.0<br>
+and later do not support it because the virtio-scsi device was introduced =
for<br>
+full SCSI support.=C2=A0 Use virtio-scsi instead when SCSI passthrough is =
required.<br>
+<br>
+Note this also applies to ``-device virtio-blk-pci,scsi=3Don|off``, which =
is an<br>
+alias.<br>
+<br>
+Block device options<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+``&quot;backing&quot;: &quot;&quot;`` (since 2.12.0)<br>
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<wbr>^^^<br>
+<br>
+In order to prevent QEMU from automatically opening an image&#39;s backing=
<br>
+chain, use ``&quot;backing&quot;: null`` instead.<br>
+<br>
+``rbd`` keyvalue pair encoded filenames: ``&quot;&quot;`` (since 3.1.0)<br=
>
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<wbr>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<wbr>^^<br=
>
+<br>
+Options for ``rbd`` should be specified according to its runtime options,<=
br>
+like other block drivers.=C2=A0 Legacy parsing of keyvalue pair encoded<br=
>
+filenames is useful to open images with the old format for backing files;<=
br>
+These image files should be updated to use the current format.<br>
+<br>
+Example of legacy encoding::<br>
+<br>
+=C2=A0 json:{&quot;file.driver&quot;:&quot;rbd&quot;, &quot;file.filename&=
quot;:&quot;rbd:rbd/name&quot;<wbr>}<br>
+<br>
+The above, converted to the current supported format::<br>
+<br>
+=C2=A0 json:{&quot;file.driver&quot;:&quot;rbd&quot;, &quot;file.pool&quot=
;:&quot;rbd&quot;, &quot;file.image&quot;:&quot;name&quot;}<br>
+<br>
+Related binaries<br>
+----------------<br>
+<br>
+``qemu-img convert -n -o`` (since 4.2.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+All options specified in ``-o`` are image creation options, so<br>
+they have no effect when used with ``-n`` to skip image creation.<br>
+Silently ignored options can be confusing, so this combination of<br>
+options will be made an error in future versions.<br>
+<br>
+Backwards compatibility<br>
+-----------------------<br>
+<br>
+Runnability guarantee of CPU models (since 4.1.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+Previous versions of QEMU never changed existing CPU models in<br>
+ways that introduced additional host software or hardware<br>
+requirements to the VM.=C2=A0 This allowed management software to<br>
+safely change the machine type of an existing VM without<br>
+introducing new requirements (&quot;runnability guarantee&quot;).=C2=A0 Th=
is<br>
+prevented CPU models from being updated to include CPU<br>
+vulnerability mitigations, leaving guests vulnerable in the<br>
+default configuration.<br>
+<br>
+The CPU model runnability guarantee won&#39;t apply anymore to<br>
+existing CPU models.=C2=A0 Management software that needs runnability<br>
+guarantees must resolve the CPU model aliases using te<br>
+``alias-of`` field returned by the ``query-cpu-definitions`` QMP<br>
+command.<br>
+<br>
+While those guarantees are kept, the return value of<br>
+``query-cpu-definitions`` will have existing CPU model aliases<br>
+point to a version that doesn&#39;t break runnability guarantees<br>
+(specifically, version 1 of those CPU models).=C2=A0 In future QEMU<br>
+versions, aliases will point to newer CPU model versions<br>
+depending on the machine type, so management software must<br>
+resolve CPU model aliases before starting a virtual machine.<br>
+<br>
+<br>
+Recently removed features<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>
+<br>
+What follows is a record of recently removed, formerly deprecated<br>
+features that serves as a record for users who have encountered<br>
+trouble after a recent upgrade.<br>
+<br>
+QEMU Machine Protocol (QMP) commands<br>
+-----------------------------<wbr>-------<br>
+<br>
+``block-dirty-bitmap-add`` &quot;autoload&quot; parameter (since 4.2.0)<br=
>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;<wbr>&#39;&#39;<br>
+<br>
+The &quot;autoload&quot; parameter has been ignored since 2.12.0. All bitm=
aps<br>
+are automatically loaded from qcow2 images.<br>
+<br>
+Related binaries<br>
+----------------<br>
+<br>
+``qemu-nbd --partition`` (removed in 5.0.0)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<wbr=
>&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The ``qemu-nbd --partition $digit`` code (also spelled ``-P``)<br>
+could only handle MBR partitions, and never correctly handled logical<br>
+partitions beyond partition 5.=C2=A0 Exporting a partition can still be<br=
>
+done by utilizing the ``--image-opts`` option with a raw blockdev<br>
+using the ``offset`` and ``size`` parameters layered on top of<br>
+any other existing blockdev. For example, if partition 1 is 100MiB<br>
+long starting at 1MiB, the old command::<br>
+<br>
+=C2=A0 qemu-nbd -t -P 1 -f qcow2 file.qcow2<br>
+<br>
+can be rewritten as::<br>
+<br>
+=C2=A0 qemu-nbd -t --image-opts driver=3Draw,offset=3D1M,size=3D<wbr>100M,=
file.driver=3Dqcow2,file.<wbr>file.driver=3Dfile,file.file.<wbr>filename=3D=
file.qcow2<br>
diff --git a/docs/system/index.rst b/docs/system/index.rst<br>
index 887bef92f40..7d09abca954 100644<br>
--- a/docs/system/index.rst<br>
+++ b/docs/system/index.rst<br>
@@ -14,6 +14,7 @@ Contents:<br>
=C2=A0.. toctree::<br>
=C2=A0 =C2=A0 :maxdepth: 2<br>
<br>
+=C2=A0 =C2=A0deprecated<br>
=C2=A0 =C2=A0 managed-startup<br>
=C2=A0 =C2=A0 qemu-block-drivers<br>
=C2=A0 =C2=A0 security<br>
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi<br>
deleted file mode 100644<br>
index 0671c26c806..00000000000<br>
--- a/qemu-deprecated.texi<br>
+++ /dev/null<br>
@@ -1,386 +0,0 @@<br>
-@node Deprecated features<br>
-@appendix Deprecated features<br>
-<br>
-In general features are intended to be supported indefinitely once<br>
-introduced into QEMU. In the event that a feature needs to be removed,<br>
-it will be listed in this appendix. The feature will remain functional<br>
-for 2 releases prior to actual removal. Deprecated features may also<br>
-generate warnings on the console when QEMU starts up, or if activated<br>
-via a monitor command, however, this is not a mandatory requirement.<br>
-<br>
-Prior to the 2.10.0 release there was no official policy on how<br>
-long features would be deprecated prior to their removal, nor<br>
-any documented list of which features were deprecated. Thus<br>
-any features deprecated prior to 2.10.0 will be treated as if<br>
-they were first deprecated in the 2.10.0 release.<br>
-<br>
-What follows is a list of all features currently marked as<br>
-deprecated.<br>
-<br>
-@section System emulator command line arguments<br>
-<br>
-@subsection -machine enforce-config-section=3Don|off (since 3.1)<br>
-<br>
-The @option{enforce-config-<wbr>section} parameter is replaced by the<br>
-@option{-global migration.send-configuration=3D@<wbr>var{on|off}} option.<=
br>
-<br>
-@subsection -no-kvm (since 1.3.0)<br>
-<br>
-The ``-no-kvm&#39;&#39; argument is now a synonym for setting ``-accel tcg=
&#39;&#39;.<br>
-<br>
-@subsection -usbdevice (since 2.10.0)<br>
-<br>
-The ``-usbdevice DEV&#39;&#39; argument is now a synonym for setting<br>
-the ``-device usb-DEV&#39;&#39; argument instead. The deprecated syntax<br=
>
-would automatically enable USB support on the machine type.<br>
-If using the new syntax, USB support must be explicitly<br>
-enabled via the ``-machine usb=3Don&#39;&#39; argument.<br>
-<br>
-@subsection -drive file=3Djson:@{...@{&#39;driver&#39;:&#39;<wbr>file&#39;=
@}@} (since 3.0)<br>
-<br>
-The &#39;file&#39; driver for drives is no longer appropriate for characte=
r or host<br>
-devices and will only accept regular files (S_IFREG). The correct driver<b=
r>
-for these file types is &#39;host_cdrom&#39; or &#39;host_device&#39; as a=
ppropriate.<br>
-<br>
-@subsection -net ...,name=3D@var{name} (since 3.1)<br>
-<br>
-The @option{name} parameter of the @option{-net} option is a synonym<br>
-for the @option{id} parameter, which should now be used instead.<br>
-<br>
-@subsection -smp (invalid topologies) (since 3.1)<br>
-<br>
-CPU topology properties should describe whole machine topology including<b=
r>
-possible CPUs.<br>
-<br>
-However, historically it was possible to start QEMU with an incorrect topo=
logy<br>
-where @math{@var{n} &lt;=3D @var{sockets} * @var{cores} * @var{threads} &l=
t; @var{maxcpus}},<br>
-which could lead to an incorrect topology enumeration by the guest.<br>
-Support for invalid topologies will be removed, the user must ensure<br>
-topologies described with -smp include all possible cpus, i.e.<br>
-=C2=A0 @math{@var{sockets} * @var{cores} * @var{threads} =3D @var{maxcpus}=
}.<br>
-<br>
-@subsection -vnc acl (since 4.0.0)<br>
-<br>
-The @code{acl} option to the @code{-vnc} argument has been replaced<br>
-by the @code{tls-authz} and @code{sasl-authz} options.<br>
-<br>
-@subsection QEMU_AUDIO_ environment variables and -audio-help (since 4.0)<=
br>
-<br>
-The ``-audiodev&#39;&#39; argument is now the preferred way to specify aud=
io<br>
-backend settings instead of environment variables.=C2=A0 To ease migration=
 to<br>
-the new format, the ``-audiodev-help&#39;&#39; option can be used to conve=
rt<br>
-the current values of the environment variables to ``-audiodev&#39;&#39; o=
ptions.<br>
-<br>
-@subsection Creating sound card devices and vnc without audiodev=3D proper=
ty (since 4.2)<br>
-<br>
-When not using the deprecated legacy audio config, each sound card<br>
-should specify an @code{audiodev=3D} property.=C2=A0 Additionally, when us=
ing<br>
-vnc, you should specify an @code{audiodev=3D} propery if you plan to<br>
-transmit audio through the VNC protocol.<br>
-<br>
-@subsection -mon ...,control=3Dreadline,pretty=3D<wbr>on|off (since 4.1)<b=
r>
-<br>
-The @code{pretty=3Don|off} switch has no effect for HMP monitors, but is<b=
r>
-silently ignored. Using the switch with HMP monitors will become an<br>
-error in the future.<br>
-<br>
-@subsection -realtime (since 4.1)<br>
-<br>
-The @code{-realtime mlock=3Don|off} argument has been replaced by the<br>
-@code{-overcommit mem-lock=3Don|off} argument.<br>
-<br>
-@subsection -numa node,mem=3D@var{size} (since 4.1)<br>
-<br>
-The parameter @option{mem} of @option{-numa node} is used to assign a part=
 of<br>
-guest RAM to a NUMA node. But when using it, it&#39;s impossible to manage=
 specified<br>
-RAM chunk on the host side (like bind it to a host node, setting bind poli=
cy, ...),<br>
-so guest end-ups with the fake NUMA configuration with suboptiomal perform=
ance.<br>
-However since 2014 there is an alternative way to assign RAM to a NUMA nod=
e<br>
-using parameter @option{memdev}, which does the same as @option{mem} and a=
dds<br>
-means to actualy manage node RAM on the host side. Use parameter @option{m=
emdev}<br>
-with @var{memory-backend-ram} backend as an replacement for parameter @opt=
ion{mem}<br>
-to achieve the same fake NUMA effect or a properly configured<br>
-@var{memory-backend-file} backend to actually benefit from NUMA configurat=
ion.<br>
-In future new machine versions will not accept the option but it will stil=
l<br>
-work with old machine types. User can check QAPI schema to see if the lega=
cy<br>
-option is supported by looking at MachineInfo::numa-mem-<wbr>supported pro=
perty.<br>
-<br>
-@subsection -numa node (without memory specified) (since 4.1)<br>
-<br>
-Splitting RAM by default between NUMA nodes has the same issues as @option=
{mem}<br>
-parameter described above with the difference that the role of the user pl=
ays<br>
-QEMU using implicit generic or board specific splitting rule.<br>
-Use @option{memdev} with @var{memory-backend-ram} backend or @option{mem} =
(if<br>
-it&#39;s supported by used machine type) to define mapping explictly inste=
ad.<br>
-<br>
-@subsection -mem-path fallback to RAM (since 4.1)<br>
-Currently if guest RAM allocation from file pointed by @option{mem-path}<b=
r>
-fails, QEMU falls back to allocating from RAM, which might result<br>
-in unpredictable behavior since the backing file specified by the user<br>
-is ignored. In the future, users will be responsible for making sure<br>
-the backing storage specified with @option{-mem-path} can actually provide=
<br>
-the guest RAM configured with @option{-m} and QEMU will fail to start up i=
f<br>
-RAM allocation is unsuccessful.<br>
-<br>
-@subsection RISC-V -bios (since 4.1)<br>
-<br>
-QEMU 4.1 introduced support for the -bios option in QEMU for RISC-V for th=
e<br>
-RISC-V virt machine and sifive_u machine.<br>
-<br>
-QEMU 4.1 has no changes to the default behaviour to avoid breakages. This<=
br>
-default will change in a future QEMU release, so please prepare now. All u=
sers<br>
-of the virt or sifive_u machine must change their command line usage.<br>
-<br>
-QEMU 4.1 has three options, please migrate to one of these three:<br>
- 1. ``-bios none`` - This is the current default behavior if no -bios opti=
on<br>
-=C2=A0 =C2=A0 =C2=A0 is included. QEMU will not automatically load any fir=
mware. It is up<br>
-=C2=A0 =C2=A0 =C2=A0 to the user to load all the images they need.<br>
- 2. ``-bios default`` - In a future QEMU release this will become the defa=
ult<br>
-=C2=A0 =C2=A0 =C2=A0 behaviour if no -bios option is specified. This optio=
n will load the<br>
-=C2=A0 =C2=A0 =C2=A0 default OpenSBI firmware automatically. The firmware =
is included with<br>
-=C2=A0 =C2=A0 =C2=A0 the QEMU release and no user interaction is required.=
 All a user needs<br>
-=C2=A0 =C2=A0 =C2=A0 to do is specify the kernel they want to boot with th=
e -kernel option<br>
- 3. ``-bios &lt;file&gt;`` - Tells QEMU to load the specified file as the =
firmwrae.<br>
-<br>
-@subsection -tb-size option (since 5.0)<br>
-<br>
-QEMU 5.0 introduced an alternative syntax to specify the size of the trans=
lation<br>
-block cache, @option{-accel tcg,tb-size=3D}.=C2=A0 The new syntax deprecat=
es the<br>
-previously available @option{-tb-size} option.<br>
-<br>
-@subsection -show-cursor option (since 5.0)<br>
-<br>
-Use @option{-display sdl,show-cursor=3Don} or<br>
- @option{-display gtk,show-cursor=3Don} instead.<br>
-<br>
-@section QEMU Machine Protocol (QMP) commands<br>
-<br>
-@subsection change (since 2.5.0)<br>
-<br>
-Use ``blockdev-change-medium&#39;&#39; or ``change-vnc-password&#39;&#39; =
instead.<br>
-<br>
-@subsection migrate_set_downtime and migrate_set_speed (since 2.8.0)<br>
-<br>
-Use ``migrate-set-parameters&#39;&#39; instead.<br>
-<br>
-@subsection migrate-set-cache-size and query-migrate-cache-size (since 2.1=
1.0)<br>
-<br>
-Use ``migrate-set-parameters&#39;&#39; and ``query-migrate-parameters&#39;=
&#39; instead.<br>
-<br>
-@subsection query-block result field dirty-bitmaps[i].status (since 4.0)<b=
r>
-<br>
-The ``status&#39;&#39; field of the ``BlockDirtyInfo&#39;&#39; structure, =
returned by<br>
-the query-block command is deprecated. Two new boolean fields,<br>
-``recording&#39;&#39; and ``busy&#39;&#39; effectively replace it.<br>
-<br>
-@subsection query-block result field dirty-bitmaps (Since 4.2)<br>
-<br>
-The ``dirty-bitmaps`` field of the ``BlockInfo`` structure, returned by<br=
>
-the query-block command is itself now deprecated. The ``dirty-bitmaps``<br=
>
-field of the ``BlockDeviceInfo`` struct should be used instead, which is t=
he<br>
-type of the ``inserted`` field in query-block replies, as well as the<br>
-type of array items in query-named-block-nodes.<br>
-<br>
-Since the ``dirty-bitmaps`` field is optionally present in both the old an=
d<br>
-new locations, clients must use introspection to learn where to anticipate=
<br>
-the field if/when it does appear in command output.<br>
-<br>
-@subsection query-cpus (since 2.12.0)<br>
-<br>
-The ``query-cpus&#39;&#39; command is replaced by the ``query-cpus-fast&#3=
9;&#39; command.<br>
-<br>
-@subsection query-cpus-fast &quot;arch&quot; output member (since 3.0.0)<b=
r>
-<br>
-The ``arch&#39;&#39; output member of the ``query-cpus-fast&#39;&#39; comm=
and is<br>
-replaced by the ``target&#39;&#39; output member.<br>
-<br>
-@subsection cpu-add (since 4.0)<br>
-<br>
-Use ``device_add&#39;&#39; for hotplugging vCPUs instead of ``cpu-add&#39;=
&#39;.=C2=A0 See<br>
-documentation of ``query-hotpluggable-cpus&#39;&#39; for additional<br>
-details.<br>
-<br>
-@subsection query-events (since 4.0)<br>
-<br>
-The ``query-events&#39;&#39; command has been superseded by the more power=
ful<br>
-and accurate ``query-qmp-schema&#39;&#39; command.<br>
-<br>
-@subsection chardev client socket with &#39;wait&#39; option (since 4.0)<b=
r>
-<br>
-Character devices creating sockets in client mode should not specify<br>
-the &#39;wait&#39; field, which is only applicable to sockets in server mo=
de<br>
-<br>
-@section Human Monitor Protocol (HMP) commands<br>
-<br>
-@subsection The hub_id parameter of &#39;hostfwd_add&#39; / &#39;hostfwd_r=
emove&#39; (since 3.1)<br>
-<br>
-The @option{[hub_id name]} parameter tuple of the &#39;hostfwd_add&#39; an=
d<br>
-&#39;hostfwd_remove&#39; HMP commands has been replaced by @option{netdev_=
id}.<br>
-<br>
-@subsection cpu-add (since 4.0)<br>
-<br>
-Use ``device_add&#39;&#39; for hotplugging vCPUs instead of ``cpu-add&#39;=
&#39;.=C2=A0 See<br>
-documentation of ``query-hotpluggable-cpus&#39;&#39; for additional detail=
s.<br>
-<br>
-@subsection acl_show, acl_reset, acl_policy, acl_add, acl_remove (since 4.=
0.0)<br>
-<br>
-The ``acl_show&#39;&#39;, ``acl_reset&#39;&#39;, ``acl_policy&#39;&#39;, `=
`acl_add&#39;&#39;, and<br>
-``acl_remove&#39;&#39; commands are deprecated with no replacement. Author=
ization<br>
-for VNC should be performed using the pluggable QAuthZ objects.<br>
-<br>
-@section Guest Emulator ISAs<br>
-<br>
-@subsection RISC-V ISA privledge specification version 1.09.1 (since 4.1)<=
br>
-<br>
-The RISC-V ISA privledge specification version 1.09.1 has been deprecated.=
<br>
-QEMU supports both the newer version 1.10.0 and the ratified version 1.11.=
0, these<br>
-should be used instead of the 1.09.1 version.<br>
-<br>
-@section System emulator CPUS<br>
-<br>
-@subsection RISC-V ISA CPUs (since 4.1)<br>
-<br>
-The RISC-V cpus with the ISA version in the CPU name have been depcreated.=
 The<br>
-four CPUs are: ``rv32gcsu-v1.9.1``, ``rv32gcsu-v1.10.0``, ``rv64gcsu-v1.9.=
1`` and<br>
-``rv64gcsu-v1.10.0``. Instead the version can be specified via the CPU ``p=
riv_spec``<br>
-option when using the ``rv32`` or ``rv64`` CPUs.<br>
-<br>
-@subsection RISC-V ISA CPUs (since 4.1)<br>
-<br>
-The RISC-V no MMU cpus have been depcreated. The two CPUs: ``rv32imacu-nom=
mu`` and<br>
-``rv64imacu-nommu`` should no longer be used. Instead the MMU status can b=
e specified<br>
-via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.<br>
-<br>
-@section System emulator devices<br>
-<br>
-@subsection ide-drive (since 4.2)<br>
-<br>
-The &#39;ide-drive&#39; device is deprecated. Users should use &#39;ide-hd=
&#39; or<br>
-&#39;ide-cd&#39; as appropriate to get an IDE hard disk or CD-ROM as neede=
d.<br>
-<br>
-@subsection scsi-disk (since 4.2)<br>
-<br>
-The &#39;scsi-disk&#39; device is deprecated. Users should use &#39;scsi-h=
d&#39; or<br>
-&#39;scsi-cd&#39; as appropriate to get a SCSI hard disk or CD-ROM as need=
ed.<br>
-<br>
-@section System emulator machines<br>
-<br>
-@subsection mips r4k platform (since 5.0)<br>
-<br>
-This machine type is very old and unmaintained. Users should use the &#39;=
malta&#39;<br>
-machine type instead.<br>
-<br>
-@subsection pc-1.0, pc-1.1, pc-1.2 and pc-1.3 (since 5.0)<br>
-<br>
-These machine types are very old and likely can not be used for live migra=
tion<br>
-from old QEMU versions anymore. A newer machine type should be used instea=
d.<br>
-<br>
-@subsection spike_v1.9.1 and spike_v1.10 (since 4.1)<br>
-<br>
-The version specific Spike machines have been deprecated in favour of the<=
br>
-generic ``spike`` machine. If you need to specify an older version of the =
RISC-V<br>
-spec you can use the ``-cpu rv64gcsu,priv_spec=3Dv1.9.1`` command line arg=
ument.<br>
-<br>
-@section Device options<br>
-<br>
-@subsection Emulated device options<br>
-<br>
-@subsubsection -device virtio-blk,scsi=3Don|off (since 5.0.0)<br>
-<br>
-The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.=C2=A0 =
VIRTIO 1.0<br>
-and later do not support it because the virtio-scsi device was introduced =
for<br>
-full SCSI support.=C2=A0 Use virtio-scsi instead when SCSI passthrough is =
required.<br>
-<br>
-Note this also applies to ``-device virtio-blk-pci,scsi=3Don|off&#39;&#39;=
, which is an<br>
-alias.<br>
-<br>
-@subsection Block device options<br>
-<br>
-@subsubsection &quot;backing&quot;: &quot;&quot; (since 2.12.0)<br>
-<br>
-In order to prevent QEMU from automatically opening an image&#39;s backing=
<br>
-chain, use ``&quot;backing&quot;: null&#39;&#39; instead.<br>
-<br>
-@subsubsection rbd keyvalue pair encoded filenames: &quot;&quot; (since 3.=
1.0)<br>
-<br>
-Options for ``rbd&#39;&#39; should be specified according to its runtime o=
ptions,<br>
-like other block drivers.=C2=A0 Legacy parsing of keyvalue pair encoded<br=
>
-filenames is useful to open images with the old format for backing files;<=
br>
-These image files should be updated to use the current format.<br>
-<br>
-Example of legacy encoding:<br>
-<br>
-@code{json:@{&quot;file.driver&quot;:&quot;<wbr>rbd&quot;, &quot;file.file=
name&quot;:&quot;rbd:rbd/name&quot;<wbr>@}}<br>
-<br>
-The above, converted to the current supported format:<br>
-<br>
-@code{json:@{&quot;file.driver&quot;:&quot;<wbr>rbd&quot;, &quot;file.pool=
&quot;:&quot;rbd&quot;, &quot;file.image&quot;:&quot;name&quot;@}}<br>
-<br>
-@section Related binaries<br>
-<br>
-@subsection qemu-img convert -n -o (since 4.2.0)<br>
-<br>
-All options specified in @option{-o} are image creation options, so<br>
-they have no effect when used with @option{-n} to skip image creation.<br>
-Silently ignored options can be confusing, so this combination of<br>
-options will be made an error in future versions.<br>
-<br>
-@section Backwards compatibility<br>
-<br>
-@subsection Runnability guarantee of CPU models (since 4.1.0)<br>
-<br>
-Previous versions of QEMU never changed existing CPU models in<br>
-ways that introduced additional host software or hardware<br>
-requirements to the VM.=C2=A0 This allowed management software to<br>
-safely change the machine type of an existing VM without<br>
-introducing new requirements (&quot;runnability guarantee&quot;).=C2=A0 Th=
is<br>
-prevented CPU models from being updated to include CPU<br>
-vulnerability mitigations, leaving guests vulnerable in the<br>
-default configuration.<br>
-<br>
-The CPU model runnability guarantee won&#39;t apply anymore to<br>
-existing CPU models.=C2=A0 Management software that needs runnability<br>
-guarantees must resolve the CPU model aliases using te<br>
-``alias-of&#39;&#39; field returned by the ``query-cpu-definitions&#39;&#3=
9; QMP<br>
-command.<br>
-<br>
-While those guarantees are kept, the return value of<br>
-``query-cpu-definitions&#39;&#39; will have existing CPU model aliases<br>
-point to a version that doesn&#39;t break runnability guarantees<br>
-(specifically, version 1 of those CPU models).=C2=A0 In future QEMU<br>
-versions, aliases will point to newer CPU model versions<br>
-depending on the machine type, so management software must<br>
-resolve CPU model aliases before starting a virtual machine.<br>
-<br>
-<br>
-@node Recently removed features<br>
-@appendix Recently removed features<br>
-<br>
-What follows is a record of recently removed, formerly deprecated<br>
-features that serves as a record for users who have encountered<br>
-trouble after a recent upgrade.<br>
-<br>
-@section QEMU Machine Protocol (QMP) commands<br>
-<br>
-@subsection block-dirty-bitmap-add &quot;autoload&quot; parameter (since 4=
.2.0)<br>
-<br>
-The &quot;autoload&quot; parameter has been ignored since 2.12.0. All bitm=
aps<br>
-are automatically loaded from qcow2 images.<br>
-<br>
-@section Related binaries<br>
-<br>
-@subsection qemu-nbd --partition (removed in 5.0.0)<br>
-<br>
-The ``qemu-nbd --partition $digit&#39;&#39; code (also spelled @option{-P}=
)<br>
-could only handle MBR partitions, and never correctly handled logical<br>
-partitions beyond partition 5.=C2=A0 Exporting a partition can still be<br=
>
-done by utilizing the @option{--image-opts} option with a raw blockdev<br>
-using the @code{offset} and @code{size} parameters layered on top of<br>
-any other existing blockdev. For example, if partition 1 is 100MiB<br>
-long starting at 1MiB, the old command:<br>
-<br>
-@code{qemu-nbd -t -P 1 -f qcow2 file.qcow2}<br>
-<br>
-can be rewritten as:<br>
-<br>
-@code{qemu-nbd -t --image-opts driver=3Draw,offset=3D1M,size=3D<wbr>100M,f=
ile.driver=3Dqcow2,file.<wbr>file.driver=3Dfile,file.file.<wbr>filename=3Df=
ile.qcow2}<br>
diff --git a/qemu-doc.texi b/qemu-doc.texi<br>
index 7798e072a1c..6bb1fd54c03 100644<br>
--- a/qemu-doc.texi<br>
+++ b/qemu-doc.texi<br>
@@ -40,8 +40,6 @@<br>
=C2=A0* QEMU System emulator for non PC targets::<br>
=C2=A0* QEMU User space emulator::<br>
=C2=A0* System requirements::<br>
-* Deprecated features::<br>
-* Recently removed features::<br>
=C2=A0* Supported build platforms::<br>
=C2=A0* License::<br>
=C2=A0* Index::<br>
@@ -2834,8 +2832,6 @@ added with Linux 4.5 which is supported by the major =
distros. And even<br>
=C2=A0if RHEL7 has kernel 3.10, KVM there has the required functionality th=
ere<br>
=C2=A0to make it close to a 4.5 or newer kernel.<br>
<br>
-@include qemu-deprecated.texi<br>
-<br>
=C2=A0@node Supported build platforms<br>
=C2=A0@appendix Supported build platforms<br>
=C2=A0<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote>

--000000000000d0ed8c059f78d87f--

