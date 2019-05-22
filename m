Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF48C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 12:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73529217D4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 12:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73529217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTQ4N-0005s8-NZ
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 08:10:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTQ0k-0003gR-V7
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTQ0j-0001m2-OM
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:06:22 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:54419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTQ0j-0001kZ-FD
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:06:21 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MMnnm-1hAnEF1uxY-00IkGu; Wed, 22 May 2019 14:06:11 +0200
To: Chen-Yu Tsai <wens@kernel.org>
References: <20190514145346.20758-1-wens@kernel.org>
	<42b910fa-ca78-0231-db54-f2179fbb827c@vivier.eu>
	<CAGb2v64ArP6sahGosv9Us2NtQGUZsjKpgMt9CJjX=M+JMXZ2nw@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <10337504-1c9f-6e23-8a8a-cececf9e0bd7@vivier.eu>
Date: Wed, 22 May 2019 14:06:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v64ArP6sahGosv9Us2NtQGUZsjKpgMt9CJjX=M+JMXZ2nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lMaP1N5Rq/XnZWpQCDNVzHf+e2D+Yn3OuKuYtsggJQfU3t9BGq+
	wN8qHqkKytYS7Ft/UKdGZwaNyjp6WB28MaXQk8CUr3O0wKQ2zhSo+FhyPa9qzkeZCGANqJe
	krn+vGGAIIS/Y7MOpjw72Vt6I+mEYTwrm1Ln9R5wKIqlNUlx19Jz51sZasulsSvPHWR6m29
	QpDtwOG2xPidKqWU9Cr/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iSCkFVmJmtw=:0REP33v5bcbOd8TeWkSYf8
	1StatcVj/BDBOS3KoiGBXsN3qxSxVDVUZO2eCnvgk1HkUPnpfDWk+T/sO73KaW2BSBqhhTBua
	JLf6aV8kAlkoVCBpEAeObqMPqhsFWBIIpCmi37P6hamqL6YjWSwrv+GksRoMvmuJ+fiUFx7rD
	2df42bPKZ/GxMX7BPV2J6xP3jU0wE3Py7RHUEdbcekGsa2UaRB3LuSDbI7wQTFoNbXhF9psa9
	KJD7ts7auNYPB+N1v98qhIPLWYkcMrNcHi2Ck0ZRwdPz4z7M5LuFnZBj/AgoJky3Q7hYHOEEq
	KFqZo9lzv20fAHbAmfO3xkEkVPo3OGhwNq3AgnBrTKdUhcxcAn/enAo2n6cqr79ed+JfUhUQz
	vtXMusTM+ESR/jhnxkw9C1lFNayg/sMZ0Up606M9dRHJ/c/Bapqlm/FUav6A5E4OxT/wd9G+h
	/kL9R49CWLwIsAUT6+i5OMyz5ReAr4Y4hK3AAvUm6irEcQteHw6hnIQL00QUbopytoTUu71VG
	1ObMvyGh5Ksu/czNW9MXNPdfHqMjH6haIOEBoYfSj59vUg+JjqBBEgAK001DXLUvk4St+w2fc
	27UpdZARU+e5haj2r1q+cSQ/X5xtBdNbXCiz5tLZC6TfolI71ZML/XSZR3fGJjk6a0RvtnuOL
	HuX2yxlg2oYqDztEqSh/o/95QbtLfOctDtp8r/gW9upPoojiBMLAY4eZ5/Yhr83yGskF6R6CA
	IzVS8ITohlxNV9sQzqmJBpeIdYd4HavLZk/ORhWlBIK4UAUyBQrb+Zgf88c=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/05/2019 11:45, Chen-Yu Tsai wrote:
> On Wed, May 22, 2019 at 5:08 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> On 14/05/2019 16:53, Chen-Yu Tsai wrote:
>>> From: Chen-Yu Tsai <wens@csie.org>
>>>
>>> Since Linux 2.6 the stat syscalls have mostly supported nanosecond
>>> components for each of the file-related timestamps.
>>>
>>> QEMU user mode emulation currently does not pass through the nanosecond
>>> portion of the timestamp, even when the host system fills in the value.
>>> This results in a mismatch when run on subsecond resolution filesystems
>>> such as ext4 or XFS.
>>>
>>> An example of this leading to inconsistency is cross-debootstraping a
>>> full desktop root filesystem of Debian Buster. Recent versions of
>>> fontconfig store the full timestamp (instead of just the second portion)
>>> of the directory in its per-directory cache file, and checks this against
>>> the directory to see if the cache is up-to-date. With QEMU user mode
>>> emulation, the timestamp stored is incorrect, and upon booting the rootfs
>>> natively, fontconfig discovers the mismatch, and proceeds to rebuild the
>>> cache on the comparatively slow machine (low-power ARM vs x86). This
>>> stalls the first attempt to open whatever application that incorporates
>>> fontconfig.
>>>
>>> This patch renames the "unused" padding trailing each timestamp element
>>> to its nanosecond counterpart name if such an element exists in the
>>> kernel sources for the given platform. Not all do. Then have the syscall
>>> wrapper fill in the nanosecond portion if the host supports it, as
>>> specified by the _POSIX_C_SOURCE and _XOPEN_SOURCE feature macros.
>>>
>>> Recent versions of glibc only use stat64 and newfstatat syscalls on
>>> 32-bit and 64-bit platforms respectively. The changes in this patch
>>> were tested by directly calling the stat, stat64 and newfstatat syscalls
>>> directly, in addition to the glibc wrapper, on arm and aarch64 little
>>> endian targets.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>>
>>> ---
>>>
>>> This issue was found while integrating some software that uses newer
>>> versions of fontconfig into Raspbian images. We found that the first
>>> launch of said software always stalls with fontconfig regenerating its
>>> font cache files. Upon closer examination I found the timestamps were
>>> not matching. The rest is explained above. Currently we're just working
>>> around the problem by patching the correct timestamps into the cache
>>> files after the fact.
>>>
>>> Please consider this a drive-by scratch-my-own-itch contribution, but I
>>> will stick around to deal with any comments raised during review. I'm
>>> not on the mailing lists either, so please keep me in CC.
>>>
>>> checkpatch returns "ERROR: code indent should never use tabs" for
>>> linux-user/syscall_defs.h, however as far as I can tell the whole file
>>> is indented with tabs. I'm not sure what to make of this.
>>
>> Yes, the file is entirely indented with tabs, so you can let this as-is.
>> Anyway, I plan to split the file in several ones so we will be able to
>> swap the tabs with spaces.
>>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> 
> Thanks. Unfortunately this patch has some issues. It fails to build for
> targets that don't have the *_nsec fields, such as Alpha or M68K.

ok, anyway I always build all linux-user target before my PR, I would 
have seend the problem :)

> 
> I'll spin a v2 with a new macro TARGET_STAT_HAS_NSEC defined for targets
> that have the fields, added before each struct stat definition. The hunk
> below will gain a check against said macro. This is pretty much how the
> kernel deals with the difference as well, as I just found out.
> 
>>> @@ -8866,6 +8876,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>>>                    __put_user(st.st_atime, &target_st->target_st_atime);
>>>                    __put_user(st.st_mtime, &target_st->target_st_mtime);
>>>                    __put_user(st.st_ctime, &target_st->target_st_ctime);
>>> +#if _POSIX_C_SOURCE >= 200809L || _XOPEN_SOURCE >= 700
>>> +                __put_user(st.st_atim.tv_nsec,
>>> +                           &target_st->target_st_atime_nsec);
>>> +                __put_user(st.st_mtim.tv_nsec,
>>> +                           &target_st->target_st_mtime_nsec);
>>> +                __put_user(st.st_ctim.tv_nsec,
>>> +                           &target_st->target_st_ctime_nsec);
>>> +#endif
>>>                    unlock_user_struct(target_st, arg2, 1);
>>>                }
>>>            }
> 
> If that sounds good to you I'll keep your reviewed-by for v2.

You can.

Thanks,
Laurent


