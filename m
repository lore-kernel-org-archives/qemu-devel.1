Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411A3C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 11:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F8120747
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 11:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKT98z0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F8120747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQUVf-0008CE-6h
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 07:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36092 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQUSb-0006GI-9B
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:19:33 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQUSZ-0004FZ-Up
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:19:32 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38455)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQUSY-0004Ea-GM
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:19:30 -0400
Received: by mail-ot1-x344.google.com with SMTP id q9so1076148otf.5
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 04:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e29Sh5IimfCKpqH0hBK++S43Pnt0kxeDo73Bk32ebac=;
 b=eKT98z0rlqPd4Kddmlbg2xii0nzNK7Sm2cE/Q6/CBrjGOOjyYbLacaC4mYzeDR8qth
 NYoIsJE4FH1XfuGxFDuyzVazcMc0nCSjEa9a4BoVe6619W6MbmSZiDGTwBJLCugjX94j
 D++G15LhNNY0COTf7B9pMxjnmtdEZE97ilXLn6lh33Dn7MvW638xIp/BR1nPmPfMviBj
 FNpPjQkGh5S1hvic5k0OhT1PISv5NGV872ANVVrLN6U9lQn+WmLvNxb4D1kstjbjuRyG
 Wqu/og9QYMpF+EUzjWCQLy6X/P3KWKVVBWPwxR1/geHYWXhhugNMNhDt7ZGW+Ch5fDZt
 CTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e29Sh5IimfCKpqH0hBK++S43Pnt0kxeDo73Bk32ebac=;
 b=qLZWkOhfXKYCAn2v/ggepXVE3nYRMtkDwsJk9UnCjLs5kBvlSEQR/RM8TW0+26X4YH
 X0E2bL4NNiNmDvjVLu3U58KuajOeV79CRZGOjD0m3nLvfakOfRGWOomrJOA9iTcH2r61
 SVNe76jNzkfNJrDhH/IH5NUU4rXarf1x88QO5t89DKgWDVOxa2GXyKlYVfX5c4Y6UUTI
 yUPPCNvkJZ/k7oO8gVBI9xoSnZTvTOfyTS3gmGczyxO7SCDd9cRHbfd/UWXXGE170eC6
 rWpUa5tUxd0keL002HEZrqDDs/pw4mx4JkwEWcJeCThWHSLdLKabAjcG8BApLliIHuO5
 U6xw==
X-Gm-Message-State: AGi0Pua9lljN9eeY+kKrLLKyZY1TBq6Ry5NUk48Mh4yEeyzeyJx7ebIK
 c9oOAL5BB6Behpwc0tNLS/Zo9LPhzC52VhCUcblBlg==
X-Google-Smtp-Source: APiQypISlIaSdLEv9rD1htlLD8VkbzpN2m6GxaJB8UzqhFJFyFLfmU6fCYcTBRnsKquAseuGmbeStBgIrDCH+Py5D9A=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr8665535otc.221.1587381568875; 
 Mon, 20 Apr 2020 04:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133536.3328-1-linus.walleij@linaro.org>
In-Reply-To: <20200331133536.3328-1-linus.walleij@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Apr 2020 12:19:17 +0100
Message-ID: <CAFEAcA9Gep1HN+7WJHencp9g2uUBLhagxdgjHf-16AOdP5oOjg@mail.gmail.com>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
To: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Theodore Ts'o <tytso@mit.edu>, Linux API <linux-api@vger.kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Florian Weimer <fw@deneb.enyo.de>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Andy Lutomirski <luto@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Mar 2020 at 14:37, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> It was brought to my attention that this bug from 2018 was
> still unresolved: 32 bit emulators like QEMU were given
> 64 bit hashes when running 32 bit emulation on 64 bit systems.
>
> This adds a fcntl() operation to set the underlying filesystem
> into 32bit mode even if the file hanle was opened using 64bit
> mode without the compat syscalls.
>
> Programs that need the 32 bit file system behavior need to
> issue a fcntl() system call such as in this example:
>
>   #define F_SET_FILE_32BIT_FS (1024 + 15)
>
>   int main(int argc, char** argv) {
>     DIR* dir;
>     int err;
>     int fd;
>
>     dir = opendir("/boot");
>     fd = dirfd(dir);
>     err = fcntl(fd, F_SET_FILE_32BIT_FS);
>     if (err) {
>       printf("fcntl() failed! err=%d\n", err);
>       return 1;
>     }
>     printf("dir=%p\n", dir);
>     printf("readdir(dir)=%p\n", readdir(dir));
>     printf("errno=%d: %s\n", errno, strerror(errno));
>     return 0;
>   }

