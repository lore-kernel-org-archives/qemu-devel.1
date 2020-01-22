Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABFFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 19:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB6821835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 19:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eU6/oNcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB6821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuLH4-0005mD-AR
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 14:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iuLEz-0004UL-3p
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 14:00:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iuLEp-0000Mf-DS
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 14:00:37 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iuLEo-0000Li-EI
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 14:00:27 -0500
Received: by mail-wm1-x341.google.com with SMTP id t23so216441wmi.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 11:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=t+BJeT3WYyS+RcjUkXgRajZ7e5ueMA3mQaVw3tajJ3I=;
 b=eU6/oNcqNBGjeiwFA6WV1WoKs9YaHvBxJp7XnUlF0uWilN6i/lA+RxxZrZEjlLlUV/
 noAHPvQwWYiW3ZIy6rClw2v7NPg1XiZzGJQub90dJIVZxJot7BorcQjrQ3TUNIMDjepV
 MygF0E/8KIAyPVBcnqPBJcXZq91OA7EmoDwt+hnHxF2PFbYT1tTcXmfssNJsvQzapRhG
 6YQCzkkxzayRbAs4tajfqyRNwGOmQcDcNl2Dk/BPS7Zpji2kmzlVJnUz711EZokAof2J
 M7kg2KPpBLuRewJqHBhvfWgeTk0BvaDqwTQwAiL+ZqdSoNBgAJIqJFVc6OKXEBubSrWO
 N7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=t+BJeT3WYyS+RcjUkXgRajZ7e5ueMA3mQaVw3tajJ3I=;
 b=gmKNlADib6WDiFwJ/+/LE/5tt+aBu1rt1sBo7Iq/CHtVA5wqZVTFhRsAlKWR7ph4ki
 5PbwUwPMiPYO5yQ+oFxuGF7sAL+jKg1uHu5QnWbDQlWPwff+eh59tx6qUXwlDc2TMx2I
 eMMh2LJidPWUTtzsuu3GSY0Qq1dXnOhVk7nm+c7dNE4h0YVJ09kBJ9e/Behvt8YiHmAA
 ZagDQd8S/T86mBhl4b3xxCsL/hQ/pmTesUPEr+HFXai0HzwjrTPgeFDSCRYNisk/gzNf
 F8UG3YeXC6K881LCrwi26tLty7S1GHP8Tl2wno5dFzEe9vI5PkP+dM+Rf4t5WYMVmF6s
 sfEA==
X-Gm-Message-State: APjAAAV2hgIT/LDy/GaFU0bWHGNVVBN1arhRxQpUVDRqHJQjHyzrc/16
 SlX2IDaYyV2DuLuqCA51HTSScg==
X-Google-Smtp-Source: APXvYqxYYcjHAjKyhJ0vreJ7RPBNPxRt//e/AMIcU7y6YPfdm/oCzdXO+LusJvb4qo799UQGzdAPAQ==
X-Received: by 2002:a1c:720a:: with SMTP id n10mr4374101wmc.74.1579719623786; 
 Wed, 22 Jan 2020 11:00:23 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a5sm5244621wmb.37.2020.01.22.11.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 11:00:22 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9E4AE1FF87;
 Wed, 22 Jan 2020 19:00:21 +0000 (GMT)
References: <20200116141511.16849-1-peter.maydell@linaro.org>
 <20200116141511.16849-4-peter.maydell@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/3] qemu-block-drivers: Convert to rST
In-reply-to: <20200116141511.16849-4-peter.maydell@linaro.org>
Date: Wed, 22 Jan 2020 19:00:21 +0000
Message-ID: <87eevrz58a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> The qemu-block-drivers documentation is currently in
> docs/qemu-block-drivers.texi in Texinfo format, which we present
> to the user as:
>  * a qemu-block-drivers manpage
>  * a section of the main qemu-doc HTML documentation
>
> Convert the documentation to rST format, and present it to
> the user as:
>  * a qemu-block-drivers manpage
>  * part of the system/ Sphinx manual
>
> This follows the same pattern we've done for qemu-ga and qemu-nbd.
>
> We have to drop a cross-reference from the documentation of the
> -cdrom option back to the qemu-block-drivers documentation, since
> they're no longer within the same texinfo document.
>
> As noted in a comment, the manpage output is slightly compromised
> due to limitations in Sphinx. In an ideal world, the HTML output
> would have the various headings like 'Disk image file formats'
> as top-level section headings (which then appear in the overall
> system manual's table-of-contents), and it would not have the
> section headings which make sense only for the manpage like
> 'synopsis', 'description', and 'see also'. Unfortunately, the
> mechanism Sphinx provides for restricting pieces of documentation
> is limited to the point of being flawed: the 'only::' directive
> is implemented as a filter that is applied at a very late stage
> in the document processing pipeline, rather than as an early
> equivalent of an #ifdef. This means that Sphinx's process of
> identifying which section heading markup styles are which levels
> of heading gets confused if the 'only::' directive contains
> section headings which would affect the heading-level of a
> later heading. I have opted to prioritise making the HTML format
> look better, with the compromise being that in the manpage
> the 'Disk image file formats' &c headings are top-level headings
> rather than being sub-headings under the traditional 'Description'
> top-level section title.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> I enquired on sphinx-users (without response so far)
> https://www.mail-archive.com/sphinx-users@googlegroups.com/msg03837.html
> whether there's a better approach than using 'only::' to delimit
> output for a specific format.  That directive seems fundamentally
> flawed because it's implemented as a filter very late in the document
> processing, so for instance text goes into the search index even if
> it's marked as not-for-HTML:
> https://github.com/sphinx-doc/sphinx/issues/1420
> What we want ideally would be some equivalent to #ifdef that happens
> early in the processing pipeline, but I'm not sure Sphinx has it and
> I'm not convinced that "run everything through the C preprocessor so
> we can use #ifdef" is worthwhile for the minor benefit here.
> ---
>  Makefile                           |  11 +-
>  docs/qemu-block-drivers.texi       | 889 --------------------------
>  docs/system/conf.py                |   7 +
>  docs/system/index.rst              |   1 +
>  docs/system/qemu-block-drivers.rst | 985 +++++++++++++++++++++++++++++
>  qemu-doc.texi                      |  12 -
>  qemu-options.hx                    |   2 +-
>  7 files changed, 1000 insertions(+), 907 deletions(-)
>  delete mode 100644 docs/qemu-block-drivers.texi
>  create mode 100644 docs/system/qemu-block-drivers.rst
>
> diff --git a/Makefile b/Makefile
> index 4372d0d1fbd..318d1046c6c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -342,9 +342,9 @@ ifdef BUILD_DOCS
>  DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1 qemu-img.1
>  DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-nbd.8
>  DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-ga.8
> +DOCS+=3D$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
>  DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt doc=
s/interop/qemu-qmp-ref.7
>  DOCS+=3Ddocs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/=
interop/qemu-ga-ref.7
> -DOCS+=3Ddocs/qemu-block-drivers.7
>  DOCS+=3Ddocs/qemu-cpu-models.7
>  DOCS+=3D$(MANUAL_BUILDDIR)/index.html
>  ifdef CONFIG_VIRTFS
> @@ -751,7 +751,6 @@ distclean: clean
>  	rm -f docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
>  	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
>  	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
> -	rm -f docs/qemu-block-drivers.7
>  	rm -f docs/qemu-cpu-models.7
>  	rm -rf .doctrees
>  	$(call clean-manual,devel)
> @@ -828,7 +827,7 @@ ifdef CONFIG_POSIX
>  	$(INSTALL_DATA) qemu.1 "$(DESTDIR)$(mandir)/man1"
>  	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
>  	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
> -	$(INSTALL_DATA) docs/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
> +	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7 "$(DESTD=
IR)$(mandir)/man7"
>  	$(INSTALL_DATA) docs/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
>  ifeq ($(CONFIG_TOOLS),y)
>  	$(INSTALL_DATA) qemu-img.1 "$(DESTDIR)$(mandir)/man1"
> @@ -1036,6 +1035,9 @@ $(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual=
-deps,interop)
>  $(MANUAL_BUILDDIR)/interop/qemu-nbd.8: $(call manual-deps,interop)
>  	$(call build-manual,interop,man)
>=20=20
> +$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7: $(call manual-deps,syste=
m)
> +	$(call build-manual,system,man)
> +
>  $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-versi=
on.h
>  	$(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, \
>               "GEN","$@")
> @@ -1062,7 +1064,6 @@ qemu.1: qemu-doc.texi qemu-options.texi qemu-monito=
r.texi qemu-monitor-info.texi
>  qemu.1: qemu-option-trace.texi
>  qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
>  fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
> -docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
>  docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
>  scripts/qemu-trace-stap.1: scripts/qemu-trace-stap.texi
>=20=20
> @@ -1075,7 +1076,7 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.t=
xt: \
>  	qemu-img.texi qemu-options.texi \
>  	qemu-tech.texi qemu-option-trace.texi \
>  	qemu-deprecated.texi qemu-monitor.texi qemu-img-cmds.texi \
> -	qemu-monitor-info.texi docs/qemu-block-drivers.texi \
> +	qemu-monitor-info.texi \
>  	docs/qemu-cpu-models.texi docs/security.texi
>=20=20
>  docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
> diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
> deleted file mode 100644
> index 2c7ea49c32d..00000000000
> --- a/docs/qemu-block-drivers.texi
> +++ /dev/null
> @@ -1,889 +0,0 @@
> -@c man begin SYNOPSIS
> -QEMU block driver reference manual
> -@c man end
> -
> -@set qemu_system qemu-system-x86_64
> -
> -@c man begin DESCRIPTION
> -
> -@node disk_images_formats
> -@subsection Disk image file formats
> -
> -QEMU supports many image file formats that can be used with VMs as well =
as with
> -any of the tools (like @code{qemu-img}). This includes the preferred for=
mats
> -raw and qcow2 as well as formats that are supported for compatibility wi=
th
> -older QEMU versions or other hypervisors.
> -
> -Depending on the image format, different options can be passed to
> -@code{qemu-img create} and @code{qemu-img convert} using the @code{-o} o=
ption.
> -This section describes each format and the options that are supported fo=
r it.
> -
> -@table @option
> -@item raw
> -
> -Raw disk image format. This format has the advantage of
> -being simple and easily exportable to all other emulators. If your
> -file system supports @emph{holes} (for example in ext2 or ext3 on
> -Linux or NTFS on Windows), then only the written sectors will reserve
> -space. Use @code{qemu-img info} to know the real size used by the
> -image or @code{ls -ls} on Unix/Linux.
> -
> -Supported options:
> -@table @code
> -@item preallocation
> -Preallocation mode (allowed values: @code{off}, @code{falloc}, @code{ful=
l}).
> -@code{falloc} mode preallocates space for image by calling posix_falloca=
te().
> -@code{full} mode preallocates space for image by writing data to underly=
ing
> -storage.  This data may or may not be zero, depending on the storage loc=
ation.
> -@end table
> -
> -@item qcow2
> -QEMU image format, the most versatile format. Use it to have smaller
> -images (useful if your filesystem does not supports holes, for example
> -on Windows), zlib based compression and support of multiple VM
> -snapshots.
> -
> -Supported options:
> -@table @code
> -@item compat
> -Determines the qcow2 version to use. @code{compat=3D0.10} uses the
> -traditional image format that can be read by any QEMU since 0.10.
> -@code{compat=3D1.1} enables image format extensions that only QEMU 1.1 a=
nd
> -newer understand (this is the default). Amongst others, this includes
> -zero clusters, which allow efficient copy-on-read for sparse images.
> -
> -@item backing_file
> -File name of a base image (see @option{create} subcommand)
> -@item backing_fmt
> -Image format of the base image
> -@item encryption
> -This option is deprecated and equivalent to @code{encrypt.format=3Daes}
> -
> -@item encrypt.format
> -
> -If this is set to @code{luks}, it requests that the qcow2 payload (not
> -qcow2 header) be encrypted using the LUKS format. The passphrase to
> -use to unlock the LUKS key slot is given by the @code{encrypt.key-secret}
> -parameter. LUKS encryption parameters can be tuned with the other
> -@code{encrypt.*} parameters.
> -
> -If this is set to @code{aes}, the image is encrypted with 128-bit AES-CB=
C.
> -The encryption key is given by the @code{encrypt.key-secret} parameter.
> -This encryption format is considered to be flawed by modern cryptography
> -standards, suffering from a number of design problems:
> -
> -@itemize @minus
> -@item The AES-CBC cipher is used with predictable initialization vectors=
 based
