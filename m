Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92784C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC6021741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC6021741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izdiC-0003Tt-8M
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 04:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1izdfw-0002cT-Hn
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:42:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1izdfu-0007ux-5e
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:42:20 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:41129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1izdfo-0007bO-5w; Thu, 06 Feb 2020 04:42:12 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N8GAQ-1jd30K3HJg-014EvA; Thu, 06 Feb 2020 10:42:00 +0100
Subject: Re: [PATCH] monitor: fix memory leak in
 monitor_fdset_dup_fd_find_remove
To: kuhn.chenqun@huawei.com, qemu-devel@nongnu.org, dgilbert@redhat.com
References: <20200115072016.167252-1-kuhn.chenqun@huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7e4fd315-692e-f2f7-17f3-30dff0f29994@vivier.eu>
Date: Thu, 6 Feb 2020 10:41:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115072016.167252-1-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Nay1P60iK6AqdxDSjSVpf2lHzx28LWBgQ1vjgMuj2bktZI0KIye
 1WW7VY3LeIUN7vIL4jRhGXCPasvJdaihfL0uT3uaF2+hqtT9JEmz1Ms9iqXavQ9aFGzGC0b
 m+70yvShqVYc++Vb2Vr5qWTexd63tujMs8kIuY5h1fxx/raPdNqNFyoNf3oL6S76FEQb4P4
 0G9DnpSGLWWm880aQbMQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dRo33JFyT6k=:NGFaMHJ906hi0QzO62o3is
 JJ3CvFVOL5UBvW2uHdkzigYkYobFtWti7Ut/Wi+8yW5WGmCYcKeKqUOLHkQ+Nmb2cM/wSanae
 n7qSjWgaeCuvobQYVR7gC/jlmlEyEcEbM2WG7TMeJUupvr0//k3Fs/FwpO8zB0G/fOU0r1t4+
 77ozb6DJbiBT9+wccsUZHSJMrNRlnzQqZy8hwGKOqoY7sab5p0kj6Diayp0U4YjlWRdgwbapq
 W3dr8TmFJkMAaVz+ptV6yOzWbQqCvoy8Y3+m5VNBQtbJwP/cVnctqqhxbeYcBPLvWDn5GhZYl
 Fj5KBIpjWlCWfJq6XudlppQufhguAjKDppbeKa8ggQSXH9sGCxbqyPJ/iG/bGbW1XD3aXGNM9
 m7l34We8gm5uZVJn+BZA3T2hTD+QGyqBx+8AwbTBZn/2uWpvMn6I7rJUAkVmJdBlkm9VGXIXZ
 O+gnXpu1+TMLCq30DKSP9Dsbc8L8UEkEhCgZ82OAqq9dWhxAtuvgafQ4s5dy8geiZ8tgXm/2h
 mKwOr83B2zgrvu8orcGr58tDcSY8jqz0t/8ZXgXy9qIH3wedjIlghW4ncBSjEZ9O1IZAIcJSJ
 BsNzQWgZCVh+86iiMOtLsfKUsC6AWNnxXpiDSmhl0OL9u9jOEzosTC4xUnVEdS2vZemf/4E3E
 7Q7xScyx7anrDJbyiG9JxDyJVdYZX7DozCQ4VRE+mHmiHiG5pbvS9ZXGdKy2BIL3ItZM+7Ydg
 vtcGSpB7cgTausAuHzek7BsHk4V8xnyE+y916nWizINvowvi/H2en5PlHJoADYdUQCJGdBtxU
 elqhlSnL5bDkmLhheK2qlkuwwFESsh4vNTJpixfDeeObEuDUA4znwLLW7iHpZpgYPyqanYX
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
Cc: qemu-trivial@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 15/01/2020 à 08:20, kuhn.chenqun@huawei.com a écrit :
> From: Chen Qun <kuhn.chenqun@huawei.com>
> 
> When remove dup_fd in monitor_fdset_dup_fd_find_remove function,
> we need to free mon_fdset_fd_dup. ASAN shows memory leak stack:
> 
> Direct leak of 96 byte(s) in 3 object(s) allocated from:
>     #0 0xfffd37b033b3 in __interceptor_calloc (/lib64/libasan.so.4+0xd33b3)
>     #1 0xfffd375c71cb in g_malloc0 (/lib64/libglib-2.0.so.0+0x571cb)
>     #2 0xaaae25bf1c17 in monitor_fdset_dup_fd_add /qemu/monitor/misc.c:1724
>     #3 0xaaae265cfd8f in qemu_open /qemu/util/osdep.c:315
>     #4 0xaaae264e2b2b in qmp_chardev_open_file_source /qemu/chardev/char-fd.c:122
>     #5 0xaaae264e47cf in qmp_chardev_open_file /qemu/chardev/char-file.c:81
>     #6 0xaaae264e118b in qemu_char_open /qemu/chardev/char.c:237
>     #7 0xaaae264e118b in qemu_chardev_new /qemu/chardev/char.c:964
>     #8 0xaaae264e1543 in qemu_chr_new_from_opts /qemu/chardev/char.c:680
>     #9 0xaaae25e12e0f in chardev_init_func /qemu/vl.c:2083
>     #10 0xaaae26603823 in qemu_opts_foreach /qemu/util/qemu-option.c:1170
>     #11 0xaaae258c9787 in main /qemu/vl.c:4089
>     #12 0xfffd35b80b9f in __libc_start_main (/lib64/libc.so.6+0x20b9f)
>     #13 0xaaae258d7b63  (/qemu/build/aarch64-softmmu/qemu-system-aarch64+0x8b7b63)
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
>  monitor/misc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/monitor/misc.c b/monitor/misc.c
> index a04d7edde0..cf79d36100 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -1744,6 +1744,7 @@ static int64_t monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
>              if (mon_fdset_fd_dup->fd == dup_fd) {
>                  if (remove) {
>                      QLIST_REMOVE(mon_fdset_fd_dup, next);
> +                    g_free(mon_fdset_fd_dup);
>                      if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
>                          monitor_fdset_cleanup(mon_fdset);
>                      }
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

