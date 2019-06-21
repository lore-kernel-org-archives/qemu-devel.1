Return-Path: <SRS0=QkNH=UV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEB8C43613
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 00:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044AF2070B
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 00:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AExfeHhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044AF2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38600 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heUD2-00058n-8F
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 20:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33676)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marlies.ruck@gmail.com>) id 1heSUm-0007me-1o
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 18:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marlies.ruck@gmail.com>) id 1heSUj-0006I0-Ve
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 18:58:59 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e]:45238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marlies.ruck@gmail.com>)
 id 1heSUh-00069U-SB
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 18:58:56 -0400
Received: by mail-io1-xd2e.google.com with SMTP id e3so4914742ioc.12
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 15:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=1g0zr3kl3LbsJ+l0SJdCuFf9ZDEbk/mv+OJ3WSy3lAA=;
 b=AExfeHhEpVDI//Q7/yona9Gz+S5w7F0JJTBpW7iGHujPq2zFedsMTqG1WVOT+gAVZi
 OWAqrgnMe8vTDIZ/zXvB1ZCe7ogVYh3iiTRJX3jYjtM4HEfXTc6bCXC+grjafZsQvDcm
 Y3dr81kywR/PHp6lGDSYQwRI5x/VMN4zk3cwVzzgmiTTnaiaprjMySI8rS8XJkuewXJR
 04pylUBciVdTLXglOO61xWIqmkfoksj/VUfQtp6r771KvuTAvDEmu0k0MEb9LV+/F2Ks
 wzmN/m+wmVoD/sYxQTXnXjcfKcioeE4NPo346AVyKzyjZurpKBGY7IRnilU1mSn0Jok6
 Ar6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=1g0zr3kl3LbsJ+l0SJdCuFf9ZDEbk/mv+OJ3WSy3lAA=;
 b=UZuEFTQc0lwug94iJ7k2EhgoA/JRrRmY+iw3IjqEKrhKG28cO2gmGI7zjxo1h+d/Ws
 7tXAW0lkCMgDvo12BxjOkesGNChksXxK7PCcZX/WkhtHNJqgxLk8iECZ7MJ9qizUclfG
 WcLU7nc/iPNZtcK9vqqvnaFuYURhLyX3wZRaNRN0PhRqK3wkoq0piUni0QAkl/OsSeM+
 EQlzRIW7HXlR7euKlq3VDdYuPo+6MPLxWA+3XSHT2075y58/eZshWP5cytYx+uRtKpcR
 jF5FBn40/ptAO7pLaj/or6stFCiMXHnPTD+kCboeRBLFBnU0S2B6gm6mD8UkvAJqTDVT
 +YUQ==
X-Gm-Message-State: APjAAAXAgCmwT5cHCeeA6O+dJ/HfFIMxykOhdJKF2n9YwMA/pNOR0LdF
 faPA/etNI5t/7VS/6U3QXB2FukZmxSswO3aX3Y8bTJn0
X-Google-Smtp-Source: APXvYqwGLiKC59v+jWg2T7MdOu33QR1Qzeo1qFPhfsbIneQfeKVbNEP+bnTGYW/6+FFU6PlvsmmiXGN3duv4ivrMA6U=
X-Received: by 2002:a02:b395:: with SMTP id p21mr26441548jan.31.1561157933261; 
 Fri, 21 Jun 2019 15:58:53 -0700 (PDT)
MIME-Version: 1.0
From: Marlies Ruck <marlies.ruck@gmail.com>
Date: Fri, 21 Jun 2019 15:58:42 -0700
Message-ID: <CALw29ZZZ08Lt13oZsbZCwV+uP0roLuT6t+8m16y+8YT-KH4t7A@mail.gmail.com>
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="0000000000000d1680058bdd68b3"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2e
X-Mailman-Approved-At: Fri, 21 Jun 2019 20:46:26 -0400
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] patch to swap SIGRTMIN + 1 and SIGRTMAX - 1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000d1680058bdd68b3
Content-Type: text/plain; charset="UTF-8"

Hi,

Attached is a patch to let guest programs use SIGRTMIN + 1 by swapping with
SIGRTMAX - 1. Since QEMU links against glibc, it reserves the signal for
itself and returns EINVAL (as noted in the commit message). This means
various applications that use SIGRTMIN + 1 cannot run on QEMU, including
G-WAN web server and Open TFTP.

Thanks,
Marli

--0000000000000d1680058bdd68b3
Content-Type: application/octet-stream; 
	name="0001-Swap-SIGRTMIN-1-and-SIGRTMAX-1.patch"
Content-Disposition: attachment; 
	filename="0001-Swap-SIGRTMIN-1-and-SIGRTMAX-1.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jx6p0rod0>
X-Attachment-Id: f_jx6p0rod0

