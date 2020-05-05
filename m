Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE44C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 08:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC7320661
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 08:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC7320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVt5n-0001Fs-Cj
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 04:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVt1e-0004w2-Sg; Tue, 05 May 2020 04:34:06 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:43017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVt1d-0002Mg-6G; Tue, 05 May 2020 04:34:02 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MsI0I-1jHFmf2Rh4-00tkOJ; Tue, 05 May 2020 10:33:43 +0200
Subject: Re: [PATCH v3 00/12] user-mode: Prune build dependencies (part 1)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200504152922.21365-1-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7f19b263-5493-779b-cf86-b0499c7dc80d@vivier.eu>
Date: Tue, 5 May 2020 10:33:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504152922.21365-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lBBCM+rJBMA9B9xYXM5G/mh/X58kDkXvzgSQIrCZu7W/8aF0TwM
 7sGx8JS9N3wMUi4mflsDSl9ipnh3+oOt49vsV4STeTBhaDahRSZrcO5ULXdxN02xOvKSEQE
 /TrBT5Mp8jjJhH/2iQTFE34Hsdupq/iM5wLNB9L5TIUaVz78ifdM658YsY9Mi4g0/NUSE2x
 NX9Ym+Vbu2wQJYlSbNsgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ELr7W7YrKso=:j9JXoxDLzSIJwFbJSwri31
 oHJepnhY0sdNXpnF7scGqmU/szUN9dzyAN/4Ij/VPFcii7aPfpMwdNk1eNtQVwFU46eCsWndl
 mwud/rcY6N6pKxl3SJirGGRLOhfw/JLrlCeiS3yXtein7bVE5tsr6MgZS3I/KBgE64xld4GuT
 pnb9+xN3pBizrrIfCdNkwCFZDnMKneb0rw5Dzsu7JNaf7K+KssykGSydLQVYa//MREsFhGRaO
 bL0/Hi91zWb6acJG7jpUyQCBht56DVs8RpgEZ/CQK7xefGXd8P++Q3Y9qgvbeu+bX9PuPE9U6
 30yRzDh/wY1FKrwggfEjIY7Xbut/z6IRqV8cQxmHssrQsepuO/0YuUQrxs2hB6+eSuVuqoBp5
 I1CHKCq0xKf0Wt7Wo6JMS0e86wpsAfHvoUXHoiyDgDn+3P1jy4asG4FkozqiCihnDgApJMFpQ
 p1bWTM2CVm4s7S+ZbnG4L6cU9/53ou3S/wmaorokS96qMg2KU+DfGgJ9rHgZNQ5YiZvcKjzUU
 wOb2sPlu/kX2d4uoMnixxh39aNtxwGVCwyTSnwDgIags95q2zIbR0/WPnM8cd+rE6SSRTlg5P
 r/IOO6SuHkK9qZaiY7MA+XXBgcEHAtEE9ksg7KX2X8MCiYbTrVwxu5K0ytRY6vzVHs+jMm43c
 RHRS8UHXOGyL4tm83LJlfZcWOtt+qzky5V7mqWE+JBVRWFvPv6DWSZz3cVNj2yQJWESTnYQoa
 oJqZvE6RSi+iUUgGBwXbyrK3XWn76gVmerObUIrEbMhEq/rFkCMjfIdZ/rLr5fWWxUQfpFTaT
 2+EwRKMoHdtNhbGVotmT0gDjwS2mtpWlN4B7l6egyUtfOJO3NDF8h9ZCkBEVcNggwXnzRGU
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 04:33:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-riscv@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/05/2020 à 17:29, Philippe Mathieu-Daudé a écrit :
> This is the first part of a series reducing user-mode
> dependencies. By stripping out unused code, the build
> and testing time is reduced (as is space used by objects).
> 
> Part 1 (generic):
> - reduce user-mode object list
> - remove some migration code from user-mode
> - remove cpu_get_crash_info()
> 
> This series is fully reviewed.
> 
> Since v2:
> - Rebased due to conflict when applying patch:
>   "util/Makefile: Reduce the user-mode object list"
>   because commit 01ef6b9e4e modified util/Makefile.objs:
>   "linux-user: factor out reading of /proc/self/maps"
> 
> Since v1:
> - Addressed Laurent/Richard review comments
> - Removed 'exec: Drop redundant #ifdeffery'
> - Removed 'target: Restrict write_elfXX_note() handlers to system-mode'
> 
> $ git backport-diff -u v1 -r v2
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream patch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
> 
> 001/12:[----] [--] 'Makefile: Only build virtiofsd if system-mode is enabled'
> 002/12:[----] [--] 'configure: Avoid building TCG when not needed'
> 003/12:[----] [--] 'tests/Makefile: Only display TCG-related tests when TCG is available'
> 004/12:[----] [--] 'tests/Makefile: Restrict some softmmu-only tests'
> 005/12:[----] [-C] 'util/Makefile: Reduce the user-mode object list'
> 006/12:[----] [--] 'stubs/Makefile: Reduce the user-mode object list'
> 007/12:[----] [--] 'target/riscv/cpu: Restrict CPU migration to system-mode'
> 008/12:[----] [--] 'exec: Assert CPU migration is not used on user-only build'
> 009/12:[----] [--] 'arch_init: Remove unused 'qapi-commands-misc.h' include'
> 010/12:[----] [--] 'target/i386: Restrict CpuClass::get_crash_info() to system-mode'
> 011/12:[----] [--] 'target/s390x: Restrict CpuClass::get_crash_info() to system-mode'
> 012/12:[----] [--] 'hw/core: Restrict CpuClass::get_crash_info() to system-mode'
> 
> Philippe Mathieu-Daudé (12):
>   Makefile: Only build virtiofsd if system-mode is enabled
>   configure: Avoid building TCG when not needed
>   tests/Makefile: Only display TCG-related tests when TCG is available
>   tests/Makefile: Restrict some softmmu-only tests
>   util/Makefile: Reduce the user-mode object list
>   stubs/Makefile: Reduce the user-mode object list
>   target/riscv/cpu: Restrict CPU migration to system-mode
>   exec: Assert CPU migration is not used on user-only build
>   arch_init: Remove unused 'qapi-commands-misc.h' include
>   target/i386: Restrict CpuClass::get_crash_info() to system-mode
>   target/s390x: Restrict CpuClass::get_crash_info() to system-mode
>   hw/core: Restrict CpuClass::get_crash_info() to system-mode
> 
>  configure              |  4 +++
>  Makefile               |  2 +-
>  include/hw/core/cpu.h  |  7 ++++-
>  arch_init.c            |  1 -
>  exec.c                 |  4 ++-
>  hw/core/cpu.c          |  2 ++
>  target/i386/cpu.c      |  6 ++++-
>  target/riscv/cpu.c     |  6 +++--
>  target/s390x/cpu.c     | 12 ++++-----
>  stubs/Makefile.objs    | 52 +++++++++++++++++++++----------------
>  tests/Makefile.include | 18 +++++++------
>  util/Makefile.objs     | 59 +++++++++++++++++++++++++++---------------
>  12 files changed, 108 insertions(+), 65 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>