> -on the sector number. This makes it vulnerable to chosen plaintext attac=
ks
> -which can reveal the existence of encrypted data.
> -@item The user passphrase is directly used as the encryption key. A poor=
ly
> -chosen or short passphrase will compromise the security of the encryptio=
n.
> -@item In the event of the passphrase being compromised there is no way to
> -change the passphrase to protect data in any qcow images. The files must
> -be cloned, using a different encryption passphrase in the new file. The
> -original file must then be securely erased using a program like shred,
> -though even this is ineffective with many modern storage technologies.
> -@end itemize
> -
> -The use of this is no longer supported in system emulators. Support only
> -remains in the command line utilities, for the purposes of data liberati=
on
> -and interoperability with old versions of QEMU. The @code{luks} format
> -should be used instead.
> -
> -@item encrypt.key-secret
> -
> -Provides the ID of a @code{secret} object that contains the passphrase
> -(@code{encrypt.format=3Dluks}) or encryption key (@code{encrypt.format=
=3Daes}).
> -
> -@item encrypt.cipher-alg
> -
> -Name of the cipher algorithm and key length. Currently defaults
> -to @code{aes-256}. Only used when @code{encrypt.format=3Dluks}.
> -
> -@item encrypt.cipher-mode
> -
> -Name of the encryption mode to use. Currently defaults to @code{xts}.
> -Only used when @code{encrypt.format=3Dluks}.
> -
> -@item encrypt.ivgen-alg
> -
> -Name of the initialization vector generator algorithm. Currently defaults
> -to @code{plain64}. Only used when @code{encrypt.format=3Dluks}.
> -
> -@item encrypt.ivgen-hash-alg
> -
> -Name of the hash algorithm to use with the initialization vector generat=
or
> -(if required). Defaults to @code{sha256}. Only used when @code{encrypt.f=
ormat=3Dluks}.
> -
> -@item encrypt.hash-alg
> -
> -Name of the hash algorithm to use for PBKDF algorithm
> -Defaults to @code{sha256}. Only used when @code{encrypt.format=3Dluks}.
> -
> -@item encrypt.iter-time
> -
> -Amount of time, in milliseconds, to use for PBKDF algorithm per key slot.
> -Defaults to @code{2000}. Only used when @code{encrypt.format=3Dluks}.
> -
> -@item cluster_size
> -Changes the qcow2 cluster size (must be between 512 and 2M). Smaller clu=
ster
> -sizes can improve the image file size whereas larger cluster sizes gener=
ally
> -provide better performance.
> -
> -@item preallocation
> -Preallocation mode (allowed values: @code{off}, @code{metadata}, @code{f=
alloc},
> -@code{full}). An image with preallocated metadata is initially larger bu=
t can
> -improve performance when the image needs to grow. @code{falloc} and @cod=
e{full}
> -preallocations are like the same options of @code{raw} format, but sets =
up
> -metadata also.
> -
> -@item lazy_refcounts
> -If this option is set to @code{on}, reference count updates are postpone=
d with
> -the goal of avoiding metadata I/O and improving performance. This is
> -particularly interesting with @option{cache=3Dwritethrough} which doesn'=
t batch
> -metadata updates. The tradeoff is that after a host crash, the reference=
 count
> -tables must be rebuilt, i.e. on the next open an (automatic) @code{qemu-=
img
> -check -r all} is required, which may take some time.
> -
> -This option can only be enabled if @code{compat=3D1.1} is specified.
> -
> -@item nocow
> -If this option is set to @code{on}, it will turn off COW of the file. It=
's only
> -valid on btrfs, no effect on other file systems.
> -
> -Btrfs has low performance when hosting a VM image file, even more when t=
he guest
> -on the VM also using btrfs as file system. Turning off COW is a way to m=
itigate
> -this bad performance. Generally there are two ways to turn off COW on bt=
rfs:
> -a) Disable it by mounting with nodatacow, then all newly created files w=
ill be
> -NOCOW. b) For an empty file, add the NOCOW file attribute. That's what t=
his option
> -does.
> -
> -Note: this option is only valid to new or empty files. If there is an ex=
isting
> -file which is COW and has data blocks already, it couldn't be changed to=
 NOCOW
> -by setting @code{nocow=3Don}. One can issue @code{lsattr filename} to ch=
eck if
> -the NOCOW flag is set or not (Capital 'C' is NOCOW flag).
> -
> -@end table
> -
> -@item qed
> -Old QEMU image format with support for backing files and compact image f=
iles
> -(when your filesystem or transport medium does not support holes).
> -
> -When converting QED images to qcow2, you might want to consider using the
> -@code{lazy_refcounts=3Don} option to get a more QED-like behaviour.
> -
> -Supported options:
> -@table @code
> -@item backing_file
> -File name of a base image (see @option{create} subcommand).
> -@item backing_fmt
> -Image file format of backing file (optional).  Useful if the format cann=
ot be
> -autodetected because it has no header, like some vhd/vpc files.
> -@item cluster_size
> -Changes the cluster size (must be power-of-2 between 4K and 64K). Smaller
> -cluster sizes can improve the image file size whereas larger cluster siz=
es
> -generally provide better performance.
> -@item table_size
> -Changes the number of clusters per L1/L2 table (must be power-of-2 betwe=
en 1
> -and 16).  There is normally no need to change this value but this option=
 can be
> -used for performance benchmarking.
> -@end table
> -
> -@item qcow
> -Old QEMU image format with support for backing files, compact image file=
s,
> -encryption and compression.
> -
> -Supported options:
> -@table @code
> -@item backing_file
> -File name of a base image (see @option{create} subcommand)
> -@item encryption
> -This option is deprecated and equivalent to @code{encrypt.format=3Daes}
> -
> -@item encrypt.format
> -If this is set to @code{aes}, the image is encrypted with 128-bit AES-CB=
C.
> -The encryption key is given by the @code{encrypt.key-secret} parameter.
> -This encryption format is considered to be flawed by modern cryptography
> -standards, suffering from a number of design problems enumerated previou=
sly
> -against the @code{qcow2} image format.
> -
> -The use of this is no longer supported in system emulators. Support only
> -remains in the command line utilities, for the purposes of data liberati=
on
> -and interoperability with old versions of QEMU.
> -
> -Users requiring native encryption should use the @code{qcow2} format
> -instead with @code{encrypt.format=3Dluks}.
> -
> -@item encrypt.key-secret
> -
> -Provides the ID of a @code{secret} object that contains the encryption
> -key (@code{encrypt.format=3Daes}).
> -
> -@end table
> -
> -@item luks
> -
> -LUKS v1 encryption format, compatible with Linux dm-crypt/cryptsetup
> -
> -Supported options:
> -@table @code
> -
> -@item key-secret
> -
> -Provides the ID of a @code{secret} object that contains the passphrase.
> -
> -@item cipher-alg
> -
> -Name of the cipher algorithm and key length. Currently defaults
> -to @code{aes-256}.
> -
> -@item cipher-mode
> -
> -Name of the encryption mode to use. Currently defaults to @code{xts}.
> -
> -@item ivgen-alg
> -
> -Name of the initialization vector generator algorithm. Currently defaults
> -to @code{plain64}.
> -
> -@item ivgen-hash-alg
> -
> -Name of the hash algorithm to use with the initialization vector generat=
or
> -(if required). Defaults to @code{sha256}.
> -
> -@item hash-alg
> -
> -Name of the hash algorithm to use for PBKDF algorithm
> -Defaults to @code{sha256}.
> -
> -@item iter-time
> -
> -Amount of time, in milliseconds, to use for PBKDF algorithm per key slot.
> -Defaults to @code{2000}.
> -
> -@end table
> -
> -@item vdi
> -VirtualBox 1.1 compatible image format.
> -Supported options:
> -@table @code
> -@item static
> -If this option is set to @code{on}, the image is created with metadata
> -preallocation.
> -@end table
> -
> -@item vmdk
> -VMware 3 and 4 compatible image format.
> -
> -Supported options:
> -@table @code
> -@item backing_file
> -File name of a base image (see @option{create} subcommand).
> -@item compat6
> -Create a VMDK version 6 image (instead of version 4)
> -@item hwversion
> -Specify vmdk virtual hardware version. Compat6 flag cannot be enabled
> -if hwversion is specified.
> -@item subformat
> -Specifies which VMDK subformat to use. Valid options are
> -@code{monolithicSparse} (default),
> -@code{monolithicFlat},
> -@code{twoGbMaxExtentSparse},
> -@code{twoGbMaxExtentFlat} and
> -@code{streamOptimized}.
> -@end table
> -
> -@item vpc
> -VirtualPC compatible image format (VHD).
> -Supported options:
> -@table @code
> -@item subformat
> -Specifies which VHD subformat to use. Valid options are
> -@code{dynamic} (default) and @code{fixed}.
> -@end table
> -
> -@item VHDX
> -Hyper-V compatible image format (VHDX).
> -Supported options:
> -@table @code
> -@item subformat
> -Specifies which VHDX subformat to use. Valid options are
> -@code{dynamic} (default) and @code{fixed}.
> -@item block_state_zero
> -Force use of payload blocks of type 'ZERO'.  Can be set to @code{on} (de=
fault)
> -or @code{off}.  When set to @code{off}, new blocks will be created as
> -@code{PAYLOAD_BLOCK_NOT_PRESENT}, which means parsers are free to return
> -arbitrary data for those blocks.  Do not set to @code{off} when using
> -@code{qemu-img convert} with @code{subformat=3Ddynamic}.
> -@item block_size
> -Block size; min 1 MB, max 256 MB.  0 means auto-calculate based on image=
 size.