RnJvbSAwOTZjMjQ0NjY4MzQ1ZjgwYTQ1ODI3OTlkMGI4NjBiN2MyMGE5YjU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBtYXJsaWVzIHJ1Y2sgPG1hcmxpZXNAZm9yYWxsc2VjdXJlLmNv
bT4KRGF0ZTogRnJpLCAyMSBKdW4gMjAxOSAxNDo0Mjo0MiAtMDcwMApTdWJqZWN0OiBbUEFUQ0hd
IFN3YXAgU0lHUlRNSU4gKyAxIGFuZCBTSUdSVE1BWCAtIDEKCldlIGFscmVhZHkgaGF2ZSBhIGhh
Y2sgd2hlcmVieSB3ZSBmbGlwIHRoZSBndWVzdCdzIFNJR1JUTUFYIGFuZCBTSUdSVE1JTgpzaWdu
YWxzLCB0byBhdm9pZCBhIGNvbGxpc2lvbiBiZXR3ZWVuIGd1ZXN0IHVzZSBvZiBTSUdSVE1JTiBh
bmQgdGhlIGhvc3QKbGliYyB1c2Ugb2YgaXQgZm9yIFNJR0NBTkNFTC4gSG93ZXZlciBuZXdlciBn
bGliYyBhbHNvIHVzZXMgU0lHUlRNSU4rMQpmb3IgaW50ZXJuYWwgcHVycG9zZXMgKGFzIFNJR1NF
VFhJRCkuIFJldmVyc2UgU0lHUlRNSU4rMSBhbmQgU0lHUlRNQVgtMQpzbyB0aGUgZ3Vlc3QgY2Fu
IHN1Y2Nlc3NmdWxseSB1c2UgU0lHUlRNSU4rMS4KClRoaXMgZGlkbid0IGNhdXNlIGFueSBpbW1l
ZGlhdGVseSBvYnNlcnZlZCBpc3N1ZXMgaW4gZ3Vlc3RzIGJlY2F1c2UgZ2xpYmMKZG9lcyBub3Qg
Y2hlY2sgdGhlIHJldHVybiB2YWx1ZSB3aGVuIGl0IHJlZ2lzdGVycyBhIFNJR1NFVFhJRCBoYW5k
bGVyKCEpLgpIb3dldmVyIGl0IG1lYW50IHRoYXQgaWYgYSBndWVzdCBwcm9ncmFtIHdpdGggbW9y
ZSB0aGFuIG9uZSB0aHJlYWQgaXNzdWVkCmEgc2V0dWlkKCkgc3lzY2FsbCBpdCB3b3VsZCBoYW5n
LgoKQ3JlZGl0OiBQZXRlciBNYXlkZWxsIGh0dHBzOi8vcGF0Y2hlcy5saW5hcm8ub3JnL3BhdGNo
LzYzMzEzLwpTaWduZWQtb2ZmLWJ5OiBtYXJsaWVzIHJ1Y2sgPG1hcmxpZXNAZm9yYWxsc2VjdXJl
LmNvbT4KLS0tCiBsaW51eC11c2VyL3NpZ25hbC5jIHwgNiArKysrKy0KIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9saW51eC11c2Vy
L3NpZ25hbC5jIGIvbGludXgtdXNlci9zaWduYWwuYwppbmRleCA1Y2QyMzc4MzRkLi4xMzdhNDQ5
MTQwIDEwMDY0NAotLS0gYS9saW51eC11c2VyL3NpZ25hbC5jCisrKyBiL2xpbnV4LXVzZXIvc2ln
bmFsLmMKQEAgLTc1LDggKzc1LDEyIEBAIHN0YXRpYyB1aW50OF90IGhvc3RfdG9fdGFyZ2V0X3Np
Z25hbF90YWJsZVtfTlNJR10gPSB7CiAgICAgLyogTmFzdHkgaGFjazogUmV2ZXJzZSBTSUdSVE1J
TiBhbmQgU0lHUlRNQVggdG8gYXZvaWQgb3ZlcmxhcCB3aXRoCiAgICAgICAgaG9zdCBsaWJwdGhy
ZWFkIHNpZ25hbHMuICBUaGlzIGFzc3VtZXMgbm8gb25lIGFjdHVhbGx5IHVzZXMgU0lHUlRNQVgg
Oi0vCiAgICAgICAgVG8gZml4IHRoaXMgcHJvcGVybHkgd2UgbmVlZCB0byBkbyBtYW51YWwgc2ln
bmFsIGRlbGl2ZXJ5IG11bHRpcGxleGVkCi0gICAgICAgb3ZlciBhIHNpbmdsZSBob3N0IHNpZ25h
bC4gICovCisgICAgICAgb3ZlciBhIHNpbmdsZSBob3N0IHNpZ25hbC4KKyAgICAgICBTaW1pbGFy
bHkgd2UgcmV2ZXJzZSBTSUdSVE1JTiArIDEgYW5kIFNJR1JUTUFYIC0gMSwgYmVjYXVzZQorICAg
ICAgIGhvc3QgZ2xpYmMgdXNlcyBTSUdSVE1JTisxIGZvciBTSUdTRVRYSUQuICovCiAgICAgW19f
U0lHUlRNSU5dID0gX19TSUdSVE1BWCwKKyAgICBbX19TSUdSVE1JTiArIDFdID0gX19TSUdSVE1B
WCAtIDEsCisgICAgW19fU0lHUlRNQVggLSAxXSA9IF9fU0lHUlRNSU4gKyAxLAogICAgIFtfX1NJ
R1JUTUFYXSA9IF9fU0lHUlRNSU4sCiB9Owogc3RhdGljIHVpbnQ4X3QgdGFyZ2V0X3RvX2hvc3Rf
c2lnbmFsX3RhYmxlW19OU0lHXTsKLS0gCjIuMjAuMSAoQXBwbGUgR2l0LTExNykKCg==
--0000000000000d1680058bdd68b3--

