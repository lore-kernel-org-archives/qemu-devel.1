Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FA5C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0AE21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0AE21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ata-0005xv-LW
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j6aQl-0001yF-Ry
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:39:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j6aQh-0003xS-ND
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:39:23 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:51777)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j6aQh-0003wZ-DK; Tue, 25 Feb 2020 08:39:19 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MderZ-1jfe854921-00ZctR; Tue, 25 Feb 2020 14:39:09 +0100
Subject: Re: [PATCH v2 0/2] linux-user: generate syscall_nr.sh for RISC-V
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1582586444.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <306320d5-b305-1890-3185-05353363cce5@vivier.eu>
Date: Tue, 25 Feb 2020 14:39:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1582586444.git.alistair.francis@wdc.com>
Content-Type: multipart/mixed; boundary="------------17E998FEEABEE81D847F8E95"
Content-Language: fr
X-Provags-ID: V03:K1:yHakMpK4dNtICglTp42N0h0fWqZUfFufcCVceau3t769sYrpgng
 r6wewy0jrE6kFkttXR0ndnwOlDu1102nossA7RiRM450h0ZHMzTrNZouwBi98undB4UCtdA
 GmEr5UpW0/J455h2CElWtJwvq1xOMH6DDb8G6peaxCNOmCGbEq/J7QZWBEIW3LKw/RM0KV5
 xctCL/0euQTDhsEibASGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x2x6S7VRW7Q=:y/EJy8oOLW7Q4iqy4KYznE
 PveQNWtaqUr7uo9Yu6wS+AkkMLnCFV+95RH6TfV4MBg0k71Ishvy/1/LQyo+O43ShBpOiskZa
 KLDVFNVv43LYz4fX8IqZLy+JEORylgrLaAByZ1G4ypEGpQmsRzsJYZ7qXMRZrpHUzRxqKtvwm
 5FND65cTivT9EfReWzxKOxVKTXYVazQ441FsDhRCVOOkeB6yEKkccIPzWPbAQEey18PyXceBa
 UzYiabeEOrdwUYY6i3dkLQWBJRAmAAQIXjSeCRh7XIFbC9HSJQvjCNFjshNV/SWCRpThMrnjR
 Cr6eVgQdUIfHLAxz1XbTRhWohhAFS+uXXBTjISIYhMtxL6H/2GqikfDF/oCDNXs+zCW5kTPSu
 vkz9ZQWA65Hm51PVvqJQ/n/SGvsNwt7nyUzLLhgT3kOvpPgp+4peHneiBZoaQkiYvCEp5czM8
 Ka3yJaqdNbr4eMpcgr4kA243udNSPlsXBrOlJhbBRv8LyuDETCK3HXs2dpKuxznWfpYzygezG
 1eZOs7JoUhrYLBgnjlSBNOzNZffbAiqrMyP0uRUY69ljgJuyydh6XrJHNQO0xDS3cKQgxqiT/
 TwJBIfvRSDyjVg4fKQdIRpMd+qPQoB+O+x/lxz8lOL0Ak3XWYaYtfroeX0Kq8SUspM9ulEnHl
 06MdCOJO3NYHMWVPhxOMMtJaOaf0tRIgpCZxKIcdktV4j2/8nHrZzIbCSzf84aXbqP5w5bRqL
 hebqhyPZ7JAxn9e5u0BeLMaBLik2SKs+8iwS7cdYcI3FHRCsCu0cGjBlGUqhs/Ep+3RfTkBSc
 +8MHHSCozBHh81rhY9LRXzf1LxcV06rEeeGGVcHpmTny39S8Sr2U4pZXyvhIoL1vNVTDZMF
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------17E998FEEABEE81D847F8E95
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Le 25/02/2020 à 00:21, Alistair Francis a écrit :
> This series updates the RISC-V syscall_nr.sh based on the 5.5 kernel.
> 
> There are two parts to this. One is just adding the new syscalls, the
> other part is updating the RV32 syscalls to match the fact that RV32 is
> a 64-bit time_t architectures (y2038) safe.
> 
> we need to make some changes to syscall.c to avoid warnings/errors
> during compliling with the new syscall.
> 
> I did some RV32 user space testing after applying these patches. I ran the
> glibc testsuite in userspace and I don't see any regressions.
> 
> Alistair Francis (2):
>   linux-user: Protect more syscalls
>   linux-user/riscv: Update the syscall_nr's to the 5.5 kernel
> 
>  linux-user/riscv/syscall32_nr.h | 314 ++++++++++++++++++++++++++++++++
>  linux-user/riscv/syscall64_nr.h | 303 ++++++++++++++++++++++++++++++
>  linux-user/riscv/syscall_nr.h   | 294 +-----------------------------
>  linux-user/strace.c             |   2 +
>  linux-user/syscall.c            |  20 ++
>  5 files changed, 641 insertions(+), 292 deletions(-)
>  create mode 100644 linux-user/riscv/syscall32_nr.h
>  create mode 100644 linux-user/riscv/syscall64_nr.h
> 