> -@item log_size
> -Log size; min 1 MB.
> -@end table
> -@end table
> -
> -@subsubsection Read-only formats
> -More disk image file formats are supported in a read-only mode.
> -@table @option
> -@item bochs
> -Bochs images of @code{growing} type.
> -@item cloop
> -Linux Compressed Loop image, useful only to reuse directly compressed
> -CD-ROM images present for example in the Knoppix CD-ROMs.
> -@item dmg
> -Apple disk image.
> -@item parallels
> -Parallels disk image format.
> -@end table
> -
> -
> -@node host_drives
> -@subsection Using host drives
> -
> -In addition to disk image files, QEMU can directly access host
> -devices. We describe here the usage for QEMU version >=3D 0.8.3.
> -
> -@subsubsection Linux
> -
> -On Linux, you can directly use the host device filename instead of a
> -disk image filename provided you have enough privileges to access
> -it. For example, use @file{/dev/cdrom} to access to the CDROM.
> -
> -@table @code
> -@item CD
> -You can specify a CDROM device even if no CDROM is loaded. QEMU has
> -specific code to detect CDROM insertion or removal. CDROM ejection by
> -the guest OS is supported. Currently only data CDs are supported.
> -@item Floppy
> -You can specify a floppy device even if no floppy is loaded. Floppy
> -removal is currently not detected accurately (if you change floppy
> -without doing floppy access while the floppy is not loaded, the guest
> -OS will think that the same floppy is loaded).
> -Use of the host's floppy device is deprecated, and support for it will
> -be removed in a future release.
> -@item Hard disks
> -Hard disks can be used. Normally you must specify the whole disk
> -(@file{/dev/hdb} instead of @file{/dev/hdb1}) so that the guest OS can
> -see it as a partitioned disk. WARNING: unless you know what you do, it
> -is better to only make READ-ONLY accesses to the hard disk otherwise
> -you may corrupt your host data (use the @option{-snapshot} command
> -line option or modify the device permissions accordingly).
> -@end table
> -
> -@subsubsection Windows
> -
> -@table @code
> -@item CD
> -The preferred syntax is the drive letter (e.g. @file{d:}). The
> -alternate syntax @file{\\.\d:} is supported. @file{/dev/cdrom} is
> -supported as an alias to the first CDROM drive.
> -
> -Currently there is no specific code to handle removable media, so it
> -is better to use the @code{change} or @code{eject} monitor commands to
> -change or eject media.
> -@item Hard disks
> -Hard disks can be used with the syntax: @file{\\.\PhysicalDrive@var{N}}
> -where @var{N} is the drive number (0 is the first hard disk).
> -
> -WARNING: unless you know what you do, it is better to only make
> -READ-ONLY accesses to the hard disk otherwise you may corrupt your
> -host data (use the @option{-snapshot} command line so that the
> -modifications are written in a temporary file).
> -@end table
> -
> -
> -@subsubsection Mac OS X
> -
> -@file{/dev/cdrom} is an alias to the first CDROM.
> -
> -Currently there is no specific code to handle removable media, so it
> -is better to use the @code{change} or @code{eject} monitor commands to
> -change or eject media.
> -
> -@node disk_images_fat_images
> -@subsection Virtual FAT disk images
> -
> -QEMU can automatically create a virtual FAT disk image from a
> -directory tree. In order to use it, just type:
> -
> -@example
> -@value{qemu_system} linux.img -hdb fat:/my_directory
> -@end example
> -
> -Then you access access to all the files in the @file{/my_directory}
> -directory without having to copy them in a disk image or to export
> -them via SAMBA or NFS. The default access is @emph{read-only}.
> -
> -Floppies can be emulated with the @code{:floppy:} option:
> -
> -@example
> -@value{qemu_system} linux.img -fda fat:floppy:/my_directory
> -@end example
> -
> -A read/write support is available for testing (beta stage) with the
> -@code{:rw:} option:
> -
> -@example
> -@value{qemu_system} linux.img -fda fat:floppy:rw:/my_directory
> -@end example
> -
> -What you should @emph{never} do:
> -@itemize
> -@item use non-ASCII filenames ;
> -@item use "-snapshot" together with ":rw:" ;
> -@item expect it to work when loadvm'ing ;
> -@item write to the FAT directory on the host system while accessing it w=
ith the guest system.
> -@end itemize
> -
> -@node disk_images_nbd
> -@subsection NBD access
> -
> -QEMU can access directly to block device exported using the Network Bloc=
k Device
> -protocol.
> -
> -@example
> -@value{qemu_system} linux.img -hdb nbd://my_nbd_server.mydomain.org:1024/
> -@end example
> -
> -If the NBD server is located on the same host, you can use an unix socke=
t instead
> -of an inet socket:
> -
> -@example
> -@value{qemu_system} linux.img -hdb nbd+unix://?socket=3D/tmp/my_socket
> -@end example
> -
> -In this case, the block device must be exported using qemu-nbd:
> -
> -@example
> -qemu-nbd --socket=3D/tmp/my_socket my_disk.qcow2
> -@end example
> -
> -The use of qemu-nbd allows sharing of a disk between several guests:
> -@example
> -qemu-nbd --socket=3D/tmp/my_socket --share=3D2 my_disk.qcow2
> -@end example
> -
> -@noindent
> -and then you can use it with two guests:
> -@example
> -@value{qemu_system} linux1.img -hdb nbd+unix://?socket=3D/tmp/my_socket
> -@value{qemu_system} linux2.img -hdb nbd+unix://?socket=3D/tmp/my_socket
> -@end example
> -
> -If the nbd-server uses named exports (supported since NBD 2.9.18, or wit=
h QEMU's
> -own embedded NBD server), you must specify an export name in the URI:
> -@example
> -@value{qemu_system} -cdrom nbd://localhost/debian-500-ppc-netinst
> -@value{qemu_system} -cdrom nbd://localhost/openSUSE-11.1-ppc-netinst
> -@end example
> -
> -The URI syntax for NBD is supported since QEMU 1.3.  An alternative synt=
ax is
> -also available.  Here are some example of the older syntax:
> -@example
> -@value{qemu_system} linux.img -hdb nbd:my_nbd_server.mydomain.org:1024
> -@value{qemu_system} linux2.img -hdb nbd:unix:/tmp/my_socket
> -@value{qemu_system} -cdrom nbd:localhost:10809:exportname=3Ddebian-500-p=
pc-netinst
> -@end example
> -
> -@node disk_images_sheepdog
> -@subsection Sheepdog disk images
> -
> -Sheepdog is a distributed storage system for QEMU.  It provides highly
> -available block level storage volumes that can be attached to
> -QEMU-based virtual machines.
> -
> -You can create a Sheepdog disk image with the command:
> -@example
> -qemu-img create sheepdog:///@var{image} @var{size}
> -@end example
> -where @var{image} is the Sheepdog image name and @var{size} is its
> -size.
> -
> -To import the existing @var{filename} to Sheepdog, you can use a
> -convert command.
> -@example
> -qemu-img convert @var{filename} sheepdog:///@var{image}
> -@end example
> -
> -You can boot from the Sheepdog disk image with the command:
> -@example
> -@value{qemu_system} sheepdog:///@var{image}
> -@end example
> -
> -You can also create a snapshot of the Sheepdog image like qcow2.
> -@example
> -qemu-img snapshot -c @var{tag} sheepdog:///@var{image}
> -@end example
> -where @var{tag} is a tag name of the newly created snapshot.
> -
> -To boot from the Sheepdog snapshot, specify the tag name of the
> -snapshot.
> -@example
> -@value{qemu_system} sheepdog:///@var{image}#@var{tag}
> -@end example
> -
> -You can create a cloned image from the existing snapshot.
> -@example
> -qemu-img create -b sheepdog:///@var{base}#@var{tag} sheepdog:///@var{ima=
ge}
> -@end example
> -where @var{base} is an image name of the source snapshot and @var{tag}
> -is its tag name.
> -
> -You can use an unix socket instead of an inet socket:
> -
> -@example
> -@value{qemu_system} sheepdog+unix:///@var{image}?socket=3D@var{path}
> -@end example
> -
> -If the Sheepdog daemon doesn't run on the local host, you need to
> -specify one of the Sheepdog servers to connect to.
> -@example
> -qemu-img create sheepdog://@var{hostname}:@var{port}/@var{image} @var{si=
ze}
> -@value{qemu_system} sheepdog://@var{hostname}:@var{port}/@var{image}
> -@end example
> -
> -@node disk_images_iscsi
> -@subsection iSCSI LUNs
> -
> -iSCSI is a popular protocol used to access SCSI devices across a computer
> -network.
> -
> -There are two different ways iSCSI devices can be used by QEMU.
> -
> -The first method is to mount the iSCSI LUN on the host, and make it appe=
ar as
> -any other ordinary SCSI device on the host and then to access this devic=
e as a
> -/dev/sd device from QEMU. How to do this differs between host OSes.
> -
> -The second method involves using the iSCSI initiator that is built into
> -QEMU. This provides a mechanism that works the same way regardless of wh=
ich
> -host OS you are running QEMU on. This section will describe this second =
method
> -of using iSCSI together with QEMU.
> -
> -In QEMU, iSCSI devices are described using special iSCSI URLs
> -
> -@example
> -URL syntax:
> -iscsi://[<username>[%<password>]@@]<host>[:<port>]/<target-iqn-name>/<lu=
n>
> -@end example
> -
> -Username and password are optional and only used if your target is set up
> -using CHAP authentication for access control.
> -Alternatively the username and password can also be set via environment
> -variables to have these not show up in the process list
> -
> -@example
> -export LIBISCSI_CHAP_USERNAME=3D<username>
> -export LIBISCSI_CHAP_PASSWORD=3D<password>
> -iscsi://<host>/<target-iqn-name>/<lun>
> -@end example
> -
> -Various session related parameters can be set via special options, either
> -in a configuration file provided via '-readconfig' or directly on the
> -command line.
> -
> -If the initiator-name is not specified qemu will use a default name
> -of 'iqn.2008-11.org.linux-kvm[:<uuid>'] where <uuid> is the UUID of the
> -virtual machine. If the UUID is not specified qemu will use
> -'iqn.2008-11.org.linux-kvm[:<name>'] where <name> is the name of the
> -virtual machine.
> -
> -@example
> -Setting a specific initiator name to use when logging in to the target
> --iscsi initiator-name=3Diqn.qemu.test:my-initiator
> -@end example
> -
> -@example
> -Controlling which type of header digest to negotiate with the target
> --iscsi header-digest=3DCRC32C|CRC32C-NONE|NONE-CRC32C|NONE
> -@end example
> -
> -These can also be set via a configuration file
> -@example
> -[iscsi]
> -  user =3D "CHAP username"
> -  password =3D "CHAP password"
> -  initiator-name =3D "iqn.qemu.test:my-initiator"
> -  # header digest is one of CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
> -  header-digest =3D "CRC32C"
> -@end example
> -
> -
> -Setting the target name allows different options for different targets
> -@example
> -[iscsi "iqn.target.name"]
> -  user =3D "CHAP username"
> -  password =3D "CHAP password"
> -  initiator-name =3D "iqn.qemu.test:my-initiator"
> -  # header digest is one of CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
> -  header-digest =3D "CRC32C"
> -@end example
> -
> -
> -Howto use a configuration file to set iSCSI configuration options:
> -@example
> -cat >iscsi.conf <<EOF
> -[iscsi]
> -  user =3D "me"
> -  password =3D "my password"
> -  initiator-name =3D "iqn.qemu.test:my-initiator"
> -  header-digest =3D "CRC32C"
> -EOF
> -
> -@value{qemu_system} -drive file=3Discsi://127.0.0.1/iqn.qemu.test/1 \
> -    -readconfig iscsi.conf
> -@end example
> -
> -
> -How to set up a simple iSCSI target on loopback and access it via QEMU:
> -@example
> -This example shows how to set up an iSCSI target with one CDROM and one =
DISK
> -using the Linux STGT software target. This target is available on Red Ha=
t based
> -systems as the package 'scsi-target-utils'.
> -
> -tgtd --iscsi portal=3D127.0.0.1:3260
> -tgtadm --lld iscsi --op new --mode target --tid 1 -T iqn.qemu.test
> -tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 1 \
> -    -b /IMAGES/disk.img --device-type=3Ddisk
> -tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 2 \
> -    -b /IMAGES/cd.iso --device-type=3Dcd
> -tgtadm --lld iscsi --op bind --mode target --tid 1 -I ALL
> -
> -@value{qemu_system} -iscsi initiator-name=3Diqn.qemu.test:my-initiator \
> -    -boot d -drive file=3Discsi://127.0.0.1/iqn.qemu.test/1 \
> -    -cdrom iscsi://127.0.0.1/iqn.qemu.test/2
> -@end example
> -
> -@node disk_images_gluster
> -@subsection GlusterFS disk images
> -
> -GlusterFS is a user space distributed file system.
> -
> -You can boot from the GlusterFS disk image with the command:
> -@example
> -URI:
> -@value{qemu_system} -drive file=3Dgluster[+@var{type}]://[@var{host}[:@v=
ar{port}]]/@var{volume}/@var{path}
> -                               [?socket=3D...][,file.debug=3D9][,file.lo=
gfile=3D...]
> -
> -JSON:
> -@value{qemu_system} 'json:@{"driver":"qcow2",
> -                           "file":@{"driver":"gluster",
> -                                    "volume":"testvol","path":"a.img","d=
ebug":9,"logfile":"...",
> -                                    "server":[@{"type":"tcp","host":"...=
","port":"..."@},
> -                                              @{"type":"unix","socket":"=
..."@}]@}@}'
> -@end example
> -
> -@var{gluster} is the protocol.
> -
> -@var{type} specifies the transport type used to connect to gluster
> -management daemon (glusterd). Valid transport types are
> -tcp and unix. In the URI form, if a transport type isn't specified,
> -then tcp type is assumed.
> -
> -@var{host} specifies the server where the volume file specification for
> -the given volume resides. This can be either a hostname or an ipv4 addre=
ss.
> -If transport type is unix, then @var{host} field should not be specified.
> -Instead @var{socket} field needs to be populated with the path to unix d=
omain
> -socket.
> -
> -@var{port} is the port number on which glusterd is listening. This is op=
tional
> -and if not specified, it defaults to port 24007. If the transport type i=
s unix,
> -then @var{port} should not be specified.
> -
> -@var{volume} is the name of the gluster volume which contains the disk i=
mage.
> -
> -@var{path} is the path to the actual disk image that resides on gluster =
volume.
> -
> -@var{debug} is the logging level of the gluster protocol driver. Debug l=
evels
> -are 0-9, with 9 being the most verbose, and 0 representing no debugging =
output.
> -The default level is 4. The current logging levels defined in the gluste=
r source
> -are 0 - None, 1 - Emergency, 2 - Alert, 3 - Critical, 4 - Error, 5 - War=
ning,
> -6 - Notice, 7 - Info, 8 - Debug, 9 - Trace
> -
> -@var{logfile} is a commandline option to mention log file path which hel=
ps in
> -logging to the specified file and also help in persisting the gfapi logs=
. The
> -default is stderr.
> -
> -
> -
> -
> -You can create a GlusterFS disk image with the command:
> -@example
> -qemu-img create gluster://@var{host}/@var{volume}/@var{path} @var{size}
> -@end example
> -
> -Examples
> -@example
> -@value{qemu_system} -drive file=3Dgluster://1.2.3.4/testvol/a.img
> -@value{qemu_system} -drive file=3Dgluster+tcp://1.2.3.4/testvol/a.img
> -@value{qemu_system} -drive file=3Dgluster+tcp://1.2.3.4:24007/testvol/di=
r/a.img
> -@value{qemu_system} -drive file=3Dgluster+tcp://[1:2:3:4:5:6:7:8]/testvo=
l/dir/a.img
> -@value{qemu_system} -drive file=3Dgluster+tcp://[1:2:3:4:5:6:7:8]:24007/=
testvol/dir/a.img
> -@value{qemu_system} -drive file=3Dgluster+tcp://server.domain.com:24007/=
testvol/dir/a.img
> -@value{qemu_system} -drive file=3Dgluster+unix:///testvol/dir/a.img?sock=
et=3D/tmp/glusterd.socket
> -@value{qemu_system} -drive file=3Dgluster+rdma://1.2.3.4:24007/testvol/a=
.img
> -@value{qemu_system} -drive file=3Dgluster://1.2.3.4/testvol/a.img,file.d=
ebug=3D9,file.logfile=3D/var/log/qemu-gluster.log
> -@value{qemu_system} 'json:@{"driver":"qcow2",
> -                           "file":@{"driver":"gluster",
> -                                    "volume":"testvol","path":"a.img",
> -                                    "debug":9,"logfile":"/var/log/qemu-g=
luster.log",
> -                                    "server":[@{"type":"tcp","host":"1.2=
.3.4","port":24007@},
> -                                              @{"type":"unix","socket":"=
/var/run/glusterd.socket"@}]@}@}'
> -@value{qemu_system} -drive driver=3Dqcow2,file.driver=3Dgluster,file.vol=
ume=3Dtestvol,file.path=3D/path/a.img,
> -                                       file.debug=3D9,file.logfile=3D/va=
r/log/qemu-gluster.log,
> -                                       file.server.0.type=3Dtcp,file.ser=
ver.0.host=3D1.2.3.4,file.server.0.port=3D24007,
> -                                       file.server.1.type=3Dunix,file.se=
rver.1.socket=3D/var/run/glusterd.socket
> -@end example
> -
> -@node disk_images_ssh
> -@subsection Secure Shell (ssh) disk images
> -
> -You can access disk images located on a remote ssh server
> -by using the ssh protocol:
> -
> -@example
> -@value{qemu_system} -drive file=3Dssh://[@var{user}@@]@var{server}[:@var=
{port}]/@var{path}[?host_key_check=3D@var{host_key_check}]
> -@end example
> -
> -Alternative syntax using properties:
> -
> -@example
> -@value{qemu_system} -drive file.driver=3Dssh[,file.user=3D@var{user}],fi=
le.host=3D@var{server}[,file.port=3D@var{port}],file.path=3D@var{path}[,fil=
e.host_key_check=3D@var{host_key_check}]
> -@end example
> -
> -@var{ssh} is the protocol.
> -
> -@var{user} is the remote user.  If not specified, then the local
> -username is tried.
> -
> -@var{server} specifies the remote ssh server.  Any ssh server can be
> -used, but it must implement the sftp-server protocol.  Most Unix/Linux
> -systems should work without requiring any extra configuration.
> -
> -@var{port} is the port number on which sshd is listening.  By default
> -the standard ssh port (22) is used.
> -
> -@var{path} is the path to the disk image.
> -
> -The optional @var{host_key_check} parameter controls how the remote
> -host's key is checked.  The default is @code{yes} which means to use
> -the local @file{.ssh/known_hosts} file.  Setting this to @code{no}
> -turns off known-hosts checking.  Or you can check that the host key
> -matches a specific fingerprint:
> -@code{host_key_check=3Dmd5:78:45:8e:14:57:4f:d5:45:83:0a:0e:f3:49:82:c9:=
c8}
> -(@code{sha1:} can also be used as a prefix, but note that OpenSSH
> -tools only use MD5 to print fingerprints).
> -
> -Currently authentication must be done using ssh-agent.  Other
> -authentication methods may be supported in future.
> -
> -Note: Many ssh servers do not support an @code{fsync}-style operation.
> -The ssh driver cannot guarantee that disk flush requests are
> -obeyed, and this causes a risk of disk corruption if the remote
> -server or network goes down during writes.  The driver will
> -print a warning when @code{fsync} is not supported:
> -
> -warning: ssh server @code{ssh.example.com:22} does not support fsync
> -
> -With sufficiently new versions of libssh and OpenSSH, @code{fsync} is
> -supported.
> -
> -@node disk_images_nvme
> -@subsection NVMe disk images
> -
> -NVM Express (NVMe) storage controllers can be accessed directly by a use=
rspace
> -driver in QEMU.  This bypasses the host kernel file system and block lay=
ers
> -while retaining QEMU block layer functionalities, such as block jobs, I/O
> -throttling, image formats, etc.  Disk I/O performance is typically highe=
r than
> -with @code{-drive file=3D/dev/sda} using either thread pool or linux-aio.
> -
> -The controller will be exclusively used by the QEMU process once started=
. To be
> -able to share storage between multiple VMs and other applications on the=
 host,
> -please use the file based protocols.
> -
> -Before starting QEMU, bind the host NVMe controller to the host vfio-pci
> -driver.  For example:
> -
> -@example
> -# modprobe vfio-pci
> -# lspci -n -s 0000:06:0d.0
> -06:0d.0 0401: 1102:0002 (rev 08)
> -# echo 0000:06:0d.0 > /sys/bus/pci/devices/0000:06:0d.0/driver/unbind
> -# echo 1102 0002 > /sys/bus/pci/drivers/vfio-pci/new_id
> -
> -# @value{qemu_system} -drive file=3Dnvme://@var{host}:@var{bus}:@var{slo=
t}.@var{func}/@var{namespace}
> -@end example
> -
> -Alternative syntax using properties:
> -
> -@example
> -@value{qemu_system} -drive file.driver=3Dnvme,file.device=3D@var{host}:@=
var{bus}:@var{slot}.@var{func},file.namespace=3D@var{namespace}
> -@end example
> -
> -@var{host}:@var{bus}:@var{slot}.@var{func} is the NVMe controller's PCI =
device
> -address on the host.
> -
> -@var{namespace} is the NVMe namespace number, starting from 1.
> -
> -@node disk_image_locking
> -@subsection Disk image file locking
> -
> -By default, QEMU tries to protect image files from unexpected concurrent
> -access, as long as it's supported by the block protocol driver and host
> -operating system. If multiple QEMU processes (including QEMU emulators a=
nd
> -utilities) try to open the same image with conflicting accessing modes, =
all but
> -the first one will get an error.
> -
> -This feature is currently supported by the file protocol on Linux with t=
he Open
> -File Descriptor (OFD) locking API, and can be configured to fall back to=
 POSIX
> -locking if the POSIX host doesn't support Linux OFD locking.
> -
> -To explicitly enable image locking, specify "locking=3Don" in the file p=
rotocol
> -driver options. If OFD locking is not possible, a warning will be printe=
d and
> -the POSIX locking API will be used. In this case there is a risk that th=
e lock
> -will get silently lost when doing hot plugging and block jobs, due to the
> -shortcomings of the POSIX locking API.
> -
> -QEMU transparently handles lock handover during shared storage migration=
.  For
> -shared virtual disk images between multiple VMs, the "share-rw" device o=
ption
> -should be used.
> -
> -By default, the guest has exclusive write access to its disk image. If t=
he
> -guest can safely share the disk image with other writers the @code{-devi=
ce
> -...,share-rw=3Don} parameter can be used.  This is only safe if the gues=
t is
> -running software, such as a cluster file system, that coordinates disk a=
ccesses
> -to avoid corruption.
> -
> -Note that share-rw=3Don only declares the guest's ability to share the d=
isk.
> -Some QEMU features, such as image file formats, require exclusive write =
access
> -to the disk image and this is unaffected by the share-rw=3Don option.
> -
> -Alternatively, locking can be fully disabled by "locking=3Doff" block de=
vice
> -option. In the command line, the option is usually in the form of
> -"file.locking=3Doff" as the protocol driver is normally placed as a "fil=
e" child
> -under a format driver. For example:
> -
> -@code{-blockdev driver=3Dqcow2,file.filename=3D/path/to/image,file.locki=
ng=3Doff,file.driver=3Dfile}
> -
> -To check if image locking is active, check the output of the "lslocks" c=
ommand
> -on host and see if there are locks held by the QEMU process on the image=
 file.
> -More than one byte could be locked by the QEMU instance, each byte of wh=
ich
> -reflects a particular permission that is acquired or protected by the ru=
nning
> -block driver.
> -
> -@c man end
> -
> -@ignore
> -
> -@setfilename qemu-block-drivers
> -@settitle QEMU block drivers reference
> -
> -@c man begin SEEALSO
> -The HTML documentation of QEMU for more precise information and Linux
> -user mode emulator invocation.
> -@c man end
> -
> -@c man begin AUTHOR
> -Fabrice Bellard and the QEMU Project developers
> -@c man end
> -
> -@end ignore
> diff --git a/docs/system/conf.py b/docs/system/conf.py
> index 6435b4d3f8e..7ca115f5e03 100644
> --- a/docs/system/conf.py
> +++ b/docs/system/conf.py
> @@ -13,3 +13,10 @@ exec(compile(open(parent_config, "rb").read(), parent_=
config, 'exec'))
>  # This slightly misuses the 'description', but is the best way to get
>  # the manual title to appear in the sidebar.
>  html_theme_options['description'] =3D u'System Emulation User''s Guide'
> +# One entry per manual page. List of tuples
> +# (source start file, name, description, authors, manual section).
> +man_pages =3D [
> +    ('qemu-block-drivers', 'qemu-block-drivers',
> +     u'QEMU block drivers reference',
> +     ['Fabrice Bellard and the QEMU Project developers'], 7)
> +]
> diff --git a/docs/system/index.rst b/docs/system/index.rst
> index ea8ea5fe3dc..f66e6ea585c 100644
> --- a/docs/system/index.rst
> +++ b/docs/system/index.rst
> @@ -14,3 +14,4 @@ Contents:
>  .. toctree::
>     :maxdepth: 2
>=20=20
> +   qemu-block-drivers
> diff --git a/docs/system/qemu-block-drivers.rst b/docs/system/qemu-block-=
drivers.rst
> new file mode 100644
> index 00000000000..388adbefbf4
> --- /dev/null
> +++ b/docs/system/qemu-block-drivers.rst
> @@ -0,0 +1,985 @@
> +QEMU block drivers reference
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +.. |qemu_system| replace:: qemu-system-x86_64
> +
> +..
> +   We put the 'Synopsis' and 'See also' sections into the manpage, but n=
ot
> +   the HTML. This makes the HTML docs read better and means the ToC in
> +   the index has a more useful set of entries. Ideally, the section
> +   headings 'Disk image file formats' would be top-level headings for
> +   the HTML, but sub-headings of the conventional manpage 'Description'
> +   header for the manpage. Unfortunately, due to deficiencies in
> +   the Sphinx 'only' directive, this isn't possible: they must be headers
> +   at the same level as 'Synopsis' and 'See also', otherwise Sphinx's
> +   identification of which header underline style is which gets confused.
> +
> +.. only:: man
> +
> +  Synopsis
> +  --------
> +
> +  QEMU block driver reference manual
> +
> +Disk image file formats
> +-----------------------
> +
> +QEMU supports many image file formats that can be used with VMs as well =
as with
> +any of the tools (like ``qemu-img``). This includes the preferred formats
> +raw and qcow2 as well as formats that are supported for compatibility wi=
th
> +older QEMU versions or other hypervisors.
> +
> +Depending on the image format, different options can be passed to
> +``qemu-img create`` and ``qemu-img convert`` using the ``-o`` option.
> +This section describes each format and the options that are supported fo=
r it.
> +
> +.. program:: image-formats
> +.. option:: raw
> +
> +  Raw disk image format. This format has the advantage of
> +  being simple and easily exportable to all other emulators. If your
> +  file system supports *holes* (for example in ext2 or ext3 on
> +  Linux or NTFS on Windows), then only the written sectors will reserve
> +  space. Use ``qemu-img info`` to know the real size used by the
> +  image or ``ls -ls`` on Unix/Linux.
> +
> +  Supported options:
> +
> +  .. program:: raw
> +  .. option:: preallocation
> +
> +    Preallocation mode (allowed values: ``off``, ``falloc``,
> +    ``full``). ``falloc`` mode preallocates space for image by
> +    calling ``posix_fallocate()``. ``full`` mode preallocates space
> +    for image by writing data to underlying storage. This data may or
> +    may not be zero, depending on the storage location.
> +
> +.. program:: image-formats
> +.. option:: qcow2
> +
> +  QEMU image format, the most versatile format. Use it to have smaller
> +  images (useful if your filesystem does not supports holes, for example
> +  on Windows), zlib based compression and support of multiple VM
> +  snapshots.
> +
> +  Supported options:
> +
> +  .. program:: qcow2
> +  .. option:: compat
> +
> +    Determines the qcow2 version to use. ``compat=3D0.10`` uses the
> +    traditional image format that can be read by any QEMU since 0.10.
> +    ``compat=3D1.1`` enables image format extensions that only QEMU 1.1 =
and
> +    newer understand (this is the default). Amongst others, this includes
> +    zero clusters, which allow efficient copy-on-read for sparse images.
> +
> +  .. option:: backing_file
> +
> +    File name of a base image (see ``create`` subcommand)
> +
> +  .. option:: backing_fmt
> +
> +    Image format of the base image
> +
> +  .. option:: encryption
> +
> +    This option is deprecated and equivalent to ``encrypt.format=3Daes``
> +
> +  .. option:: encrypt.format
> +
> +    If this is set to ``luks``, it requests that the qcow2 payload (not
> +    qcow2 header) be encrypted using the LUKS format. The passphrase to
> +    use to unlock the LUKS key slot is given by the ``encrypt.key-secret=
``
> +    parameter. LUKS encryption parameters can be tuned with the other
> +    ``encrypt.*`` parameters.
> +
> +    If this is set to ``aes``, the image is encrypted with 128-bit AES-C=
BC.
> +    The encryption key is given by the ``encrypt.key-secret`` parameter.
> +    This encryption format is considered to be flawed by modern cryptogr=
aphy
> +    standards, suffering from a number of design problems:
> +
> +    - The AES-CBC cipher is used with predictable initialization vectors=
 based
> +      on the sector number. This makes it vulnerable to chosen plaintext=
 attacks
> +      which can reveal the existence of encrypted data.
> +    - The user passphrase is directly used as the encryption key. A poor=
ly
> +      chosen or short passphrase will compromise the security of the enc=
ryption.
> +    - In the event of the passphrase being compromised there is no way to
> +      change the passphrase to protect data in any qcow images. The file=
s must
> +      be cloned, using a different encryption passphrase in the new file=
. The
> +      original file must then be securely erased using a program like sh=
red,
> +      though even this is ineffective with many modern storage technolog=
ies.
> +
> +    The use of this is no longer supported in system emulators. Support =
only
> +    remains in the command line utilities, for the purposes of data libe=
ration
> +    and interoperability with old versions of QEMU. The ``luks`` format
> +    should be used instead.
> +
> +  .. option:: encrypt.key-secret
> +
> +    Provides the ID of a ``secret`` object that contains the passphrase
> +    (``encrypt.format=3Dluks``) or encryption key (``encrypt.format=3Dae=
s``).
> +
> +  .. option:: encrypt.cipher-alg
> +
> +    Name of the cipher algorithm and key length. Currently defaults
> +    to ``aes-256``. Only used when ``encrypt.format=3Dluks``.
> +
> +  .. option:: encrypt.cipher-mode
> +
> +    Name of the encryption mode to use. Currently defaults to ``xts``.
> +    Only used when ``encrypt.format=3Dluks``.
> +
> +  .. option:: encrypt.ivgen-alg
> +
> +    Name of the initialization vector generator algorithm. Currently def=
aults
> +    to ``plain64``. Only used when ``encrypt.format=3Dluks``.
> +
> +  .. option:: encrypt.ivgen-hash-alg
> +
> +    Name of the hash algorithm to use with the initialization vector gen=
erator
> +    (if required). Defaults to ``sha256``. Only used when ``encrypt.form=
at=3Dluks``.
> +
> +  .. option:: encrypt.hash-alg
> +
> +    Name of the hash algorithm to use for PBKDF algorithm
> +    Defaults to ``sha256``. Only used when ``encrypt.format=3Dluks``.
> +
> +  .. option:: encrypt.iter-time
> +
> +    Amount of time, in milliseconds, to use for PBKDF algorithm per key =
slot.
> +    Defaults to ``2000``. Only used when ``encrypt.format=3Dluks``.
> +
> +  .. option:: cluster_size
> +
> +    Changes the qcow2 cluster size (must be between 512 and 2M). Smaller=
 cluster
> +    sizes can improve the image file size whereas larger cluster sizes g=
enerally
> +    provide better performance.
> +
> +  .. option:: preallocation
> +
> +    Preallocation mode (allowed values: ``off``, ``metadata``, ``falloc`=
`,
> +    ``full``). An image with preallocated metadata is initially larger b=
ut can
> +    improve performance when the image needs to grow. ``falloc`` and ``f=
ull``
> +    preallocations are like the same options of ``raw`` format, but sets=
 up
> +    metadata also.
> +
> +  .. option:: lazy_refcounts
> +
> +    If this option is set to ``on``, reference count updates are postpon=
ed with
> +    the goal of avoiding metadata I/O and improving performance. This is
> +    particularly interesting with :option:`cache=3Dwritethrough` which d=
oesn't batch
> +    metadata updates. The tradeoff is that after a host crash, the refer=
ence count
> +    tables must be rebuilt, i.e. on the next open an (automatic) ``qemu-=
img
> +    check -r all`` is required, which may take some time.
> +
> +    This option can only be enabled if ``compat=3D1.1`` is specified.
> +
> +  .. option:: nocow
> +
> +    If this option is set to ``on``, it will turn off COW of the file. I=
t's only
> +    valid on btrfs, no effect on other file systems.
> +
> +    Btrfs has low performance when hosting a VM image file, even more
> +    when the guest on the VM also using btrfs as file system. Turning off
> +    COW is a way to mitigate this bad performance. Generally there are t=
wo
> +    ways to turn off COW on btrfs:
> +
> +    - Disable it by mounting with nodatacow, then all newly created files
> +      will be NOCOW.
> +    - For an empty file, add the NOCOW file attribute. That's what this
> +      option does.
> +
> +    Note: this option is only valid to new or empty files. If there is
> +    an existing file which is COW and has data blocks already, it couldn=
't
> +    be changed to NOCOW by setting ``nocow=3Don``. One can issue ``lsattr
> +    filename`` to check if the NOCOW flag is set or not (Capital 'C' is
> +    NOCOW flag).
> +
> +.. program:: image-formats
> +.. option:: qed
> +
> +   Old QEMU image format with support for backing files and compact imag=
e files
> +   (when your filesystem or transport medium does not support holes).
> +
> +   When converting QED images to qcow2, you might want to consider using=
 the
> +   ``lazy_refcounts=3Don`` option to get a more QED-like behaviour.
> +
> +   Supported options:
> +
> +   .. program:: qed
> +   .. option:: backing_file
> +
> +      File name of a base image (see ``create`` subcommand).
> +
> +   .. option:: backing_fmt
> +
> +     Image file format of backing file (optional).  Useful if the format=
 cannot be
> +     autodetected because it has no header, like some vhd/vpc files.
> +
> +   .. option:: cluster_size
> +
> +     Changes the cluster size (must be power-of-2 between 4K and 64K). S=
maller
> +     cluster sizes can improve the image file size whereas larger cluste=
r sizes
> +     generally provide better performance.
> +
> +   .. option:: table_size
> +
> +     Changes the number of clusters per L1/L2 table (must be
> +     power-of-2 between 1 and 16).  There is normally no need to
> +     change this value but this option can between used for
> +     performance benchmarking.
> +
> +.. program:: image-formats
> +.. option:: qcow
> +
> +  Old QEMU image format with support for backing files, compact image fi=
les,
> +  encryption and compression.
> +
> +  Supported options:
> +
> +   .. program:: qcow
> +   .. option:: backing_file
> +
> +     File name of a base image (see ``create`` subcommand)
> +
> +   .. option:: encryption
> +
> +     This option is deprecated and equivalent to ``encrypt.format=3Daes``
> +
> +   .. option:: encrypt.format
> +
> +     If this is set to ``aes``, the image is encrypted with 128-bit AES-=
CBC.
> +     The encryption key is given by the ``encrypt.key-secret`` parameter.
> +     This encryption format is considered to be flawed by modern cryptog=
raphy
> +     standards, suffering from a number of design problems enumerated pr=
eviously
> +     against the ``qcow2`` image format.
> +
> +     The use of this is no longer supported in system emulators. Support=
 only
> +     remains in the command line utilities, for the purposes of data lib=
eration
> +     and interoperability with old versions of QEMU.
> +
> +     Users requiring native encryption should use the ``qcow2`` format
> +     instead with ``encrypt.format=3Dluks``.
> +
> +   .. option:: encrypt.key-secret
> +
> +     Provides the ID of a ``secret`` object that contains the encryption
> +     key (``encrypt.format=3Daes``).
> +
> +.. program:: image-formats
> +.. option:: luks
> +
> +  LUKS v1 encryption format, compatible with Linux dm-crypt/cryptsetup
> +
> +  Supported options:
> +
> +  .. program:: luks
> +  .. option:: key-secret
> +
> +    Provides the ID of a ``secret`` object that contains the passphrase.
> +
> +  .. option:: cipher-alg
> +
> +    Name of the cipher algorithm and key length. Currently defaults
> +    to ``aes-256``.
> +
> +  .. option:: cipher-mode
> +
> +    Name of the encryption mode to use. Currently defaults to ``xts``.
> +
> +  .. option:: ivgen-alg
> +
> +    Name of the initialization vector generator algorithm. Currently def=
aults
> +    to ``plain64``.
> +
> +  .. option:: ivgen-hash-alg
> +
> +    Name of the hash algorithm to use with the initialization vector gen=
erator
> +    (if required). Defaults to ``sha256``.
> +
> +  .. option:: hash-alg
> +
> +    Name of the hash algorithm to use for PBKDF algorithm
> +    Defaults to ``sha256``.
> +
> +  .. option:: iter-time
> +
> +    Amount of time, in milliseconds, to use for PBKDF algorithm per key =
slot.
> +    Defaults to ``2000``.
> +
> +.. program:: image-formats
> +.. option:: vdi
> +
> +  VirtualBox 1.1 compatible image format.
> +
> +  Supported options:
> +
> +  .. program:: vdi
> +  .. option:: static
> +
> +    If this option is set to ``on``, the image is created with metadata
> +    preallocation.
> +
> +.. program:: image-formats
> +.. option:: vmdk
> +
> +  VMware 3 and 4 compatible image format.
> +
> +  Supported options:
> +
> +  .. program: vmdk
> +  .. option:: backing_file
> +
> +    File name of a base image (see ``create`` subcommand).
> +
> +  .. option:: compat6
> +
> +    Create a VMDK version 6 image (instead of version 4)
> +
> +  .. option:: hwversion
> +
> +    Specify vmdk virtual hardware version. Compat6 flag cannot be enabled
> +    if hwversion is specified.
> +
> +  .. option:: subformat
> +
> +    Specifies which VMDK subformat to use. Valid options are
> +    ``monolithicSparse`` (default),
> +    ``monolithicFlat``,
> +    ``twoGbMaxExtentSparse``,
> +    ``twoGbMaxExtentFlat`` and
> +    ``streamOptimized``.
> +
> +.. program:: image-formats
> +.. option:: vpc
> +
> +  VirtualPC compatible image format (VHD).
> +
> +  Supported options:
> +
> +  .. program:: vpc
> +  .. option:: subformat
> +
> +    Specifies which VHD subformat to use. Valid options are
> +    ``dynamic`` (default) and ``fixed``.
> +
> +.. program:: image-formats
> +.. option:: VHDX
> +
> +  Hyper-V compatible image format (VHDX).
> +
> +  Supported options:
> +
> +  .. program:: VHDX
> +  .. option:: subformat
> +
> +    Specifies which VHDX subformat to use. Valid options are
> +    ``dynamic`` (default) and ``fixed``.
> +
> +    .. option:: block_state_zero
> +
> +      Force use of payload blocks of type 'ZERO'.  Can be set to ``on`` =
(default)
> +      or ``off``.  When set to ``off``, new blocks will be created as
> +      ``PAYLOAD_BLOCK_NOT_PRESENT``, which means parsers are free to ret=
urn
> +      arbitrary data for those blocks.  Do not set to ``off`` when using
> +      ``qemu-img convert`` with ``subformat=3Ddynamic``.
> +
> +    .. option:: block_size
> +
> +      Block size; min 1 MB, max 256 MB.  0 means auto-calculate based on
> +      image size.
> +
> +    .. option:: log_size
> +
> +      Log size; min 1 MB.
> +
> +Read-only formats
> +-----------------
> +
> +More disk image file formats are supported in a read-only mode.
> +
> +.. program:: image-formats
> +.. option:: bochs
> +
> +  Bochs images of ``growing`` type.
> +
> +.. program:: image-formats
> +.. option:: cloop
> +
> +  Linux Compressed Loop image, useful only to reuse directly compressed
> +  CD-ROM images present for example in the Knoppix CD-ROMs.
> +
> +.. program:: image-formats
> +.. option:: dmg
> +
> +  Apple disk image.
> +
> +.. program:: image-formats
> +.. option:: parallels
> +
> +  Parallels disk image format.
> +
> +Using host drives
> +-----------------
> +
> +In addition to disk image files, QEMU can directly access host
> +devices. We describe here the usage for QEMU version >=3D 0.8.3.
> +
> +Linux
> +'''''
> +
> +On Linux, you can directly use the host device filename instead of a
> +disk image filename provided you have enough privileges to access
> +it. For example, use ``/dev/cdrom`` to access to the CDROM.
> +
> +CD
> +  You can specify a CDROM device even if no CDROM is loaded. QEMU has
> +  specific code to detect CDROM insertion or removal. CDROM ejection by
> +  the guest OS is supported. Currently only data CDs are supported.
> +
> +Floppy
> +  You can specify a floppy device even if no floppy is loaded. Floppy
> +  removal is currently not detected accurately (if you change floppy
> +  without doing floppy access while the floppy is not loaded, the guest
> +  OS will think that the same floppy is loaded).
> +  Use of the host's floppy device is deprecated, and support for it will
> +  be removed in a future release.
> +
> +Hard disks
> +  Hard disks can be used. Normally you must specify the whole disk
> +  (``/dev/hdb`` instead of ``/dev/hdb1``) so that the guest OS can
> +  see it as a partitioned disk. WARNING: unless you know what you do, it
> +  is better to only make READ-ONLY accesses to the hard disk otherwise
> +  you may corrupt your host data (use the ``-snapshot`` command
> +  line option or modify the device permissions accordingly).
> +
> +Windows
> +'''''''
> +
> +CD
> +  The preferred syntax is the drive letter (e.g. ``d:``). The
> +  alternate syntax ``\\.\d:`` is supported. ``/dev/cdrom`` is
> +  supported as an alias to the first CDROM drive.
> +
> +  Currently there is no specific code to handle removable media, so it
> +  is better to use the ``change`` or ``eject`` monitor commands to
> +  change or eject media.
> +
> +Hard disks
> +  Hard disks can be used with the syntax: ``\\.\PhysicalDriveN``
> +  where *N* is the drive number (0 is the first hard disk).
> +
> +  WARNING: unless you know what you do, it is better to only make
> +  READ-ONLY accesses to the hard disk otherwise you may corrupt your
> +  host data (use the ``-snapshot`` command line so that the
> +  modifications are written in a temporary file).
> +
> +Mac OS X
> +''''''''
> +
> +``/dev/cdrom`` is an alias to the first CDROM.
> +
> +Currently there is no specific code to handle removable media, so it
> +is better to use the ``change`` or ``eject`` monitor commands to
> +change or eject media.
> +
> +Virtual FAT disk images
> +-----------------------
> +
> +QEMU can automatically create a virtual FAT disk image from a
> +directory tree. In order to use it, just type:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| linux.img -hdb fat:/my_directory
> +
> +Then you access access to all the files in the ``/my_directory``
> +directory without having to copy them in a disk image or to export
> +them via SAMBA or NFS. The default access is *read-only*.
> +
> +Floppies can be emulated with the ``:floppy:`` option:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| linux.img -fda fat:floppy:/my_directory
> +
> +A read/write support is available for testing (beta stage) with the
> +``:rw:`` option:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| linux.img -fda fat:floppy:rw:/my_directory
> +
> +What you should *never* do:
> +
> +- use non-ASCII filenames
> +- use "-snapshot" together with ":rw:"
> +- expect it to work when loadvm'ing
> +- write to the FAT directory on the host system while accessing it with =
the guest system
> +
> +NBD access
> +----------
> +
> +QEMU can access directly to block device exported using the Network Bloc=
k Device
> +protocol.
> +
> +.. parsed-literal::
> +
> +  |qemu_system| linux.img -hdb nbd://my_nbd_server.mydomain.org:1024/
> +
> +If the NBD server is located on the same host, you can use an unix socke=
t instead
> +of an inet socket:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| linux.img -hdb nbd+unix://?socket=3D/tmp/my_socket
> +
> +In this case, the block device must be exported using qemu-nbd:
> +
> +.. parsed-literal::
> +
> +  qemu-nbd --socket=3D/tmp/my_socket my_disk.qcow2
> +
> +The use of qemu-nbd allows sharing of a disk between several guests:
> +
> +.. parsed-literal::
> +
> +  qemu-nbd --socket=3D/tmp/my_socket --share=3D2 my_disk.qcow2
> +
> +and then you can use it with two guests:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| linux1.img -hdb nbd+unix://?socket=3D/tmp/my_socket
> +  |qemu_system| linux2.img -hdb nbd+unix://?socket=3D/tmp/my_socket
> +
> +If the nbd-server uses named exports (supported since NBD 2.9.18, or wit=
h QEMU's
> +own embedded NBD server), you must specify an export name in the URI:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| -cdrom nbd://localhost/debian-500-ppc-netinst
> +  |qemu_system| -cdrom nbd://localhost/openSUSE-11.1-ppc-netinst
> +
> +The URI syntax for NBD is supported since QEMU 1.3.  An alternative synt=
ax is
> +also available.  Here are some example of the older syntax:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| linux.img -hdb nbd:my_nbd_server.mydomain.org:1024
> +  |qemu_system| linux2.img -hdb nbd:unix:/tmp/my_socket
> +  |qemu_system| -cdrom nbd:localhost:10809:exportname=3Ddebian-500-ppc-n=
etinst
> +
> +
> +
> +Sheepdog disk images
> +--------------------
> +
> +Sheepdog is a distributed storage system for QEMU.  It provides highly
> +available block level storage volumes that can be attached to
> +QEMU-based virtual machines.
> +
> +You can create a Sheepdog disk image with the command:
> +
> +.. parsed-literal::
> +
> +  qemu-img create sheepdog:///IMAGE SIZE
> +
> +where *IMAGE* is the Sheepdog image name and *SIZE* is its
> +size.
> +
> +To import the existing *FILENAME* to Sheepdog, you can use a
> +convert command.
> +
> +.. parsed-literal::
> +
> +  qemu-img convert FILENAME sheepdog:///IMAGE
> +
> +You can boot from the Sheepdog disk image with the command:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| sheepdog:///IMAGE
> +
> +You can also create a snapshot of the Sheepdog image like qcow2.
> +
> +.. parsed-literal::
> +
> +  qemu-img snapshot -c TAG sheepdog:///IMAGE
> +
> +where *TAG* is a tag name of the newly created snapshot.
> +
> +To boot from the Sheepdog snapshot, specify the tag name of the
> +snapshot.
> +
> +.. parsed-literal::
> +
> +  |qemu_system| sheepdog:///IMAGE#TAG
> +
> +You can create a cloned image from the existing snapshot.
> +
> +.. parsed-literal::
> +
> +  qemu-img create -b sheepdog:///BASE#TAG sheepdog:///IMAGE
> +
> +where *BASE* is an image name of the source snapshot and *TAG*
> +is its tag name.
> +
> +You can use an unix socket instead of an inet socket:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| sheepdog+unix:///IMAGE?socket=3DPATH
> +
> +If the Sheepdog daemon doesn't run on the local host, you need to
> +specify one of the Sheepdog servers to connect to.
> +
> +.. parsed-literal::
> +
> +  qemu-img create sheepdog://HOSTNAME:PORT/IMAGE SIZE
> +  |qemu_system| sheepdog://HOSTNAME:PORT/IMAGE
> +
> +iSCSI LUNs
> +----------
> +
> +iSCSI is a popular protocol used to access SCSI devices across a computer
> +network.
> +
> +There are two different ways iSCSI devices can be used by QEMU.
> +
> +The first method is to mount the iSCSI LUN on the host, and make it appe=
ar as
> +any other ordinary SCSI device on the host and then to access this devic=
e as a
> +/dev/sd device from QEMU. How to do this differs between host OSes.
> +
> +The second method involves using the iSCSI initiator that is built into
> +QEMU. This provides a mechanism that works the same way regardless of wh=
ich
> +host OS you are running QEMU on. This section will describe this second =
method
> +of using iSCSI together with QEMU.
> +
> +In QEMU, iSCSI devices are described using special iSCSI URLs. URL synta=
x:
> +
> +::
> +
> +  iscsi://[<username>[%<password>]@]<host>[:<port>]/<target-iqn-name>/<l=
un>
> +
> +Username and password are optional and only used if your target is set up
> +using CHAP authentication for access control.
> +Alternatively the username and password can also be set via environment
> +variables to have these not show up in the process list:
> +
> +::
> +
> +  export LIBISCSI_CHAP_USERNAME=3D<username>
> +  export LIBISCSI_CHAP_PASSWORD=3D<password>
> +  iscsi://<host>/<target-iqn-name>/<lun>
> +
> +Various session related parameters can be set via special options, either
> +in a configuration file provided via '-readconfig' or directly on the
> +command line.
> +
> +If the initiator-name is not specified qemu will use a default name
> +of 'iqn.2008-11.org.linux-kvm[:<uuid>'] where <uuid> is the UUID of the
> +virtual machine. If the UUID is not specified qemu will use
> +'iqn.2008-11.org.linux-kvm[:<name>'] where <name> is the name of the
> +virtual machine.
> +
> +Setting a specific initiator name to use when logging in to the target:
> +
> +::
> +
> +  -iscsi initiator-name=3Diqn.qemu.test:my-initiator
> +
> +Controlling which type of header digest to negotiate with the target:
> +
> +::
> +
> +  -iscsi header-digest=3DCRC32C|CRC32C-NONE|NONE-CRC32C|NONE
> +
> +These can also be set via a configuration file:
> +
> +::
> +
> +  [iscsi]
> +    user =3D "CHAP username"
> +    password =3D "CHAP password"
> +    initiator-name =3D "iqn.qemu.test:my-initiator"
> +    # header digest is one of CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
> +    header-digest =3D "CRC32C"
> +
> +Setting the target name allows different options for different targets:
> +
> +::
> +
> +  [iscsi "iqn.target.name"]
> +    user =3D "CHAP username"
> +    password =3D "CHAP password"
> +    initiator-name =3D "iqn.qemu.test:my-initiator"
> +    # header digest is one of CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
> +    header-digest =3D "CRC32C"
> +
> +How to use a configuration file to set iSCSI configuration options:
> +
> +.. parsed-literal::
> +
> +  cat >iscsi.conf <<EOF
> +  [iscsi]
> +    user =3D "me"
> +    password =3D "my password"
> +    initiator-name =3D "iqn.qemu.test:my-initiator"
> +    header-digest =3D "CRC32C"
> +  EOF
> +
> +  |qemu_system| -drive file=3Discsi://127.0.0.1/iqn.qemu.test/1 \\
> +    -readconfig iscsi.conf
> +
> +How to set up a simple iSCSI target on loopback and access it via QEMU:
> +this example shows how to set up an iSCSI target with one CDROM and one =
DISK
> +using the Linux STGT software target. This target is available on Red Ha=
t based
> +systems as the package 'scsi-target-utils'.
> +
> +.. parsed-literal::
> +
> +  tgtd --iscsi portal=3D127.0.0.1:3260
> +  tgtadm --lld iscsi --op new --mode target --tid 1 -T iqn.qemu.test
> +  tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 1 \\
> +      -b /IMAGES/disk.img --device-type=3Ddisk
> +  tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 2 \\
> +      -b /IMAGES/cd.iso --device-type=3Dcd
> +  tgtadm --lld iscsi --op bind --mode target --tid 1 -I ALL
> +
> +  |qemu_system| -iscsi initiator-name=3Diqn.qemu.test:my-initiator \\
> +    -boot d -drive file=3Discsi://127.0.0.1/iqn.qemu.test/1 \\
> +    -cdrom iscsi://127.0.0.1/iqn.qemu.test/2
> +
> +GlusterFS disk images
> +---------------------
> +
> +GlusterFS is a user space distributed file system.
> +
> +You can boot from the GlusterFS disk image with the command:
> +
> +URI:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| -drive file=3Dgluster[+TYPE]://[HOST}[:PORT]]/VOLUME/PATH
> +                               [?socket=3D...][,file.debug=3D9][,file.lo=
gfile=3D...]
> +
> +JSON:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| 'json:{"driver":"qcow2",
> +                           "file":{"driver":"gluster",
> +                                    "volume":"testvol","path":"a.img","d=
ebug":9,"logfile":"...",
> +                                    "server":[{"type":"tcp","host":"..."=
,"port":"..."},
> +                                              {"type":"unix","socket":".=
.."}]}}'
> +
> +*gluster* is the protocol.
> +
> +*TYPE* specifies the transport type used to connect to gluster
> +management daemon (glusterd). Valid transport types are
> +tcp and unix. In the URI form, if a transport type isn't specified,
> +then tcp type is assumed.
> +
> +*HOST* specifies the server where the volume file specification for
> +the given volume resides. This can be either a hostname or an ipv4 addre=
ss.
> +If transport type is unix, then *HOST* field should not be specified.
> +Instead *socket* field needs to be populated with the path to unix domain
> +socket.
> +
> +*PORT* is the port number on which glusterd is listening. This is option=
al
> +and if not specified, it defaults to port 24007. If the transport type i=
s unix,
> +then *PORT* should not be specified.
> +
> +*VOLUME* is the name of the gluster volume which contains the disk image.
> +
> +*PATH* is the path to the actual disk image that resides on gluster volu=
me.
> +
> +*debug* is the logging level of the gluster protocol driver. Debug levels
> +are 0-9, with 9 being the most verbose, and 0 representing no debugging =
output.
> +The default level is 4. The current logging levels defined in the gluste=
r source
> +are 0 - None, 1 - Emergency, 2 - Alert, 3 - Critical, 4 - Error, 5 - War=
ning,
> +6 - Notice, 7 - Info, 8 - Debug, 9 - Trace
> +
> +*logfile* is a commandline option to mention log file path which helps in
> +logging to the specified file and also help in persisting the gfapi logs=
. The
> +default is stderr.
> +
> +You can create a GlusterFS disk image with the command:
> +
> +.. parsed-literal::
> +
> +  qemu-img create gluster://HOST/VOLUME/PATH SIZE
> +
> +Examples
> +
> +.. parsed-literal::
> +
> +  |qemu_system| -drive file=3Dgluster://1.2.3.4/testvol/a.img
> +  |qemu_system| -drive file=3Dgluster+tcp://1.2.3.4/testvol/a.img
> +  |qemu_system| -drive file=3Dgluster+tcp://1.2.3.4:24007/testvol/dir/a.=
img
> +  |qemu_system| -drive file=3Dgluster+tcp://[1:2:3:4:5:6:7:8]/testvol/di=
r/a.img
> +  |qemu_system| -drive file=3Dgluster+tcp://[1:2:3:4:5:6:7:8]:24007/test=
vol/dir/a.img
> +  |qemu_system| -drive file=3Dgluster+tcp://server.domain.com:24007/test=
vol/dir/a.img
> +  |qemu_system| -drive file=3Dgluster+unix:///testvol/dir/a.img?socket=
=3D/tmp/glusterd.socket
> +  |qemu_system| -drive file=3Dgluster+rdma://1.2.3.4:24007/testvol/a.img
> +  |qemu_system| -drive file=3Dgluster://1.2.3.4/testvol/a.img,file.debug=
=3D9,file.logfile=3D/var/log/qemu-gluster.log
> +  |qemu_system| 'json:{"driver":"qcow2",
> +                           "file":{"driver":"gluster",
> +                                    "volume":"testvol","path":"a.img",
> +                                    "debug":9,"logfile":"/var/log/qemu-g=
luster.log",
> +                                    "server":[{"type":"tcp","host":"1.2.=
3.4","port":24007},
> +                                              {"type":"unix","socket":"/=
var/run/glusterd.socket"}]}}'
> +  |qemu_system| -drive driver=3Dqcow2,file.driver=3Dgluster,file.volume=
=3Dtestvol,file.path=3D/path/a.img,
> +                                       file.debug=3D9,file.logfile=3D/va=
r/log/qemu-gluster.log,
> +                                       file.server.0.type=3Dtcp,file.ser=
ver.0.host=3D1.2.3.4,file.server.0.port=3D24007,
> +                                       file.server.1.type=3Dunix,file.se=
rver.1.socket=3D/var/run/glusterd.socket
> +
> +Secure Shell (ssh) disk images
> +------------------------------
> +
> +You can access disk images located on a remote ssh server
> +by using the ssh protocol:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| -drive file=3Dssh://[USER@]SERVER[:PORT]/PATH[?host_key_=
check=3DHOST_KEY_CHECK]
> +
> +Alternative syntax using properties:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| -drive file.driver=3Dssh[,file.user=3DUSER],file.host=3D=
SERVER[,file.port=3DPORT],file.path=3DPATH[,file.host_key_check=3DHOST_KEY_=
CHECK]
> +
> +*ssh* is the protocol.
> +
> +*USER* is the remote user.  If not specified, then the local
> +username is tried.
> +
> +*SERVER* specifies the remote ssh server.  Any ssh server can be
> +used, but it must implement the sftp-server protocol.  Most Unix/Linux
> +systems should work without requiring any extra configuration.
> +
> +*PORT* is the port number on which sshd is listening.  By default
> +the standard ssh port (22) is used.
> +
> +*PATH* is the path to the disk image.
> +
> +The optional *HOST_KEY_CHECK* parameter controls how the remote
> +host's key is checked.  The default is ``yes`` which means to use
> +the local ``.ssh/known_hosts`` file.  Setting this to ``no``
> +turns off known-hosts checking.  Or you can check that the host key
> +matches a specific fingerprint:
> +``host_key_check=3Dmd5:78:45:8e:14:57:4f:d5:45:83:0a:0e:f3:49:82:c9:c8``
> +(``sha1:`` can also be used as a prefix, but note that OpenSSH
> +tools only use MD5 to print fingerprints).
> +
> +Currently authentication must be done using ssh-agent.  Other
> +authentication methods may be supported in future.
> +
> +Note: Many ssh servers do not support an ``fsync``-style operation.
> +The ssh driver cannot guarantee that disk flush requests are
> +obeyed, and this causes a risk of disk corruption if the remote
> +server or network goes down during writes.  The driver will
> +print a warning when ``fsync`` is not supported:
> +
> +::
> +
> +  warning: ssh server ssh.example.com:22 does not support fsync
> +
> +With sufficiently new versions of libssh and OpenSSH, ``fsync`` is
> +supported.
> +
> +NVMe disk images
> +----------------
> +
> +NVM Express (NVMe) storage controllers can be accessed directly by a use=
rspace
> +driver in QEMU.  This bypasses the host kernel file system and block lay=
ers
> +while retaining QEMU block layer functionalities, such as block jobs, I/O
> +throttling, image formats, etc.  Disk I/O performance is typically highe=
r than
> +with ``-drive file=3D/dev/sda`` using either thread pool or linux-aio.
> +
> +The controller will be exclusively used by the QEMU process once started=
. To be
> +able to share storage between multiple VMs and other applications on the=
 host,
> +please use the file based protocols.
> +
> +Before starting QEMU, bind the host NVMe controller to the host vfio-pci
> +driver.  For example:
> +
> +.. parsed-literal::
> +
> +  # modprobe vfio-pci
> +  # lspci -n -s 0000:06:0d.0
> +  06:0d.0 0401: 1102:0002 (rev 08)
> +  # echo 0000:06:0d.0 > /sys/bus/pci/devices/0000:06:0d.0/driver/unbind
> +  # echo 1102 0002 > /sys/bus/pci/drivers/vfio-pci/new_id
> +
> +  # |qemu_system| -drive file=3Dnvme://HOST:BUS:SLOT.FUNC/NAMESPACE
> +
> +Alternative syntax using properties:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| -drive file.driver=3Dnvme,file.device=3DHOST:BUS:SLOT.FU=
NC,file.namespace=3DNAMESPACE
> +
> +*HOST*:*BUS*:*SLOT*.\ *FUNC* is the NVMe controller's PCI device
> +address on the host.
> +
> +*NAMESPACE* is the NVMe namespace number, starting from 1.
> +
> +Disk image file locking
> +-----------------------
> +
> +By default, QEMU tries to protect image files from unexpected concurrent
> +access, as long as it's supported by the block protocol driver and host
> +operating system. If multiple QEMU processes (including QEMU emulators a=
nd
> +utilities) try to open the same image with conflicting accessing modes, =
all but
> +the first one will get an error.
> +
> +This feature is currently supported by the file protocol on Linux with t=
he Open
> +File Descriptor (OFD) locking API, and can be configured to fall back to=
 POSIX
> +locking if the POSIX host doesn't support Linux OFD locking.
> +
> +To explicitly enable image locking, specify "locking=3Don" in the file p=
rotocol
> +driver options. If OFD locking is not possible, a warning will be printe=
d and
> +the POSIX locking API will be used. In this case there is a risk that th=
e lock
> +will get silently lost when doing hot plugging and block jobs, due to the
> +shortcomings of the POSIX locking API.
> +
> +QEMU transparently handles lock handover during shared storage migration=
.  For
> +shared virtual disk images between multiple VMs, the "share-rw" device o=
ption
> +should be used.
> +
> +By default, the guest has exclusive write access to its disk image. If t=
he
> +guest can safely share the disk image with other writers the
> +``-device ...,share-rw=3Don`` parameter can be used.  This is only safe =
if
> +the guest is running software, such as a cluster file system, that
> +coordinates disk accesses to avoid corruption.
> +
> +Note that share-rw=3Don only declares the guest's ability to share the d=
isk.
> +Some QEMU features, such as image file formats, require exclusive write =
access
> +to the disk image and this is unaffected by the share-rw=3Don option.
> +
> +Alternatively, locking can be fully disabled by "locking=3Doff" block de=
vice
> +option. In the command line, the option is usually in the form of
> +"file.locking=3Doff" as the protocol driver is normally placed as a "fil=
e" child
> +under a format driver. For example:
> +
> +::
> +
> +  -blockdev driver=3Dqcow2,file.filename=3D/path/to/image,file.locking=
=3Doff,file.driver=3Dfile
> +
> +To check if image locking is active, check the output of the "lslocks" c=
ommand
> +on host and see if there are locks held by the QEMU process on the image=
 file.
> +More than one byte could be locked by the QEMU instance, each byte of wh=
ich
> +reflects a particular permission that is acquired or protected by the ru=
nning
> +block driver.
> +
> +.. only:: man
> +
> +  See also
> +  --------
> +
> +  The HTML documentation of QEMU for more precise information and Linux
> +  user mode emulator invocation.
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 617485d1461..2328e7ea476 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -633,16 +633,6 @@ encrypted disk images.
>  * disk_images_snapshot_mode:: Snapshot mode
>  * vm_snapshots::              VM snapshots
>  * qemu_img_invocation::       qemu-img Invocation
> -* disk_images_formats::       Disk image file formats
> -* host_drives::               Using host drives
> -* disk_images_fat_images::    Virtual FAT disk images
> -* disk_images_nbd::           NBD access
> -* disk_images_sheepdog::      Sheepdog disk images
> -* disk_images_iscsi::         iSCSI LUNs
> -* disk_images_gluster::       GlusterFS disk images
> -* disk_images_ssh::           Secure Shell (ssh) disk images
> -* disk_images_nvme::          NVMe userspace driver
> -* disk_image_locking::        Disk image file locking
>  @end menu
>=20=20
>  @node disk_images_quickstart
> @@ -723,8 +713,6 @@ state is not saved or restored properly (in particula=
r USB).
>=20=20
>  @include qemu-img.texi
>=20=20
> -@include docs/qemu-block-drivers.texi
> -
>  @node pcsys_network
>  @section Network emulation
>=20=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 709162c159a..224a8e8712a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -953,7 +953,7 @@ STEXI
>  @findex -cdrom
>  Use @var{file} as CD-ROM image (you cannot use @option{-hdc} and
>  @option{-cdrom} at the same time). You can use the host CD-ROM by
> -using @file{/dev/cdrom} as filename (@pxref{host_drives}).
> +using @file{/dev/cdrom} as filename.
>  ETEXI
>=20=20
>  DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,


--=20
Alex Benn=C3=A9e