I gave this a try with a modified QEMU, but it doesn't seem
to fix the problem. Here's the relevant chunk of the strace
output from stracing a QEMU that's running a 32-bit guest
binary that issues a getdents64 and fails (it's the 'readdir-bug'
test case from the launchpad bug):

openat(AT_FDCWD, ".", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3
fcntl(3, 0x40f /* F_??? */, 0x3)        = 0
fstat(3, {st_dev=makedev(0, 16), st_ino=4637237, st_mode=S_IFDIR|0755,
st_nlink=12, st_uid=1000, st_gid=1000, st_blksize=8192, st_blocks=8,
st_size=4096, st_atime=1587380917 /*
2020-04-20T11:08:37.756174607+0000 */, st_atime_nsec=756174607,
st_mtime=1587380910 /* 2020-04-20T11:08:30.356230179+0000 */,
st_mtime_nsec=356230179, st_ctime=1587380910 /*
2020-04-20T11:08:30.356230179+0000 */, st_ctime_nsec=356230179}) = 0
fstat(1, {st_dev=makedev(0, 2), st_ino=9017, st_mode=S_IFCHR|0600,
st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0,
st_rdev=makedev(5, 1), st_atime=1587381196 /* 2020-04-20T11:13:16+0000
*/, st_atime_nsec=0, st_mtime=1587381196 /* 2020-04-20T11:13:16+0000
*/, st_mtime_nsec=0, st_ctime=1587381042 /*
2020-04-20T11:10:42.484981152+0000 */, st_ctime_nsec=484981152}) = 0
ioctl(1, TCGETS, {c_iflags=0x2502, c_oflags=0x5, c_cflags=0xcbd,
c_lflags=0x8a3b, c_line=0,
c_cc="\x03\x1c\x7f\x15\x04\x00\x01\x00\x11\x13\x1a\x00\x12\x0f\x17\x16\x00\x00\x00"})
= 0
write(1, "dir=0x76128\n", 12)           = 12
getdents64(3, [{d_ino=1, d_off=273341893525646730, d_reclen=24,
d_type=DT_DIR, d_name=".."}, {d_ino=4637239, d_off=849308795555391993,
d_reclen=24, d_type=DT_DIR, d_name="etc"}, {d_ino=4587984,
d_off=1620709961571101518, d_reclen=24, d_type=DT_LNK, d_name="usr"},
{d_ino=4637238, d_off=2787937917159437645, d_reclen=24, d_type=DT_DIR,
d_name="dev"}, {d_ino=4637244, d_off=3015508490233103491, d_reclen=24,
d_type=DT_DIR, d_name="sys"}, {d_ino=4587608,
d_off=3551089360661460833, d_reclen=24, d_type=DT_LNK, d_name="lib"},
{d_ino=4637246, d_off=3857320197951442970, d_reclen=24, d_type=DT_DIR,
d_name="var"}, {d_ino=4637242, d_off=4103122318823701457, d_reclen=24,
d_type=DT_DIR, d_name="proc"}, {d_ino=4587541,
d_off=4252201186220906002, d_reclen=24, d_type=DT_LNK, d_name="bin"},
{d_ino=4637245, d_off=4386533378951587638, d_reclen=24, d_type=DT_DIR,
d_name="tmp"}, {d_ino=4637241, d_off=4883206313583644962, d_reclen=24,
d_type=DT_DIR, d_name="host"}, {d_ino=4637237,
d_off=4941119754928488586, d_reclen=24, d_type=DT_DIR, d_name="."},
{d_ino=4637243, d_off=5301154723342888169, d_reclen=24, d_type=DT_DIR,
d_name="root"}, {d_ino=4587838, d_off=6989908915879243400,
d_reclen=32, d_type=DT_LNK, d_name="lib64"}, {d_ino=4587679,
d_off=7356513223657690979, d_reclen=32, d_type=DT_REG,
d_name="strace.log"}, {d_ino=4587847, d_off=7810090083157553519,
d_reclen=24, d_type=DT_LNK, d_name="sbin"}, {d_ino=4637240,
d_off=8254997891991845677, d_reclen=24, d_type=DT_DIR, d_name="home"},
{d_ino=4637248, d_off=9223372036854775807, d_reclen=24, d_type=DT_DIR,
d_name="virt"}], 32768) = 448
write(1, "readdir(dir)=(nil)\n", 19)    = 19
write(1, "errno=75: Value too large for de"..., 48) = 48
exit_group(0)                           = ?


We open fd 3 to read '.'; we issue the new fcntl, which
succeeds. Then there's some unrelated stuff operating on
stdout. Then we do a getdents64(), but the d_off values
we get back are still 64 bits. The guest binary doesn't
like those, so it fails. My expectation was that we would
get back d_off values here that were in the 32 bit range.

(To be clear, the guest binary here is doing a getdents64(),
which QEMU translates into a host getdents64().)

thanks
-- PMM