I have written a shell script to generate the syscall_nr.h from the
asm-generic, but as it uses a lot of cpp, tr, sed and grep, the result
needs to be checked.

If it can help, it is in attachment.

Put it in scripts, and run it as:

scripts/gensyscalls.sh /path/to/linux

then check the result with something like "git diff -w"

Thanks,
Laurent

--------------17E998FEEABEE81D847F8E95
Content-Type: application/x-shellscript;
 name="gensyscalls.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="gensyscalls.sh"

IyEvYmluL3NoCgpsaW51eD0iJDEiCm91dHB1dD0iJDIiCgpUTVA9JChta3RlbXAgLWQpCgpp
ZiBbICIkbGludXgiID0gIiIgXSA7IHRoZW4KICAgIGVjaG8gIk5lZWRzIHBhdGggdG8gbGlu
dXggc291cmNlIHRyZWUiIDE+JjIKICAgIGV4aXQgMQpmaQoKaWYgWyAiJG91dHB1dCIgPSAi
IiBdIDsgdGhlbgogICAgb3V0cHV0PSIkUFdEIgpmaQoKdXBwZXIoKQp7CiAgICBlY2hvICIk
MSIgfCB0ciAiWzpsb3dlcjpdIiAiWzp1cHBlcjpdIiB8IHRyICJbOnB1bmN0Ol0iICJfIgp9
CgpxZW11X2FyY2goKQp7CiAgICBjYXNlICIkMSIgaW4KICAgIGFybTY0KQogICAgICAgIGVj
aG8gImFhcmNoNjQiCiAgICAgICAgOzsKICAgICopCiAgICAgICAgdXBwZXIgIiQxIgogICAg
ICAgIDs7CiAgICBlc2FjCn0KCnJlYWRfaW5jbHVkZXMoKQp7CiAgICBhcmNoPSQxCiAgICBi
aXRzPSQyCgogICAgIGNwcCAtUCAtbm9zdGRpbmMgLWZkaXJlY3RpdmVzLW9ubHkgXAogICAg
ICAgIC1EX1VBUElfQVNNXyQodXBwZXIgJHthcmNofSlfQklUU1BFUkxPTkdfSCBcCiAgICAg
ICAgLURfX0JJVFNfUEVSX0xPTkc9JHtiaXRzfSBcCiAgICAgICAgLUkke2xpbnV4fS9hcmNo
LyR7YXJjaH0vaW5jbHVkZS91YXBpLyBcCiAgICAgICAgLUkke2xpbnV4fS9pbmNsdWRlL3Vh
cGkgXAogICAgICAgIC1JJHtUTVB9IFwKICAgICAgICAiJHtsaW51eH0vYXJjaC8ke2FyY2h9
L2luY2x1ZGUvdWFwaS9hc20vdW5pc3RkLmgiCn0KCmZpbHRlcl9kZWZpbmVzKCkKewogICAg
Z3JlcCAtZSAiI2RlZmluZSBfX05SXyIgLWUgIiNkZWZpbmUgX19OUjMyNjQiCn0KCnJlbmFt
ZV9kZWZpbmVzKCkKewogICAgc2VkICJzLyBfX05SXy8gVEFSR0VUX05SXy9nO3MvKF9fTlJf
LyhUQVJHRVRfTlJfL2ciCn0KCmV2YWx1YXRlX3ZhbHVlcygpCnsKICAgIHNlZCAicy8jZGVm
aW5lIFRBUkdFVF9OUl8vUUVNVSBUQVJHRVRfTlJfLyIgfCBcCiAgICBjcHAgLVAgLW5vc3Rk
aW5jIHwgXAogICAgc2VkICJzL15RRU1VIC8jZGVmaW5lIC8iCn0KCmdlbmVyYXRlX3N5c2Nh
bGxfbnIoKQp7CiAgICBhcmNoPSQxCiAgICBiaXRzPSQyCiAgICBmaWxlPSIkMyIKICAgIGd1
YXJkPSIkKHVwcGVyIExJTlVYX1VTRVJfJChxZW11X2FyY2ggJGFyY2gpXyQoYmFzZW5hbWUg
IiRmaWxlIikpIgoKICAgIChlY2hvICIvKiIKICAgIGVjaG8gIiAqIFRoaXMgZmlsZSBjb250
YWlucyB0aGUgc3lzdGVtIGNhbGwgbnVtYmVycy4iCiAgICBlY2hvICIgKi8iCiAgICBlY2hv
ICIjaWZuZGVmICR7Z3VhcmR9IgogICAgZWNobyAiI2RlZmluZSAke2d1YXJkfSIKICAgIGVj
aG8KICAgIHJlYWRfaW5jbHVkZXMgJGFyY2ggJGJpdHMgfCBmaWx0ZXJfZGVmaW5lcyB8IHJl
bmFtZV9kZWZpbmVzIHwgXAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV2YWx1
YXRlX3ZhbHVlcyB8IHNvcnQgLW4gLWsgMwogICAgZWNobwogICAgZWNobyAiI2VuZGlmIC8q
ICR7Z3VhcmR9ICovIgogICAgZWNobykgPiAiJGZpbGUiCn0KCm1rZGlyICIkVE1QL2FzbSIK
PiAiJFRNUC9hc20vYml0c3BlcmxvbmcuaCIKCmdlbmVyYXRlX3N5c2NhbGxfbnIgYXJtNjQg
NjQgIiRvdXRwdXQvbGludXgtdXNlci9hYXJjaDY0L3N5c2NhbGxfbnIuaCIKZ2VuZXJhdGVf
c3lzY2FsbF9uciBuaW9zMiAzMiAiJG91dHB1dC9saW51eC11c2VyL25pb3MyL3N5c2NhbGxf
bnIuaCIKZ2VuZXJhdGVfc3lzY2FsbF9uciBvcGVucmlzYyAzMiAiJG91dHB1dC9saW51eC11
c2VyL29wZW5yaXNjL3N5c2NhbGxfbnIuaCIKCmdlbmVyYXRlX3N5c2NhbGxfbnIgcmlzY3Yg
MzIgIiRvdXRwdXQvbGludXgtdXNlci9yaXNjdi9zeXNjYWxsMzJfbnIuaCIKZ2VuZXJhdGVf
c3lzY2FsbF9uciByaXNjdiA2NCAiJG91dHB1dC9saW51eC11c2VyL3Jpc2N2L3N5c2NhbGw2
NF9uci5oIgpybSAtZnIgIiRUTVAiCg==
--------------17E998FEEABEE81D847F8E95--

