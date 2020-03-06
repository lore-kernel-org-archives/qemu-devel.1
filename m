Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F39C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9B52072A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9B52072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA8E2-0003mR-14
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 03:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jA8DK-0003Eo-Sg
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jA8DJ-0000LQ-Vb
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:20:10 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:38645)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jA8DH-0008PY-IH; Fri, 06 Mar 2020 03:20:07 -0500
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MLRDv-1isK6U0b2p-00ISbs; Fri, 06 Mar 2020 09:19:29 +0100
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20200225121553.2191597-1-laurent@vivier.eu>
 <BYAPR02MB488629A01AD705E092CA633ADEE30@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v3 00/21] linux-user: generate syscall_nr.sh
Message-ID: <0e405da9-b187-006d-87dc-4e2fdb66706d@vivier.eu>
Date: Fri, 6 Mar 2020 09:19:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB488629A01AD705E092CA633ADEE30@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: multipart/mixed; boundary="------------9B18DD2DB93D056CB524FECC"
Content-Language: fr
X-Provags-ID: V03:K1:pwpHaStiJqLPQSJbiuincjkJdSYwwlvMPTjE9kvKkkSX3JWR2jH
 +zp79j/r5OJtCgig4SKVfhnMhD327HC6GArOKBbjOOjKurKlac6+dGCCMR/qTTWV+z0O01X
 Qt3reBebi6DAlx0I/9lHdRfjpl7unstwM+x6NPK9BP/vDVXMeFnMH9TfiGrOqfLa6db5wli
 cVdG93xx2sdkFSGtNIGkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z2AjLduWKhM=:1XdvPm8gAxt8e3ZB+RxQUq
 nmBSPDNwaTU1FrVuQ+MIcTLQ3ROdX5wSvOiSuaw3m6t0hjVxkFwZqkqIn/Zsr8lPlI8sbpxMK
 j02jjqMgpcocfttT3b+pEI0bh7cnEDng5WFMDb2v+NOC2OrEn8E61bGHjnYotS07LjkJSduyn
 wOQp6Aei25tDLeTE6Pl3GpwM7a2RmAcDgwC8aSBPmXZhLUcAo36QuWxeOVbSgPIwcEWTCIQXn
 i/rOSkpKYuoiaSEX0v8Klfjfk8uqjwp8bDyKQ591AV1B6uxMeF8IxkyzC8t3wih+gWOBxX548
 fBioRQt3ylwFyPgFtdrFQHK7UIBCY4EZ+iYuoCbNNS6pGFYhkEI1vJTOE1VXijHHns5XM7nsc
 +FZi9LhqlII6f4p+HxoU0eovRxUGCJfbWjMkyFcPEvKtOOV4Xhgq27G5fpyrKb3Im5RQy5IG3
 VsYttKSlNzJEK6I/KNqrqrXaMA0sd+kalfqZ1F19mK7PvmcXrRnjgg3ZoSS364WaZ81QihEl3
 7OkwzA3/yXQBOqDukoh3aDmChzJUysSt4wnPKitVZw2K8BaVT3aOIuOXX/pzpCTe3vWUmXM/D
 +KoxIPkN0GFxkAwvGJBhZHLb69dm4WyzeLZOlpOQfhgmSN8AhUhl/GKJbaRSg5984+ERdqvG7
 U4nBKcpiyI0gxm9lMilEKcloro+l0weGMQhQduhcvDgEYRV4QKdAFueqjh2uALUdlG+3TdfiT
 CosZZuOGrtYBWjFMu+TBis271VjZ7bwWvd+bAEIqHtOwomgl+XWL/P1CorvRpVw6NJ2pOCdtZ
 H7FnrbK+ZDv+aCWMjioauGevfFE7108GlCLM+oEiAh7rvEYRIFjhuXpREKtmS/2W8Sw1Gd8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------9B18DD2DB93D056CB524FECC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Le 06/03/2020 à 01:24, Taylor Simpson a écrit :
> Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
> 
> FWIW, the Hexagon Linux port does not use this mechanism.  I can work with our kernel maintainer and in the meantime create something suitable for qemu.

Not needed, syscall.tbl are for the old archs that don't use the
asm-generic.

I have a little script (see attachement) that converts
asm-generic/unistd.h from linux to syscall_nr.h for QEMU. I will send a
series to update the remaining archs in QEMU.

Thanks,
Laurent

--------------9B18DD2DB93D056CB524FECC
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
NF9uci5oIgpnZW5lcmF0ZV9zeXNjYWxsX25yIGhleGFnb24gMzIgIiRvdXRwdXQvbGludXgt
dXNlci9oZXhhZ29uL3N5c2NhbGxfbnIuaCIKcm0gLWZyICIkVE1QIgo=
--------------9B18DD2DB93D056CB524FECC--

