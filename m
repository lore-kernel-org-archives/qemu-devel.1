Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE01AC18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B20E217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfKKJN06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B20E217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39355 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTNqP-0002Rh-Ph
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 05:47:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wens@kernel.org>) id 1hTNoq-0001mc-3X
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wens@kernel.org>) id 1hTNoo-0004FM-U8
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wens@kernel.org>) id 1hTNoo-0004E9-CP
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:45:54 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
	[209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 44E8321841
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 09:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558518352;
	bh=ClXVxlz3Vz4he3Br8PuLKK9BuYCxEL0+RGBXqrwWkyc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QfKKJN06tgvVPJGC1FIRBLr8yxNM5KQGIIaOOaihXNzfR4xJV2N9ZrsIZNNTZlGi5
	Vms7AKbpbnQNI6modqJGea2YJWW/FPR0IpiAGS2oqTMs19f8h39pvOcIplXXXB9nQj
	308mFM5lQunu2GVgxkjlV/REpY+fDf5N/RHO6LO8=
Received: by mail-wr1-f50.google.com with SMTP id w13so1490569wru.11
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 02:45:52 -0700 (PDT)
X-Gm-Message-State: APjAAAVu65jKPAg7JYTy9FilzQwJZmxBSt9TCodYEMqWbBU/6qf1YdTd
	wUHHiTgWu/lYqugpSWpI5sJvyLscGnfyi8bS2t0=
X-Google-Smtp-Source: APXvYqyWbROQJAK2jlOkdEWN8oJGO2lnBUogeEoc4Utj/0VkNtY5k9mCqkgEghIpBFUK+IwZdPKg7UF081TOsG4Zmrg=
X-Received: by 2002:adf:9023:: with SMTP id h32mr41486056wrh.95.1558518350840; 
	Wed, 22 May 2019 02:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190514145346.20758-1-wens@kernel.org>
	<42b910fa-ca78-0231-db54-f2179fbb827c@vivier.eu>
In-Reply-To: <42b910fa-ca78-0231-db54-f2179fbb827c@vivier.eu>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 22 May 2019 17:45:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v64ArP6sahGosv9Us2NtQGUZsjKpgMt9CJjX=M+JMXZ2nw@mail.gmail.com>
Message-ID: <CAGb2v64ArP6sahGosv9Us2NtQGUZsjKpgMt9CJjX=M+JMXZ2nw@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
Subject: Re: [Qemu-devel] [PATCH] linux-user: Pass through nanosecond
 timestamp components for stat syscalls
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Chen-Yu Tsai <wens@kernel.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 22, 2019 at 5:08 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> On 14/05/2019 16:53, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > Since Linux 2.6 the stat syscalls have mostly supported nanosecond
> > components for each of the file-related timestamps.
> >
> > QEMU user mode emulation currently does not pass through the nanosecond
> > portion of the timestamp, even when the host system fills in the value.
> > This results in a mismatch when run on subsecond resolution filesystems
> > such as ext4 or XFS.
> >
> > An example of this leading to inconsistency is cross-debootstraping a
> > full desktop root filesystem of Debian Buster. Recent versions of
> > fontconfig store the full timestamp (instead of just the second portion)
> > of the directory in its per-directory cache file, and checks this against
> > the directory to see if the cache is up-to-date. With QEMU user mode
> > emulation, the timestamp stored is incorrect, and upon booting the rootfs
> > natively, fontconfig discovers the mismatch, and proceeds to rebuild the
> > cache on the comparatively slow machine (low-power ARM vs x86). This
> > stalls the first attempt to open whatever application that incorporates
> > fontconfig.
> >
> > This patch renames the "unused" padding trailing each timestamp element
> > to its nanosecond counterpart name if such an element exists in the
> > kernel sources for the given platform. Not all do. Then have the syscall
> > wrapper fill in the nanosecond portion if the host supports it, as
> > specified by the _POSIX_C_SOURCE and _XOPEN_SOURCE feature macros.
> >
> > Recent versions of glibc only use stat64 and newfstatat syscalls on
> > 32-bit and 64-bit platforms respectively. The changes in this patch
> > were tested by directly calling the stat, stat64 and newfstatat syscalls
> > directly, in addition to the glibc wrapper, on arm and aarch64 little
> > endian targets.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > ---
> >
> > This issue was found while integrating some software that uses newer
> > versions of fontconfig into Raspbian images. We found that the first
> > launch of said software always stalls with fontconfig regenerating its
> > font cache files. Upon closer examination I found the timestamps were
> > not matching. The rest is explained above. Currently we're just working
> > around the problem by patching the correct timestamps into the cache
> > files after the fact.
> >
> > Please consider this a drive-by scratch-my-own-itch contribution, but I
> > will stick around to deal with any comments raised during review. I'm
> > not on the mailing lists either, so please keep me in CC.
> >
> > checkpatch returns "ERROR: code indent should never use tabs" for
> > linux-user/syscall_defs.h, however as far as I can tell the whole file
> > is indented with tabs. I'm not sure what to make of this.
>
> Yes, the file is entirely indented with tabs, so you can let this as-is.
> Anyway, I plan to split the file in several ones so we will be able to
> swap the tabs with spaces.
>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks. Unfortunately this patch has some issues. It fails to build for
targets that don't have the *_nsec fields, such as Alpha or M68K.

I'll spin a v2 with a new macro TARGET_STAT_HAS_NSEC defined for targets
that have the fields, added before each struct stat definition. The hunk
below will gain a check against said macro. This is pretty much how the
kernel deals with the difference as well, as I just found out.

> > @@ -8866,6 +8876,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
> >                   __put_user(st.st_atime, &target_st->target_st_atime);
> >                   __put_user(st.st_mtime, &target_st->target_st_mtime);
> >                   __put_user(st.st_ctime, &target_st->target_st_ctime);
> > +#if _POSIX_C_SOURCE >= 200809L || _XOPEN_SOURCE >= 700
> > +                __put_user(st.st_atim.tv_nsec,
> > +                           &target_st->target_st_atime_nsec);
> > +                __put_user(st.st_mtim.tv_nsec,
> > +                           &target_st->target_st_mtime_nsec);
> > +                __put_user(st.st_ctim.tv_nsec,
> > +                           &target_st->target_st_ctime_nsec);
> > +#endif
> >                   unlock_user_struct(target_st, arg2, 1);
> >               }
> >           }

If that sounds good to you I'll keep your reviewed-by for v2.

Thanks
ChenYu

